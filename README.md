# Autoincrement Version

A GitHub Action that automatically increments version numbers based on branch naming conventions. Perfect for semantic versioning workflows that follow Git Flow or similar branching strategies.

## Features

- 🔢 Automatically increments version numbers based on branch type
- 📋 Supports semantic versioning (major.minor.patch)
- 🌿 Works with common branch naming conventions
- 📝 Updates version files in your repository
- ⚡ Fast and lightweight

## Usage

Add this action to your workflow:

```yaml
name: Version Increment
on:
  push:
    branches:
      - 'release/**'
      - 'feature/**'
      - 'feat/**'
      - 'bug/**'
      - 'bugfix/**'
      - 'chore/**'

jobs:
  increment-version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Autoincrement Version
        uses: placemyorderorg/autoincrementversion@v1
        with:
          branch: ${{ github.ref_name }}
          versionfile: './version.txt'
```

## Inputs

| Input | Description | Required |
|-------|-------------|----------|
| `branch` | The branch name (typically `${{ github.ref_name }}`) | Yes |
| `versionfile` | Path to the version file (e.g., `./version.txt`) | Yes |

## Version File Format

Your version file should contain a semantic version number in the format:

```
1.0.0
```

## Branch Naming Convention

The action determines how to increment the version based on the branch prefix:

| Branch Type | Version Change | Example Branch |
|-------------|----------------|----------------|
| `release/*` | Major version increment (X.0.0) | `release/new-feature` |
| `feature/*` or `feat/*` | Minor version increment (x.Y.0) | `feature/user-auth` |
| `bug/*`, `bugfix/*`, or `chore/*` | Patch version increment (x.y.Z) | `bug/fix-login` |

### Examples

- Starting version: `1.5.3`
- Branch: `release/v2` → New version: `2.0.0`
- Branch: `feature/new-api` → New version: `1.6.0`
- Branch: `bug/fix-crash` → New version: `1.5.4`

## Complete Workflow Example

Here's a complete example that increments the version and commits it back to the repository:

```yaml
name: Auto Increment Version
on:
  push:
    branches:
      - 'release/**'
      - 'feature/**'
      - 'feat/**'
      - 'bug/**'
      - 'bugfix/**'
      - 'chore/**'

jobs:
  version:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Increment Version
        uses: placemyorderorg/autoincrementversion@v1
        with:
          branch: ${{ github.ref_name }}
          versionfile: './version.txt'

      - name: Commit Version Change
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add version.txt
          git commit -m "Auto increment version [skip ci]" || exit 0
          git push
```

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

If you encounter any issues or have questions, please [open an issue](https://github.com/placemyorderorg/autoincrementversion/issues).
