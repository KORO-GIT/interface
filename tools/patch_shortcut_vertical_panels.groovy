import ct0.XDAT
import ct0.Window

import java.nio.file.Files
import java.nio.file.StandardCopyOption

if (args.length == 0) {
    System.err.println('Usage: patch_shortcut_vertical_panels.groovy <Interface.xdat> [more.xdat...]')
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

    List<Window> windows = []
    xdat.windows.each { window -> collect((Window) window, windows) }

    (1..5).each { int index ->
        String name = "ShortcutWndVertical_${index}"
        Window window = windows.find { it.name == name }
        if (window == null) {
            throw new IllegalStateException("${name} not found in ${file.path}")
        }

        window.unk106 = 0
        window.unk109 = -1
        window.unk126 = 1
        window.unk127 = 0
        window.unk128 = 1
        window.unk129 = index == 1 ? 'ShortcutWndVertical' : "ShortcutWndVertical_${index - 1}"
    }

    File backup = new File(file.parentFile, file.name + '.bak_before_shortcut_vertical_panels')
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

void collect(Window window, List<Window> output) {
    output << window
    window.children.each { child ->
        if (child instanceof Window) {
            collect((Window) child, output)
        }
    }
}
