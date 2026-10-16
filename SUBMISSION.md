# Lab 1 submission

Fill in every line marked `ANSWER:` (one to three sentences each). Write the answer on the same line, right after `ANSWER:`; for pasted output, add a short summary there and paste the output below. Push before the start of the week 3 session.

## Part A - targets

- Path used (azure or local): ANSWER:
- If Azure: region used: ANSWER:

## Part B - inventory and ad hoc commands

1. Paste the output of `ansible-inventory --graph`.
   ANSWER:

2. You ran `ansible web -b -m ansible.builtin.apt -a "name=htop state=present update_cache=true"` twice. What did each run report (changed or ok), and why?
   ANSWER:

3. What is the difference between `ansible web -a "uptime"` and `ansible web -m ping`? Which one checks that Python works on the target?
   ANSWER:

## Part C - YAML

4. Which of the six problems in `yaml/shop.yml` would have broken a real deployment silently, without any error message?
   ANSWER:

## Part D - first playbook

5. Paste the PLAY RECAP of your first run and of your second run.
   ANSWER:

6. Why does `cache_valid_time: 3600` matter for idempotency?
   ANSWER:

## Cleanup

- Azure resource group deleted, or local containers removed (yes/no): ANSWER:
