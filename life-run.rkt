#lang racket

; Implementation of Conway's Game of Life.
; Owain Kenway, 2017
; Distributed under the MIT license.

(require "life.rkt")
(require "periodic2d.rkt")

; Perform a run with output to console.
; Two args - input file and number of steps.
(define (run-console args)
  (define filename (vector-ref args 0))
  (define steps (string->number (vector-ref args 1)))
  (define inputdata (periodic2d-readpbm filename))
  (define p2d (list-ref inputdata 1))
  (define dimensions (list-ref inputdata 0))
  
  (life-run-console p2d dimensions steps)
  
  )

; Perform a run with output to a sequence of files
; Three args - input file, number of steps and prefix for output file.
(define (run-file args)
  (define filename (vector-ref args 0))
  (define steps (string->number (vector-ref args 1)))
  (define outname (vector-ref args 2))
  (define inputdata (periodic2d-readpbm filename))
  (define p2d (list-ref inputdata 1))
  (define dimensions (list-ref inputdata 0))
  
  (life-run-file p2d dimensions steps outname)
  
  )

; Our main.  Works out how many arguments the code has been run with and
; either prints usage (0, 1 args), runs console version (2 args) or
; runs the version that outputs to files (3 args).
(module* main #f
  (if (> (vector-length (current-command-line-arguments)) 1)
      (if (> (vector-length(current-command-line-arguments)) 2)
          (run-file (current-command-line-arguments))
          (run-console (current-command-line-arguments))
          )
      (display "\nUsage:\n  life-run input.pbm steps [output]\n\n")
      )
  
  )
