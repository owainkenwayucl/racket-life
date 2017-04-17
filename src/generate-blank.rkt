#lang racket

; Generate blank PBM images for editing.
; Owain Kenway, 2017
; Distributed under the MIT license.

(require "periodic2d.rkt")

; Blank image
(define (generate-blank w h file)
  (define p2d (build-list (* w h) (lambda (x) (* 0 x))))
  (periodic2d-writepbm file p2d (list w h))
  )

(module* main #f
  (if (> (vector-length (current-command-line-arguments)) 2)
      (generate-blank (string->number (vector-ref (current-command-line-arguments) 0))
                      (string->number (vector-ref (current-command-line-arguments) 1))
                      (vector-ref (current-command-line-arguments) 2))
      (display "\nUsage:\n  generate-blank width height filename\n\n")
      )
  
  
  )
