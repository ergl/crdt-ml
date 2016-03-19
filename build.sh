#!/bin/bash

[[ $# -ne 2 ]] && \
echo "Usage: ./${0##*/} entrypoint executable name" && \
exit 1

entrypoint="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
executable=$2

cd src/
ocamlopt -c util.ml
ocamlopt -c types.ml
ocamlopt -c crdt.ml

ocamlopt -o $executable util.cmx types.cmx crdt.cmx $entrypoint
mv $executable ../

rm *.cmx
rm *.cmi
rm *.o

cd ../
rm *.cmx
rm *.cmi
rm *.o
