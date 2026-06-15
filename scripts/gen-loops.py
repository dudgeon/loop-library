#!/usr/bin/env python3
"""gen-loops.py — rebuild the loop registry's inventory table + mermaid topology in loop/LOOPS.md.

SELF-CONTAINED BY DESIGN. The single source of truth is loop/loops.registry.json. The generator
does NOT read the wiki (or anything else): a loop registry must travel with any repo that *uses*
loops, and a user's repo won't contain this research wiki. `catalog` links on entries are optional
cross-references only (in this repo they point at our wiki pages) — never a data dependency.

Run after editing the registry. `--check` verifies LOOPS.md is current (non-zero exit if stale).
"""
import json
import re
import sys
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
REG = ROOT / "loop" / "loops.registry.json"
OUT = ROOT / "loop" / "LOOPS.md"


def cell(s):
    return str(s).replace("|", "\\|")


def q(s):
    return str(s).replace('"', '\\"')


def build(reg):
    rows = [
        "| Loop | Status | Encoded in | Goal | Work product | Cadence | Maturity |",
        "| --- | --- | --- | --- | --- | --- | --- |",
    ]
    for l in reg["loops"]:
        catalog = l.get("catalog")
        name = f"[{l['name']}]({catalog})" if catalog else l["name"]
        status = l.get("status", "active")
        status_disp = "**active**" if status == "active" else status
        rows.append(
            "| " + " | ".join(cell(x) for x in [
                name, status_disp, l["encoded_in"], l["goal"], l["work_product"],
                l.get("cadence", "—"), l.get("maturity", "—"),
            ]) + " |"
        )
    inventory = "\n".join(rows)

    m = ["```mermaid", "flowchart TD"]
    for l in reg["loops"]:
        spec = l["mermaid"]
        shape, label = spec["shape"], q(spec["label"])
        if shape == "subgraph":
            m.append(f'  subgraph {l["id"]}["{label}"]')
            m.append(f'    {spec["inner_id"]}["{q(spec["inner_label"])}"]')
            m.append("  end")
        elif shape == "subroutine":
            m.append(f'  {l["anchor"]}[["{label}"]]')
        elif shape == "hexagon":
            m.append(f'  {l["anchor"]}{{{{"{label}"}}}}')
        else:
            m.append(f'  {l["anchor"]}["{label}"]')
    for n in reg.get("extra_nodes", []):
        label = q(n["label"])
        m.append(f'  {n["id"]}[("{label}")]' if n["shape"] == "cylinder" else f'  {n["id"]}["{label}"]')
    m.append("")
    for e in reg["edges"]:
        arrow = "-.->" if e.get("dotted") else "-->"
        m.append(f'  {e["from"]} {arrow}|{e["label"]}| {e["to"]}')
    for l in reg["loops"]:
        if l.get("status", "active") != "active":
            vid = l["id"] if l["mermaid"]["shape"] == "subgraph" else l["anchor"]
            m.append(f'  style {vid} stroke-dasharray: 4 3,opacity:0.7')
    m.append("```")
    return inventory, "\n".join(m)


def replace_region(text, name, body):
    start, end = f"<!-- gen-loops:{name}:start -->", f"<!-- gen-loops:{name}:end -->"
    pat = re.compile(re.escape(start) + r".*?" + re.escape(end), re.S)
    if not pat.search(text):
        raise SystemExit(f"marker block '{name}' not found in {OUT}")
    return pat.sub(lambda _: f"{start}\n{body}\n{end}", text)


def main():
    check = "--check" in sys.argv[1:]
    reg = json.loads(REG.read_text(encoding="utf-8"))
    inventory, topology = build(reg)
    cur = OUT.read_text(encoding="utf-8")
    new = replace_region(cur, "inventory", inventory)
    new = replace_region(new, "topology", topology)
    if check:
        if new != cur:
            print("STALE: loop/LOOPS.md is out of date — run scripts/gen-loops.sh", file=sys.stderr)
            sys.exit(1)
        print("OK: loop/LOOPS.md is up to date")
        sys.exit(0)
    OUT.write_text(new, encoding="utf-8")
    print(f"wrote {OUT.relative_to(ROOT)} — {len(reg['loops'])} loops, {len(reg['edges'])} edges")
    sys.exit(0)


if __name__ == "__main__":
    main()
