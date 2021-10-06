# GoKart Action

Scan your Golang code for vulnerabilities with GoKart

## Usage

The workflow, usually declared in `.github/workflows/gokart.yaml` under your Go project repository, looks like:

```yaml
name: GoKart

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: 0 0 * * *

jobs:
  gokart:
    name: GoKart scanner
    runs-on: ubuntu-latest
    permissions:
      contents: read
      security-events: write

    steps:
    - name: Checkout the code
      uses: actions/checkout@v2

    - name: Run GoKart
      uses: phogolabs/gokart-action@v1.0.0
      with: { globalsTainted: true }
```

## References

- https://github.com/praetorian-inc/gokart
