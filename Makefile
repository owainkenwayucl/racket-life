# Set compiler here.
RACO=raco
ROPTS=

all: life generate-blank generate-random

life: src/life.rkt src/life-run.rkt src/periodic2d.rkt Makefile
	$(RACO) $(ROPTS) exe -o life src/life-run.rkt

generate-blank: src/generate-blank.rkt src/periodic2d.rkt Makefile
	$(RACO) $(ROPTS) exe -o generate-blank src/generate-blank.rkt

generate-random: src/generate-random.rkt src/periodic2d.rkt Makefile
	$(RACO) $(ROPTS) exe -o generate-random src/generate-random.rkt

clean:
	rm -Rf life generate-blank generate-random compiled src/compiled
