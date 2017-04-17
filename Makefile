# Set compiler here.
RACO=raco
ROPTS=

all: life generate-blank

life: src/life.rkt src/life-run.rkt src/periodic2d.rkt Makefile
	$(RACO) $(ROPTS) exe -o life src/life-run.rkt

generate-blank: src/generate-blank.rkt src/periodic2d.rkt Makefile
	$(RACO) $(ROPTS) exe -o generate-blank src/generate-blank.rkt

clean:
	rm -f life generate-blank compiled
