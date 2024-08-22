# asdf-copier <!-- omit in toc -->

[![Build](https://github.com/looztra/asdf-copier/actions/workflows/code_checks.yml/badge.svg)](https://github.com/looztra/asdf-copier/actions/workflows/code_checks.yml)

[copier](https://copier.readthedocs.io/en/stable/) plugin for the [asdf version manager](https://asdf-vm.com).

## Contents

- [Contents](#contents)
- [Dependencies](#dependencies)
- [Install](#install)
  - [Plugin](#plugin)
  - [copier itself](#copier-itself)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- a python 3 runtime (provided through [asdf-python](https://github.com/asdf-community/asdf-python) or not)
- optional: [uv](https://docs.astral.sh/uv/)

## Install

### Plugin

When asdf-vm/asdf-plugins#1034 will be merged

```shell
asdf plugin add copier
```

Or:

```shell
asdf plugin add copier https://github.com/looztra/asdf-copier.git
```

### copier itself

- If `uv` is found, the virtual environment that hosts the `copier` package will be created with it. The plugin will fallback to `python -m venv`if `uv` is not available.
- Similarly to [asdf-pyapp](https://github.com/amrox/asdf-pyapp) (KUDOS to the maintainers!), the python **3** version used will be one provided by `asdf` if the [asdf-python](https://github.com/asdf-community/asdf-python) plugin is installed. The `asdf-copier` plugin will fallback to a system python3 installation if no python3 version is available through asdf.
- You can override the detection mechanism by providing the `ASDF_PYAPP_DEFAULT_PYTHON_PATH` environment variable when installing a `copier` version (we decided to use the same env var name as pyapp to avoid having to define one more env var if possible)

```shell
# Show all installable versions
asdf list all copier

# Install latest version
asdf install copier latest

# Set a version globally (on your ~/.tool-versions file)
asdf global copier latest

# Now copier commands are available
copier --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

## Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/looztra/asdf-copier/graphs/contributors)!

## License

See [LICENSE](LICENSE) © [Christophe Furmaniak](https://github.com/looztra/)
