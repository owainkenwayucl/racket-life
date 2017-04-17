# Set compiler here.
RACO=raco
ROPTS=

life: src/life.rkt src/life-run.rkt src/periodic2d.rkt Makefile
	$(RACO) $(ROPTS) exe -o life src/life-run.rkt


clean:
	rm -f life compiled
