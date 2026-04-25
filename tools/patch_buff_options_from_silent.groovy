import ct0.DefaultProperty
import ct0.CheckBox
import ct0.Tab
import ct0.TextBox
import ct0.Texture
import ct0.Window
import ct0.XDAT

import java.nio.file.Files
import java.nio.file.StandardCopyOption

if (args.length < 2) {
    System.err.println('Usage: patch_buff_options_from_silent.groovy <Interface.xdat> <SilentInterface.xdat>')
    System.exit(2)
}

File file = new File(args[0]).canonicalFile
File silentFile = new File(args[1]).canonicalFile
if (!file.isFile()) {
    throw new FileNotFoundException(file.path)
}
if (!silentFile.isFile()) {
    throw new FileNotFoundException(silentFile.path)
}

XDAT xdat = readXdat(file)
XDAT silent = readXdat(silentFile)

Window root = xdat.windows.find { it.name == 'BuffOptionsWnd' }
if (root == null) {
    throw new IllegalStateException("BuffOptionsWnd not found in ${file.path}")
}

Window silentRoot = silent.windows.find { it.name == 'BuffOptionsWnd' }
Window buffTab = silent.windows.find { it.name == 'BuffOptionsTabBuff' }
Window partyTab = silent.windows.find { it.name == 'BuffOptionsTabPTBuff' }
if (silentRoot == null || buffTab == null || partyTab == null) {
    throw new IllegalStateException("Silent BuffOptions windows not found in ${silentFile.path}")
}

Tab rootTab = root.children.find { it instanceof Tab && it.name == 'TabCtrl' } as Tab
Tab silentTab = silentRoot.children.find { it instanceof Tab && it.name == 'TabCtrl' } as Tab
if (rootTab == null || silentTab == null) {
    throw new IllegalStateException('BuffOptions TabCtrl not found')
}

xdat.windows.removeAll {
    it.name == 'BuffOptionsTabBuff' ||
    it.name == 'BuffOptionsTabPTBuff' ||
    it.name == 'OtherTab2' ||
    it.name == 'OtherTab3'
}

prune(buffTab, ['BuffPotions'] as Set)
normalizeTab(buffTab)
normalizeTab(partyTab)
setText(buffTab, 'AbnormalSizeHead', 'Buff Size')
setText(buffTab, 'AbnormalColHead', 'Buff Columns')
setText(buffTab, 'AbnormalDebuffSizeHead', 'Debuff Size')
setText(partyTab, 'PTDebuffSizeHead', 'Debuff Size')

rootTab.tabs.clear()
silentTab.tabs.each { Tab.TabElement tab ->
    Tab.TabElement copy = new Tab.TabElement()
    copy.buttonName = tab.buttonName
    copy.target = tab.target
    copy.width = tab.width
    copy.height = tab.height
    copy.normalTex = tab.normalTex
    copy.pushedTex = tab.pushedTex
    copy.movable = tab.movable
    copy.gap = tab.gap
    copy.tooltip = tab.tooltip
    copy.noHighlight = tab.noHighlight
    rootTab.tabs.add(copy)
}

xdat.windows.add(buffTab)
xdat.windows.add(partyTab)

File backup = new File(file.parentFile, file.name + '.bak_before_buff_options_silent')
if (!backup.exists()) {
    Files.copy(file.toPath(), backup.toPath(), StandardCopyOption.COPY_ATTRIBUTES)
}

file.withOutputStream { stream ->
    BufferedOutputStream output = new BufferedOutputStream(stream)
    xdat.write(output)
    output.flush()
}

println("Patched ${file.path}: imported Silent Buff Options tabs")

XDAT readXdat(File inputFile) {
    XDAT data = new XDAT()
    inputFile.withInputStream { stream ->
        data.read(new BufferedInputStream(stream))
    }
    return data
}

void prune(Window window, Set<String> removeNames) {
    window.children.removeAll { child -> removeNames.contains(child.name) }
    window.children.each { child ->
        if (child instanceof Window) {
            prune((Window) child, removeNames)
        }
    }
}

void normalizeTab(Window window) {
    List<DefaultProperty> items = []
    collect(window, items)

    items.findAll { it instanceof CheckBox }.each {
        CheckBox checkBox = (CheckBox) it
        checkBox.titleIndex = -1
    }

    Texture back = items.find { it instanceof Texture && it.name == 'OtherBackTex' } as Texture
    if (back != null) {
        back.file = 'Was.Wnd_Box'
        back.size_absolute_width = 235
        back.size_absolute_height = 390
        back.anchor_x = 11
        back.anchor_y = 5
        back.layer = Texture.TextureLayer.Background
    }

    items.findAll { it instanceof Texture && it.name.endsWith('BG') }.each {
        Texture texture = (Texture) it
        texture.file = 'Was.Wnd_Box'
        texture.layer = Texture.TextureLayer.Background
    }
}

void setText(Window window, String name, String text) {
    List<DefaultProperty> items = []
    collect(window, items)
    TextBox textBox = items.find { it instanceof TextBox && it.name == name } as TextBox
    if (textBox == null) {
        throw new IllegalStateException("${name} not found")
    }
    textBox.text = text
    textBox.sysstring = -9999
}

void collect(DefaultProperty item, List<DefaultProperty> output) {
    output << item
    if (item instanceof Window) {
        ((Window) item).children.each { child ->
            collect((DefaultProperty) child, output)
        }
    }
}
