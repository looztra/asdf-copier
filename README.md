# asdf-copier <!-- omit in toc -->

[![Build](https://github.com/looztra/asdf-copier/actions/workflows/build.yml/badge.svg)](https://github.com/looztra/asdf-copier/actions/workflows/build.yml) [![Lint](https://github.com/looztra/asdf-copier/actions/workflows/lint.yml/badge.svg)](https://github.com/looztra/asdf-copier/actions/workflows/lint.yml)

[copier](https://copier.readthedocs.io/en/stable/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

## Contents

- [Contents](#contents)
- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- a python 3 runtime
- optional: [uv](https://docs.astral.sh/uv/)

## Install

Plugin:

```shell
asdf plugin add copier
# or
asdf plugin add copier https://github.com/looztra/asdf-copier.git
```

copier:

```shell
# Show all installable versions
asdf list all copier

# Install specific version
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
