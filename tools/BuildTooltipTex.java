import acmi.l2.clientmod.io.RandomAccessFile;
import acmi.l2.clientmod.io.UnrealPackage;
import acmi.l2.clientmod.l2resources.texture.Img;
import acmi.l2.clientmod.l2resources.texture.MipMapInfo;
import gr.zdimensions.jsquish.Squish;

import javax.imageio.ImageIO;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

public class BuildTooltipTex {
    // We patch a copy of the real fange_ui package so the client keeps loading
    // textures from an external .utx without depending on Interface.u imports.
    private static final List<TextureSpec> SPECS = Arrays.asList(
            new TextureSpec("icons.acumen", "tooltip_icon_augment.bmp"),
            new TextureSpec("icons.arcane_protection", "tooltip_icon_sa.bmp"),
            new TextureSpec("icons.empower", "tooltip_icon_set.bmp"),
            new TextureSpec("icons.guidance", "tooltip_icon_clock.bmp")
    );

    public static void main(String[] args) throws Exception {
        if (args.length < 3) {
            System.err.println("Usage: BuildTooltipTex <source-utx> <texture-dir> <output-utx>");
            System.exit(2);
        }

        File sourcePackage = new File(args[0]).getCanonicalFile();
        File textureDir = new File(args[1]).getCanonicalFile();
        File outputPackage = new File(args[2]).getCanonicalFile();

        if (!sourcePackage.isFile()) {
            throw new IllegalArgumentException("Source package not found: " + sourcePackage);
        }
        if (!textureDir.isDirectory()) {
            throw new IllegalArgumentException("Texture directory not found: " + textureDir);
        }

        File parent = outputPackage.getParentFile();
        if (parent != null) {
            parent.mkdirs();
        }
        if (outputPackage.exists() && !outputPackage.delete()) {
            throw new IllegalStateException("Unable to replace " + outputPackage);
        }

        Files.copy(sourcePackage.toPath(), outputPackage.toPath(), StandardCopyOption.REPLACE_EXISTING);

        try (UnrealPackage target = new UnrealPackage(outputPackage, false)) {
            for (TextureSpec spec : SPECS) {
                patchTexture(target, textureDir, spec);
            }
        }

        try (UnrealPackage verify = new UnrealPackage(outputPackage, true)) {
            System.out.println("Built " + outputPackage.getPath());
            for (TextureSpec spec : SPECS) {
                int ref = verify.exportReferenceByName(spec.exportName, name -> "Engine.Texture".equals(name));
                if (ref == 0) {
                    throw new IllegalStateException("Missing export in output package: " + spec.exportName);
                }
            }
        }
    }

    private static void patchTexture(UnrealPackage target, File textureDir, TextureSpec spec) throws Exception {
        int ref = target.exportReferenceByName(spec.exportName, name -> "Engine.Texture".equals(name));
        if (ref == 0) {
            throw new IllegalStateException("Target texture not found: " + spec.exportName);
        }

        UnrealPackage.ExportEntry export = (UnrealPackage.ExportEntry) target.objectReference(ref);
        Optional<MipMapInfo> infoOpt = MipMapInfo.getInfo(export);
        if (!infoOpt.isPresent()) {
            throw new IllegalStateException("Unable to read mip data for " + spec.exportName);
        }

        MipMapInfo info = infoOpt.get();
        if (info.properties.getFormat() != Img.Format.DXT3 && info.properties.getFormat() != Img.Format.RGBA8) {
            throw new IllegalStateException("Unsupported base format for " + spec.exportName + ": " + info.properties.getFormat());
        }

        File imageFile = new File(textureDir, spec.imageFileName).getCanonicalFile();
        BufferedImage image = ImageIO.read(imageFile);
        if (image == null) {
            throw new IllegalStateException("Unable to load source image: " + imageFile);
        }

        byte[] raw = export.getObjectRawDataExternally().clone();
        for (int i = 0; i < info.offsets.length; i++) {
            int width = Math.max(1, info.properties.getWidth() >> i);
            int height = Math.max(1, info.properties.getHeight() >> i);
            BufferedImage mip = scaleImage(image, width, height);
            byte[] encoded;
            if (info.properties.getFormat() == Img.Format.DXT3) {
                byte[] rgba = bufferedImageToRgba(mip);
                encoded = Squish.compressImage(rgba, width, height, null, Squish.CompressionType.DXT3, Squish.CompressionMethod.CLUSTER_FIT);
                if (encoded.length != info.sizes[i]) {
                    throw new IllegalStateException(
                            "Unexpected encoded mip size for " + spec.exportName + " mip " + i +
                                    ": got " + encoded.length + ", expected " + info.sizes[i]);
                }
            } else {
                encoded = bufferedImageToRgba(mip);
                if (encoded.length != info.sizes[i]) {
                    throw new IllegalStateException(
                            "Unexpected encoded mip size for " + spec.exportName + " mip " + i +
                                    ": got " + encoded.length + ", expected " + info.sizes[i]);
                }
            }
            System.arraycopy(encoded, 0, raw, info.offsets[i], encoded.length);
        }

        export.setObjectRawData(raw);
    }

    private static BufferedImage scaleImage(BufferedImage source, int width, int height) {
        if (source.getWidth() == width && source.getHeight() == height) {
            return source;
        }

        BufferedImage scaled = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = scaled.createGraphics();
        try {
            g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
            g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g.drawImage(source, 0, 0, width, height, null);
        } finally {
            g.dispose();
        }
        return scaled;
    }

    private static byte[] bufferedImageToRgba(BufferedImage image) {
        byte[] rgba = new byte[image.getWidth() * image.getHeight() * 4];
        int p = 0;
        for (int y = 0; y < image.getHeight(); y++) {
            for (int x = 0; x < image.getWidth(); x++) {
                int argb = image.getRGB(x, y);
                rgba[p++] = (byte) ((argb >> 16) & 0xff);
                rgba[p++] = (byte) ((argb >> 8) & 0xff);
                rgba[p++] = (byte) (argb & 0xff);
                rgba[p++] = (byte) ((argb >> 24) & 0xff);
            }
        }
        return rgba;
    }

    private static final class TextureSpec {
        private final String exportName;
        private final String imageFileName;

        private TextureSpec(String exportName, String imageFileName) {
            this.exportName = exportName;
            this.imageFileName = imageFileName;
        }
    }
}
