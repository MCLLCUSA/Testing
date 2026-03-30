#!/bin/bash
# Backup workspace files to GitHub

REPO_DIR="/tmp/backup-repo"
WORKSPACE_DIR="/root/.openclaw/workspace"
REPO_URL="https://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@github.com/MCLLCUSA/Testing.git"

# Clone or pull the repo
if [ -d "$REPO_DIR" ]; then
    cd "$REPO_DIR" && git pull origin main
else
    git clone "$REPO_URL" "$REPO_DIR"
    cd "$REPO_DIR"
    git config user.email "casey@example.com"
    git config user.name "Casey"
fi

# Copy workspace files (excluding this script itself)
mkdir -p "$REPO_DIR/workspace-backup"
cp -r "$WORKSPACE_DIR"/* "$REPO_DIR/workspace-backup/"

# Commit and push
cd "$REPO_DIR"
git add .
git commit -m "Backup workspace $(date '+%Y-%m-%d %H:%M')" 2>/dev/null || echo "No changes to commit"
git push origin main

echo "Backup complete: $(date)"