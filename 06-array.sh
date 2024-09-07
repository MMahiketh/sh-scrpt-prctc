#!/bin/bash

read -p "Enter student's name:	" -a STUDENTS

echo "First student name: ${STUDENTS[0]}"
echo "Second student name: ${STUDENTS[1]}"
echo "Third student name: ${STUDENTS[2]}"
echo "All student's names: ${STUDENTS[@]}"
