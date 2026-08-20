# Agent Workflow Boundary Guide

> **Purpose**: Keep two layers from fighting each other — **Trellis owns the workflow; minimization rules (e.g. ponytail) only shape how implementation code is written.**

---

## The Boundary Rule (CRITICAL)

**Trellis holds final authority over process. Any minimization / laziness / YAGNI instruction applies only to implementation details and must never override or skip Trellis process artifacts.**

1. **Process decisions belong to Trellis alone.** Whether to create a Trellis task, which workflow step to run (planning → implementation → check → finish-work), whether to write process artifacts (`prd.md` / `design.md` / `implement.md` / `implement.jsonl` / `check.jsonl`), and whether to archive — all of these are Trellis workflow decisions. No "does this need to exist? → skip (YAGNI)" reasoning may be used to skip them.
2. **Minimization rules apply only to implementation.** Rules like ponytail / YAGNI govern *how to write the least code that is correct* — reuse vs. rewrite, stdlib vs. dependency vs. native feature, one-liner vs. component. They **never** apply to task creation, process artifacts, review gates, or spec/journal updates.
3. **Conflict resolution.** When an active ruleset says "skip" and Trellis requires "create", **Trellis wins for process decisions**. The YAGNI exception is explicit: it must not be used to skip a required Trellis task or artifact.
4. **Follow Trellis's own routing.** Simple chat / inline small tasks may skip a formal task — but that is a Trellis workflow decision, not something a minimization rule gets to decide.

## Never

- ❌ Skipping task creation for a multi-file change on "YAGNI" grounds (task creation is a workflow decision, not an implementation decision).
- ❌ Treating `design.md` / `implement.md` / `check.jsonl` as "over-engineering" to delete.
- ❌ Letting a minimization ruleset bypass `/trellis:check` or the finish-work journal/archive.
- ❌ Running a second workflow framework side-by-side so the agent improvises (only "one workflow + code-style rules" is allowed).

## Always

- ✅ When unsure whether a task is needed, follow Trellis's own triage (simple chat / inline / full task) and get user consent.
- ✅ Keep process artifacts and spec files as compact as the process requires — compactness is a value; **omission is not**. Required artifacts are not exempt from existence because of code minimalism.
- ✅ If two instructions conflict (one says "skip", Trellis says "create"), treat the process one as Trellis's call.

---

## One-liner

> Trellis decides process and artifacts; minimization rules shape implementation code only. On conflict, Trellis wins for process.
