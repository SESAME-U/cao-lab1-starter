"""Autograded check for Lab 1, Part B: the inventory structure.

Passes when inventory/hosts.ini defines a group "web" with at least two hosts
and the group variable http_port=80. Real IPs are not checked.
"""
import json
import subprocess
import sys

out = subprocess.run(
    ["ansible-inventory", "-i", "inventory/hosts.ini", "--list"],
    capture_output=True, text=True, check=True,
).stdout
data = json.loads(out)

hosts = data.get("web", {}).get("hosts", [])
if len(hosts) < 2:
    sys.exit(f"group 'web' must contain at least 2 hosts, found {hosts}")

hostvars = data.get("_meta", {}).get("hostvars", {})
for h in hosts:
    port = str(hostvars.get(h, {}).get("http_port", ""))
    if port != "80":
        sys.exit(f"host {h}: http_port should be 80 (set it in [web:vars]), found {port!r}")

print(f"OK: group web has {len(hosts)} hosts with http_port=80")
