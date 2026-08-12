---
name: "skill-currency-check"
description: "On-demand audit that compares skills currently installed in this Cowork session against canonical versions in the BoS OS GitHub repos, using skills-manifest.yml as the source of truth. Catches version drift, broken installs, and skills not yet shared to GitHub. Works for any BoS OS user."
metadata:
  version: 1.0.0
  author: Business of Software
  prerequisites: A BoS OS install with one or more skills already in place
---

# Skill Currency Check

**Version:** 1.0
**Status:** RELEASED

**Author:** Business of Software
**Owner:** Mark Littlewood

Compares every installed skill against its canonical counterpart in the BoS OS GitHub repos (BoS_OS_Start, Quick_Questions, BoS_OS_Advancing_Skills), using a central manifest as the source of truth. This works for anyone running BoS OS, whether they have local 05_ARTIFACTS/Skills/ or not.

The point is to catch three different failure modes:

1. **Version drift** — the installed skill is an older (or newer, unreleased) version than the one in GitHub.
2. **Broken installs** — the installed skill's body was truncated during sync and replaced with a placeholder like `[Full skill content included - 219 lines]` instead of real instructions. Silent and serious: the skill still appears in the available-skills list, but invoking it gives Claude no actual instructions to follow.
3. **Not yet shared** — a skill exists locally but isn't in any of the three GitHub repos. A gentle flag: "This skill is not in the BoS OS repo. You may consider sharing it."

Report findings as you find them, don't wait until the full scan is done — if you hit a stub or a clear mismatch partway through, say so immediately, then keep going.

## Step 1: Load the skills manifest

Fetch `https://raw.githubusercontent.com/BoSMark/BoS_OS_Start/main/skills-manifest.yml` and parse it.

The manifest maps skill names to their GitHub repos. Structure:

```yaml
skills:
  agent-os-bootstrap:
    repo: "BoS_OS_Start"
    path: "skills/agent-os-bootstrap/SKILL.md"
  signalprocessing:
    repo: "Quick_Questions"
    path: "SKILL.md"
  some-skill:
    repo: "BoS_OS_Advancing_Skills"
    path: "advanced/some-skill/SKILL.md"
```

The `repo` field maps to one of three GitHub repos in the BoSMark org:
- `BoS_OS_Start` → https://github.com/BoSMark/BoS_OS_Start
- `Quick_Questions` → https://github.com/BoSMark/Quick_Questions
- `BoS_OS_Advancing_Skills` → https://github.com/BoSMark/BoS_OS_Advancing_Skills

If the manifest can't be fetched or is malformed, report that immediately and stop — the check can't proceed without the source of truth.

## Step 2: List installed skills

Using `mcp__skills__list_skills` or the system prompt's `<available_skills>` listing, get each installed skill's `name` and `location` (the SKILL.md path in the plugin cache).

Read each installed SKILL.md directly with the Read tool to get the full body — you need actual content, not just metadata.

Skip generic, non-BoS skills that don't originate from the BoS OS pipeline: `docx`, `pdf`, `pptx`, `xlsx`, `schedule`, `setup-cowork`, `skill-creator`, `consolidate-memory`, and any obviously-generic Anthropic-provided skill. These have no canonical GitHub entry and would only produce false "orphan" noise.

In scope: anything that looks BoS-authored (agent-os-*, signalprocessing, prospect-intelligence-scoping, skill-currency-check, bos-competitive-signal-watch, signal-consolidation-sweep, transcript-insight-processor, ceo-interview-prep, founder-alignment-check, founder-replaceability-check, otter-transcript-pull-shared, ai-readiness-check, bos-os-demo-guide, and similar).

## Step 3: Check for broken installs first

Before comparing versions or content, check whether the installed file's body (after frontmatter) is just a heading plus a line matching the pattern `[Full skill content included - N lines...]` or clearly truncated/stubbed. If so, this is a **BROKEN INSTALL** — flag it immediately as high severity. Don't try to diff a stub; there's nothing meaningful to diff.

## Step 4: Look up each skill in the manifest

For each installed skill:

- If the skill name appears in the manifest, get its `repo` and `path`.
- If not found in the manifest, the skill is **NOT IN MANIFEST** — proceed to Step 6 ("not yet shared" report).

## Step 5: Fetch canonical from GitHub and compare

For each skill in the manifest:

1. Build the raw GitHub URL: `https://raw.githubusercontent.com/BoSMark/{repo}/main/{path}` (using the repo name and path from the manifest).
2. Fetch the canonical SKILL.md from that URL using `mcp__workspace__web_fetch` or equivalent.
3. If the fetch fails (404, network error, etc.), report it as a **GITHUB FETCH ERROR** and flag for the user — don't guess or skip.

**Compare version:**

1. Look for a version number in two places: the installed file's frontmatter (`metadata.version` or `version:` field) and the canonical GitHub file's frontmatter (same fields).
2. If both have resolvable version numbers, compare them directly:
   - Canonical version higher → installed is behind (divergence: canonical newer)
   - Installed version higher → installed is ahead (divergence: installed ahead)
   - Versions equal → proceed to content diff
3. If either side lacks a version number, or versions are equal but content might differ, fall back to a text diff of the body content (strip frontmatter and trailing whitespace). Zero diff → they match. Non-zero diff with no version signal → flag as undecidable divergence.
4. Minor cosmetic drift (punctuation, em-dashes vs colons per the "no em-dashes" writing standard) still counts as drift — note it as "cosmetic only" so it doesn't read as urgent.

## Step 6: Report

Chat only — this is a read-only diagnostic. Nothing is written to disk or to a tracked folder just from running the check.

For each installed BoS skill, give one line: name, status, and one concrete detail (version numbers, whether it's a stub, what the diff showed).

**Status codes:**
- `MATCH` — no drift
- `CANONICAL NEWER` — GitHub version is ahead
- `INSTALLED AHEAD` — local version is ahead
- `BROKEN INSTALL` — truncated stub
- `NOT IN MANIFEST` — skill exists locally but isn't in skills-manifest.yml (suggest sharing)
- `GITHUB FETCH ERROR` — couldn't reach GitHub to compare

**Report order:**
1. **BROKEN INSTALL** items first (highest severity)
2. **CANONICAL NEWER** items next (proposed batch for update)
3. **GITHUB FETCH ERROR** items (blocked checks)
4. **INSTALLED AHEAD** items (flagged for attention, not auto-fixable)
5. **NOT IN MANIFEST** items (gentle sharing suggestion)
6. **MATCH** items (clean, bulk them together)

## Step 7: Propose updates for canonical-is-newer

If any skills are `CANONICAL NEWER`, batch them together and present to the user:

- Skill name
- Old version → new version (or "stub → real content" for broken installs)
- Approval question: "Update these X skills from GitHub?"

Once approved, call `mcp__cowork__save_skill` with `overwrite: true` for each approved item, using the canonical SKILL.md from GitHub (with frontmatter intact). Do not auto-commit — always wait for explicit approval.

## What this skill does not do

- It doesn't auto-merge or reconcile line-by-line differences.
- It doesn't silently push updates — always wait for user approval.
- It doesn't write to tracked folders (05_ARTIFACTS/Skills/ or GitHub repos) directly. Pushing an INSTALLED AHEAD skill back to canonical is a tracked-folder write and follows the normal decision cascade.
- It doesn't require internet for the check itself if the user has a local copy of the manifest, but without GitHub access, INSTALLED AHEAD and version-drift checks can't proceed.

---

# INTEGRATION & HAND-OFFS

## Skill Currency Check and Your BoS OS

Skill Currency Check is an **advancing skill**, but it sits apart from the build pipeline rather than inside it. It doesn't require a completed Bootstrap or Workshop pass, and it doesn't produce a spec or a mission — it's a maintenance and hygiene tool that assumes only one thing: at least one BoS-authored skill is already installed, somewhere, in this Cowork session.

**Bootstrap** (build your folder structure and strategy documents)
→ **Workshop** (refine strategy, create agent specs, define your first mission)
→ *(any skill install, at any point in the pipeline)*
→ **Skill Currency Check** (confirm what's installed actually matches what's live on GitHub, on demand)

It has no forward hand-off in the way a scoping or build skill does — its output is a chat report and, if the user approves, a batch of `save_skill` overwrites. Nothing it produces feeds into a mission, a spec, or another skill's input. Run it whenever version drift, a broken install, or an unshared local skill is suspected, or on a regular cadence as a light health check.

## Hand-Off to Nothing (by design)

Unlike Prospect Intelligence Scoping's hand-off to Agent OS Run, this skill's output is consumed entirely by the user in the same session — approve, decline, or ignore each finding. If the user wants to push an `INSTALLED AHEAD` skill back to canonical GitHub, that's a separate, deliberate tracked-folder write following the normal decision cascade, not something this skill initiates.

---

## Version History

**v1.0 (2026-08-12) First public release.**

*Skill Currency Check, Business of Software. AI-generated skill; review before activating on production data. All work is subject to the host install's own CLAUDE.md hard constraints.*
