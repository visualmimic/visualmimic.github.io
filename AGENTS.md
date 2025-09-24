# Repository Guidelines

## Project Structure & Module Organization
Core landing content lives in `index.html`, which drives all sections of the site. Shared styles sit under `assets/css/` (edit `main.css` for global rules) while icons and fonts are in `assets/fontawesome/` and `assets/fonts/`. Media examples are stored in `videos/` (organized by scenario such as `sim`, `real`, and `analysis`) and lightweight demo pages live in `demo/<task>/`. Keep supporting imagery in `images/` and logos in `assets/logos/` to avoid mixing source assets.

## Build, Test, and Development Commands
Serve the site locally with `python3 -m http.server 8000` from the repository root to preview changes. Use `npx serve` if you prefer a Node tooling stack. The helper script `bash update.sh` stages every file, commits with a generic message, and pushes; override it with manual `git` commands when you need granular control or non-default remotes.

## Coding Style & Naming Conventions
Indent HTML and CSS with four spaces and keep inline styles minimal—extend `assets/css/main.css` when possible. Name media files with lowercase, hyphenated descriptors (for example, `kick-ball-step.mp4`) to remain consistent with existing folders. Reuse the established color tokens and typography (Source Sans and Source Serif) already referenced in the CSS to maintain visual harmony.

## Testing Guidelines
There is no automated test suite, so rely on manual verification before submitting changes. Confirm the page renders in desktop and mobile breakpoints, check video playback in Chromium- and WebKit-based browsers, and validate that relative paths resolve when served locally. When introducing new media, ensure load times remain acceptable and preview links in the demos function end-to-end.

## Commit & Pull Request Guidelines
Recent history uses terse `update` commits; please switch to descriptive messages such as `feat: add sim2sim gallery` or `fix: adjust hero layout`. Group related changes into a single commit and run `git status` to confirm only intended files are staged. Pull requests should summarize the change, link to any related issues, and attach before/after screenshots or clips for visual updates. Highlight any manual verification performed so reviewers can reproduce it quickly.

## Asset & Media Handling
Use `./mov_to_mp4.sh <folder>` to convert `.mov` recordings to `.mp4` before committing; store the outputs in the matching subfolder inside `videos/`. Large raw captures belong in `videos/analysis/` and web-ready clips in `videos/real_vis/` or `videos/sim_vis/`. Keep file sizes reasonable (prefer H.264, medium preset) to ensure smooth playback on the deployed site.
