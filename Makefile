.PHONY: help check azure-up azure-down local-up local-down ping test-yaml test-inventory run test clean

help:
	@echo "make check           verify the toolbox"
	@echo "make azure-up        Part A, Azure path: create web1 and web2 VMs"
	@echo "make local-up        Part A, no-Azure path: start web1 and web2 containers"
	@echo "make ping            Part B: ansible web -m ping"
	@echo "make test-yaml       Part C: check yaml/shop.yml"
	@echo "make test-inventory  Part B: check inventory/hosts.ini"
	@echo "make run             Part D: run playbooks/site.yml"
	@echo "make test            run the autograder checks against local containers"
	@echo "make azure-down      delete the Azure VMs (do this before you leave)"
	@echo "make local-down      remove the local containers"

check:
	@bash scripts/check.sh

azure-up:
	@bash targets/azure-up.sh

azure-down:
	@bash targets/azure-down.sh

local-up:
	@bash targets/local-up.sh

local-down:
	@bash targets/local-down.sh

ping:
	ansible web -m ping

test-yaml:
	@python3 -m pytest -q -p no:cacheprovider tests/test_yaml.py

test-inventory:
	@python3 tests/check_inventory.py

run:
	ansible-playbook playbooks/site.yml

# Same checks as the autograder, on fresh local containers (needs Docker).
test: test-yaml test-inventory
	@bash tests/ci-targets.sh
	@bash tests/check_playbook.sh converge
	@bash tests/check_playbook.sh idempotent

clean:
	rm -f tests/ci.ini .ci_key .ci_key.pub
