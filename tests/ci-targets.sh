#!/usr/bin/env bash
# Used by the autograder only: start two fresh containers and write a CI
# inventory pointing at them. The student's own inventory is not used here,
# because the GitHub runner cannot reach your Azure VMs.
set -euo pipefail
cd "$(dirname "$0")/.."

export KEY="$PWD/.ci_key"
rm -f "$KEY" "$KEY.pub"
ssh-keygen -q -t ed25519 -N "" -f "$KEY"
./targets/local-up.sh

cat > tests/ci.ini <<EOF
[web]
web1 ansible_host=127.0.0.1 ansible_port=2221
web2 ansible_host=127.0.0.1 ansible_port=2222

[web:vars]
http_port=80
ansible_ssh_private_key_file=$KEY
EOF

# Wait until SSH answers on both containers.
for p in 2221 2222; do
  for _ in $(seq 1 30); do
    ssh -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
        -i "$KEY" -p "$p" azureuser@127.0.0.1 true && break
    sleep 1
  done
done
echo "CI targets ready."
