import ct0.Alignment
import ct0.Button
import ct0.XDAT

import java.nio.file.Files
import java.nio.file.StandardCopyOption

if (args.length == 0) {
    System.err.println('Usage: patch_menu_language_flags.groovy <Interface.xdat> [more.xdat...]')
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

    def menu = xdat.windows.find { it.name == 'Menu' }
    if (menu == null) {
        throw new IllegalStateException("Menu window not found in ${file.path}")
    }

    menu.children.removeAll { it.name in ['LangRuIcon', 'LangEnIcon', 'BtnLangRu', 'BtnLangEn'] }

    Button ruIcon = makeButton('BtnLangRu', 'L2UI_CH3.ToolTip.lang_ru_i00', -233, 3)
    Button enIcon = makeButton('BtnLangEn', 'L2UI_CH3.ToolTip.lang_en_i00', -213, 3)

    int insertAt = menu.children.findIndexOf { it.name == 'DividerAdenaRight' }
    if (insertAt < 0) {
        insertAt = menu.children.findIndexOf { it.name == 'AdenaIcon' } - 1
    }
    if (insertAt < 0) {
        insertAt = menu.children.size() - 1
    }

    menu.children.add(insertAt + 1, ruIcon)
    menu.children.add(insertAt + 2, enIcon)

    File backup = new File(file.parentFile, file.name + '.bak_before_lang_flags')
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

Button makeButton(String name, String texture, int anchorX, int anchorY) {
    Button icon = new Button()
    icon.normalTex = texture
    icon.pushedTex = texture
    icon.highlightTex = texture
    icon.dropTex = 'undefined'
    icon.buttonName = -9999
    icon.noHighlight = -1
    icon.defaultSoundOn = -1
    icon.disableTime = -9999

    icon.name = name
    icon.superName = 'undefined'
    icon.unk2 = 1
    icon.unk3 = -1
    icon.unk4 = 'Menu'
    icon.unk5 = 'undefined'
    icon.unk6 = 'undefined'
    icon.unk7 = 1
    icon.size = true
    icon.size_absolute_values = true
    icon.size_percent_width = 0.0f
    icon.size_percent_height = 0.0f
    icon.size_absolute_width = 16
    icon.size_absolute_height = 16
    icon.anchor = true
    icon.anchor_parent = Alignment.TOP_LEFT
    icon.anchor_this = Alignment.TOP_RIGHT
    icon.anchor_ctrl = ''
    icon.anchor_x = anchorX
    icon.anchor_y = anchorY
    icon.unk22 = -1
    icon.unk23 = -1
    icon.unk24 = 0
    icon.popupType = 'undefined'
    icon.popupValue = -9999

    return icon
}
