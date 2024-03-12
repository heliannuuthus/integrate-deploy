<h1 align="center">🌻🌻integration 🌻 deployment🌻🌻</h1>

## Introduction
A github **continuous integration** and **continuous deployment**, built-in `java`, `rust`, `golang`, `node` different programming languages reusable workflow.

## Getting Started
For **Java** projects that use **gradle** as a build tool, it provides integrated configuration, supporting `single applications`, `cloud services`, `single project libraries`, and `multi-project libraries`.

### rust
[![rust](https://github.com/heliannuuthus/integration-deploy/actions/workflows/rust-ci.yml/badge.svg)](https://github.com/heliannuuthus/integration-deploy/actions/workflows/rust-ci.yml)

```yaml
name: rust

on:
  pull_request:
    types: [opened, reopened, synchronize]
  pull_request_target:
    types: [closed]
jobs:
  setup:
    uses: ./.github/workflows/call-rust-setup.yml
    with:
      workdir: "tests/rust/"

  lint:
    if: ${{ github.event.pull_request.merged != true }}
    needs: setup
    uses: ./.github/workflows/call-rust-lint.yml
    with:
      workdir: "tests/rust/"

  build:
    if: ${{ always() && needs.setup.result == 'success' }}
    needs: [setup, lint]
    uses: ./.github/workflows/call-rust-build.yml
    with:
      workdir: "tests/rust/"

  containeraized:
    if: ${{ always() && github.event.pull_request.merged == true }}
    needs: build
    permissions:
      contents: read
      packages: write
    uses: ./.github/workflows/call-containerize.yml
    with:
      version: ${{ needs.build.outputs.version }}
      workdir: "tests/rust/"
      target: "tests/rust/target/"
```

### gradle
[![gradle](https://github.com/heliannuuthus/integration-deploy/actions/workflows/gradle-ci.yml/badge.svg)](https://github.com/heliannuuthus/integration-deploy/actions/workflows/gradle-ci.yml)
```yaml
name: gradle

on:
  pull_request:
    types: [opened, reopened, synchronize]
  pull_request_target:
    types: [closed]

jobs:
  lint:
    if: ${{ github.event.pull_request.merged != true }}
    uses: ./.github/workflows/call-gradle-lint.yml
    with:
      workdir: "tests/gradle/"

  build:
    if: always()
    needs: lint
    uses: ./.github/workflows/call-gradle-build.yml
    with:
      workdir: "tests/gradle/"

  publish:
    if: ${{ always() && github.event.pull_request.merged == true }}
    needs: build
    permissions:
      contents: read
      packages: write
    uses: ./.github/workflows/call-gradle-publish.yml
    with:
      workdir: "tests/gradle/"
      user: ${{ github.actor }}
    secrets:
      token: ${{ secrets.GITHUB_TOKEN }}
```
### golang
[![golang](https://github.com/heliannuuthus/integration-deploy/actions/workflows/golang-ci.yml/badge.svg)](https://github.com/heliannuuthus/integration-deploy/actions/workflows/golang-ci.yml)
```yaml
name: golang

on:
  pull_request:
    types: [opened, reopened, synchronize]
  pull_request_target:
    types: [closed]

jobs:
  setup:
    uses: ./.github/workflows/call-golang-setup.yml
    with:
      workdir: "tests/golang/"

  lint:
    if: ${{ github.event.pull_request.merged != true }}
    needs: setup
    uses: ./.github/workflows/call-golang-lint.yml
    with:
      workdir: "tests/golang/"

  build:
    if: ${{ always() && needs.setup.result == 'success' }}
    needs: [setup, lint]
    uses: ./.github/workflows/call-golang-build.yml
    with:
      workdir: "tests/golang/"
      GOOS: linux
      GOARCH: amd64
      ENTRANCE: cmd/main.go

  containeraized:
    if: ${{ always() && github.event.pull_request.merged }}
    needs: build
    permissions:
      contents: read
      packages: write
    uses: ./.github/workflows/call-containerize.yml
    with:
      version: ${{ needs.build.outputs.version }}
      workdir: "tests/golang/"
      target: "tests/golang/build"
```

### node
[![node](https://github.com/heliannuuthus/integration-deploy/actions/workflows/node-ci.yaml/badge.svg)](https://github.com/heliannuuthus/integration-deploy/actions/workflows/node-ci.yaml)
```yaml
name: node

on:
  pull_request:
    types: [opened, reopened, synchronize]
  pull_request_target:
    types: [closed]
jobs:
  setup:
    uses: ./.github/workflows/call-node-setup.yml
    with:
      workdir: "tests/node/"

  lint:
    if: ${{ github.event.pull_request.merged != true }}
    needs: setup
    uses: ./.github/workflows/call-node-lint.yml
    with:
      workdir: "tests/node/"
      PNPM_STORE: ${{ needs.setup.outputs.PNPM_STORE }}

  build:
    if: ${{ always() && needs.setup.result == 'success' }}
    needs: [setup, lint]
    uses: ./.github/workflows/call-node-build.yml
    with:
      workdir: "tests/node/"
      PNPM_STORE: ${{ needs.setup.outputs.PNPM_STORE }}
```
