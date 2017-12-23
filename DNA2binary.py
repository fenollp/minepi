#!/usr/bin/env python3

import sys

if len(sys.argv) != 2 :
    fmt = 'Usage: {} <nucleotide txt file> >nucleotides.bin'
    print(fmt.format(sys.argv[0]), file=sys.stderr)
    sys.exit(1)

ALPHABET = "ATGC"
with open(sys.argv[1], 'r') as fd:
    with open(1, 'wb') as out:
        a = ALPHABET.index(fd.read(1).upper())
        while True:
            char = fd.read(1)
            if not char:
                break
            if char in "\n":
                continue
            b = ALPHABET.index(char.upper())
            out.write(bytes([ a *10+ b ]))
            a = b
