<!-- markdownlint-configure-file
{
  "required-headings": {
    "headings": [
      "# Docker Multi-Platform Build Test Repo",
      "*",
      "## Building",
      "*"
    ]
  }
}
-->

# Docker Multi-Platform Build Test Repo

This repo is a simple demo to test Docker multi-platform container builds.

## Building

The `Makefile` has a default rule to build for all [`docker/binfmt`][1]
supported platforms:

- amd64
- arm64
- ppc64le
- riscv64

To build containers for all target platforms:

    make

[1]: https://github.com/docker/binfmt
