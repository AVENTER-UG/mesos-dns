module github.com/AVENTER-UG/mesos-dns

go 1.14

require (
	github.com/dgrijalva/jwt-go v3.2.0+incompatible
	github.com/emicklei/go-restful v2.15.0+incompatible
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/glog v1.0.0
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/kylelemons/godebug v0.0.0-20150519154555-21cb3784d9bd
	github.com/mesos/mesos-go v0.0.11
	github.com/miekg/dns v1.1.43
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/samuel/go-zookeeper v0.0.0-20201211165307-7117e9ea2414 // indirect
	github.com/tv42/zbase32 v0.0.0-20190604154422-aacc64a8f915
	golang.org/x/crypto v0.0.0-20210921155107-089bfa567519 // indirect
	golang.org/x/net v0.0.0-20211020060615-d418f374d309 // indirect
	golang.org/x/sync v0.0.0-20210220032951-036812b2e83c // indirect
	golang.org/x/sys v0.0.0-20211025201205-69cdffdb9359 // indirect
)

replace github.com/mesos/mesos-go => github.com/AVENTER-UG/mesos-go v0.0.11
