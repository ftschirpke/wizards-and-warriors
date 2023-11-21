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