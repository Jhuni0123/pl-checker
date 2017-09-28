SHELL=/bin/bash

ifeq (test,$(firstword $(MAKECMDGOALS)))
  ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(ARGS):;@:)
endif

.PHONY: test clean update

all:
	@./check.sh

test:
	@./check.sh ${ARGS}

update:
	git pull origin master

clean:
	@rm -f *.cmo *.cmi *.out *.o *.cmx
