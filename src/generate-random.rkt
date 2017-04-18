#lang racket

; Generate random PBM images for editing.
; Owain Kenway, 2017
; Distributed under the MIT license.

(require "periodic2d.rkt")

; Blank image
(define (generate-random w h fraction file)
  (define p2d (list))
  (define new 0)
  (do ((i 1 (+ i 1))) ((> i (* w h)))
    (set! new (if (< (random) fraction)
                  1
                  0))
    (set! p2d (append p2d (list new)))
    )
  (periodic2d-writepbm file p2d (list w h))
  )

(module* main #f
  (define usage "\nUsage:\n  generate-random width height fraction filename\n\n")
  (set! usage (string-append usage "  (Note: fraction is approximate)\n\n"))
  (if (> (vector-length (current-command-line-arguments)) 3)
      (generate-random (string->number (vector-ref (current-command-line-arguments) 0))
                       (string->number (vector-ref (current-command-line-arguments) 1))
                       (string->number (vector-ref (current-command-line-arguments) 2))
                       (vector-ref (current-command-line-arguments) 3))
      (display usage)
      )
  )
