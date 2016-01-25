.SILENT :
.PHONY : dockerize clean fmt

TAG:=`git describe --abbrev=0 --tags`
LDFLAGS:=-X main.buildVersion=$(TAG)

all: dockerize

dockerize:
	echo "Building dockerize"
	go install -ldflags "$(LDFLAGS)"

dist-clean:
	rm -rf dist
	rm -f dockerize-linux-*.tar.gz

dist: dist-clean
	mkdir -p dist/linux/amd64 && GOOS=linux GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o dist/linux/amd64/dockerize
	mkdir -p dist/linux/386 && GOOS=linux GOARCH=386 go build -ldflags "$(LDFLAGS)" -o dist/linux/386/dockerize
	mkdir -p dist/freebsd/amd64 && GOOS=freebsd GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o dist/freebsd/amd64/dockerize
	mkdir -p dist/freebsd/386 && GOOS=freebsd GOARCH=386 go build -ldflags "$(LDFLAGS)" -o dist/freebsd/386/dockerize
	mkdir -p dist/openbsd/amd64 && GOOS=openbsd GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o dist/openbsd/amd64/dockerize
	mkdir -p dist/openbsd/386 && GOOS=openbsd GOARCH=386 go build -ldflags "$(LDFLAGS)" -o dist/openbsd/386/dockerize
	mkdir -p dist/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -ldflags "$(LDFLAGS)" -o dist/darwin/amd64/dockerize
	mkdir -p dist/darwin/386 && GOOS=darwin GOARCH=386 go build -ldflags "$(LDFLAGS)" -o dist/darwin/386/dockerize
	mkdir -p dist/linux/armhf && GOOS=linux GOARCH=arm GOARM=6 go build -ldflags "$(LDFLAGS)" -o dist/linux/armhf/dockerize
	mkdir -p dist/linux/armel && GOOS=linux GOARCH=arm GOARM=5 go build -ldflags "$(LDFLAGS)" -o dist/linux/armel/dockerize

release: dist
	tar -cvzf dist/dockerize-linux-amd64-$(TAG).tar.gz -C dist/linux/amd64 dockerize
	tar -cvzf dist/dockerize-linux-386-$(TAG).tar.gz -C dist/linux/386 dockerize
	tar -cvzf dist/dockerize-linux-armel-$(TAG).tar.gz -C dist/linux/armel dockerize
	tar -cvzf dist/dockerize-linux-armhf-$(TAG).tar.gz -C dist/linux/armhf dockerize
	tar -cvzf dist/dockerize-freebsd-amd64-$(TAG).tar.gz -C dist/freebsd/amd64 dockerize
	tar -cvzf dist/dockerize-freebsd-386-$(TAG).tar.gz -C dist/freebsd/386 dockerize
	tar -cvzf dist/dockerize-openbsd-amd64-$(TAG).tar.gz -C dist/openbsd/amd64 dockerize
	tar -cvzf dist/dockerize-openbsd-386-$(TAG).tar.gz -C dist/openbsd/386 dockerize
	tar -cvzf dist/dockerize-darwin-amd64-$(TAG).tar.gz -C dist/darwin/amd64 dockerize
	tar -cvzf dist/dockerize-darwin-386-$(TAG).tar.gz -C dist/darwin/386 dockerize
