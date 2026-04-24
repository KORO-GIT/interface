param(
    [string]$Root = $PSScriptRoot,
    [string]$ClientRoot = 'D:\L2ANT\clean',
    [string]$InterfaceUPath,
    [string]$InterfaceXdatPath,
    [string]$FangeUiPath,
    [switch]$PatchEnglishFlag
)

$ErrorActionPreference = 'Stop'

if([string]::IsNullOrWhiteSpace($InterfaceUPath)) {
    $InterfaceUPath = Join-Path $Root 'dist\Interlude\Interface.u'
}
if([string]::IsNullOrWhiteSpace($InterfaceXdatPath)) {
    $InterfaceXdatPath = Join-Path $Root 'dist\Interlude\Interface.xdat'
}
if([string]::IsNullOrWhiteSpace($FangeUiPath)) {
    $candidate = Join-Path $Root 'dist\Interlude\fange_ui.utx'
    if(Test-Path -LiteralPath $candidate) {
        $FangeUiPath = $candidate
    }
}

$systemDir = Join-Path $ClientRoot 'system'
$systexturesDir = Join-Path $ClientRoot 'systextures'
$backupRoot = Join-Path $ClientRoot '_codex_backups'
$baselineDir = Join-Path $backupRoot 'baseline_original'
$stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$deployDir = Join-Path $backupRoot ("before_deploy_" + $stamp)
$defaultUtxPath = Join-Path $systexturesDir 'default.utx'
$windowsInfoPath = Join-Path $systemDir 'WindowsInfo.ini'

function Remove-IniSections {
    param(
        [string]$Path,
        [string[]]$Sections,
        [string]$BackupRoot
    )

    if(-not (Test-Path -LiteralPath $Path)) {
        return $false
    }

    $sectionLookup = @{}
    foreach($section in $Sections) {
        $sectionLookup[$section] = $true
    }

    $lines = [System.IO.File]::ReadAllLines($Path, [System.Text.Encoding]::Default)
    $output = New-Object 'System.Collections.Generic.List[string]'
    $skip = $false
    $changed = $false

    foreach($line in $lines) {
        if($line -match '^\s*\[([^\]]+)\]\s*$') {
            $skip = $sectionLookup.ContainsKey($Matches[1])
            if($skip) {
                $changed = $true
                continue
            }
        }

        if(-not $skip) {
            $output.Add($line)
        }
    }

    if($changed) {
        $backupTarget = Join-Path $BackupRoot 'system\WindowsInfo.ini'
        $backupParent = Split-Path -Parent $backupTarget
        New-Item -ItemType Directory -Force -Path $backupParent | Out-Null
        if(-not (Test-Path -LiteralPath $backupTarget)) {
            Copy-Item -LiteralPath $Path -Destination $backupTarget -Force
        }
        [System.IO.File]::WriteAllLines($Path, $output.ToArray(), [System.Text.Encoding]::Default)
    }

    return $changed
}

foreach($dir in @($systemDir, $systexturesDir)) {
    if(-not (Test-Path -LiteralPath $dir)) {
        throw "Missing client directory: $dir"
    }
}

$baselineFiles = @(
    @{Src=(Join-Path $systemDir 'Interface.u'); Rel='system\Interface.u'},
    @{Src=(Join-Path $systemDir 'Interface.xdat'); Rel='system\Interface.xdat'},
    @{Src=(Join-Path $systemDir 'Option.ini'); Rel='system\Option.ini'},
    @{Src=(Join-Path $systemDir 'WindowsInfo.ini'); Rel='system\WindowsInfo.ini'},
    @{Src=(Join-Path $systemDir 'Running.ini'); Rel='system\Running.ini'},
    @{Src=(Join-Path $systemDir 'L2CompiledShader.bin'); Rel='system\L2CompiledShader.bin'},
    @{Src=(Join-Path $systemDir 'SmartGuard.ini'); Rel='system\SmartGuard.ini'},
    @{Src=(Join-Path $systemDir 'clmods.dll'); Rel='system\clmods.dll'},
    @{Src=(Join-Path $systemDir 's_info.ini'); Rel='system\s_info.ini'},
    @{Src=(Join-Path $systexturesDir 'default.utx'); Rel='systextures\default.utx'},
    @{Src=(Join-Path $systexturesDir 'fange_ui.utx'); Rel='systextures\fange_ui.utx'},
    @{Src=(Join-Path $systexturesDir 'Crest.utx'); Rel='systextures\Crest.utx'}
)

$deployFiles = @(
    @{Src=$InterfaceUPath; Dst=(Join-Path $systemDir 'Interface.u'); Rel='system\Interface.u'},
    @{Src=$InterfaceXdatPath; Dst=(Join-Path $systemDir 'Interface.xdat'); Rel='system\Interface.xdat'}
)

if(-not [string]::IsNullOrWhiteSpace($FangeUiPath)) {
    $deployFiles += @{Src=$FangeUiPath; Dst=(Join-Path $systexturesDir 'fange_ui.utx'); Rel='systextures\fange_ui.utx'}
}

foreach($file in $deployFiles) {
    if(-not (Test-Path -LiteralPath $file.Src)) {
        throw "Missing deploy source: $($file.Src)"
    }
}

New-Item -ItemType Directory -Force -Path $backupRoot, $baselineDir, $deployDir | Out-Null

foreach($file in $baselineFiles) {
    if(Test-Path -LiteralPath $file.Src) {
        $baselineTarget = Join-Path $baselineDir $file.Rel
        $baselineParent = Split-Path -Parent $baselineTarget
        New-Item -ItemType Directory -Force -Path $baselineParent | Out-Null
        if(-not (Test-Path -LiteralPath $baselineTarget)) {
            Copy-Item -LiteralPath $file.Src -Destination $baselineTarget -Force
        }
    }
}

foreach($file in $deployFiles) {
    if(Test-Path -LiteralPath $file.Dst) {
        $backupTarget = Join-Path $deployDir $file.Rel
        $backupParent = Split-Path -Parent $backupTarget
        New-Item -ItemType Directory -Force -Path $backupParent | Out-Null
        Copy-Item -LiteralPath $file.Dst -Destination $backupTarget -Force
    }
}

foreach($file in $deployFiles) {
    Copy-Item -LiteralPath $file.Src -Destination $file.Dst -Force
}

$cleanedWindowsInfo = Remove-IniSections `
    -Path $windowsInfoPath `
    -Sections @('ShortcutWndVertical_4', 'ShortcutWndVertical_5') `
    -BackupRoot $deployDir

if($PatchEnglishFlag) {
    if(-not (Test-Path -LiteralPath $defaultUtxPath)) {
        throw "Missing default.utx: $defaultUtxPath"
    }

    $defaultBackup = Join-Path $deployDir 'systextures\default.utx'
    $defaultBackupParent = Split-Path -Parent $defaultBackup
    New-Item -ItemType Directory -Force -Path $defaultBackupParent | Out-Null
    Copy-Item -LiteralPath $defaultUtxPath -Destination $defaultBackup -Force

    $groovyJar = Join-Path $Root 'tools\xdat_editor\build\dist\xdat_editor-1.3.10\groovy-2.4.7.jar'
    $groovyScript = Join-Path $Root 'tools\generate_language_texture.groovy'
    $javaCandidates = @(
        'C:\Program Files\Java\jdk1.8.0_333\bin\java.exe',
        'C:\Program Files\Java\jdk-17.0.1\bin\java.exe'
    )
    $java = $javaCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
    if(-not $java) {
        throw 'Java runtime not found. Expected java.exe in Program Files\Java.'
    }

    $groovyDeps = @(
        $groovyJar,
        (Join-Path $Root 'tools\l2decompile\lib\L2unreal-1.0-SNAPSHOT.jar'),
        (Join-Path $Root 'tools\l2decompile\lib\l2io-2.0.jar'),
        (Join-Path $Root 'tools\l2decompile\lib\serializer-1.1-SNAPSHOT.jar'),
        (Join-Path $Root 'tools\l2decompile\lib\commons-io-2.4.jar'),
        (Join-Path $Root 'tools\l2decompile\lib\commons-lang3-3.4.jar'),
        (Join-Path $Root 'tools\l2decompile\lib\l2crypt-1.2.jar'),
        (Join-Path $Root 'tools\xdat_editor\commons\l2resources\build\libs\l2resources.jar'),
        (Join-Path $Root 'tools\xdat_editor\schema\commons\l2resources\libs\jsquish.jar')
    )
    foreach($dep in $groovyDeps + $groovyScript) {
        if(-not (Test-Path -LiteralPath $dep)) {
            throw "Missing English flag patch dependency: $dep"
        }
    }

    $groovyCp = [string]::Join(';', $groovyDeps)
    & $java -cp $groovyCp groovy.ui.GroovyMain $groovyScript $defaultUtxPath
    if($LASTEXITCODE -ne 0) {
        throw 'English flag patch failed.'
    }
}

$manifest = Join-Path $deployDir 'deploy_manifest.txt'
@(
    'ClientRoot=' + $ClientRoot,
    'DeployedAt=' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'),
    ''
) | Set-Content -LiteralPath $manifest -Encoding ASCII

Add-Content -LiteralPath $manifest -Encoding ASCII -Value '[Sources]'
foreach($file in $deployFiles) {
    Add-Content -LiteralPath $manifest -Encoding ASCII -Value ($file.Rel + ' <= ' + $file.Src)
}

Add-Content -LiteralPath $manifest -Encoding ASCII -Value ''
Add-Content -LiteralPath $manifest -Encoding ASCII -Value '[PostDeployHashes]'
$hashTargets = $deployFiles | ForEach-Object { $_.Dst }
if($PatchEnglishFlag) {
    $hashTargets += $defaultUtxPath
}
Get-FileHash -LiteralPath $hashTargets -Algorithm SHA256 |
    ForEach-Object {
        Add-Content -LiteralPath $manifest -Encoding ASCII -Value ($_.Path + ' | ' + $_.Hash)
    }

Add-Content -LiteralPath $manifest -Encoding ASCII -Value ''
Add-Content -LiteralPath $manifest -Encoding ASCII -Value '[IniSanitizer]'
Add-Content -LiteralPath $manifest -Encoding ASCII -Value ('WindowsInfoRemovedShortcutWndVertical4And5=' + $cleanedWindowsInfo)

Get-Item -LiteralPath $manifest
