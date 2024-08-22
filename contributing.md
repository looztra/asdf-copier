# Contributing

## When developing the plugin

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

asdf plugin test copier https://github.com/looztra/asdf-copier.git "copier --help"
```

Tests are automatically run in GitHub Actions on push and PR.

## Before pushing

- Make sure you installed the required dev dependencies with `asdf install`
- Run the pre-commit hooks: `pre-commit run --all-files`
