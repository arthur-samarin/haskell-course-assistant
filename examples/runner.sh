#!/usr/bin/env bash
cd ${0%/*}

EXAMPLES_PATH=$(realpath .)
PROJECT_PATH=$(realpath ..)
OUTPUT_PATH=$(realpath out)
OUTPUT_PATH_0="$OUTPUT_PATH/theorymin"
OUTPUT_PATH_1="$OUTPUT_PATH/control1"
OUTPUT_PATH_2="$OUTPUT_PATH/control2"

rm -rf "$OUTPUT_PATH_0"
rm -rf "$OUTPUT_PATH_1"
rm -rf "$OUTPUT_PATH_2"
mkdir -p "$OUTPUT_PATH_0"
mkdir -p "$OUTPUT_PATH_1"
mkdir -p "$OUTPUT_PATH_2"

cd "$PROJECT_PATH"

stack exec assistant -- 0 "$EXAMPLES_PATH/students.txt" "$EXAMPLES_PATH/tasks01.txt" "$OUTPUT_PATH_0"
stack exec assistant -- 1 "$EXAMPLES_PATH/students.txt" "$EXAMPLES_PATH/tasks01.txt" "$OUTPUT_PATH_1"
stack exec assistant -- 2 "$EXAMPLES_PATH/students.txt" "$EXAMPLES_PATH/tasks2.txt" "$OUTPUT_PATH_2"
