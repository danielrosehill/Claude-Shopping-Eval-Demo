[![Claude Code Project](https://img.shields.io/badge/Claude%20Code-Project-blue?style=flat-square&logo=github)](https://github.com/danielrosehill/Claude-Code-Repos-Index)

# Claude Shopping Eval Demo

A demo of using [Claude Code](https://claude.ai/claude-code) as a consumer purchasing assistant for a relatively small purchase — in this case, a portable Bluetooth speaker.

## How It Works

```
┌──────────────┐     ┌────────────────┐     ┌───────────────┐     ┌─────────────┐     ┌──────────┐
│ Define Specs │────▶│ Gather Prices  │────▶│  Run Agent    │────▶│ Read Report │────▶│ Purchase │
│              │     │                │     │               │     │             │     │          │
│ Write what   │     │ Screenshot     │     │ /recommend    │     │ Typeset PDF │     │ Buy with │
│ you need in  │     │ catalog pages  │     │ analyzes spec │     │ with ranked │     │ full     │
│ spec.md      │     │ from stores    │     │ vs. all data  │     │ picks       │     │ context  │
└──────────────┘     └────────────────┘     └───────────────┘     └─────────────┘     └──────────┘
```

## Advantages of This Approach

This approach is slower than browsing websites — but that's the point. It would simply not be possible to manually look up spec sheets and cross-reference them against a personal requirements document in the time it takes Claude to run through the catalogs. The result is a much more precise match against your actual needs, not just a "top 10 best speakers" listicle.

I've used this exact pattern many times for consumer purchases, each time with excellent results. The process consistently:

- **Matches against your actual spec, not generic reviews** — Claude reads your requirements document and evaluates every product against *your* criteria (room size, use case, budget), not a reviewer's assumptions
- **Surfaces products I wouldn't have considered** — Claude cross-references across stores and price tiers, catching options I'd have scrolled past
- **Catches pricing anomalies** — especially useful living in Israel, where products are often marked up significantly versus international markets. Sometimes you discover things are actually *well-priced* locally (as in this case — the JBL Flip 7 was 27% below international RRP at KSP)
- **Identifies value for money precisely** — by comparing local prices against international RRP across every store, Claude can instantly flag which products are overpriced locally and which are genuine deals
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
- **`/catalog-to-json`** — Extract all products from catalog screenshots into structured `products.json` (useful as a first pass before analysis, or for building a persistent product database)
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

## Recommended Additional Tooling

The catalog screenshot approach works well on its own, but you can significantly enhance it with live data ingestion and better output formatting.

### Live Search & Price Ingestion

The demo uses static screenshots, but for real-time pricing you'll want an MCP server or tool that can fetch current web data:

- **Gemini MCP** — I used Gemini for real-time search ingestion in the actual research behind this demo. Gemini's grounding in Google Search makes it especially good at pulling current prices and specs from product pages. Configure it as an MCP server so Claude can call it mid-analysis.
- **Firecrawl** — A web scraping tool available as an MCP server. Useful for extracting structured data from product pages, especially when you need to pull full spec sheets rather than just prices.
- **Context7** or similar documentation/search MCPs — helpful for pulling manufacturer spec sheets and datasheets when you need precise technical comparisons.

### PDF Output with Typst

The recommendation report in this demo is typeset with [Typst](https://typst.app/), a modern document preparation system. Typst is ideal for this use case because:

- Claude can write Typst markup directly — the syntax is clean and LLM-friendly
- Compilation is near-instant (`typst compile recommendations.typ`)
- The output is a properly typeset PDF with tables, color-coded cards, and professional formatting
- No LaTeX installation or dependency hell required

Install Typst:
```bash
# On most systems
cargo install --git https://github.com/typst/typst --locked typst-cli

# Or via package manager
brew install typst        # macOS
sudo snap install typst   # Ubuntu
```

The `/recommend` command generates a `.typ` file and compiles it automatically. See [`recommendations.typ`](recommendations.typ) for an example of what Claude produces.

---

For more Claude Code projects, visit [my index](https://github.com/danielrosehill/Claude-Code-Repos-Index).
