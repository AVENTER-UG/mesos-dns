module github.com/AVENTER-UG/mesos-dns

go 1.21

require (
	github.com/emicklei/go-restful v2.16.0+incompatible
	github.com/golang-jwt/jwt v3.2.2+incompatible
	github.com/golang/glog v1.2.2
	github.com/kylelemons/godebug v0.0.0-20150519154555-21cb3784d9bd
	github.com/mesos/mesos-go v0.0.11
	github.com/miekg/dns v1.1.61
	github.com/tv42/zbase32 v0.0.0-20220222190657-f76a9fc892fa
)

require (
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/samuel/go-zookeeper v0.0.0-20201211165307-7117e9ea2414 // indirect
	golang.org/x/mod v0.20.0 // indirect
	golang.org/x/net v0.28.0 // indirect
	golang.org/x/sync v0.8.0 // indirect
	golang.org/x/sys v0.24.0 // indirect
	golang.org/x/tools v0.24.0 // indirect
	golang.org/x/xerrors v0.0.0-20220609144429-65e65417b02f // indirect
)

replace github.com/mesos/mesos-go => github.com/AVENTER-UG/mesos-go v0.0.11
