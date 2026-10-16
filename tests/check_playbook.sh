#!/usr/bin/env bash
# Autograded check for Lab 1, Part D.
#   converge   : the playbook runs and both pages say "Hello from <name>"
#   idempotent : a second run reports changed=0 on every host
set -uo pipefail
cd "$(dirname "$0")/.."
mode="${1:-converge}"
INV="tests/ci.ini"

case "$mode" in
  converge)
    ansible-playbook -i "$INV" playbooks/site.yml --syntax-check || exit 1
    ansible-playbook -i "$INV" playbooks/site.yml || exit 1
    for i in 1 2; do
      page=$(curl -fsS "http://127.0.0.1:808$i/") || { echo "web$i: no page on port 808$i"; exit 1; }
      grep -q "Hello from web$i" <<<"$page" || { echo "web$i: page does not say 'Hello from web$i'"; echo "$page"; exit 1; }
    done
    echo "OK: both servers serve their page"
    ;;
  idempotent)
    out=$(ansible-playbook -i "$INV" playbooks/site.yml) || { echo "$out"; exit 1; }
    echo "$out" | sed -n '/PLAY RECAP/,$p'
    if echo "$out" | sed -n '/PLAY RECAP/,$p' | grep -Eq 'changed=[1-9]'; then
      echo "Second run changed something: the playbook is not idempotent."
      exit 1
    fi
    echo "OK: second run changed nothing"
    ;;
  *) echo "usage: $0 converge|idempotent"; exit 2 ;;
esac
