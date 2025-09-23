import os
import pathlib
import webbrowser

def open_docs():
    egg_path = os.getenv("DYMOLA_PYTHON_INTERFACE")
    if egg_path and os.path.exists(egg_path):
        docs_path = pathlib.Path(egg_path).parent / "doc" / "index.html"
        if docs_path.exists():
            webbrowser.open_new_tab(docs_path.as_uri())
        else:
            print(f"Documentation not found at {docs_path}")
    else:
        print("DYMOLA_PYTHON_INTERFACE environment variable is not set or path does not exist.")

if __name__ == "__main__":
    open_docs()