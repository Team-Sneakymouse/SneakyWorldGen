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

Custom **amplified-based** terrain (`sneakyworldgen:adventure` noise settings) with taller peaks, deeper valleys, and extra jaggedness — plus a **whitelisted** multi-noise biome set: green lowlands, highlands/peaks, jungles, savannas, rivers/coasts, warm ocean, and all cave biomes (including sulfur caves). Lifeless biomes (deserts, badlands, most other oceans, plains/forest fillers, etc.) are removed so climate niches fill from nearby kept biomes.

Biome whitelist: [`datapack/data/sneakyworldgen/tags/worldgen/biome/adventure.json`](datapack/data/sneakyworldgen/tags/worldgen/biome/adventure.json)

**Direction**: epic mega-tree forests, cliff/scree on highlands, wilder river banks, biome color polish, and sparse ruined roads as a hint of long-abandoned civilization. Vanilla villages, mineshafts, and trial chambers are disabled pack-wide.

**In pack now**
- Structures: no villages / mineshafts / trial chambers; denser ancient cities in deep dark
- No water/lava cliff springs (`spring_water` / `spring_lava`)
- Caves: large cheese **pockets** only (no spaghetti/noodle/carver snakes), ~3× wider than vanilla cheese scale. Mid-depth = lush/dripstone/sulfur; deep band depth `[0.8, 1.2]` = deep dark
- Biomes: beach/snowy beach/stony shore continentalness narrowed (less inland paint); ice spikes inland-only (no coastal niches)
- Noise: `sneakyworldgen:adventure` (amplified peaks; calm coasts/wetlands — swamp/mangrove pinned to coastal continentalness, flat sea-level offset)
- Terrain features: stone/peak/shore cliffs, scree, river-bank carve, ruined roads (`sneakyworldgen:adventure/terrain/*`)
- Highland andesite recolor; peak de-snowify + lee-side shadow snow
- Moss floor + dense fern understory + rainforest vines (OGT, jungle, dark forest)
- Alpine tree-line banding (low/mid/high spruce) on taiga, snowy taiga, grove, windswept forest
- Swamp mud + pools + hanging moss (swamp, mangrove swamp)
- Alpine tarns (meadow, cherry grove, grove); rocky coast mossy stone/tuff (beach, stony shore)
- Fallen logs + forest bushes on wooded biomes
- Dark forest mud floor + huge/dense fungi; pale garden eerie floor/moss/hanging moss + sparse oaks
- Glacial ice spikes (blue ice, scree, grass islands, denser spikes); erratic stone piles (meadow/taiga/grove/etc.)
- Savanna highland kit (packed-mud crust, woodland/sparse acacia, tussock grass)
- Wilder rivers (gravel bars, bank grass, gallery oaks)
- Jungle elevation banding (lowland canopy → midland → upland scrub) + jungle floor
- Meadow fir pockets + denser wildflowers
- OGT muddy-roots / mossy-gravel floor; cathedral mega-conifers in old-growth taiga
- Sparse jungle open woodland (grass-first floor, light ferns) + tropical flowers; dense bamboo jungle bands + clearings
- Grove coarse/scree spread; powder-snow pockets (peaks, grove, snowy taiga/beach)
- Warm ocean seafloor rocks + denser coral; floating lilies on wetlands/rivers/tarns
- Taiga/meadow/OGT gravel flats; cherry pool densify; beach shore cliffs
- Trees: huge spruce/pine for old-growth taiga; denser jungle canopy with huge jungle trees; common + custom trees scaled for ≥5-block clear trunks + proportional crowns (vanilla spruce/oak/pine/etc. overridden)
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
      noise_settings/<generator>.json    # plot + adventure
      density_function/adventure/…       # adventure terrain shape
      biome/…
      density_function/<generator>/…
```

## License

All rights reserved unless otherwise noted.
