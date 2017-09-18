SHELL := /bin/bash
HWNUM = 2
NEXERCISE = 7

ifeq (,$(MAKECMDGOALS))
  EX :=
else
  ifeq (test, $(firstword $(MAKECMDGOALS)))
  EX := $(word 2,$(MAKECMDGOALS))
  $(eval $(EX):;@:)
  endif
endif

ifneq (,$(EX))
  CORRECT_EX := $(shell echo "$$(($(EX)>=1 && $(EX)<=$(NEXERCISE)))")
endif

SRCS=$(shell srcs=""; num=1 ; while [[ $$num -le $(NEXERCISE) ]] ; do \
	srcs=$$srcs\ ex$$num.ml\ test$$num.ml;((num = num + 1)); \
	done; \
	echo $$srcs)

.PHONY: test clean

all: test

test:
ifeq (, $(EX))
	@echo "# Compiling Every Exercises"
	@ocamlc -I ../lib/ -o hw$(HWNUM).out ../lib/testlib.ml $(SRCS)
	@./hw$(HWNUM).out total
else
  ifeq (1, $(CORRECT_EX))
	@echo "# Compiling Exercise $(EX)"
	@ocamlc -I ../lib/ -o ex$(EX).out ../lib/testlib.ml ex$(EX).ml test$(EX).ml
	@./ex$(EX).out
  else
	@echo "Exercise $(EX) not found."
  endif
endif

clean:
	@rm -f *.cmo *.cmi *.out *.o *.cmx
