# Development Environment Tasks

This assumes that `mask` has been installed. If it hasn't already been
installed one may use `mise` en place.

## sync

> Synchronize project dependencies

By synchronizing project dependencies this ensures that the pinned versions are
used and that they exist in the first place.

```nu
mise i
mise exec -- pnpm i
mise exec -- uv sync

cd src

mise exec -- ggg sync --force

run ./sh/replace.nu
```

## dev

```nu
cd src
mise exec -- ggg edit
```
