#!/usr/bin/env python3

import os
import subprocess
from pathlib import Path
from typing import List

root = Path('.')
excludes = [Path(".git"), Path(".godot"), Path("venv")]

gdscript_files: List[Path] = []

for path in root.iterdir():
    if path.is_file():
        if path.suffix == ".gd":
            gdscript_files.append(path)
    elif path.is_dir():
        if path in excludes:
            continue
        for (dirpath, _, filenames) in path.walk():
            for filename in filenames:
                filepath = dirpath / filename
                if filepath.suffix == ".gd":
                    gdscript_files.append(filepath)
    else:
        raise Exception(f"{path} is neither file nor directory")

command_args = ["gdformat", "--line-length", "120"] + [str(filepath) for filepath in gdscript_files]
subprocess.run(command_args)

print("Removing double empty lines and replacing tabs with 4 spaces...")
for filepath in gdscript_files:
    lines: str = []
    with open(filepath, "r") as f:
        lines = f.readlines()
    delete_lines: int = []
    last_was_empty = False
    for i, line in enumerate(lines):
        line_is_empty = line == "\n"
        if line_is_empty and last_was_empty:
            delete_lines.append(i)
        else:
            lines[i] = line.replace("\t", "    ")
        last_was_empty = line_is_empty
    for i, idx in enumerate(delete_lines):
        lines.pop(idx - i)
    with open(filepath, "w") as f:
        f.writelines(lines)
