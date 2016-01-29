.PHONY: all

all:
	./afp-git-log.sh -q | ./aggregate.py
