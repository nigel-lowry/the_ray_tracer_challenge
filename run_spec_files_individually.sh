#!/bin/sh
set -e

(for f in `find spec -iname '*_spec.rb'`; do
  echo "$f:"
  rspec $f -fp || exit 1
done)