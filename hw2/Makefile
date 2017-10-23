SHELL=/bin/bash

ifeq (test,$(firstword $(MAKECMDGOALS)))
  ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(ARGS):;@:)
endif

.PHONY: test clean update

all:
	@./check

test:
	@./check ${ARGS}

update:
	git pull --rebase origin master

clean:
	@rm -f *.cmo *.cmi *.out *.o *.cmx ../lib/*.cmo ../lib/*.cmi
