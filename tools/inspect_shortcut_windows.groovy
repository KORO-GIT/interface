import ct0.XDAT
import ct0.Window

if (args.length != 1) {
    System.err.println('Usage: inspect_shortcut_windows.groovy <Interface.xdat>')
    System.exit(2)
}

def collect(Window window, List<Window> output) {
    output << window
    window.children.each { child ->
        if (child instanceof Window) {
            collect((Window) child, output)
        }
    }
}

XDAT xdat = new XDAT()
new File(args[0]).withInputStream { stream ->
    xdat.read(new BufferedInputStream(stream))
}

List<Window> windows = []
xdat.windows.each { window -> collect(window, windows) }

[
    'ShortcutWndVertical',
    'ShortcutWndVertical_1',
    'ShortcutWndVertical_2',
    'ShortcutWndVertical_3',
    'ShortcutWndVertical_4',
    'ShortcutWndVertical_5',
    'ShortcutWndHorizontal',
    'ShortcutWndHorizontal_1',
    'ShortcutWndHorizontal_2',
    'ShortcutWndHorizontal_3',
    'ShortcutWndHorizontal_4',
    'ShortcutWndHorizontal_5'
].each { name ->
    Window window = windows.find { it.name == name }
    if (window == null) {
        println("MISSING ${name}")
        return
    }

    println("== ${name} ==")
    (100..139).each { index ->
        String prop = "unk${index}"
        if (window.hasProperty(prop)) {
            println("${prop}=${window[prop]}")
        }
    }
}
