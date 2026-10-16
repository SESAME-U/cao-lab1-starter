# Cloud Automation and Orchestration - Lab 1

SESAME University, Computer Engineering, ING5. Week 2: Ansible, inventory, YAML and your first playbook.

You will create two servers, describe them in an Ansible inventory, fix a YAML file, and write a playbook that makes both servers serve a web page. Run it twice: the second run must change nothing.

## Start

1. Open this repository in a Codespace (**Code > Codespaces > Create codespace on main**).
2. Wait for `Toolbox ready`, then run `make check`.
3. Follow the Lab 1 handout shared in class.

## Two ways to get servers

| Path | Command | Servers | When |
| --- | --- | --- | --- |
| Azure (default) | `make azure-up` | 2 Ubuntu VMs, `Standard_B1s` | Your Azure for Students subscription works |
| Local (fallback) | `make local-up` | 2 Ubuntu containers in your Codespace | No Azure yet, or Azure is blocked |

Both paths write `inventory/generated.ini`. The rest of the lab is the same.

**Before you leave:** `make azure-down` (or `make local-down`), then stop your Codespace.

## What you edit

| File | Part |
| --- | --- |
| `inventory/hosts.ini` | B: group your servers |
| `yaml/shop.yml` | C: fix six YAML problems |
| `playbooks/site.yml` | D: write your first play |
| `SUBMISSION.md` | answers |

## Grading (10 points, autograded on every push)

| Check | Points |
| --- | --- |
| Part C: `yaml/shop.yml` loads with the right values | 2 |
| Part B: group `web` with 2 hosts and `http_port=80` | 1 |
| Part D: playbook runs and both pages say Hello | 3 |
| Part D: second run reports `changed=0` | 2 |
| `SUBMISSION.md` complete | 2 |

The autograder runs your playbook against two fresh containers on GitHub, not against your Azure VMs. Run the same checks yourself with `make test`.
