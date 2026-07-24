# Changelog

All notable changes to BoS OS Advancing Skills are documented here.

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
