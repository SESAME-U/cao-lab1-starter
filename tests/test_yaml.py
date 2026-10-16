"""Autograded checks for Lab 1, Part C (yaml/shop.yml).

Loaded with PyYAML, the same parser Ansible uses, so the YAML 1.1 rules
(yes/no/NO become booleans, 1.10 becomes a float) apply exactly as in a playbook.
"""
from pathlib import Path

import yaml

SHOP_FILE = Path(__file__).resolve().parents[1] / "yaml" / "shop.yml"


class NoDuplicatesLoader(yaml.SafeLoader):
    """SafeLoader that refuses duplicate keys (PyYAML silently keeps the last one)."""


def _no_duplicates(loader, node, deep=False):
    keys = [loader.construct_object(k, deep=deep) for k, _ in node.value]
    dupes = {k for k in keys if keys.count(k) > 1}
    if dupes:
        raise yaml.constructor.ConstructorError(
            None, None, f"duplicate key(s): {sorted(dupes)}", node.start_mark)
    return loader.construct_mapping(node, deep=deep)


NoDuplicatesLoader.add_constructor(
    yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG, _no_duplicates)


def load():
    return yaml.load(SHOP_FILE.read_text(), Loader=NoDuplicatesLoader)["shop"]


def test_file_is_valid_yaml_without_duplicate_keys():
    load()


def test_strings_are_strings():
    shop = load()
    assert shop["name"] == "SESAME Shop"
    assert shop["tagline"] == "Fast: cheap: reliable"
    assert shop["country"] == "NO", "Norway problem: NO unquoted is the boolean false"
    assert shop["version"] == "1.10", "1.10 unquoted is the number 1.1"


def test_lists_and_maps():
    shop = load()
    assert shop["ports"] == [80, 443]
    assert shop["admins"] == [
        {"name": "Amira", "email": "amira@example.com"},
        {"name": "Youssef", "email": "youssef@example.com"},
    ]


def test_boolean():
    assert load()["enabled"] is True
