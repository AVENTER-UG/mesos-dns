module github.com/AVENTER-UG/mesos-dns

go 1.14

require (
	github.com/dgrijalva/jwt-go v2.7.0+incompatible
	github.com/emicklei/go-restful v1.1.3
	github.com/go-zookeeper/zk v1.0.2 // indirect
	github.com/gogo/protobuf v0.0.0-20150914153205-43ab7f0ec7b6 // indirect
	github.com/golang/glog v0.0.0-20150731225221-fca8c8854093
	github.com/kylelemons/godebug v0.0.0-20150519154555-21cb3784d9bd
	github.com/mesos/mesos-go v0.0.11
	github.com/miekg/dns v1.0.15
	github.com/stretchr/objx v0.0.0-20140526180921-cbeaeb16a013 // indirect
	github.com/stretchr/testify v0.0.0-20150914093255-b8dc1cecf15b // indirect
	github.com/tv42/zbase32 v0.0.0-20150911225513-03389da7e0bf
	golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550 // indirect
	golang.org/x/net v0.0.0-20210405180319-a5a99cb37ef4 // indirect
	golang.org/x/sync v0.0.0-20210220032951-036812b2e83c // indirect
	golang.org/x/sys v0.0.0-20210510120138-977fb7262007 // indirect
)

replace github.com/mesos/mesos-go => github.com/AVENTER-UG/mesos-go v0.0.12-0.20210805110736-f382f67087ed
