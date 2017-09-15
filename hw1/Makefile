HWNUM = 1
NEXERCISE = 4

ifeq (,$(MAKECMDGOALS))
  EX :=
else
  ifeq (test, $(firstword $(MAKECMDGOALS)))
    EX := $(word 2,$(MAKECMDGOALS))
    $(eval $(EX):;@:)
  endif
endif

ifneq (,$(EX))
  CORRECT_EX := $(shell echo "$(EX)>=1 && $(EX)<=$(NEXERCISE)" | bc)
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
	@ocamlc -o tester.out testlib.ml $(SRCS) tester.ml
	@./tester.out
else
  ifeq (1, $(CORRECT_EX))
	@echo "# Compiling Exercise $(EX)"
	@ocamlc -o ex$(EX).out testlib.ml ex$(EX).ml test$(EX).ml
	@./ex$(EX).out
  else
	@echo "Exercise $(EX) not found."
  endif
endif
	@make clean

clean:
	@rm -f *.cmo *.cmi *.out
