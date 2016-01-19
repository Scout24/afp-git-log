#!/usr/bin/env python
import sys
results = {}
for line in sys.stdin.readlines():
    count, name = line.strip().split('\t')
    count = int(count)
    results[name] = count if name not in results else results[name] + count

for count,name in sorted([(count, name) for name, count in results.items()])[::-1]:
    print "%s\t%s" % (count,name)
