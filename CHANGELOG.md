# Changelog

All notable changes to BoS OS Advancing Skills are documented here.

---

## skill-currency-check v1.1.1 (2026-08-19)

### Fix: ghost-repo routing

`BoSOS-Bootstrap`, `BoSOS-Workshop`, and `BoSOS-Run` are real, live repos in the BoSMark org — frozen single-skill pointer mirrors with no version-specific content, no CI/CD sync to `BoS_OS_Start`. Their names closely match the `agent-os-bootstrap`/`agent-os-workshop`/`agent-os-run` skill names, which made them an easy wrong guess if a repo name were ever inferred from a skill name rather than read from `skills-manifest.yml`. Step 1 now names all three explicitly and instructs the skill never to fetch from them; `BoS_OS_Start` is the only canonical source for those three skills, which the manifest already correctly reflected. Steps 2 and 5 updated to match — all three Toolkit skills stay in scope and get checked normally, never excluded. No manifest change required.

### Upgrade path

Instructions-only fix, no schema or behaviour change for any other skill. Re-download or re-sync via Skill Currency Check itself.

---

## skill-currency-check v1.1.0 (2026-08-12)

### New: Supersession detection (Phase 1)

Added a check for skills the manifest marks as superseded by a newer one (`supersedes`, `deprecated_date`, `replacement_guidance` — three new optional manifest fields), reported informationally with a new `SUPERSEDED` status code. No auto-removal; the user decides. No manifest entries use it yet — ships the mechanism ahead of the first real case.

### Upgrade path

New capability, additive. No migration needed.

---

## skill-currency-check v1.0.0 (2026-08-12)

### New: Skill Currency Check (third Advancing Skill)

A simple, basic way of keeping your BoS OS current: an on-demand audit that compares every skill installed in your Cowork session against the canonical version in these repos, using a central manifest as the source of truth. It won't touch anything without asking, but it may surface ideas for doing things more efficiently, a skill you're running on an old version, one that's silently broken, or one you built locally and never shared back.

Catches three failure modes: version drift, broken installs (a skill truncated to a stub during sync), and skills that exist locally but aren't yet in any BoS OS repo. Reports findings in chat only; updates only happen with explicit approval, one batch at a time.

### Upgrade path

New addition to the repo. Nothing to migrate. SignalProcessing and Prospect Intelligence Scoping are unaffected and remain at their own v1.0.0.

### Infrastructure

`.github/workflows/release.yml` and `scripts/pre-release-checklist.sh` both gained a package-structure check (build each skill's `.skill`, confirm `SKILL.md` sits at the zip root, not nested inside a wrapping folder). This closes a gap found live during this release: the zip-nesting fix described in `GitHub_Release_Process.md` v1.7 as already ported to this repo was verified live-missing at the start of this build.

Checking the two already-live `.skill` assets against this same test confirmed both were affected, see the two patch releases immediately below, shipped in the same push as this release.

---

## signalprocessing v1.0.1 (2026-08-12)

### Fix: repackaged, no content change

The `v1.0.0` release of SignalProcessing shipped with `SKILL.md` nested one level too deep inside its `.skill` zip (`signalprocessing/SKILL.md` instead of `SKILL.md` at the root), which breaks Cowork's skill uploader. Confirmed by downloading and inspecting the live `v1.0.0` asset. Repackaged correctly under `v1.0.1`; the skill's content and behaviour are unchanged. Anyone who downloaded `v1.0.0` and hit an install error should re-download from this release.

### Upgrade path

Packaging fix only. No content or behaviour change from v1.0.0.

---

## prospect-intelligence-scoping v1.0.1 (2026-08-12)

### Fix: repackaged, no content change

Same bug, same fix as SignalProcessing above: the `prospect-intelligence-scoping-v1.0.0` release had `SKILL.md` nested one level too deep inside its `.skill` zip. Confirmed by downloading and inspecting the live asset. Repackaged correctly under `v1.0.1`; the skill's content and behaviour are unchanged. Anyone who downloaded `v1.0.0` and hit an install error should re-download from this release.

### Upgrade path

Packaging fix only. No content or behaviour change from v1.0.0.

---

## prospect-intelligence-scoping v1.0.0 (2026-07-24)

### New: Prospect Intelligence Scoping (second Advancing Skill)

Scopes a prospect-intelligence system by pressure-testing whether the criteria that define your buyers, and the gatekeepers inside them, are discoverable from public data before you build anything. Four steps (TAM, ICP fit, gatekeeper identification, best route in), sharpened through a challenger-advisor conversation, classified by discoverability (attribute / event / judgement / private-fact), and, where live tools are available, prototyped against real public data with a coverage hit-rate reported per criterion, not just a pass/fail. Produces a feasibility scorecard plus a build-ready spec.

Built by Tim Barker, tested against his own company's real data before release.

### Upgrade path

New addition to the repo. Nothing to migrate. SignalProcessing is unaffected and remains at its own v1.0.0.

### Infrastructure

`.github/workflows/release.yml` generalized to support multiple independently-versioned skills in this repo. Previously hardcoded to SignalProcessing only. New releases from this point on tag as `<skill-folder>-v<version>` (e.g. `prospect-intelligence-scoping-v1.0.0`) rather than a bare version number, to avoid collisions across skills. SignalProcessing's existing `v1.0.0` tag is untouched.

---

## v1.0.0 (2026-07-17)

### New: SignalProcessing (first Advancing Skill)

Turns recorded conversations and transcripts into signals that feed your BoS OS's core documents. Four stages: Document Architect (identify and design your critical documents), Signal Sweeper (extract and stage candidate signals from conversations), Approval (one batched decision per run, visible before anything writes), Promotion (write, verify, three anomaly checks before anything touches your files).

Confidentiality screening runs before staging, using a generic, fixed exclusion notice that never names what was excluded. No autonomy phase: every batch requires your explicit sign-off in v1.

### Upgrade path

New install. Nothing to migrate.
