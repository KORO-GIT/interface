param(
    [string]$Root = $PSScriptRoot
)

$ErrorActionPreference = 'Stop'

$sourceClasses = Join-Path $Root 'src\Interlude\Interface\Classes'
$buildRoot = Join-Path $Root 'build_work\Interlude'
$buildClasses = Join-Path $buildRoot 'Interface\Classes'
$systemDir = Join-Path $buildRoot 'System'
$outputDir = Join-Path $Root 'dist\Interlude'
$outputPackage = Join-Path $outputDir 'Interface.u'
$buildPackage = Join-Path $systemDir 'Interface.u'
$logFile = Join-Path $systemDir 'ucc.log'

if(-not (Test-Path -LiteralPath $sourceClasses)) {
    throw "Source classes not found: $sourceClasses"
}
if(-not (Test-Path -LiteralPath (Join-Path $systemDir 'ucc.exe'))) {
    throw "Compiler not found: $systemDir\ucc.exe"
}

New-Item -ItemType Directory -Force -Path $buildClasses, $outputDir | Out-Null
Get-ChildItem -LiteralPath $buildClasses -Filter '*.uc' -File -ErrorAction SilentlyContinue | Remove-Item -Force
Get-ChildItem -LiteralPath $sourceClasses -Filter '*.uc' -File | Copy-Item -Destination $buildClasses -Force

Remove-Item -LiteralPath $buildPackage -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $logFile -Force -ErrorAction SilentlyContinue

Push-Location $systemDir
try {
    cmd /c "echo N|ucc make -NoBind"
}
finally {
    Pop-Location
}

if(-not (Test-Path -LiteralPath $buildPackage)) {
    if(Test-Path -LiteralPath $logFile) {
        Select-String -LiteralPath $logFile -Pattern 'Error:|Warning:' | Select-Object -Last 80 | ForEach-Object Line
    }
    throw 'Build failed: Interface.u was not produced.'
}

Copy-Item -LiteralPath $buildPackage -Destination $outputPackage -Force
Get-Item -LiteralPath $outputPackage
