SHELL=/bin/bash

ifeq (test,$(firstword $(MAKECMDGOALS)))
  ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(ARGS):;@:)
endif

.PHONY: test clean

all:
	@./check.sh

test:
	@./check.sh ${ARGS}

clean:
	@rm -f *.cmo *.cmi *.out *.o *.cmx
