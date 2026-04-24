param(
    [string]$Root = $PSScriptRoot,
    [string]$SourcePackagePath
)

$ErrorActionPreference = 'Stop'

$textureDir = Join-Path $Root 'src\TooltipTex\Textures'
$javaSource = Join-Path $Root 'tools\BuildTooltipTex.java'
$outputDir = Join-Path $Root 'dist\Interlude'
$outputPackage = Join-Path $outputDir 'fange_ui.utx'
$tempDir = Join-Path $Root 'build_work\java_tools'

if(-not (Test-Path -LiteralPath $textureDir)) {
    throw "Tooltip icon source folder not found: $textureDir"
}
if(-not (Test-Path -LiteralPath $javaSource)) {
    throw "Tooltip texture patcher source not found: $javaSource"
}

if([string]::IsNullOrWhiteSpace($SourcePackagePath)) {
    $candidates = @(
        'D:\L2ANT\systextures\fange_ui.utx',
        'D:\Interlude_clean\clean\systextures\fange_ui.utx'
    )

    foreach($candidate in $candidates) {
        if(Test-Path -LiteralPath $candidate) {
            $SourcePackagePath = $candidate
            break
        }
    }
}

if([string]::IsNullOrWhiteSpace($SourcePackagePath) -or -not (Test-Path -LiteralPath $SourcePackagePath)) {
    throw 'Unable to find a source fange_ui.utx package for tooltip icon build.'
}

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

$classpathParts = @(
    (Join-Path $Root 'tools\l2decompile\lib\L2unreal-1.0-SNAPSHOT.jar'),
    (Join-Path $Root 'tools\l2decompile\lib\l2io-2.0.jar'),
    (Join-Path $Root 'tools\l2decompile\lib\serializer-1.1-SNAPSHOT.jar'),
    (Join-Path $Root 'tools\l2decompile\lib\commons-io-2.4.jar'),
    (Join-Path $Root 'tools\l2decompile\lib\commons-lang3-3.4.jar'),
    (Join-Path $Root 'tools\l2decompile\lib\l2crypt-1.2.jar'),
    (Join-Path $Root 'tools\xdat_editor\commons\l2resources\build\libs\l2resources.jar'),
    (Join-Path $Root 'tools\xdat_editor\schema\commons\l2resources\libs\jsquish.jar')
)

foreach($part in $classpathParts) {
    if(-not (Test-Path -LiteralPath $part)) {
        throw "Missing Java dependency: $part"
    }
}

$classpath = [string]::Join(';', $classpathParts)

New-Item -ItemType Directory -Force -Path $outputDir, $tempDir | Out-Null
Get-ChildItem -LiteralPath $tempDir -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse

& $javac -cp $classpath -d $tempDir $javaSource
if($LASTEXITCODE -ne 0) {
    throw 'Tooltip texture patcher compilation failed.'
}

if(Test-Path -LiteralPath $outputPackage) {
    Remove-Item -LiteralPath $outputPackage -Force
}

$runtimeClasspath = [string]::Join(';', @($tempDir) + $classpathParts)
& $java -cp $runtimeClasspath BuildTooltipTex $SourcePackagePath $textureDir $outputPackage
if($LASTEXITCODE -ne 0) {
    throw 'Tooltip texture package build failed.'
}

Get-Item -LiteralPath $outputPackage
