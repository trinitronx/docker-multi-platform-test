<!-- markdownlint-configure-file
{
  "required-headings": {
    "headings": [
      "# Docker Multi-Platform Build Test Repo",
      "*",
      "## Building",
      "*",
      "### Alternate Ways to Use `buildx`"
      "*"
    ]
  }
}
-->

# Docker Multi-Platform Build Test Repo

This repo is a simple demo to test Docker multi-platform container builds.

## Help

Run the `help` GNU `make` target to display all the main targets with help.

    make help

## Building

The `Makefile` has a default rule to build for all [`docker/binfmt`][1]
and [`tonistiigi/binfmt`][2] supported platforms:

- amd64
- arm64
- ppc64le
- riscv64
- s390x
- 386
- arm/v7
- arm/v6

To build single-platform containers for all target platforms:

    make

### Alternate Ways to Use `buildx`

Other GNU `make` targets are provided to demonstrate other ways to use `buildx`:

- Build multi-platform containers with buildx manifest list

        make buildx

- Build multi-platform with `buildx bake --file docker-compose.buildx.yml`

        make bake

## Check Platforms

The `check` target runs all the single-platform containers to display `uname -m`
output:

    make check

[1]: https://github.com/docker/binfmt
[2]: https://github.com/tonistiigi/binfmt
