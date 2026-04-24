import ct0.DefaultProperty
import ct0.ComboBox
import ct0.TextBox
import ct0.Window
import ct0.XDAT

if (args.length != 1) {
    System.err.println('Usage: inspect_keysetting_bind_window.groovy <Interface.xdat>')
    System.exit(2)
}

XDAT xdat = new XDAT()
new File(args[0]).withInputStream { stream ->
    xdat.read(new BufferedInputStream(stream))
}

List<DefaultProperty> items = []
xdat.windows.each { window -> collect((DefaultProperty) window, items) }

[
    'checkEnterChat',
    'checkUseBind1',
    'checkUseBind2',
    'checkUseBind3',
    'txtEnterChat'
].each { name ->
    println("${name}=" + (items.find { it.name == name } != null))
}

[
    'ComboPanel1',
    'ComboPanel2',
    'ComboPanel3'
].each { name ->
    ComboBox comboBox = (ComboBox) items.find { it instanceof ComboBox && it.name.equalsIgnoreCase(name) }
    if (comboBox == null) {
        println("${name}=MISSING")
    } else {
        println("${name}=" + comboBox.values.collect { it.text }.join(','))
    }
}

[
    'Head_Sockets',
    'txtCheckBind1',
    'txtCheckBind2',
    'txtCheckBind3'
].each { name ->
    TextBox textBox = (TextBox) items.find { it instanceof TextBox && it.name == name }
    if (textBox == null) {
        println("${name}=MISSING")
    } else {
        println("${name}=${textBox.text} @ ${textBox.anchor_ctrl} ${textBox.anchor_x},${textBox.anchor_y}")
    }
}

void collect(DefaultProperty item, List<DefaultProperty> output) {
    output << item
    if (item instanceof Window) {
        ((Window) item).children.each { child -> collect((DefaultProperty) child, output) }
    }
}
