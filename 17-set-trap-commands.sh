#!/bin/bash

set -e

failure(){

	echo "Failed at line:$1 and command is $2 with exit code $? ."
}

trap 'failure "$LINENO" "$BASH_COMMAND"' ERR

echo "hello from script."

lss -halt

ls -halt
