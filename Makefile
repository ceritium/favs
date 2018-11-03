CRYSTAL_BIN ?= $(shell which crystal)
SHARDS_BIN ?= $(shell which shards)
FAVS_BIN ?= $(shell which favs)
PREFIX ?= /usr/local

build:
	$(SHARDS_BIN) build --release $(CRFLAGS)
clean:
	rm -f ./bin/favs ./bin/favs.dwarf
test: build
	$(CRYSTAL_BIN) spec
install: build
	mkdir -p $(PREFIX)/bin
	cp ./bin/favs $(PREFIX)/bin
reinstall: build
	cp ./bin/favs $(FAVS_BIN) -rf
