#!/bin/bash
HWNUM=2
EXERCISES=(1 2 3 4 5 6 7)
LIB_PATH="../lib/"
LIBSRC="testlib.ml"

if [[ $# -eq 0 ]]
then
    for EX in "${EXERCISES[@]}"; do
        SRCS+=("ex${EX}.ml")
        SRCS+=("test${EX}.ml")
    done
    echo "# Compiling Every Exercises"
    ocamlc -I "${LIB_PATH}" -o hw${HWNUM}.out ${LIB_PATH}${LIBSRC} "${SRCS[@]}" \
        && ./hw${HWNUM}.out total
elif [[ $# -eq 1 ]]
then
    VALID=0
    for EX in "${EXERCISES[@]}"; do
        if [[ $1 -eq ${EX} ]]
        then
            VALID=1
            break
        fi
    done
    if [[ ${VALID} -eq 1 ]]
    then
        EX=$1
        echo "# Compiling Exercise ${EX}"
        ocamlc -I "${LIB_PATH}" -o ex"${EX}".out ${LIB_PATH}${LIBSRC} ex"${EX}".ml test"${EX}".ml \
            && ./ex"${EX}".out
    else
        echo "Error: Exercise ${1} not found"
    fi
else
    echo "Error: Too many arguments"
fi
