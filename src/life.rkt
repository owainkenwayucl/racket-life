#lang racket

; Implementation of Conway's Game of Life.
; Owain Kenway, 2017
; Distributed under the MIT license.

(require "periodic2d.rkt")

(provide life-run-console)
(provide life-run-file)


; Print an lower edge.
(define (loweredge n)
  (display (string-append "╰" (make-string (- n 2) #\─) "╯\n"))
  )

; Print an upper edge.
(define (upperedge n)
  (display (string-append "╭" (make-string (- n 2) #\─) "╮\n"))
  )


; Print a line (l).
(define (lineout l)
  (define ln (length l))
  (display "│")
  (do ((i 1 (+ i 1 ))) ((> i ln))    
    (display (if (> (list-ref l (- i 1)) 0)
                 #\o
                 #\.  
                 ))
    )
  (display "│\n")
  )

; Update state.
(define (update orig dimensions)
  (define new (list))
  (define w (list-ref dimensions 0))
  (define h (list-ref dimensions 1))
  
  (define state 0)
  (define oldstate 0)
  (define 9wsum 0)
  
  (do ((j 0 (+ j 1 ))) ((= j h))
    (do ((i 0 (+ i 1 ))) ((= i w))
      (set! oldstate (periodic2d-get orig dimensions (list i j)))
      (set! 9wsum (periodic2d-9wsum orig dimensions (list i j)))
      (set! state (calcstate oldstate 9wsum))
      (set! new (append new (list state)))
      )
    )
  
  new
  )

; Calculate the state of a cell based on its 9-way sum.
(define (calcstate oldstate 9wsum)
  (define state 0)
  (set! state (if (= 9wsum 3) 1 state))
  (set! state (if (= 9wsum 4) oldstate state))
  state
  )

; Draw state.
(define (consoledraw status dimensions)
  (define w (list-ref dimensions 0))
  (define h (list-ref dimensions 1))
  (upperedge (+ w 2)) 
  (do ((i 1 (+ i 1 ))) ((> i h))
    (lineout (periodic2d-getrow status dimensions (- i 1)))
    )  
  (loweredge (+ w 2))
  )

(define (print-pop p2d)
  (define population (apply + p2d))
  (display "Population: ")
  (display population)
  (display "\n")
  )

; Run a specific periodic2d list for n steps and print to console.
(define (run-console start dimensions n)
  
  (consoledraw start dimensions)
  (print-pop start)
  (define state start)
  (do ((i 1 (+ i 1))) ((> i n))
    (newline)
    (display i)
    (display ":\n")
    (set! state (update state dimensions))
    (consoledraw state dimensions)
    (print-pop state)
    )
  
  )

; Create output file name.
(define (outfilename start num max)
  
  ; pad appropriately.
  (define n (number->string num))
  (define ln (string-length n))
  (define diff (- max ln))
  (define pad (make-string diff #\0))
  (set! n (string-append pad n))
  
  (define ret (string-append start n))
  (set! ret (string-append ret ".pbm"))
  ret
  )

; Run a specific periodic2d list for n steps and print to console.
(define (run-file start dimensions n filename)
  (define max (string-length (number->string n)))
  (define outfile (outfilename filename 0 max))
  (display "Step: 0  ")
  (print-pop start)
  (periodic2d-writepbm outfile start dimensions)
  
  (define state start)
  (do ((i 1 (+ i 1))) ((> i n))
    (set! outfile (outfilename filename i max))
    (set! state (update state dimensions))
    (display (string-append "Step: " (number->string i)))
    (display "  ")
    (print-pop state)
    (periodic2d-writepbm outfile state dimensions)
    )
  
  )

; Wrappers for export.
(define (life-run-console start dimensions n)
  (run-console start dimensions n)
  )

(define (life-run-file start dimensions n filename)
  (run-file start dimensions n filename)
  )