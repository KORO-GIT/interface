import gr.zdimensions.jsquish.Squish;

import javax.imageio.ImageIO;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.geom.Line2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

public class ExportInterfaceTexturePack {
    private static final class Asset {
        private final String fileName;
        private final BufferedImage image;
        private final String importName;
        private final String note;

        private Asset(String fileName, BufferedImage image, String importName, String note) {
            this.fileName = fileName;
            this.image = image;
            this.importName = importName;
            this.note = note;
        }
    }

    public static void main(String[] args) throws Exception {
        if (args.length < 2) {
            System.err.println("Usage: ExportInterfaceTexturePack <source-texture-dir> <output-dir>");
            System.exit(2);
        }

        File sourceDir = new File(args[0]).getCanonicalFile();
        File outputDir = new File(args[1]).getCanonicalFile();
        File ddsDir = new File(outputDir, "dds");
        File sourceOutDir = new File(outputDir, "source");

        if (!sourceDir.isDirectory()) {
            throw new IllegalArgumentException("Source directory not found: " + sourceDir);
        }

        ddsDir.mkdirs();
        sourceOutDir.mkdirs();

        List<Asset> assets = new ArrayList<Asset>();
        assets.add(loadBmpAsset(sourceDir, sourceOutDir, "tooltip_section_bg.bmp", "tooltip_section_bg.dds", "TooltipSectionBG", "Suggested import: Interface.Tooltip.TooltipSectionBG"));
        assets.add(loadBmpAsset(sourceDir, sourceOutDir, "tooltip_line.bmp", "tooltip_line.dds", "TooltipLine", "Suggested import: Interface.Tooltip.TooltipLine"));
        assets.add(loadBmpAsset(sourceDir, sourceOutDir, "tooltip_icon_augment.bmp", "tooltip_icon_augment.dds", "LifeBG", "Suggested import: Interface.Tooltip.LifeBG"));
        assets.add(loadBmpAsset(sourceDir, sourceOutDir, "tooltip_icon_sa.bmp", "tooltip_icon_sa.dds", "SaBG", "Suggested import: Interface.Tooltip.SaBG"));
        assets.add(loadBmpAsset(sourceDir, sourceOutDir, "tooltip_icon_set.bmp", "tooltip_icon_set.dds", "setBG", "Suggested import: Interface.Tooltip.setBG"));
        assets.add(loadBmpAsset(sourceDir, sourceOutDir, "tooltip_icon_clock.bmp", "tooltip_icon_clock.dds", "ClockBG", "Suggested import: Interface.Tooltip.ClockBG"));

        BufferedImage langEn16 = createUnionJack(16, 16);
        BufferedImage langRu16 = createRussianFlag(16, 16);
        BufferedImage langEn64 = createUnionJack(64, 64);

        writePng(new File(sourceOutDir, "lang_en_i00.png"), langEn16);
        writePng(new File(sourceOutDir, "lang_ru_i00.png"), langRu16);
        writePng(new File(sourceOutDir, "default_icon_english.png"), langEn64);

        assets.add(new Asset("lang_en_i00.dds", langEn16, "lang_en_i00", "Suggested import: fange_ui.etc.lang_en_i00 or custom package equivalent"));
        assets.add(new Asset("lang_ru_i00.dds", langRu16, "lang_ru_i00", "Optional mirror asset if you want both flags in one package"));
        assets.add(new Asset("default_icon_english.dds", langEn64, "English", "Suggested import: default.Icon.English"));

        for (Asset asset : assets) {
            writeDdsDxt3(new File(ddsDir, asset.fileName), asset.image);
        }

        writeManifest(new File(outputDir, "manifest.txt"), assets);
    }

    private static Asset loadBmpAsset(File sourceDir, File sourceOutDir, String sourceName, String outputName, String importName, String note) throws IOException {
        File sourceFile = new File(sourceDir, sourceName).getCanonicalFile();
        if (!sourceFile.isFile()) {
            throw new IOException("Missing source texture: " + sourceFile);
        }

        Files.copy(sourceFile.toPath(), new File(sourceOutDir, sourceName).toPath(), StandardCopyOption.REPLACE_EXISTING);
        BufferedImage image = ImageIO.read(sourceFile);
        if (image == null) {
            throw new IOException("Unable to read image: " + sourceFile);
        }

        return new Asset(outputName, ensureArgb(image), importName, note);
    }

    private static BufferedImage ensureArgb(BufferedImage image) {
        if (image.getType() == BufferedImage.TYPE_INT_ARGB) {
            return image;
        }
        BufferedImage converted = new BufferedImage(image.getWidth(), image.getHeight(), BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = converted.createGraphics();
        try {
            g.drawImage(image, 0, 0, null);
        } finally {
            g.dispose();
        }
        return converted;
    }

    private static void writePng(File out, BufferedImage image) throws IOException {
        out.getParentFile().mkdirs();
        ImageIO.write(image, "png", out);
    }

    private static void writeManifest(File file, List<Asset> assets) throws IOException {
        StringBuilder sb = new StringBuilder();
        sb.append("Interface texture pack").append("\r\n");
        sb.append("Generated: ").append(new java.util.Date()).append("\r\n");
        sb.append("\r\n");
        sb.append("[DDS]").append("\r\n");
        for (Asset asset : assets) {
            sb.append(asset.fileName)
                    .append(" | ")
                    .append(asset.image.getWidth())
                    .append("x")
                    .append(asset.image.getHeight())
                    .append(" | DXT3 | ")
                    .append(asset.note)
                    .append("\r\n");
        }
        sb.append("\r\n");
        sb.append("[Current references]").append("\r\n");
        sb.append("Menu EN button -> default.Icon.English").append("\r\n");
        sb.append("Tooltip section bg -> Interface.Tooltip.TooltipSectionBG").append("\r\n");
        sb.append("Tooltip separator -> Interface.Tooltip.TooltipLine").append("\r\n");
        sb.append("Tooltip icons -> Interface.Tooltip.LifeBG / SaBG / setBG / ClockBG").append("\r\n");
        sb.append("\r\n");
        sb.append("[Notes]").append("\r\n");
        sb.append("If you import into a separate UTX or into L2UI_CH*, update Menu/ToolTip references to your package path.").append("\r\n");

        Files.write(file.toPath(), sb.toString().getBytes(StandardCharsets.US_ASCII));
    }

    private static void writeDdsDxt3(File out, BufferedImage image) throws IOException {
        if ((image.getWidth() % 4) != 0 || (image.getHeight() % 4) != 0) {
            throw new IOException("DDS DXT3 requires dimensions divisible by 4: " + out.getName() + " " + image.getWidth() + "x" + image.getHeight());
        }

        byte[] rgba = bufferedImageToRgba(image);
        byte[] dxt = Squish.compressImage(rgba, image.getWidth(), image.getHeight(), null, Squish.CompressionType.DXT3, Squish.CompressionMethod.CLUSTER_FIT);

        ByteBuffer header = ByteBuffer.allocate(128).order(ByteOrder.LITTLE_ENDIAN);
        header.put((byte) 'D');
        header.put((byte) 'D');
        header.put((byte) 'S');
        header.put((byte) ' ');
        header.putInt(124);
        header.putInt(0x00081007);
        header.putInt(image.getHeight());
        header.putInt(image.getWidth());
        header.putInt(dxt.length);
        header.putInt(0);
        header.putInt(0);
        for (int i = 0; i < 11; i++) {
            header.putInt(0);
        }
        header.putInt(32);
        header.putInt(0x00000004);
        header.put((byte) 'D');
        header.put((byte) 'X');
        header.put((byte) 'T');
        header.put((byte) '3');
        header.putInt(0);
        header.putInt(0);
        header.putInt(0);
        header.putInt(0);
        header.putInt(0);
        header.putInt(0x00001000);
        header.putInt(0);
        header.putInt(0);
        header.putInt(0);
        header.putInt(0);

        out.getParentFile().mkdirs();
        FileOutputStream fos = new FileOutputStream(out);
        try {
            fos.write(header.array());
            fos.write(dxt);
        } finally {
            fos.close();
        }
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

    private static BufferedImage createRussianFlag(int width, int height) {
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = image.createGraphics();
        try {
            int stripeHeight = Math.max(1, height / 3);
            g.setColor(new Color(255, 255, 255));
            g.fillRect(0, 0, width, stripeHeight);
            g.setColor(new Color(0, 57, 166));
            g.fillRect(0, stripeHeight, width, stripeHeight);
            g.setColor(new Color(213, 43, 30));
            g.fillRect(0, stripeHeight * 2, width, height - (stripeHeight * 2));
        } finally {
            g.dispose();
        }
        return image;
    }

    private static BufferedImage createUnionJack(int width, int height) {
        int scale = Math.max(1, (int) Math.ceil(128.0d / Math.max(1, Math.min(width, height))));
        BufferedImage large = new BufferedImage(width * scale, height * scale, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = large.createGraphics();
        try {
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g.setColor(new Color(1, 33, 105));
            g.fillRect(0, 0, large.getWidth(), large.getHeight());

            float diagonalBase = Math.min(large.getWidth(), large.getHeight());
            drawLine(g, Color.WHITE, 0, 0, large.getWidth(), large.getHeight(), diagonalBase * 0.34f);
            drawLine(g, Color.WHITE, 0, large.getHeight(), large.getWidth(), 0, diagonalBase * 0.34f);
            drawLine(g, new Color(200, 16, 46), 0, 0, large.getWidth(), large.getHeight(), diagonalBase * 0.16f);
            drawLine(g, new Color(200, 16, 46), 0, large.getHeight(), large.getWidth(), 0, diagonalBase * 0.16f);

            int whiteCross = Math.max(1, (int) Math.round(Math.min(large.getWidth(), large.getHeight()) * 0.32d));
            int redCross = Math.max(1, (int) Math.round(Math.min(large.getWidth(), large.getHeight()) * 0.18d));
            int whiteBarOffset = (large.getHeight() - whiteCross) / 2;
            int whitePoleOffset = (large.getWidth() - whiteCross) / 2;
            int redBarOffset = (large.getHeight() - redCross) / 2;
            int redPoleOffset = (large.getWidth() - redCross) / 2;

            g.setColor(Color.WHITE);
            g.fillRect(0, whiteBarOffset, large.getWidth(), whiteCross);
            g.fillRect(whitePoleOffset, 0, whiteCross, large.getHeight());
            g.setColor(new Color(200, 16, 46));
            g.fillRect(0, redBarOffset, large.getWidth(), redCross);
            g.fillRect(redPoleOffset, 0, redCross, large.getHeight());
        } finally {
            g.dispose();
        }

        BufferedImage small = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
        Graphics2D s = small.createGraphics();
        try {
            s.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
            s.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
            s.drawImage(large, 0, 0, width, height, null);
        } finally {
            s.dispose();
        }
        return small;
    }

    private static void drawLine(Graphics2D g, Color color, int x1, int y1, int x2, int y2, float width) {
        g.setColor(color);
        g.setStroke(new BasicStroke(width, BasicStroke.CAP_BUTT, BasicStroke.JOIN_MITER));
        g.draw(new Line2D.Float(x1, y1, x2, y2));
    }
}
