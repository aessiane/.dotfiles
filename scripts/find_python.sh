#!/bin/sh

# Script used by Conjure (nvim) to find the right interpreter for Python code

(poetry check -q && poetry run python3 -iq) || python3 -iq
