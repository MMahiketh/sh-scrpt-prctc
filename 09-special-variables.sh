#!/bin/bash

echo "All arguments passed to script:	$@"
echo "No. of arguments passed:		$#"
echo "Name of this script:		$0"
echo "PID of this script:		$$"
sleep 100 &
echo "PID of last background process:	$!"
echo "Print present working directory:	$PWD"
echo "Home directory of current user:	$HOME"
echo "Result of last process:	$?"
