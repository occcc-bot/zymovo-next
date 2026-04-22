#!/usr/bin/env bash
set -euo pipefail
cd /home/node/projects/zymovo-fresh-site
printf '== IMAGE FILES ==\n'
find zymovoimages -maxdepth 1 -type f | sort
printf '\n== RUN GEMINI ==\n'
timeout 1800 sh -c 'GOOGLE_GENAI_USE_GCA=true gemini --approval-mode=yolo -m gemini-2.5-flash -p "$(cat TASK.md)
Do not ask for confirmation. Build the complete new site now from scratch in this directory, commit the result, and push to origin/main before finishing." </dev/null'
printf '\n== GIT STATUS ==\n'
git status --short || true
printf '\n== LAST LOG ==\n'
git --no-pager log -3 --oneline || true
