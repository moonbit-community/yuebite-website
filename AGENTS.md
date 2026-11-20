# Repository Instructions

## MoonBit validation

After editing MoonBit code, run `moon fmt` followed by `moon check` from the repository root. Run the commands for every component you changed.

### Website generator

```sh
moon fmt generator
moon check --target js --deny-warn generator
```

### Build script

```sh
moon fmt build-site.mbtx
moon check --target native --deny-warn build-site.mbtx
```

Fix every compiler error and warning, then rerun formatting and checks. Finish only when the applicable checks pass with zero errors and warnings.
