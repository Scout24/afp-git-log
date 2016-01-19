#!/usr/bin/env python
import sys
results = {}
for line in sys.stdin.readlines():
    line = line.strip()
    splitted = line.split('\t')
    count, name = splitted
    count = int(count)
    if name not in results:
        results[name] = count
    else:
        results[name] = results[name] + count

for count,name in sorted([(count, name) for name, count in results.items()])[::-1]:
    print "%s\t%s" % (count,name)
