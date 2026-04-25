import ct0.Alignment
import ct0.ComboBox
import ct0.DefaultProperty
import ct0.TextBox
import ct0.Window
import ct0.XDAT

import java.nio.file.Files
import java.nio.file.StandardCopyOption

if (args.length == 0) {
    System.err.println('Usage: patch_keysetting_bind_window.groovy <Interface.xdat> [more.xdat...]')
    System.exit(2)
}

Set<String> removeNames = [
    'checkUseBind1',
    'checkUseBind2',
    'checkUseBind3'
] as Set

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

    Window keyWnd = (Window) all.find { it instanceof Window && it.name == 'InterfaceAI_KeySettingWnd' }
    if (keyWnd == null) {
        throw new IllegalStateException("InterfaceAI_KeySettingWnd not found in ${file.path}")
    }

    prune(keyWnd, removeNames)

    List<DefaultProperty> patched = []
    collect(keyWnd, patched)

    setText(patched, 'Head_Sockets', 'Panel:')
    setText(patched, 'txtCheckBind1', '1-12', 21, 116)
    setText(patched, 'txtCheckBind2', 'Q-P', 21, 140)
    setText(patched, 'txtCheckBind3', 'F1-F12', 21, 165)
    limitCombo(patched, 'ComboPanel1', 6)
    limitCombo(patched, 'ComboPanel2', 6)
    limitCombo(patched, 'ComboPanel3', 6)

    File backup = new File(file.parentFile, file.name + '.bak_before_keysetting_bind_window')
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

void prune(Window window, Set<String> removeNames) {
    window.children.removeAll { child -> removeNames.contains(child.name) }
    window.children.each { child ->
        if (child instanceof Window) {
            prune((Window) child, removeNames)
        }
    }
}

void collect(DefaultProperty item, List<DefaultProperty> output) {
    output << item
    if (item instanceof Window) {
        ((Window) item).children.each { child -> collect((DefaultProperty) child, output) }
    }
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

void limitCombo(List<DefaultProperty> items, String name, int maxValue) {
    ComboBox comboBox = (ComboBox) items.find { it instanceof ComboBox && it.name.equalsIgnoreCase(name) }
    if (comboBox == null) {
        throw new IllegalStateException("${name} not found")
    }
    comboBox.values.removeAll { item ->
        item.text != null && item.text.isInteger() && item.text.toInteger() > maxValue
    }
}
