# surrogate-test-models

## Description
This repository is a collection of free test models for training of surrogate models, for which no intellectual property rights exist. The models are modelled in Modelica and exported as FMUs (following the [FMI standard](https://fmi-standard.org/)) from Dymola. The purpose of this repository is to use them to generate datasets to train data-driven surrogate methods. 

## Cloning this repository
`git lfs` is enabled for this repository to efficiently store large files. You can simply clone the repository using:

```
git clone <repository-url>
```

For faster download, use:

```
git lfs clone <repository-url>
```

## Install uv
```uv``` is a powerful python dependency and environment manager. Please install it from [uv docs](https://docs.astral.sh/uv/getting-started/installation/).
The easiest way is to use pip:
```bash
pip install uv
```


## Usage

### FMU Generation

This repository provides tools to generate Functional Mock-up Units (FMUs) from Modelica models using Dymola.

#### Command Line Interface

To interact with dymola, the environment variable ```DYMOLA_PYTHON_INTERFACE``` must be set to the path of your Dymola installation. For example, in Git Bash:

```bash
export DYMOLA_PYTHON_INTERFACE="C:\Program Files\Dymola 2024x\Modelica\Library\python_interface\dymola.egg"
```
Starting in Dymola 2025x, this might be a *.whl file instead of an .egg file.

You can also set it in Windows Environment Variables. *(Search for "Environment Variables" in Windows Settings, add the environment variable, and restart your terminal or IDE to apply the changes.)*



Generate FMUs using the `export-fmu` command:

```bash
uv run export-fmu <model_path> <libraries_file> [options]
```
*(the command is defined in the `pyproject.toml` under ```packages/dymola-python-interface-wrapper```)*

**Arguments:**
- `model_path`: Path to the Modelica model file (e.g., `models/ClaRaTester/SteamCycle_01.mo`)
- `libraries_file`: Full path to the `libraries.txt` file containing required libraries

**Options:**
Use `--help` to see all available options:
```bash
uv run export-fmu --help
```

**Example:**
```bash
uv run export-fmu models/ClaRaTester/SteamCycle_01.mo ./models/ClaRaTester/libraries.txt --CopyExternalResources
```

for more information, see the [dymola-python-interface-wrapper README](packages/dymola-python-interface-wrapper/README.md).

#### Batch Generation

For regenerating all FMUs of this repository, use the provided script:
- **Git Bash**: `bash generate_fmus.sh`

#### Generated Files

Each FMU export creates three files in the model directory:
1. `{model_name}.fmu` - The exported FMU file
2. `export_{model_name}.mos` - Dymola script for regenerating the FMU
3. `export_{model_name}.log` - Complete log of the export process

#### Manual Dymola Export

If you need to regenerate a single FMU manually in Dymola:
- To open the model, use the `startup.mos` file in each model directory to quickly load required libraries.
- To generate a new fmu, save your model and run the generated `export_{model_name}.mos` script.


#### Library Structure

Each (Modelica) model package in the `models/` directory contains:
- `libraries.txt` - List of required Modelica libraries (placed at package top level)
- `startup.mos` - Dymola script to open all libraries listed in `libraries.txt` for fast access
- Model files (`.mo`)

The `libraries.txt` file should contain relative paths to library files, one per line:
```
./../..libraries/ClaRa/package.mo
./package.mo
```
### Using fmpy to simulate FMUs
You can use the [fmpy](https://pypi.org/project/FMPy/) package to simulate the generated FMUs.

To launch the FMPy GUI using `uv`, run:

```bash
uvx --from 'fmpy[complete]' python -m fmpy.gui
```
*(uv will create a temporary environment with only fmpy installed. )*

To create a desktop shortcut (Windows):

1. Right-click your desktop and choose **New > Shortcut**.
2. For the location, enter:
    ```
    uvx --from "fmpy[complete]" python -m fmpy.gui
    ```
3. Click **Next**, name the shortcut (e.g., "FMPy GUI"), and click **Finish**.


## Support
If you have questions or issues, please open an issue on GitHub.

## Contributing
You are welcome to contribute further test models to this project. Please fork the repository and create a pull request with your changes.

## Authors and acknowledgment
- Julius Aka, 
Chair of Mechatronics, 
University of Augsburg,
<julius.aka@uni-a.de>

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Third-Party Licenses

This project makes use of external code via git submodules.  
Please see the individual submodules for their licenses.  
In particular:
- ClaRa development team code (BSD 3-Clause) → see `third_party_licenses/ClaRa.md`

### Dependency on Dymola® for FMU generation

This project contains Python code that uses the **Dymola® Python Interface**. Dymola® is proprietary software by Dassault Systèmes and is **not included** in this repository.  
To run the the FMU generation scripts in this repository, you must have your **own licensed installation of Dymola®**.