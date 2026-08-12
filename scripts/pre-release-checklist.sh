#!/bin/bash

# Pre-Release Checklist for BoS OS Advancing Skills
#
# Validates that a release is ready to push to main.
# Generalized 2026-07-24 to check every skill in the repo, not just one --
# previously hardcoded to signalprocessing/SKILL.md throughout, so a second
# skill (prospect-intelligence-scoping) was never actually checked by this
# script even though it reported "safe to push." See MISSION-014.
#
# Usage: bash scripts/pre-release-checklist.sh
#
# Exit codes:
#   0 = all checks passed, safe to push
#   1 = one or more checks failed, do not push

set -o pipefail

REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$REPO_ROOT"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

CHECKS_PASSED=0
CHECKS_FAILED=0

check_pass() { echo -e "${GREEN}✓${NC} $1"; ((CHECKS_PASSED++)); }
check_fail() { echo -e "${RED}✗${NC} $1"; ((CHECKS_FAILED++)); }
check_warn() { echo -e "${YELLOW}⚠${NC} $1"; }

# Reads the version out of a skill's SKILL.md. No associative arrays --
# kept portable to bash 3.2 (macOS default), not just bash 4+ (CI runners).
get_version() {
    local dir="$1"
    local file="$dir/SKILL.md"
    if [ -f "$file" ] && grep -q "version:" "$file"; then
        grep "version:" "$file" | head -1 | awk '{print $NF}'
    fi
}

echo "=========================================="
echo "BoS OS Advancing Skills Pre-Release Checklist"
echo "=========================================="
echo ""

# Discover every skill in the repo: any top-level directory containing a SKILL.md
SKILL_DIRS=$(find . -maxdepth 2 -name "SKILL.md" -not -path "./.git/*" | xargs -n1 dirname | sed 's|^\./||' | sort -u)

if [ -z "$SKILL_DIRS" ]; then
    echo "No skill folders found (no SKILL.md anywhere). Nothing to check."
    exit 1
fi

echo "Skills found in this repo:"
for d in $SKILL_DIRS; do echo "  - $d"; done
echo ""

# ==================== PHASE 1: REPOSITORY STATE ====================
echo "=== PHASE 1: REPOSITORY STATE ==="
echo ""

if git diff-index --quiet HEAD --; then
    check_pass "No uncommitted changes"
else
    check_fail "Uncommitted changes detected. Commit or stash before releasing."
    git status
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" = "main" ]; then
    check_pass "On main branch"
else
    check_fail "Not on main branch (current: $CURRENT_BRANCH)"
fi

git fetch origin main >/dev/null 2>&1 || true
LOCAL_COMMIT=$(git rev-parse main)
REMOTE_COMMIT=$(git rev-parse origin/main 2>/dev/null || echo "unknown")
if [ "$LOCAL_COMMIT" = "$REMOTE_COMMIT" ]; then
    check_pass "Main branch is up to date with origin"
elif [ "$REMOTE_COMMIT" = "unknown" ]; then
    check_pass "Main branch is up to date with origin (no origin/main ref found to compare against)"
elif git merge-base --is-ancestor "$REMOTE_COMMIT" "$LOCAL_COMMIT" 2>/dev/null; then
    # Local has commits origin doesn't yet -- this is the normal, safe state right
    # before a push (e.g. the release commit you just made). Fixed 2026-07-24:
    # this check used to compare LOCAL_COMMIT = REMOTE_COMMIT by exact equality,
    # which fails on every real release the moment a local commit is made ahead
    # of origin -- a false-positive "behind origin" trap. See MISSION-014 BLOCK-3
    # follow-up, Registry Known Issue #6.
    check_pass "Main branch is ahead of origin, safe to push (local commits not yet on origin)"
else
    check_fail "Main branch has diverged from or is behind origin. Pull/rebase before pushing."
fi

# ==================== PHASE 2: VERSION VALIDATION (every skill) ====================
echo ""
echo "=== PHASE 2: VERSION VALIDATION ==="
echo ""

for DIR in $SKILL_DIRS; do
    V=$(get_version "$DIR")
    if [ -n "$V" ]; then
        check_pass "Version found in $DIR/SKILL.md: $V"
    else
        check_fail "Version not found in $DIR/SKILL.md"
        continue
    fi

    if [[ $V =~ ^[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; then
        check_pass "Version format is valid for $DIR: $V"
    else
        check_fail "Version format is invalid for $DIR (expected X.Y or X.Y.Z): $V"
    fi

    TAG="${DIR}-v${V}"
    if git tag | grep -qx "$TAG"; then
        check_fail "Version $TAG already exists as a git tag for $DIR. Increment version."
    else
        check_pass "Version $TAG is not yet released"
    fi
done

# ==================== PHASE 3: FILE VALIDATION ====================
echo ""
echo "=== PHASE 3: FILE VALIDATION ==="
echo ""

if [ -f README.md ] && [ -s README.md ]; then
    check_pass "README.md exists and is not empty"
else
    check_fail "README.md is missing or empty"
fi

if [ -f .github/workflows/release.yml ]; then
    check_pass ".github/workflows/release.yml exists"
else
    check_fail ".github/workflows/release.yml not found"
fi

for DIR in $SKILL_DIRS; do
    if [ -f "$DIR/SKILL.md" ] && [ -s "$DIR/SKILL.md" ]; then
        check_pass "$DIR/SKILL.md exists"
    else
        check_fail "$DIR/SKILL.md is missing or empty"
    fi

    V=$(get_version "$DIR")
    if [ -n "$V" ]; then
        if grep -q "$V" README.md 2>/dev/null; then
            check_pass "README.md mentions $DIR v$V"
        else
            check_fail "README.md does not mention $DIR v$V"
        fi
    fi
done

# ==================== PHASE 4: CHANGELOG (every skill) ====================
echo ""
echo "=== PHASE 4: CHANGELOG ==="
echo ""

if [ ! -f CHANGELOG.md ]; then
    check_fail "CHANGELOG.md not found"
elif [ ! -s CHANGELOG.md ]; then
    check_fail "CHANGELOG.md is empty"
else
    check_pass "CHANGELOG.md exists and is not empty"
    for DIR in $SKILL_DIRS; do
        V=$(get_version "$DIR")
        [ -z "$V" ] && continue
        # Accepts either a skill-scoped heading ("## prospect-intelligence-scoping v1.0.0 ...")
        # or the older bare-version heading ("## v1.0.0 ...") for repos/entries predating
        # the skill-prefixed tag scheme.
        if grep -E "^#+.*\b${DIR}\b.*\b${V}\b" CHANGELOG.md > /dev/null || \
           grep -E "^#+[[:space:]]*(v)?${V}([[:space:]]|\$)" CHANGELOG.md > /dev/null; then
            check_pass "CHANGELOG.md contains an entry for $DIR v$V"
        else
            check_fail "CHANGELOG.md does not contain an entry for $DIR v$V"
        fi
    done
fi

# ==================== PHASE 5: CONTENT HYGIENE ====================
echo ""
echo "=== PHASE 5: CONTENT HYGIENE ==="
echo ""

for DIR in $SKILL_DIRS; do
    EMDASH_COUNT=$(grep -c "—" "$DIR/SKILL.md" || true)
    if [ "$EMDASH_COUNT" -eq 0 ]; then
        check_pass "No em dashes in $DIR/SKILL.md"
    else
        check_warn "$DIR/SKILL.md contains $EMDASH_COUNT em dash(es) - informational only, SKILL.md files are exempt from the house no-em-dash rule (Brand_and_Messaging.md), not a release blocker"
    fi
done

# ==================== PHASE 6: PACKAGE STRUCTURE ====================
echo ""
echo "=== PHASE 6: PACKAGE STRUCTURE ==="
echo ""

# Guards against the nested-folder zip bug: `zip -r x.skill dir/` packages the
# wrapping folder itself, putting SKILL.md one level too deep for Cowork's
# uploader (which expects SKILL.md at the zip root). Build each skill's
# package the same way release.yml does and verify the structure locally,
# before it ever reaches GitHub Actions. Added 2026-08-12 — the fix described
# in GitHub_Release_Process.md v1.7 as already ported to this repo was found
# live-missing at the start of the skill-currency-check-v1.0.0 release.
TMP_PKG_DIR=$(mktemp -d)
for DIR in $SKILL_DIRS; do
    PKG="$TMP_PKG_DIR/${DIR}.skill"
    (cd "$DIR" && zip -qr "$PKG" .)
    if unzip -l "$PKG" | awk '{print $4}' | grep -qx "SKILL.md"; then
        check_pass "$DIR packages with SKILL.md at the zip root"
    else
        check_fail "$DIR packages with SKILL.md nested (not at zip root) — would break Cowork's uploader"
    fi
done
rm -rf "$TMP_PKG_DIR"

# ==================== SUMMARY ====================
echo ""
echo "=========================================="
echo "Summary"
echo "=========================================="
echo -e "Passed: ${GREEN}$CHECKS_PASSED${NC}"
echo -e "Failed: ${RED}$CHECKS_FAILED${NC}"
echo ""

if [ $CHECKS_FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed. Safe to push.${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Review your commit message clarity"
    echo "  2. Run: git push origin main"
    echo "  3. Watch GitHub Actions: https://github.com/BoSMark/BoS_OS_Advancing_Skills/actions"
    echo "  4. Verify release at: https://github.com/BoSMark/BoS_OS_Advancing_Skills/releases"
    exit 0
else
    echo -e "${RED}✗ Checks failed. Do not push until issues are resolved.${NC}"
    exit 1
fi
