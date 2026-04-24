param(
    [string]$Root = $PSScriptRoot
)

$ErrorActionPreference = 'Stop'

$javaSource = Join-Path $Root 'asset_tools\ExportInterfaceTexturePack.java'
$textureDir = Join-Path $Root 'src\Interlude\Interface\Textures'
$outputDir = Join-Path $Root 'dist\interface_texture_pack'
$tempDir = Join-Path $Root 'build_work\java_tools_texture_pack'

$javac = @(
    'C:\Program Files\Java\jdk1.8.0_333\bin\javac.exe',
    'C:\Program Files\Java\jdk-17.0.1\bin\javac.exe'
) | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1

$java = @(
    'C:\Program Files\Java\jdk1.8.0_333\bin\java.exe',
    'C:\Program Files\Java\jdk-17.0.1\bin\java.exe'
) | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1

if(-not $javac -or -not $java) {
    throw 'Java JDK not found. Expected javac/java in Program Files\Java.'
}

$jsquishJar = Join-Path $Root 'tools\xdat_editor\schema\commons\l2resources\libs\jsquish.jar'
if(-not (Test-Path -LiteralPath $jsquishJar)) {
    throw "Missing dependency: $jsquishJar"
}

New-Item -ItemType Directory -Force -Path $outputDir, $tempDir | Out-Null
Get-ChildItem -LiteralPath $tempDir -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse
Get-ChildItem -LiteralPath $outputDir -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse

& $javac -cp $jsquishJar -d $tempDir $javaSource
if($LASTEXITCODE -ne 0) {
    throw 'Texture pack compiler failed.'
}

& $java -cp ([string]::Join(';', @($tempDir, $jsquishJar))) ExportInterfaceTexturePack $textureDir $outputDir
if($LASTEXITCODE -ne 0) {
    throw 'Texture pack export failed.'
}

Get-ChildItem -Recurse -LiteralPath $outputDir | Select-Object FullName,Length | Format-Table -AutoSize
