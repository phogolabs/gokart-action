# gokart-action

Scan your Golang code for vulnerabilities with GoKart.

## Usage

The workflow, usually declared in `.github/workflows/gokart.yaml` under your Go project repository, looks like:

```yaml
name: gokart

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: 0 0 * * *

jobs:
  gokart:
    name: gokart scanner
    runs-on: ubuntu-latest

    permissions:
      contents: read
      security-events: write

    steps:
    - name: Checkout
      uses: actions/checkout@v2

    - name: Run GoKart
      uses: phogolabs/gokart-action@v2.0.0
```

## References

- https://github.com/praetorian-inc/gokart
