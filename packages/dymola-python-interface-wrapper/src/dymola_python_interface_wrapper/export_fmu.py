import dymola_python_interface_wrapper
import pathlib
import argparse
import tempfile
import os

def export_fmu(model_path: str, library_path: str, libraries_to_load_path: str, fmu_args):
    from dymola.dymola_interface import DymolaInterface
    
    model_path = pathlib.Path(model_path)
    assert model_path.exists(), f"Model file {model_path} does not exist"

    dymola = DymolaInterface(showwindow=True)
    
    if libraries_to_load_path is not None:
        with open(pathlib.Path(library_path) / libraries_to_load_path, "r") as lib_file:
            for lib in lib_file:
                lib = lib.strip()
                lib = pathlib.Path(library_path+ lib)
                if lib:
                    assert lib.suffix == ".mo", f"Library file must be a .mo file, got {lib}"
                    assert lib.exists(), f"Library file {lib} does not exist"
                    print(f"Loading library {lib}")
                    dymola.openModel(str(lib.resolve()), changeDirectory=False)
                    print("\t --> Dymola output:" + dymola.getLastErrorLog())

    
    # change working directory
    working_dir = pathlib.Path('.dymola_wd')
    if not working_dir.exists():
        working_dir.mkdir()
    dymola.cd(str(working_dir.resolve()))
    
    def execute_command(cmd):
        print(cmd)
        dymola.ExecuteCommand(cmd)
        print("\t --> Dymola output: " + dymola.getLastErrorLog())

    # Set advanced options based on arguments
    execute_command(f"Advanced.EnableCodeExport = {'true' if fmu_args.EnableCodeExport else 'false'};")
    execute_command(f"Advanced.FMI.CrossExport = {'true' if fmu_args.CrossExport else 'false'};")
    execute_command(f"Advanced.FMI.UseInputSmoother = {'true' if fmu_args.UseInputSmoother else 'false'};")
    execute_command(f"Advanced.FMI.UsePredictorCompensation = {'true' if fmu_args.UsePredictorCompensation else 'false'};")
    execute_command(f"Advanced.FMI.CopyExternalResources = {'true' if fmu_args.CopyExternalResources else 'false'};")

    # Prepare arguments for translateModelFMU
    # the model is expected to be in library path, make relative to library path
    model_to_open = str(model_path.relative_to(pathlib.Path(library_path).parent).with_suffix("").as_posix())
    fmu_name = model_to_open.split("/")[-1]
    model_to_open = model_to_open.replace("/", ".")
    store_result = "true" if fmu_args.storeResults else "false"
    fmi_version = str(fmu_args.fmiVersion[0]) if isinstance(fmu_args.fmiVersion, list) else str(fmu_args.fmiVersion)
    fmi_type = fmu_args.fmiType[0] if isinstance(fmu_args.fmiType, list) else fmu_args.fmiType
    include_source = "true" if fmu_args.includeSource else "false"
    include_image = fmu_args.includeImage
    include_variables = fmu_args.includeVariables

    execute_command(
        f'translateModelFMU('
        f'modelToOpen="{model_to_open}", '
        f'storeResult={store_result}, '
        f'modelName="{fmu_name}", '
        f'fmiVersion="{fmi_version}", '
        f'fmiType="{fmi_type}", '
        f'includeSource={include_source}, '
        f'includeImage={include_image}, '
        f'includeVariables={include_variables}'
        f');'
    )

    execute_command("Advanced.FMI.CopyExternalResources = false;")
    execute_command("Advanced.EnableCodeExport = false;")
    execute_command("Advanced.FMI.UseInputSmoother = false;")
    execute_command("Advanced.FMI.UsePredictorCompensation = false;")
    execute_command("Advanced.FMI.CrossExport = false;")

    # copy fmu to model directory
    fmu_dir = model_path.parent 
    if not os.path.exists(fmu_dir):
        os.makedirs(fmu_dir)
    try: 
        os.replace(str(working_dir / f"{fmu_name}.fmu"), str(pathlib.Path(fmu_dir) / f"{fmu_name}.fmu"))
    except Exception as e:
        print(f"Error occurred while copying FMU. Probably the FMU Generation was not successful. Error: {e}")

    dymola.close()
    print(f"FMU exported to {fmu_dir}{fmu_name}")

def main():
    parser = argparse.ArgumentParser(description="Export a Modelica model to FMU using Dymola.")
    # This script expects the modelica package to not be saved as one file, but as a directory structure.
    
    parser.add_argument("model_path", type=str, help="Path to the Modelica model (e.g., 'models/ClaRaTester/SteamCycle_01.mo').")
    parser.add_argument("library_path", type=str, help="Path to the root of the Modelica libraries to load (e.g., 'models/myLib').")
    parser.add_argument("libraries_file", type=str, help="Path to a .txt-file containing libraries to load, one per line in the format 'package_name/package_name.mo'. Relative to library_path.")
    
    parser.add_argument("--storeResults", action='store_true', help="Flag to store simulation results as mat files.")
    parser.add_argument("--fmiVersion", type=str, nargs='*', default=2, help="FMI version(s) to use for export (e.g., 1, 2, or 3).")
    parser.add_argument("--fmiType", type=str, nargs='*', default="all", help="FMI type(s) to use for export (e.g., 'me', 'cs', 'all', 'csSolver').")
    parser.add_argument("--includeSource", action='store_true', help="Flag to include source code in the FMU.")
    parser.add_argument("--includeImage", type=str, default=0, help="Whether to include model image in the FMU (0, 1, 2).")
    parser.add_argument("--includeVariables", type=str, default='fill("",0)', help="Variables to include in the FMU.")

    # additional arguments
    parser.add_argument("--EnableCodeExport", action='store_true', help="Enable code export during FMU export.")
    parser.add_argument("--CrossExport", action='store_true', help="Enable cross export during FMU export.")
    parser.add_argument("--UseInputSmoother", action='store_true', help="Use input smoother during FMU export.")
    parser.add_argument("--UsePredictorCompensation", action='store_true', help="Use predictor compensation during FMU export.")
    parser.add_argument("--CopyExternalResources", action='store_true', help="Copy external resources during FMU export.")

    args = parser.parse_args()

    export_fmu(
        model_path=args.model_path,
        library_path=args.library_path,
        libraries_to_load_path=args.libraries_file,
        fmu_args=args
    )

if __name__ == "__main__":
    main()