[![Claude Code Project](https://img.shields.io/badge/Claude%20Code-Project-blue?style=flat-square&logo=github)](https://github.com/danielrosehill/Claude-Code-Repos-Index)

# Claude Shopping Eval Demo

A demo of using [Claude Code](https://claude.ai/claude-code) as a consumer purchasing assistant for a relatively small purchase — in this case, a portable Bluetooth speaker.

## Why This Works

I've used this exact pattern many times for consumer purchases, each time with excellent results. The process consistently:

- **Surfaces products I wouldn't have considered** — Claude cross-references across stores and price tiers, catching options I'd have scrolled past
- **Catches pricing anomalies** — especially useful living in Israel, where products are often marked up significantly versus international markets. Sometimes you discover things are actually *well-priced* locally (as in this case — the JBL Flip 7 was 27% below international RRP at KSP)
- **Handles AliExpress vs local trade-offs** — AliExpress is often cheaper, but shipping takes weeks and there's no local warranty. Claude factors this into the recommendation rather than just sorting by price

## The Pattern

The workflow has two ingredients:

### 1. A Spec

Write down what you need and why. This can be as informal as a voice note transcribed to text or a quick typed summary. The key is giving Claude enough context to evaluate *fit*, not just features.

See [`spec.md`](spec.md) for this demo's spec.

### 2. Pricing Data

Prices change constantly, so rather than relying on APIs or scrapers (which break), I use an informal but effective method: **screenshot the catalog pages** from relevant stores and drop them into the repo.

Claude Code reads the screenshots directly (it's multimodal), extracts every visible product and price, and cross-references across stores. The `catalogs/` directory is organized by store:

```
catalogs/
├── ali/      # AliExpress (prices in USD)
├── bug/      # Bug.co.il (prices in NIS)
├── ivory/    # Ivory.co.il (prices in NIS, Eilat prices)
└── ksp/      # KSP.co.il (prices in NIS, Eilat prices)
```

### 3. Claude Does the Rest

Using custom slash commands and subagents (see `.claude/`), Claude:

- Scans every screenshot and extracts structured product data
- Analyzes pricing across stores and compares to international RRP
- Evaluates each product against the spec
- Generates a ranked recommendation report as a typeset PDF

## What's in This Repo

| File | Description |
|------|-------------|
| [`spec.md`](spec.md) | The purchase requirements — what I need and why |
| [`catalogs/`](catalogs/) | Screenshots from 4 Israeli electronics retailers + AliExpress |
| [`recommendations.typ`](recommendations.typ) | Claude-generated recommendation report (Typst source) |
| [`recommendations.pdf`](recommendations.pdf) | The compiled PDF output |
| [`.claude/`](.claude/) | Subagents and slash commands that power the workflow |

## The Agents & Commands

### Subagents (`.claude/agents/`)

- **`catalog-scanner`** — Reads catalog screenshots, extracts product/price data, renames files descriptively
- **`price-analyst`** — Cross-references prices across stores, calculates RRP deviation, identifies best value

### Slash Commands (`.claude/commands/`)

- **`/add-product`** — Scan a new catalog screenshot and add its products to the dataset
- **`/compare`** — Side-by-side comparison of specific products across all stores
- **`/recommend`** — Generate the full ranked recommendation report from spec + catalogs

## Result

For this particular purchase, Claude recommended the **JBL Flip 7 at ₪349 from KSP** — 27% below international RRP, 2.5–3x louder than my current speaker, with excellent podcast/voice clarity. It also flagged budget alternatives (Xiaomi at ₪249, Tribit at ~₪210 from AliExpress) and a premium option (JBL Charge 6 at ₪489).

See the full report: [`recommendations.pdf`](recommendations.pdf)

## Replicating This

1. Create a repo with a `spec.md` describing what you're looking for
2. Screenshot catalog/product pages from relevant stores into `catalogs/{store}/`
3. Copy the `.claude/` directory from this repo (agents + commands)
4. Run `/recommend` in Claude Code

The pattern works for any consumer purchase where you want to compare across multiple stores and evaluate against specific requirements.

---

For more Claude Code projects, visit [my index](https://github.com/danielrosehill/Claude-Code-Repos-Index).
