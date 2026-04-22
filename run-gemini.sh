#!/usr/bin/env bash
set -euo pipefail
cd /home/node/projects/zymovo-fresh-site
TASK_CONTENT="$(cat /home/node/projects/zymovo-fresh-site/TASK.md)"
printf '== IMAGE FILES ==\n'
find zymovoimages -maxdepth 1 -type f | sort

run_model() {
  local model="$1"
  printf '\n== RUN GEMINI (%s) ==\n' "$model"
  GOOGLE_GENAI_USE_GCA=true timeout 900 sh -c "gemini --approval-mode=yolo -m '$model' -p \"$TASK_CONTENT
Do not ask for confirmation. Build the complete new site now from scratch in this directory, commit the result, and push to origin/main before finishing.\" </dev/null"
}

run_model gemini-3.1-pro-preview \
  || run_model gemini-3.1-pro \
  || run_model gemini-3.1-flash-preview \
  || run_model gemini-3.1-flash \
  || run_model gemini-3.0-flash-preview \
  || run_model gemini-3.0-flash

printf '\n== GIT STATUS ==\n'
git status --short || true
printf '\n== LAST LOG ==\n'
git --no-pager log -3 --oneline || true
