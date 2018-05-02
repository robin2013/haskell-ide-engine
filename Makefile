BASEDIR=$(CURDIR)

build:
	stack --stack-yaml=stack-8.0.2.yaml install                  \
		&& cp ~/.local/bin/hie ~/.local/bin/hie-8.0.2            \
		&& cp ~/.local/bin/hie ~/.local/bin/hie-8.0              \
	&& stack --stack-yaml=stack-8.2.1.yaml install               \
		&& cp ~/.local/bin/hie ~/.local/bin/hie-8.2.1            \
		&& cp ~/.local/bin/hie-8.2.1 ~/.local/bin/hie-8.2        \
	&& stack --stack-yaml=stack.yaml install                     \
		&& cp ~/.local/bin/hie ~/.local/bin/hie-8.2.2            \
		&& cp ~/.local/bin/hie-8.2.2 ~/.local/bin/hie-8.2
.PHONY: build

build-docs:
	stack --stack-yaml=stack-8.0.2.yaml exec hoogle generate    \
	&& stack --stack-yaml=stack-8.2.1.yaml exec hoogle generate \
	&& stack --stack-yaml=stack.yaml exec hoogle generate
.PHONY: build-docs

build-all: | build build-docs
.PHONY: build-all

hie-8.2.2:
	stack --stack-yaml=stack.yaml install                  \
		&& cp ~/.local/bin/hie ~/.local/bin/hie-8.2.2      \
		&& cp ~/.local/bin/hie-8.2.2 ~/.local/bin/hie-8.2
.PHONY: hie-8.2.2

test:
	stack --stack-yaml=stack-8.0.2.yaml test    \
	&& stack --stack-yaml=stack-8.2.1.yaml test \
	&& stack --stack-yaml=stack.yaml test
.PHONY: test

build-copy-compiler-tool:
	stack --stack-yaml=stack-8.0.2.yaml build --copy-compiler-tool    \
	&& stack --stack-yaml=stack-8.2.1.yaml build --copy-compiler-tool \
	&& stack --stack-yaml=stack.yaml build --copy-compiler-tool
.PHONY: build-copy-compiler-tool

icu-macos-fix:
	brew install icu4c                                     \
	&& stack --stack-yaml=stack-8.0.2.yaml build text-icu  \
         --extra-lib-dirs=/usr/local/opt/icu4c/lib         \
         --extra-include-dirs=/usr/local/opt/icu4c/include \
	&& stack --stack-yaml=stack-8.2.1.yaml build text-icu  \
         --extra-lib-dirs=/usr/local/opt/icu4c/lib         \
         --extra-include-dirs=/usr/local/opt/icu4c/include \
	&& stack --stack-yaml=stack.yaml build text-icu        \
         --extra-lib-dirs=/usr/local/opt/icu4c/lib         \
         --extra-include-dirs=/usr/local/opt/icu4c/include
.PHONY: icu-macos-fix

