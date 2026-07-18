# SneakyWorldGen

Custom world-generation datapack for **Minecraft Java Edition 26.2** (data pack format **107.1**).

Ships multiple world presets in one pack under the `sneakyworldgen` namespace.

## World presets

| Preset | `level-type` | Purpose |
|--------|--------------|---------|
| **Plot** | `sneakyworldgen:plot` | Flat-ish freebuild / plot server worlds |
| **Adventure** | `sneakyworldgen:adventure` | Lush, highland-focused exploration (New Zealand / LOTR vibe) |

### Plot

Custom noise settings, single biome, grass surface. Tuned for building, not exploration.

### Adventure

Vanilla overworld terrain for now, with a **whitelisted** multi-noise biome set: green lowlands, highlands/peaks, jungles, savannas, rivers/coasts, warm ocean, and all cave biomes (including sulfur caves). Lifeless biomes (deserts, badlands, most other oceans, plains/forest fillers, etc.) are removed so climate niches fill from nearby kept biomes.

Biome whitelist: [`datapack/data/sneakyworldgen/tags/worldgen/biome/adventure.json`](datapack/data/sneakyworldgen/tags/worldgen/biome/adventure.json)

**Direction**: epic mega-tree forests, cliff/scree on highlands, wilder river banks, biome color polish, and sparse ruined roads as a hint of long-abandoned civilization. Custom noise for mountain drama comes later.

**In pack now**
- Terrain: stone/peak/shore cliffs, scree, river-bank carve, ruined roads (`sneakyworldgen:adventure/terrain/*`)
- Highland andesite recolor; peak de-snowify + lee-side shadow snow
- Moss floor + dense fern understory + rainforest vines (OGT, jungle, dark forest)
- Alpine tree-line banding (low/mid/high spruce) on taiga, snowy taiga, grove, windswept forest
- Swamp mud + pools + hanging moss (swamp, mangrove swamp)
- Trees: huge spruce/pine for old-growth taiga; denser jungle canopy with huge jungle trees
- Biome overrides (feature wiring + sky/foliage/water polish)

## Install

1. Download `SneakyWorldGen.zip` from [Releases](https://github.com/Team-Sneakymouse/SneakyWorldGen/releases) (rolling **Latest datapack**, or a `v*` tag).
2. Drop it into the world’s `datapacks/` folder (create a new world, or wipe terrain if switching generator).
3. Set the world type / server `level-type` to `sneakyworldgen:plot` or `sneakyworldgen:adventure` (escape the colon in `server.properties`: `sneakyworldgen\:plot`).

## Develop / test locally

Repo layout:

```
datapack/          # source of truth for the datapack
scripts/test.sh    # zip → deploy → wipe world → set level-type → start Paper
run/               # local Paper test server (gitignored except .gitkeep)
```

Requirements: Java, `zip`, and `run/paper-*.jar` present.

```bash
./scripts/test.sh plot       # or: adventure
```

VS Code / Cursor tasks (`.vscode/tasks.json`):

- **Test: plot** — default build task (`Ctrl+Shift+B`)
- **Test: adventure**

The script stops any running Paper process, zips `datapack/` into `run/world/datapacks/SneakyWorldGen.zip`, deletes everything under `run/world/` except `datapacks/`, sets `level-type`, then starts the server with `--nogui`.

## Releases

Pushing to `main` runs [`.github/workflows/publish-datapack.yml`](.github/workflows/publish-datapack.yml): zips the datapack and updates the rolling **Latest datapack** release (`latest` tag).

Push a tag `v*` (e.g. `v1.0.0`) for a versioned release.

## Pack layout

Generators live side by side under `data/sneakyworldgen/`:

```
datapack/
  pack.mcmeta
  data/sneakyworldgen/
    dimension_type/<generator>.json      # when custom
    tags/worldgen/biome/adventure.json
    worldgen/
      world_preset/<generator>.json
      noise_settings/<generator>.json    # plot today; adventure uses vanilla for now
      biome/…
      density_function/<generator>/…
```

## License

All rights reserved unless otherwise noted.
