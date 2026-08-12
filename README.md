# BoS OS: Advancing Skills

Advancing skills extend a BoS OS once the core is running. Bootstrap has built your operating system, Workshop has refined it, and you're ready to add capability, not just get started.

This repo collects them. Each skill lives in its own folder and versions and releases independently.

**Prerequisite for everything here:** Bootstrap complete, Workshop complete (or at least one core document identified). If you haven't run those yet, start at [BoS_OS_Start](https://github.com/BoSMark/BoS_OS_Start).

---

## What's here

**SignalProcessing** (v1.0.1): turns recorded conversations and transcripts into signals that feed your BoS OS's core documents (a roadmap, an FAQ, a testimonials file, whatever you name), on a batched, approved cadence. Nothing writes to a document without you seeing it first.

The skill teaches you the importance of your core documents, then shows you how to set your system up so that customer interviews and customer conversations you've transcribed can be fed into it, informing everything from frequently asked questions to roadmap ideas. You'll then learn how to process transcripts, first one by one to see how they work, then on a regular cadence.

**Prospect Intelligence Scoping** (v1.0.1): scopes a prospect-intelligence system by pressure-testing whether the criteria that define your buyers, and the gatekeepers inside them, are actually discoverable from public data before you build anything. A challenger-advisor, not a form: takes your rough definitions across four steps (target market, ICP fit, gatekeeper identification, best route in), sharpens each until precise, classifies each criterion by how it can actually be found, then, where tools allow, runs a live prototype against real public data and reports a coverage hit-rate, not just a pass/fail. Produces a feasibility scorecard and a build-ready spec.

Built by Tim Barker to scope his own company's prospect intelligence, before it was offered here.

**Skill Currency Check** (v1.0.0): an on-demand audit that compares the skills installed in your Cowork session against the canonical versions in these BoS OS repos. It's a way of keeping your system current that doesn't touch anything without your say-so, and it can surface skills worth updating that you'd otherwise never notice had moved on. Catches three things: version drift (yours is older, or newer, than what's live), broken installs (a skill silently truncated to a stub during sync), and skills you've built locally but never shared back. Reports what it finds in chat; nothing updates without your explicit approval.

See [CHANGELOG.md](CHANGELOG.md) for release history.

---

## Getting started

Each skill in this repo is released and versioned independently.

**Step 1: Download the skill**

Go to [Releases](https://github.com/BoSMark/BoS_OS_Advancing_Skills/releases) and download the `.skill` file for the one you want (`signalprocessing.skill`, `prospect-intelligence-scoping.skill`, or `skill-currency-check.skill`). Don't unzip it, upload it as-is.

**Step 2: Install it**

In Cowork: **Customize** → **Skills** → click the **+** icon → **Create skill** → **Upload a skill** → select the `.skill` file.

**Step 3: Run it**

Inside your BoS OS project, type the skill's name. For example:

> **SignalProcessing**

or

> **Prospect Intelligence Scoping**

or

> **Skill Currency Check**

It checks your prerequisites (Bootstrap complete, Workshop complete or at least one document identified, BoS OS folder structure in place) before starting, and tells you plainly what's missing if something isn't ready yet.

---

## More skills

This collection grows over time. Follow or watch this repo for new additions.

All BoSMark repos: [github.com/BoSMark](https://github.com/BoSMark)

---

*Business of Software: helping software founders build profitable, enduring companies since 2007.*
