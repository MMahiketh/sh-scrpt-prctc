#!/bin/bash

STUDENTS=("Suresh", "Ramesh", "Ram")

echo "First person name: ${STUDENTS[0]}"
echo "Second person name: ${STUDENTS[1]}"
echo "Third person name: ${STUDENTS[2]}"
echo "All person's names: ${STUDENTS[@]}"
