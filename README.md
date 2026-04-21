# Interlude Interface

Cleaned Lineage II Interlude interface sources for client protocol 746.

## Layout

- `src/Interlude/Interface/Classes` - cleaned UnrealScript sources.
- `dist/Interlude/Interface.u` - compiled package ready for testing.
- `dist/Interlude/Interface.xdat` - matching xdat copied from the project input.
- `build_interface.ps1` - rebuilds `Interface.u` from `src`.

## Build

Run from PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File H:\ANT-BUILD\INTERFACE\build_interface.ps1
```

The result is written to:

```text
H:\ANT-BUILD\INTERFACE\dist\Interlude\Interface.u
```

## Current TargetStatusWnd Logic

`TargetStatusWnd.HandleTargetUpdate()` treats `Info.nUserRank` as the active class id and renders it with:

```uc
RankName = GetClassType(Info.nUserRank);
```
