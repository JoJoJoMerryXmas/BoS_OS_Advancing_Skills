---
name: SignalProcessing
description: |
  Turn recorded conversations and interviews into actionable insights in your BoS OS. Builds a repeatable system: define your key documents, identify the signals in transcripts worth tracking, set it up, then iterate. Also handles batch processing, so information your system already produces costs less time to use. MANDATORY TRIGGERS: SignalProcessing, set up signal routing, turn transcripts into signals, extract signals from conversations. Use when building a system for routing insights from conversations to core documents, starting a signal-routing workflow, testing signal matching and approval, or running a weekly signal batch. Do not trigger on: "signal processing" (generic), "batch processing" (generic), "transcript processing" (generic), "transcriptinator" (legacy v1.0).
metadata:
  version: 1.0.0
  author: Jo Littlewood and Business of Software
  prerequisites: Bootstrap complete, Workshop completed or at least one document identified, BoS OS folder structure in place
  state_requirements: |
    Contextually aware: reads from 01_STATE/ for BoS OS state (folders, strategy documents, agent specs, CLAUDE.md).
    Does NOT version-lock: works with any BoS OS state established after 2026-06-01 that has the folder structure and CLAUDE.md.
---

# SignalProcessing

**Version:** 1.0
**Status:** RELEASED

**Author:** Jo Littlewood and Business of Software
**Owner:** Jo Littlewood

Turns conversations and transcripts into compounding progress on your BoS OS's own core documents: a roadmap, an FAQ, a testimonials file, whatever you name. Signals get spotted, batched, and routed only with your approval, so nothing evaporates and nothing writes itself in without you seeing where it went.

This is one of BoS OS's **advancing skills**, for a user who already has a working core (Bootstrap and Workshop complete), not someone just getting started. Sits after Bootstrap → Workshop → Run.

**Origin:** built the same way it works: this mission started as a line in a workshop transcript, was flagged as a strong signal, and became real the same day. Worth telling that story to a new user as the illustrative case.

---

# PREREQUISITE CHECKS: COMPLETE BEFORE PROCEEDING

Do not begin setup. Do not open any documents. Complete checks 1–4 first, in order.

## Check 1: Who Are You? (Establish Personalization)

Do you have a saved name for this user (stored in the BoS OS or available in session context)?

**If yes:** Use their name throughout this session. Example: "Sarah, we're going to set up signal routing for your roadmap. Let's start by..."

**If no:** Ask now:

> "Before we begin, I'd like to know who I'm working with. What's your name? What should I call you?"

Once you have a name, use it. This is not a formality. Using someone's name throughout the session makes the process feel collaborative and personal, not automated.

---

## Check 2: Does a BoS OS Exist?

Look for evidence of a BoS OS folder structure:
- Does the user have a folder containing `01_STATE/`, `02_STRATEGY/`, `03_AGENTS/`, `04_MISSIONS/`, `05_ARTIFACTS/`?
- Does a `CLAUDE.md` file exist in that folder?

**If yes:** Proceed to Check 3.

**If no:** Stop here. Tell the user:

> "[Name], SignalProcessing is an advancing skill designed for someone who already has a running BoS OS. Before we can set up signal routing, you need to bootstrap your operating system first.
>
> **Here's what to do:**
> 1. Run the **Agent OS Bootstrap** skill to create your folder structure and strategy documents
> 2. That will take 30–45 minutes and build everything you need
> 3. Then come back here and we'll set up signal routing
>
> Ready to bootstrap, or do you want to know more about what that involves?"

Do not proceed until they have a working BoS OS.

---

## Check 3: Has Bootstrap Been Completed?

Look for evidence of completed Bootstrap:
- Strategy documents exist in `02_STRATEGY/` (with names like `Our_Values.md`, `How_We_Grow.md`, or `RFC-100_*` for older bootstrap versions)
- Agent specs exist in `03_AGENTS/`
- An agent map exists (`agent_map.md` or `portfolio_map.md`)

**If yes:** Proceed to Check 4.

**If no:** Stop here. Tell the user:

> "[Name], I can see you have a BoS OS folder structure, but it looks like Bootstrap hasn't been run yet: I can't find your strategy documents or agent specifications.
>
> **Here's what to do:**
> 1. Run the **Agent OS Bootstrap** skill to populate your strategy documents and create agent specs
> 2. That's a prerequisite for signal routing: you need documents to route signals *to*
> 3. Then come back here
>
> This will take 30–45 minutes. Ready to run Bootstrap?"

Do not proceed until Bootstrap is complete.

---

## Check 4: Has Workshop Been Completed (or at Least One Document Set Been Established)?

Look for evidence that at least basic document setup has happened:
- At least one strategy document in `02_STRATEGY/` has content beyond bootstrap placeholders
- Or: a document registry (manually created or from Document Architect phase) exists showing what documents will receive signals

**If yes:** Proceed to "Session Opener" below.

**If no:** Tell the user:

> "[Name], I can see your bootstrap is complete, but it looks like you haven't yet decided which documents are most important for signal routing. That's okay: we can set that up together right now.
>
> In just a moment, I'm going to ask you a few questions to help you identify your key documents: the ones you actually want to feed signals into. It'll take 10–15 minutes, and at the end you'll have a clear list of documents to route to.
>
> Ready?"

Then proceed to Part 1 (Document Architect) with the understanding that you're doing a light onboarding version of document selection, not assuming they've already been through Workshop. Keep it conversational and brief.

---

---

# SESSION OPENER: BEFORE YOU START

## Before-You-Start Checklist

Before we set up signal routing, confirm you're ready:

- [ ] **Folder access.** Do you have read/write access to your BoS OS folder (the one with `01_STATE/`, `02_STRATEGY/`, `03_AGENTS/`, `04_MISSIONS/`, `05_ARTIFACTS/`)?
- [ ] **Transcripts ready (optional).** Do you have at least one conversation/transcript you want to test signal extraction on? (You can grab one later if not, but having one makes the testing feel real.)
- [ ] **Time budget.** Do you have 60–90 minutes? Setup is one session; running signals is ongoing, not a one-shot.
- [ ] **Decision authority.** Are you the person who decides what gets routed where, or do you need input from someone else? (That's fine either way: just know it now.)

If you've checked all four, we're good to go. If not, that's okay, let me know what's missing and we'll sort it.

---

## What SignalProcessing Does

SignalProcessing turns recorded conversations (transcripts, Insight Briefs, meeting notes) into signals that feed your core documents. But it's not automatic. You decide what gets routed where, and you approve every batch before anything writes to your documents.

Here's how it works in four stages:

1. **Document Architect**: You identify and design your critical documents (the ones worth keeping signals in). This happens once, at setup. *Estimate: 20–30 minutes.*
2. **Signal Sweeper**: You feed it conversations, and it extracts candidate signals and stages them for your review. *Estimate: 5–10 minutes per transcript.*
3. **Approval**: You look at a batch of candidates and decide: approve all, edit some, reject some. *Estimate: 10–15 minutes per batch.*
4. **Promotion**: Each approved signal writes to its destination document, with three safety checks running before anything touches your files. *Estimate: 1–2 minutes per signal.*

By the end of this session, you'll have a working system where signals flow in → you review → you approve → they write. Clean, intentional, auditable.

## Where You'll Be at Each Stage

As we move through this process, I'll keep you oriented. At each major checkpoint, I'll tell you:
- **"You are now in [Stage Name]"**: so you know where you are
- **"This stage does [X]"**: so you know what to expect
- **"When we're done here, we'll move to [Next Stage]"**: so you know what's coming

This way, nothing feels like a surprise. You're in control the whole time.

## About Templates

To save you time in Document Architect, I can help you get started faster with templates. SignalProcessing has three document shapes:
- **Append-only log** (FAQ, Proof Points, Objections): grows forever, newest at bottom
- **Curated doc** (Roadmap, Jobs-to-be-Done, ICP, Backlog): gets reorganised as understanding matures
- **Structured table** (Testimonials, case studies): one row per entry, columns locked

I can show you a template for each shape, or I can draft a stub document based on the seed menu (Roadmap, Backlog, FAQ, Proof Points, etc.) if you'd like. Want templates to get started faster, or would you rather design from scratch?

---

Ready to begin? Let's start by identifying your key documents.

---

---

# PART 1: DOCUMENT ARCHITECT

**STAGE 1 OF 4: Identify and design your critical documents**

This stage happens once, at setup. You're going to decide which documents are important enough to route signals into.

## Step 0: What's the Business Flow, Not "What Documents Did You Have Before"

Before you look at any seed menu or template, answer this first:

> "[Name], forget what documents you might have had in a previous system for a moment. What decisions are you currently making without good information? What keeps coming up in conversations that you have nowhere to put? A document in a BoS OS exists to serve one of those gaps: not to recreate a folder structure from somewhere else."

This is the frame for everything that follows. A document earns a place in the registry because it serves a live decision or information flow, not because "we've always had a roadmap" or "every company has an FAQ."

**Critical principle:** In a BoS OS, you don't start by asking "what goes in this document?" You start by asking:
1. **What job does this document do?** (What decision or process does it serve?)
2. **Who uses it?** (Who looks at it, and what do they decide?)
3. **How does it change what you do?** (What's different because this document exists?)

Everything else flows from those answers: the shape (append-only, curated, table), the sections, the matching criteria, the review cadence. This is what makes a BoS OS useful: every document serves a decision-making process, not just a filing system. You're building a reactive, signal-driven business operating system, not recreating the static document hierarchy you had before.

Once you're clear on the job, we'll lock in the document's purpose, shape, and matching criteria for Signal Sweeper.

**Quick note on templates:** If you want to speed this up, I can draft your documents from templates. I'll show you a template for each of the three document shapes, or I can suggest a pre-built starting set (Roadmap, Backlog, FAQ, Proof Points, Jobs-to-be-Done). You can adapt any template to your own language and structure. Totally optional: design from scratch is fine too.

## Step 0a: Overlap Check (Before Any Document Is Created)

This is the same check that runs later as **Anomaly Check 1A** when Signal Sweeper proposes an unregistered destination: see Part 4. One rule, applied at both moments: initial setup and any later ad hoc document creation.

Before adding *any* document to the registry (whether this is your first document or your fifth, whether we're doing this now or six months from now), check it against what already exists:

1. If the registry already has entries, walk through them briefly: "Here's what you already have: [list]. Does the job you just described already belong to one of these?"
2. If yes: don't create a new document. Extend the existing one's `match_criteria` or purpose instead, and confirm that with the user.
3. If no, genuinely distinct: proceed to design it fresh.
4. If the registry is empty (true first-time setup): skip straight to design: there's nothing yet to overlap with.

**Why this matters:** two documents doing the same job is worse than one document doing it imperfectly: it splits signals, and neither document stays trustworthy. This check exists so a new document is always a deliberate choice, never a reflex.

## Role

Helps you identify, name, and design your critical documents in simple, actionable form: the things worth prioritising and deciding on. A roadmap is the flagship example, because people read a roadmap, not a strategy doc.

## Decision Boundary

**MAY without approval:**
- Explain what a "critical document" is and why to have one, even as a stub
- Suggest example documents drawn from the seed menu below as illustrative starting points
- Draft a stub/template for any document you choose
- Iterate on a document's design based on your feedback

**MUST escalate before doing:**
- Locking in a document's structure as a stable routing destination before you confirm it: Signal Sweeper depends on this being stable
- Building a document type that requires data this skill doesn't have access to
- Any document type that could inherently contain confidential material (e.g. personnel notes): that requires a conversation with your Confidentiality Guardian

## The Registry: One Entry Per Document

| Field | What It Captures |
|---|---|
| `name` | Short identifier (e.g., "Roadmap", "FAQ") |
| `purpose` | One-line plain-language reason this document exists |
| `location` | File path within your BoS OS structure |
| `update_pattern` | `append-only-log` (grows forever), `curated-doc` (gets reorganised over time, includes Backlog's promote-out-or-drop cycle), or `structured-table` (row-per-entry) |
| `match_criteria` | Plain-language description of what kind of signal belongs here: Signal Sweeper checks every candidate against this |
| `owner` | Who approves a batch before it writes here (default: you) |

A new document is always a Document Architect conversation, never something Signal Sweeper invents on the fly, and always passes the Step 0a overlap check first. If a signal doesn't match anything in the registry, it stages as "no match, hold," not a guess.

## Seed Menu: Offer as Illustrative Starting Points, Not a Fixed List

| name | purpose | update_pattern | match_criteria |
|---|---|---|---|
| Roadmap | What's being committed to build next, and why | curated-doc | Feature requests, pain points, workarounds: that have enough weight to commit to |
| Backlog | Early-stage ideas and possibilities not yet worth committing to | curated-doc | Ideas raised once, speculative "maybe someday" mentions, unvalidated possibilities: not yet backed by repeated signal or a committed initiative |
| Jobs-to-be-Done | The situations people hire this for | curated-doc | Descriptions of a user's situation or motivation, not just a feature ask |
| Ideal Customer Profile | Who this is really for | curated-doc | Firmographic fit signals, trigger-event confirmations, disqualifying signals |
| FAQ | Answers to real recurring questions | append-only-log | Any question asked more than once across conversations |
| Objections Register | Reasons people say no, and how they've been answered | append-only-log | Explicit pushback or hesitation |
| Proof Points | Evidence the thing works | append-only-log | Concrete outcomes, numbers, before/after |
| Vocabulary Register | The words users actually use | append-only-log | Distinctive phrasing for describing the problem |
| Testimonials | Named quotes, with permission | structured-table | Strong, quotable statements: flagged separately for a subject-permission check before use |

**Backlog vs. Roadmap: the distinction, stated plainly**: Roadmap is for things you're committing to. Backlog is for things worth remembering but not yet worth committing to. An idea starts in Backlog by default unless it already has enough weight (repeated demand, or it fits a decision you're already committed to) to go straight to Roadmap. See "Backlog Review Cadence" below for how items move between the two.

Two deliberately left off the default menu (offer if asked, don't lead with them): **Content Bank** (a catch-all is hard to use well on day one) and **Competitive Intelligence** (in BoS's own system this isn't sweep-fed at all: it's populated by direct monitoring, so it doesn't belong on a routing menu). **Cluster Mapping** isn't a separate document type: it's the clustering already built into a Jobs-to-be-Done or ICP document; don't present it as a tenth option.

## Document Template: One Shape Per `update_pattern`

**`append-only-log`** (FAQ, Objections Register, Proof Points, Vocabulary Register):
```markdown
# [Document Name]

**Purpose:** [one line]

---

## Entries

- **[YYYY-MM-DD]**: [entry text]
```
Append only, newest at bottom. Never rewritten, never reordered.

**`curated-doc`** (Roadmap, Backlog, Jobs-to-be-Done, ICP):
```markdown
# [Document Name]

**Purpose:** [one line]
**Last reviewed:** [date]

---

## [Section: you name these; 2-4 to start]

[Free text]

---
```
No append-only constraint: the whole doc can be reorganised as understanding matures. Backlog uses this same shape, with the addition of the monthly review cadence below.

**`structured-table`** (Testimonials):
```markdown
# [Document Name]

**Purpose:** [one line]

| Date | Quote | Source | Permission | Source_Type |
|---|---|---|---|---|
```
Columns fixed at creation, confirmed with you once: not renegotiated per entry.

## Backlog Review Cadence (Monthly)

Backlog is not a place ideas go to be forgotten. Once a month, or at whatever cadence your own planning process already runs on, review every entry:

- **PROMOTE** → the idea now has enough weight (raised independently more than once, or it fits an initiative you're already committed to): move it to Roadmap. It picks up Roadmap's own review cadence from that point.
- **KEEP** → still speculative, not enough evidence yet: leave it in Backlog.
- **DESTROY** → no longer relevant: remove it.

This deliberately mirrors the triage your BoS OS already uses for its own `01_STATE/backlog.md` (DESTROY / PROMOTE / KEEP): same pattern, so it's familiar rather than a new vocabulary to learn. If your own planning cadence isn't monthly, use whatever cadence you actually run: the rule is "reviewed on a real cadence you'll keep," not "reviewed on the 1st of the month specifically."

## What Document Architect Does Not Touch
- Doesn't write signals into documents (Signal Sweeper, Part 2)
- Doesn't screen for confidentiality (Confidentiality Guardian, Part 3)
- Doesn't handle scheduling or cadence beyond the Backlog review rule above

---

**CHECKPOINT 1: Document Setup Complete**

When you've identified your documents and we've locked in their registry:

> "[Name], here's what we've just set up:
> - [Document 1]: [purpose] (append-only-log)
> - [Document 2]: [purpose] (curated-doc)
> - [Document 3]: [purpose] (structured-table)
>
> This is your routing table. Signal Sweeper will use these match criteria to know where each signal belongs. Does this look right? Any changes before we move to the next stage?"

Once you confirm, we move to **Stage 2: Confidentiality Guardian**.

---

---

# PART 2: CONFIDENTIALITY GUARDIAN

**STAGE 2 OF 4: Understand how confidential material is screened**

This stage is a setup conversation, not a hands-on task. You need to understand how SignalProcessing protects sensitive information before we start running it.

## Role

Screens transcripts, conversations, and draft content for confidential-looking material before anything reaches staging. Uses a conservative, fixed exclusion notice: built directly from a real incident where a screen worked correctly but its own notice leaked the excluded detail.

## Where the Confidentiality Boundary Comes From

This skill does not help you define your confidentiality boundary: it reads one that already exists from your BoS OS's own `CLAUDE.md` / Hard Constraints section.

Right now, let me check your existing boundary. What does your BoS OS's `CLAUDE.md` say about what's confidential?

**If you have a clear confidentiality boundary:** Good. We'll use that throughout.

**If you don't have one defined:** This is an onboarding gap, not something this skill sets up. Before we proceed, let's define what "confidential" means for you. Common examples: employee data, financial specifics, customer names, strategic decisions not yet public, M&A activity. What's off-limits for you?

## The Screening Step

Runs on every candidate signal, before staging:

1. Check the candidate against your confidentiality boundary.
2. **Pass** → proceeds to Signal Sweeper's staging step.
3. **Exclude** → dropped from staging. Counted, not silent.
4. **Ambiguous** (doesn't clearly resolve either way) → escalate to you. Never default silently in either direction.

## The Exclusion Notice: Fixed Template, No Exceptions

```
[N] item(s) excluded this batch, flagged as potentially confidential.
```

**Hard rules:**
- Never names a person, document, or topic.
- Never repeats or paraphrases the excluded detail, even partially.
- Never varies wording based on what was excluded.
- Shown in the same staged-approval view as everything that *did* pass: sitting alongside the matches, not a separate alert.

## What This Deliberately Does NOT Do (v1)

- Does not produce a specific/named exclusion notice under any circumstance: generic is safe but low-information; specific is useful but risky. Parked as a known limitation, not solved in v1.
- Does not define your confidentiality boundary: that's a Bootstrap-time input.
- Does not judge document design or content quality.

---

**CHECKPOINT 2: Confidentiality Boundary Confirmed**

> "[Name], before we move forward, I want to confirm: your confidentiality boundary is [X]. So when we're running Signal Sweeper, anything that looks like [examples] will be excluded with the generic notice. Does that sound right?"

Once you confirm, we move to **Stage 3: Signal Sweeper**.

---

---

# PART 3: SIGNAL SWEEPER (EXTRACTION & CADENCE)

**STAGE 3 OF 4: Extract signals from conversations and stage them for your approval**

This is where the system starts working. Signal Sweeper combs transcripts, conversations, and organisational input for signals relevant to your documents, and stages them for your approval before anything writes to a document.

## Role

Combs transcripts, conversations, and organisational input for signals relevant to your chosen documents, and stages them for your approval before anything writes to a document.

## Decision Boundary

**MAY without approval:** run on either cadence; propose candidate signals and stage a batch for review; run in individual mode repeatedly during onboarding: this is the intended early-phase pattern, not a fallback.

**MUST escalate before doing (hard boundary):** never write a signal into a document without that specific batch being explicitly approved by you.

## The Extraction Pass: Domain-First, Then Match

**Phase 1: Domain-first extraction.** Classify each candidate by domain before matching, so extraction logic stays independent of your specific documents: Product, Operations, Growth, Messaging/Brand, Daily Habits, Community, Learning, Strategic Tension.

**Phase 2: Segmentation.** Break the source into candidate-sized units: a claim, a question, feedback, a decision. Roughly "one thing someone said that could stand alone."

**Phase 3: Confidentiality screening.** Every segment passes through Confidentiality Guardian (Part 2) before matching. Excluded segments never reach the matching step.

**Phase 4: Matching.** Check each surviving segment against every document's `match_criteria` (Part 1), including the Roadmap/Backlog distinction: a segment with enough weight (repeated, or tied to a committed initiative) matches Roadmap; a speculative, one-off idea matches Backlog. Matching is plain-language semantic comparison, not keyword search. Multi-match is allowed. A segment matching nothing becomes "no match, hold." **Never invent a new document to fit an orphan segment**: unmatched segments escalate to you, per the Step 0a / Anomaly Check 1A overlap logic.

**Phase 5: Candidate record.** Each staged candidate carries: `source`, `domain`, `text`, `proposed_destination(s)`, `match_reason`, `conflict_flag` (if applicable), `status` (`matched` / `no-match-hold`).

## Conflict Handling

Covers two related cases, both flagged specifically by name rather than silently applied:
- **Contradiction**: a candidate conflicts with something already in the destination document.
- **Duplication / reinforcement**: a candidate restates or reinforces an existing entry (the same underlying request or theme, raised again) rather than contradicting it. Not a tension to resolve, but still named against the existing entry rather than written as if new. Repeated reinforcement of a Backlog entry is itself a signal: see Backlog Review Cadence in Part 1: it's exactly the kind of evidence that promotes an idea to Roadmap.

## Cadence: Individual Mode (The Onboarding Default)

Signal Sweeper runs the extraction pass on a single transcript/conversation, immediately after it, at your request or a standing per-conversation trigger. You've never seen this work yet, so running it once, on one real conversation, lets you see exactly what got extracted, why, and where it was proposed to go. **This is the intended early-phase pattern, not a limited fallback**: this is how you build trust in the system. Graduation to batch mode is your call, not a system-forced timer.

## Cadence: Batch Mode (Weekly or On-Demand)

Same extraction pass, run across a week's worth of sources at once, into one staged batch for a single approval decision: mirrors BoS OS's own Signal Consolidation Protocol shape exactly.

## The Staged-Approval View: What You See

```
Signal batch: [date range]
Sources: [N conversations/transcripts]

Excluded: [N] item(s) excluded this batch, flagged as potentially confidential.

Matched ([N] candidates):
  1. → [Document name]: "[segment text]"
     Reason: [match_reason]
  ...

Held, no match ([N] candidates):
  1. "[segment text]", doesn't fit an existing document
  ...

Conflicts flagged ([N]):
  1. → [Document name]: "[segment text]" conflicts with / reinforces existing entry: "[existing text]"
  ...

Your decision: APPROVE ALL, or name exclusions/edits per item.
```

Design rules: excluded count always shown, generic, never omitted or detailed. Every matched candidate shows its reason. Held items are visible, not silently dropped. Conflicts are named specifically against the existing content. One approval decision for the batch, with the ability to name exceptions.

---

## Concrete Examples: What Signal Sweeper Looks Like in Practice

To see exactly what extraction, matching, and conflict handling look like in practice, I have five worked examples from live testing and product review:

1. **Full Cycle**: A feature request extracted, matched, approved, and promoted
2. **Conflict Handling**: The same feature request raised three times (duplication/reinforcement)
3. **No-Match Signal**: A question that doesn't fit any existing document (and why we hold it rather than guess)
4. **Missing Document Conversation**: When a signal doesn't match anything, how the system helps you decide if you need a new document
5. **Backlog vs. Roadmap**: An idea mentioned once, staged to Backlog as speculative; the same idea raised independently a second time weeks later, triggering a PROMOTE decision to Roadmap at the next Backlog review: showing the distinction as something the system helps you act on, not just a label

I'll reference these examples as we move through approval and promotion. They show the system working as intended, including the "no-match," "missing document," and "backlog promotion" cases that are often where systems fail. Want me to walk you through all five examples now, or would you rather see them as they come up during testing?

## The Cadence Engine: Automated Pickup

1. Check the incoming-transcripts location for anything without a "processed" prefix: that absence is the only signal needed.
2. Validate before treating a file as a source:
   - Filename or content pattern indicates a summary, not a transcript → skip, record reason `"summary, not transcript"`.
   - A read stops before reaching the end → skip, record reason `"read incomplete"`. Never process a partial read silently.
3. Run the pipeline unchanged on each validated source: Confidentiality Guardian → extraction/match.
4. Rename/re-flag each successfully processed source with a "processed" prefix.
5. Assemble results into a draft batch: individual or weekly, depending on which cadence fired.
6. **Overlap check:** before finalising, check the batch's source list against any other batch still awaiting approval. If they overlap, name the earlier batch and its date in the new batch's view, so you see the overlap before deciding on either one.
7. Write the batch to the drafts location: **never** to any document named in the registry's `location` field. That only happens at promotion (Part 4), on explicit approval.
8. Surface the batch where you'll see it at your next session start.

## What This Deliberately Does NOT Do (v1)

- Does not write to a destination document under any circumstance: only produces drafts.
- Does not treat a summary as a transcript, or a partial read as a complete one.
- Does not hide a skipped source or an overlapping pending batch.
- Does not score or rank matches by confidence: plain pass/fail, kept legible for review.

---

**CHECKPOINT 3: Signal Sweeper Tested**

After running your first individual-mode extraction on a real conversation:

> "[Name], here's what Signal Sweeper found:
> - [N] matched signals (proposed for [documents])
> - [N] held signals (no match)
> - [N] excluded (flagged as confidential)
>
> Does this look right? Does it make sense where each signal was routed? Any surprises?"

Once you've reviewed and confirmed the system is extracting signals correctly, we move to **Stage 4: Promotion**.

---

---

# PART 4: PROMOTION (WRITE, VERIFY, ANOMALY CHECKS)

**STAGE 4 OF 4: Approve and promote signals to their destination documents**

This is the final stage. An approved batch of signals now writes to your documents, with safety checks running before anything touches your files.

## Scope of a Single Promotion Action

Each promotion action covers **exactly one candidate signal** and writes to **exactly one destination document**. Never combine two or more signals' writes into a single promotion action: not even when both target the same document. If you approve several candidates at once ("approve all"), that is several separate promotion actions run in sequence, each going through the full procedure below on its own.

## The Procedure

1. Run the three anomaly checks below against the destination document. If any fails, stop here: do not proceed to step 2. Follow that check's own escalation instructions.
2. Apply the write to the destination document, per its declared shape: append a new entry (`append-only-log`), add a row (`structured-table`), reorganise/rewrite the relevant section (`curated-doc`). Covers only the one candidate signal this promotion action is for.
3. Immediately after writing, re-read the file and confirm it still matches its declared shape and is fully readable.
4. **If confirmation fails:** stop. Tell you plainly what happened and which document is affected. Do not attempt a fix. Direct you to your own storage's recovery option (Dropbox version history, git, or whatever you use): this system holds no copy of its own to restore from.
5. **If confirmation passes:** mark the draft as promoted. Done.

## Backup Responsibility: State Once, Plainly, Before You Start

1. Back everything up yourself, however you already do that, before you begin.
2. If you want to restore something later, that's yours to do, with your own backup.

No precondition check on whether you have backup capability. No gating. This is stated once, clearly, here: **This system creates, holds, and manages no backup of anything, ever.**

## Anomaly Check 1: File Path

Confirm the document's registered `location` resolves to a real, readable file.

**On failure:** stop. Do not write. Do not guess a new location. Escalate to Document Architect: this needs a conversation with you to fix the registry entry.

## Anomaly Check 2: Disproportionate Rewrite (Curated-Doc Only)

The signal is already matched to a specific section or entry (`proposed_destination`). Confirm the write, once applied, stays inside that matched area.

**On failure:** stop. Do not write. Tell you specifically: *"this change would also affect a section it didn't first appear to be about."* Ask for direct confirmation before proceeding.

**For cluster-type documents** (a JTBD Clusters equivalent, an ICP Map, or a user-defined version): before running this check, classify the signal as either reinforcing an existing cluster (name how many signals now support it) or forming a new cluster/sub-cluster. Show this classification in the batch view regardless of whether the check fires: so a legitimate new cluster doesn't read as a block on growth.

## Anomaly Check 3: Schema Drift

- **Append-only-log:** entry format must match exactly what this system itself writes. No tolerance.
- **Structured-table:** columns must match exactly what was agreed with you at setup. No tolerance for drift after that point.
- **Curated-doc:** confirm at least one heading in the document plausibly relates to the content being promoted. If none does, that's the failure: not that the document has changed, since reorganising a curated-doc is normal.

**On any failure:** stop. Do not write. Flag the whole document, not just the one signal that triggered it. Hold every other pending draft against that document too. Escalate to Document Architect for a conversation with you to re-confirm or update the registry entry.

---

## Anomaly Check 1A: Missing Document Conversation

This check runs *before* you approve a batch, not after. It is the **same overlap-check logic as Document Architect Step 0a** (Part 1): one rule, applied whenever a new document is proposed, whether that's at initial setup or here, mid-stream, when Signal Sweeper is running. If a staged signal names a document that doesn't exist in your registry, Signal Sweeper flags it and opens a conversation with you.

**The Flow:**

1. You approve a signal with proposed destination: "Reporting Friction Points" (hypothetical new document)
2. Signal Sweeper checks the registry: no entry found
3. Signal Sweeper shows you what documents *do* exist and asks: "Did you mean one of these instead: including Backlog, if this is more speculative than committed?"
4. You answer: "No, this is new. I want to track it separately."
5. Signal Sweeper asks three clarifying questions to understand what job this document does:
   - *"What job does this document do in your system? What decision or process does it serve?"*
   - *"Who looks at it, and what decision do they make?"*
   - *"How does it change what you actually do?"*
6. As you answer, Signal Sweeper may recognise that the full operational model requires deeper thinking (e.g., understanding your monthly planning process). If so, it will:
   - Create the document with a temporary shape to get started
   - Flag what needs to be defined: when/why/how it's reviewed, how it connects to decisions, what signals feed into it
   - Add a to-do to your list: *Define [Document Name] Operating Model*
   - Proceed with routing the signal while you think through the process questions
7. Once you've answered, Signal Sweeper:
   - Confirms the new document doesn't accidentally duplicate an existing one
   - Drafts a document template and initial match criteria
   - Adds it to your registry with the `update_pattern` that fits
   - Routes the original signal to it
   - Locks it in so the next batch knows about it

**Critical principle:** Document structure is downstream of process. Don't recreate your old static documents in a BoS OS shell. Instead, define *how* each document serves your decision-making and signal flow, then shape it to support that. If the operational model isn't clear yet, flag it and come back to it. Don't guess at a document shape and regret it later.

**Why this matters:** This prevents silent duplicates (two documents doing the same job), ensures new documents are intentional, and forces you to think about whether you're building a reactive signal-driven system (BoS OS) or recreating a static document list from your old operating system.

**On failure to reach agreement:** Signal Sweeper holds the signal and tells you plainly: "I can't route this without understanding what you want to do with it. Let's talk it through." You never get a signal routed to an accidental duplicate, and you never create a document just to avoid a decision.

## What This Deliberately Does NOT Do (v1)

- Does not track repeated conflicts on the same entry across runs: the conflict flag already names every conflict, every time.
- Does not attempt a fix or workaround for any anomaly check: every failure stops and escalates.
- Does not invent a new document to route around a broken path or a drifted schema.
- Does not create, store, or manage a backup copy on your behalf, ever.

---

## Coherence Check (Before Trusting a Batch, Before Promoting)

1. Does every matched candidate show a `match_reason` you aren't asked to trust blind?
2. Is the excluded count always shown, generic, never detailed?
3. Are held (no-match) items visible, not silently dropped?
4. Is every conflict (contradiction *or* duplication/reinforcement) named against the specific existing entry?
5. Does this promotion action write to exactly one document, for exactly one signal?
6. Have all three anomaly checks run against the actual destination document before any write?
7. If a check failed, did the procedure stop and escalate rather than guess or auto-fix?
8. If a new document was proposed, did it pass the Step 0a / Anomaly Check 1A overlap check before being created?

---

**CHECKPOINT 4: System Live**

After your first successful promotion (one signal written, verified, complete):

> "[Name], your first signal is now live in [Document name]. It went through all three safety checks and your file is intact.
>
> You now have a working system:
> - Conversations feed in
> - Signals get extracted and staged
> - You review and approve
> - Approved signals write to your documents
> - Everything is safe and auditable
>
> The next time you have a transcript or conversation, just feed it to Signal Sweeper and we'll repeat this cycle. The system gets faster each time you use it: you'll learn what kinds of signals matter to you, and the matching gets tighter.
>
> Questions, or ready to start running batches?"

---

## What This Skill Does NOT Do (v1)

- Does not write anything to a document without that specific batch being explicitly approved.
- Does not define your confidentiality boundary, or invent one if none exists.
- Does not back up, store, or restore your documents.
- Does not build new documents on the fly to route an orphan signal: always escalates to a Document Architect conversation instead, and always runs the overlap check first.
- No autonomy phase: every batch requires sign-off, indefinitely, in v1.

---

---

# INTEGRATION & HAND-OFFS

## SignalProcessing and Your BoS OS

SignalProcessing is an **advancing skill**. It assumes you already have a working BoS OS (Bootstrap complete, at least one Workshop pass, CLAUDE.md in place). It sits in the flow like this:

**Bootstrap** (build your folder structure and strategy documents)
→ **Workshop** (refine strategy, create agent specs, define your first mission)
→ **SignalProcessing** (set up signal routing from conversations into your documents)
→ **Agent OS Run** (operate your agents and missions, using SignalProcessing to feed them insights)

SignalProcessing doesn't replace either Bootstrap or Workshop. It complements them: once you know *what* documents matter (Workshop output), SignalProcessing helps you *keep them current* by systematically extracting and routing signals from conversations.

## This Skill vs. the Internal Signal Consolidation Task

**Critical distinction:** This skill teaches you how to set up signal routing and run it yourself within your own BoS OS.

**The internal Signal Consolidation task** (run weekly within your BoS OS, after setup) is a *different thing*: a scheduled weekly sweep that uses the same four-stage flow you've built here to batch-process transcripts from that week and promote them to your documents. It's the *operational cadence* of what you've just learned.

Think of it this way:
- **SignalProcessing (this skill):** the *how*: teaches you the system and gets it set up
- **Signal Consolidation (your BoS OS task):** the *when*: runs weekly on a schedule, using the same method

You don't need to do both. You set this up once (you're doing that now), and then Signal Consolidation runs automatically each week using the documents and registry you've created.

## Hand-Off to Agent OS Run

Once SignalProcessing is live, the next natural step is **Agent OS Run**: the skill for operating your missions and using your agents. It has visibility into the signals you're routing, so your agents can use recent insights when executing their work.

If you're also building agents (via Bootstrap and Workshop), Agent OS Run will show you how to staff them and point them toward the signal streams you've set up here.

---

---

## Version History

**v1.0 (2026-07-17)** First public release.

*SignalProcessing, Business of Software. AI-generated skill; review before activating on production data. All work is subject to the host install's own CLAUDE.md hard constraints.*
