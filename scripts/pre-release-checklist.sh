#!/bin/bash

# Pre-Release Checklist for BoS OS Advancing Skills
#
# Validates that a release is ready to push to main.
# Adapted from BoS_OS_Start's checklist for a single-skill repo.
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

echo "=========================================="
echo "BoS OS Advancing Skills Pre-Release Checklist"
echo "=========================================="
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
if [ "$LOCAL_COMMIT" = "$REMOTE_COMMIT" ] || [ "$REMOTE_COMMIT" = "unknown" ]; then
    check_pass "Main branch is up to date with origin"
else
    check_fail "Main branch is behind origin. Pull before pushing."
fi

# ==================== PHASE 2: VERSION VALIDATION ====================
echo ""
echo "=== PHASE 2: VERSION VALIDATION ==="
echo ""

if grep -q "version:" signalprocessing/SKILL.md; then
    VERSION=$(grep "version:" signalprocessing/SKILL.md | head -1 | awk '{print $NF}')
    check_pass "Version found in signalprocessing/SKILL.md: $VERSION"
else
    check_fail "Version not found in signalprocessing/SKILL.md"
    VERSION=""
fi

if [ -n "$VERSION" ] && [[ $VERSION =~ ^[0-9]+\.[0-9]+(\.[0-9]+)?$ ]]; then
    check_pass "Version format is valid: $VERSION"
else
    check_fail "Version format is invalid (expected X.Y or X.Y.Z): $VERSION"
fi

if [ -n "$VERSION" ]; then
    if git tag | grep -q "^v$VERSION$"; then
        check_fail "Version v$VERSION already exists as a git tag. Increment version."
    else
        check_pass "Version v$VERSION is not yet released"
    fi
fi

# ==================== PHASE 3: FILE VALIDATION ====================
echo ""
echo "=== PHASE 3: FILE VALIDATION ==="
echo ""

if [ -f README.md ] && [ -s README.md ]; then
    check_pass "README.md exists and is not empty"
else
    check_fail "README.md is missing or empty"
fi

if [ -n "$VERSION" ]; then
    if grep -q "$VERSION" README.md 2>/dev/null; then
        check_pass "README.md mentions v$VERSION"
    else
        check_fail "README.md does not mention v$VERSION"
    fi
fi

if [ -f signalprocessing/SKILL.md ] && [ -s signalprocessing/SKILL.md ]; then
    check_pass "signalprocessing/SKILL.md exists"
else
    check_fail "signalprocessing/SKILL.md is missing or empty"
fi

if [ -f .github/workflows/release.yml ]; then
    check_pass ".github/workflows/release.yml exists"
else
    check_fail ".github/workflows/release.yml not found"
fi

# ==================== PHASE 4: CHANGELOG ====================
echo ""
echo "=== PHASE 4: CHANGELOG ==="
echo ""

if [ ! -f CHANGELOG.md ]; then
    check_fail "CHANGELOG.md not found"
elif [ ! -s CHANGELOG.md ]; then
    check_fail "CHANGELOG.md is empty"
else
    check_pass "CHANGELOG.md exists and is not empty"
    if [ -n "$VERSION" ]; then
        if grep -E "^#+\s*(v)?$VERSION" CHANGELOG.md > /dev/null; then
            check_pass "CHANGELOG.md contains entry for v$VERSION"
        else
            check_fail "CHANGELOG.md does not contain entry for v$VERSION"
        fi
    fi
fi

# ==================== PHASE 5: CONTENT HYGIENE ====================
echo ""
echo "=== PHASE 5: CONTENT HYGIENE ==="
echo ""

EMDASH_COUNT=$(grep -c "—" signalprocessing/SKILL.md || true)
if [ "$EMDASH_COUNT" -eq 0 ]; then
    check_pass "No em dashes in signalprocessing/SKILL.md"
else
    check_fail "signalprocessing/SKILL.md contains $EMDASH_COUNT em dash(es), house style forbids these"
fi

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
