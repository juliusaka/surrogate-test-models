# Dymola Python Interface Wrapper

This package provides a wrapper around the Dymola Python Interface for generating Functional Mock-up Units (FMUs) from Modelica models. It automatically handles the Dymola Python Interface .egg file integration and provides command-line tools for FMU generation.

## Features

- **Automatic Integration**: Automatically adds the Dymola Python Interface .egg file to the Python path
- **FMU Export**: Streamlined FMU generation with comprehensive logging via ```uv run export-fmu```
- **Documentation Access**: Quick access to Dymola Python Interface documentation via ```uv run dymola-python-docs```

## Installation

## Prerequisites

### Environment Setup

To interact with Dymola, you must set the `DYMOLA_PYTHON_INTERFACE` environment variable to point to your Dymola installation's Python interface:

**Option 1: Command Line (Git Bash/Linux)**
```bash
export DYMOLA_PYTHON_INTERFACE="C:\Program Files\Dymola 2024x\Modelica\Library\python_interface\dymola.egg"
```
Starting in Dymola 2025x, this might be a *.whl file instead of an .egg file.

**Option 2: Windows Environment Variables**
1. Search for "Environment Variables" in Windows Settings
2. Add a new environment variable:
   - Variable name: `DYMOLA_PYTHON_INTERFACE`
   - Variable value (example): `C:\Program Files\Dymola 2024x\Modelica\Library\python_interface\dymola.egg`
3. Restart your terminal or IDE to apply the changes

## Usage

### FMU Generation

Generate FMUs using the `export-fmu` command:

```bash
uv run export-fmu <model_path> <libraries_file> [options]
```

We expect that the Modelica package is saved in directory-structure, meaning that each model is a single `.mo` file within a folder that contains a `package.mo` file, whereas subpackages are represented as likewise subfolders.

**Arguments:**
- `model_path`: Path to the Modelica model file (e.g., `models/ClaRaTester/SteamCycle_01.mo`) (This is internally converted to the dot-indexed Modelica name e.g. `ClaRaTester.SteamCycle_01`)
- `libraries_file`: Full path to the `libraries.txt` file containing required libraries. The libraries file is expected to be in the root directory of the Modelica package, that means within the same directory as the first 'package.mo' file.

The `libraries.txt` file should contain relative paths to library files, one per line:

```
../../../libraries/ClaRa/package.mo
./package.mo
``` 

**Options:**
Use `--help` to see all available options:
```bash
uv run export-fmu --help
```

**Example:**
```bash
uv run export-fmu models/ClaRaTester/SteamCycle_01.mo ./models/ClaRaTester/libraries.txt --CopyExternalResources
```

#### Generated Files

Each FMU export creates three files in the model directory:

1. **`{model_name}.fmu`** - The exported FMU file
2. **`export_{model_name}.mos`** - Dymola script for regenerating the FMU
3. **`export_{model_name}.log`** - Complete log of the export process

#### Manual Dymola Export

If you need to regenerate a single FMU manually in Dymola:

1. **Open the model**: Use the `startup.mos` file in each model directory to quickly load required libraries
2. **Generate FMU**: Save your model and run the generated `export_{model_name}.mos` script

### Documentation Access

Open the Dymola Python Interface documentation:

```bash
uv run dymola-python-docs
```

### Programming Interface

You can also use the wrapper programmatically:

```python
import dymola_python_interface_wrapper
from dymola.dymola_interface import DymolaInterface

# The dymola module is now available for use
dymola = DymolaInterface()
# ... your Dymola operations
```
