import ct0.Alignment
import ct0.ComboBox
import ct0.DefaultProperty
import ct0.TextBox
import ct0.Texture
import ct0.Window
import ct0.XDAT

import java.nio.file.Files
import java.nio.file.StandardCopyOption

if (args.length == 0) {
    System.err.println('Usage: patch_shortcut_key_hints.groovy <Interface.xdat> [more.xdat...]')
    System.exit(2)
}

args.each { String fileName ->
    File file = new File(fileName).canonicalFile
    if (!file.isFile()) {
        throw new FileNotFoundException(file.path)
    }

    XDAT xdat = new XDAT()
    file.withInputStream { stream ->
        xdat.read(new BufferedInputStream(stream))
    }

    List<DefaultProperty> all = []
    xdat.windows.each { window -> collect((DefaultProperty) window, all) }

    ensureHintTextures(all, 'ShortcutWndHorizontal', [
        'ShortcutWndHorizontal_3',
        'ShortcutWndHorizontal_4',
        'ShortcutWndHorizontal_5'
    ])
    ensureHintTextures(all, 'ShortcutWndVertical', [
        'ShortcutWndVertical_3',
        'ShortcutWndVertical_4',
        'ShortcutWndVertical_5'
    ])
    patchBindLabels(all)

    File backup = new File(file.parentFile, file.name + '.bak_before_shortcut_key_hints')
    if (!backup.exists()) {
        Files.copy(file.toPath(), backup.toPath(), StandardCopyOption.COPY_ATTRIBUTES)
    }

    file.withOutputStream { stream ->
        BufferedOutputStream output = new BufferedOutputStream(stream)
        xdat.write(output)
        output.flush()
    }

    println("Patched ${file.path}")
}

void ensureHintTextures(List<DefaultProperty> all, String templateName, List<String> targetNames) {
    Window template = (Window) all.find { it instanceof Window && it.name == templateName }
    if (template == null) {
        throw new IllegalStateException("${templateName} not found")
    }

    List<Texture> hints = []
    (1..12).each { index ->
        Texture texture = (Texture) template.children.find {
            it instanceof Texture && it.name == "F${index}Tex"
        }
        if (texture == null) {
            throw new IllegalStateException("${templateName}.F${index}Tex not found")
        }
        hints << texture
    }

    targetNames.each { targetName ->
        Window target = (Window) all.find { it instanceof Window && it.name == targetName }
        if (target == null) {
            throw new IllegalStateException("${targetName} not found")
        }
        int insertAt = firstShortcutIndex(target)
        (1..12).reverseEach { index ->
            String name = "F${index}Tex"
            if (target.children.find { it.name == name } == null) {
                target.children.add(insertAt, cloneTexture(hints[index - 1], name))
            }
        }
    }
}

int firstShortcutIndex(Window window) {
    int index = window.children.findIndexOf { it.name == 'Shortcut1' }
    return index >= 0 ? index : window.children.size()
}

Texture cloneTexture(Texture source, String name) {
    Texture target = new Texture()
    [
        'superName',
        'unk2',
        'unk3',
        'unk4',
        'unk5',
        'unk6',
        'unk7',
        'size',
        'size_absolute_values',
        'size_percent_width',
        'size_percent_height',
        'size_absolute_width',
        'size_absolute_height',
        'anchor',
        'anchor_parent',
        'anchor_this',
        'anchor_ctrl',
        'anchor_x',
        'anchor_y',
        'unk22',
        'unk23',
        'unk24',
        'popupType',
        'popupValue',
        'type',
        'layer',
        'u',
        'v',
        'uSize',
        'vSize',
        'alpha',
        'isAnimTex'
    ].each { property ->
        target[property] = source[property]
    }
    target.name = name
    target.file = 'Was.Null'
    return target
}

void patchBindLabels(List<DefaultProperty> all) {
    setText(all, 'Head_Sockets', 'Panel:')
    setText(all, 'txtCheckBind1', '1-12', 21, 116)
    setText(all, 'txtCheckBind2', 'Q-P', 21, 140)
    setText(all, 'txtCheckBind3', 'F1-F12', 21, 165)
    labelComboPanels(all, 'ComboPanel1')
    labelComboPanels(all, 'ComboPanel2')
    labelComboPanels(all, 'ComboPanel3')
}

void setText(List<DefaultProperty> items, String name, String text) {
    TextBox textBox = (TextBox) items.find { it instanceof TextBox && it.name == name }
    if (textBox == null) {
        throw new IllegalStateException("${name} not found")
    }
    textBox.text = text
}

void setText(List<DefaultProperty> items, String name, String text, int x, int y) {
    TextBox textBox = (TextBox) items.find { it instanceof TextBox && it.name == name }
    if (textBox == null) {
        throw new IllegalStateException("${name} not found")
    }
    textBox.text = text
    textBox.anchor = true
    textBox.anchor_parent = Alignment.TOP_LEFT
    textBox.anchor_this = Alignment.TOP_LEFT
    textBox.anchor_ctrl = 'Tex'
    textBox.anchor_x = x
    textBox.anchor_y = y
}

void collect(DefaultProperty item, List<DefaultProperty> output) {
    output << item
    if (item instanceof Window) {
        ((Window) item).children.each { child -> collect((DefaultProperty) child, output) }
    }
}

void labelComboPanels(List<DefaultProperty> items, String name) {
    ComboBox comboBox = (ComboBox) items.find { it instanceof ComboBox && it.name.equalsIgnoreCase(name) }
    if (comboBox == null) {
        throw new IllegalStateException("${name} not found")
    }
    comboBox.values.eachWithIndex { item, int index ->
        item.text = "P${index + 1}"
    }
}
