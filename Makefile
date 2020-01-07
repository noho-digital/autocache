# Setup name variables for the package/tool
PREFIX?=$(shell pwd)

NAME := autocache
PKG := github.com/pomerium/$(NAME)

BUILDDIR := ${PREFIX}/dist
BINDIR := ${PREFIX}/bin
GO111MODULE=on
CGO_ENABLED := 0
# Set any default go build tags
BUILDTAGS :=
GOLANGCI_VERSION = v1.21.0 # .... for some reason v1.18.0 misses?

.PHONY: all
all: build-deps test lint build ## Runs a clean, build, fmt, lint, test, and vet.


.PHONY: build-deps
build-deps: ## Install build dependencies
	@echo "==> $@"
	@cd /tmp; GO111MODULE=on go get github.com/golangci/golangci-lint/cmd/golangci-lint@${GOLANGCI_VERSION}


.PHONY: build
build: ## Builds dynamic executables and/or packages.
	@echo "==> $@"
	@CGO_ENABLED=0 GO111MODULE=on go build -tags "$(BUILDTAGS)" ${GO_LDFLAGS} -o $(BINDIR)/$(NAME) ./cmd/"$(NAME)"


.PHONY: test
test: ## Runs the go tests
	@echo "==> $@"
	@go test -tags "$(BUILDTAGS)" $(shell go list ./... | grep -v vendor)


.PHONY: lint
lint: ## Verifies `golint` passes.
	@echo "==> $@"
	@golangci-lint run ./...


.PHONY: cover
cover: ## Runs go test with coverage
	@echo "" > coverage.txt
	@for d in $(shell go list ./... | grep -v vendor); do \
		go test -race -coverprofile=profile.out -covermode=atomic "$$d"; \
		if [ -f profile.out ]; then \
			cat profile.out >> coverage.txt; \
			rm profile.out; \
		fi; \
	done;

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'