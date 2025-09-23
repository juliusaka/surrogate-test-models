# Dymola-Python-Interface Wrapper

This package adds in its *__init__.py* the Dymola Python Interface .egg file to the Python path, so that it can be imported in Python scripts.

# Usage

set the environment variable ```DYMOLA_PYTHON_INTERFACE``` to the path of the Dymola Python Interface .egg file, e.g. "C:\Program Files\Dymola 2024x\Modelica\Library\python_interface\dymola.egg"

```
[powerhell]
$env:DYMOLA_PYTHON_INTERFACE="C:\Program Files\Dymola 2024x\Modelica\Library\python_interface\dymola.egg"
```

Then, you can import the Dymola Python Interface in your Python scripts as follows:

```python
# this adds the .egg file to the Python path
import dymola_python_interface_wrapper
# as .egg file is now in path, you can import from it using the package name "dymola"
from dymola.dymola_interface import DymolaInterface 
dymola = DymolaInterface()
dymola.openModel("Modelica.Blocks.Examples.PID_Controller")
```

# open Docs
You can open the Dymola Python Interface documentation using the following script:

```shell
uv run dymola-python-docs
```

[It is defined as a script in pyproject.toml](./pyproject.toml) of this package.