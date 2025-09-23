import os
import sys

# Read the env var from the .env file
egg_path = os.getenv("DYMOLA_PYTHON_INTERFACE")
print(f"DYMOLA_PYTHON_INTERFACE is set to: {egg_path}")
if egg_path:
    # Make sure egg_path exists and is on sys.path
    if os.path.exists(egg_path) and egg_path not in sys.path:
        sys.path.insert(0, egg_path)
    else:
        # Optional: warning if not found
        import warnings
        warnings.warn(f"DYMOLA_PYTHON_INTERFACE env var set to '{egg_path}', but path does not exist.")
else:
    import warnings
    warnings.warn("DYMOLA_PYTHON_INTERFACE env var not set. Dymola Python interface may not be available.")