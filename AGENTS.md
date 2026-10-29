# AGENTS.md

## Repo-specific rules

- **Read `.cursor/rules/minecraft-*.mdc` before editing worldgen JSON.** They are the 26.x format reference (e.g. removed `flower`/`random_patch`, `below_trunk_provider` required).
- **Keep the README in sync** (`.cursor/rules/maintain-readme.mdc`): update `README.md` in the same change when presets, install, the test script or release behaviour change. Link files instead of pasting lists.
- **Test before pushing.** Run `scripts/test.sh adventure` (or `plot`) and check the server log for registry/parse errors; bad JSON only fails at world load, and there is no CI validation. A push to `main` publishes the rolling release (`publish-datapack.yml`). `test.sh` wipes `run/world` (except datapacks) and hardcodes `PAPER_JAR` (`paper-26.2-62.jar`); run it only inside this repo's `run/`.
- **Namespace discipline.** Put new content under `data/sneakyworldgen/<type>/<preset>/`. Files under `data/minecraft` override vanilla for every world with the pack enabled; touch them only deliberately and note them in the README.
- **`pack.mcmeta` stays at the datapack root.** The workflow zips from inside `datapack/`.
