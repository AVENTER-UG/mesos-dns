# Mesos-DNS 

[![Chat](https://img.shields.io/static/v1?label=Chat&message=Support&color=brightgreen)](https://matrix.to/#/#mesosdns:matrix.aventer.biz?via=matrix.aventer.biz)
[![GoDoc](https://godoc.org/github.com/AVENTER-UG/mesos-dns?status.svg)](https://godoc.org/github.com/AVENTER-UG/mesos-dns) 

Mesos-DNS enables [DNS](https://en.wikipedia.org/wiki/Domain_Name_System)-based service discovery in [Apache Mesos](https://mesos.apache.org/) clusters.

![Architecture Diagram](https://aventer-ug.github.io/mesos-dns/img/architecture.png)

## Compatibility

`mesos-N` tags mark the start of support for a specific Mesos version while
maintaining backwards compatibility with the previous major version.

## Installing

The official release binaries are available at the [AVENTER UG RPM Server](http://rpm.aventer.biz/CentOS/7/x86_64/).

## Building

Building the **master** branch from source should always succeed but doesn't provide
the same stability and compatibility guarantees as releases.

You will need [Go](https://golang.org/) *1.6* or later to build the project.
All dependencies are tracked using `godep`.

```shell
# Install godep
$ go get github.com/tools/godep

# Save new dependencies
$ godep save ./...

# Build
$ go build ./...
```

### Building a release

1. Cut a branch.
2. Tag it with the relevant version, and push the tags along with the branch.

### Making a private build

1. Fork the repo on Github.
2. Customize that repo.
3. Go to the build steps.

## Testing

```shell
go test -race ./...
```

## Documentation

The detailed documentation on how to configure, operate and use Mesos-DNS
under different scenarios and environments is available at the project's [home page](https://aventer-ug.github.io/mesos-dns/).

## Contributing

Contributions are welcome. Please refer to [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Contact

For any discussion that isn't well suited for Github [issues](https://github.com/AVNETER-UG/mesos-dns/issues),
please use our public [chat room](https://matrix.to/#/#mesosdns:matrix.aventer.biz?via=matrix.aventer.biz)

## License

This project is licensed under [Apache License 2.0](LICENSE).
