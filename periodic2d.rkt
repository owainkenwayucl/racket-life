#lang racket

; This module contains tools to manipulate lists like 2D periodic arrays.
; Owain Kenway, 2017
; Distributed under the MIT license.

(provide periodic2d-create)
(provide periodic2d-print)
(provide periodic2d-set)
(provide periodic2d-get)
(provide periodic2d-getrow)
(provide periodic2d-9wsum)
(provide periodic2d-readpbm)
(provide periodic2d-writepbm)

; Create a list for dimensions (x,y).
(define (periodic2d-create dimensions)
  (define k (list))
  (define x (list-ref dimensions 0))
  (define y (list-ref dimensions 1))
  (do ((i 1 (+ i 1 ))) ((> i (* x y)))
    (set! k (append k (list 0)))
    )
  k
  )

; Print a list with dimensions (x,y).
(define (periodic2d-print p2d dimensions)
  (define x (list-ref dimensions 0))
  (define y (list-ref dimensions 1))  
  (define n 0)
  (do ((i 1 (+ i 1 ))) ((> i y))
    (do ((j 1 (+ j 1 ))) ((> j x))
      (display (list-ref p2d n))
      (display " ")
      (set! n (+ n 1))
      )
    (display "\n")
    )
  )

; Set value at (x,y)
(define (periodic2d-set p2d dimensions position value)
  (define w (list-ref dimensions 0))
  (define h (list-ref dimensions 1))  
  (define x (modulo (list-ref position 0) w))
  (define y (modulo (list-ref position 1) h))
  
  (define n (+ (* y w) x))
  
  (define k (list-set p2d n value))
  k
  )

; Get value at (x,y)
(define (periodic2d-get p2d dimensions position)
  (define w (list-ref dimensions 0))
  (define h (list-ref dimensions 1))  
  (define x (modulo (list-ref position 0) w))
  (define y (modulo (list-ref position 1) h))
  
  (define n (+ (* y w) x))
  
  (define k (list-ref p2d n))
  k
  )

; Get row at y
(define (periodic2d-getrow p2d dimensions line)
  (define w (list-ref dimensions 0))
  (define h (list-ref dimensions 1))
  (define ln (modulo line h))
  
  (define n (* ln w))
  
  (define k (list))
  (do ((i n (+ i 1 ))) ((> i (- (+ n w) 1)))
    (set! k (append k (list (list-ref p2d i))))
    )
  k
  )

; Get 9-way sum.
; For cell c:
;
; nw  n  ne
; w   c   e
; sw  s  se
;
; = c + nw + n + ne + w + e + sw + s + se
(define (periodic2d-9wsum p2d dimensions cell)
  (define w (list-ref dimensions 0))
  (define h (list-ref dimensions 1))  
  (define x (modulo (list-ref cell 0) w))
  (define y (modulo (list-ref cell 1) h))
  (define sum9 0)
  
  (define loc (list (- x 1) (- y 1))) 
  (define nw (periodic2d-get p2d dimensions loc))
  
  (set! loc (list x (- y 1))) 
  (define n (periodic2d-get p2d dimensions loc))
  
  (set! loc (list (+ x 1) (- y 1))) 
  (define ne (periodic2d-get p2d dimensions loc))
  
  (set! loc (list (- x 1) y)) 
  (define we (periodic2d-get p2d dimensions loc))
  
  (set! loc (list (+ x 1) y)) 
  (define e (periodic2d-get p2d dimensions loc))
  
  (set! loc (list (- x 1) (+ y 1)))
  (define sw (periodic2d-get p2d dimensions loc))
  
  (set! loc (list x (+ y 1))) 
  (define s (periodic2d-get p2d dimensions loc))
  
  (set! loc (list (+ x 1) (+ y 1)))
  (define se (periodic2d-get p2d dimensions loc))
  
  (define c (periodic2d-get p2d dimensions cell))
  
  (set! sum9 (+ nw n ne we e sw s se c))
  sum9
  
  )

; Remove comments and trim white-space.
(define (remove-comments str)
  (define ret (if (string-contains? str "#")
                  (if (string-prefix? str "#")
                      ""
                      (list-ref (string-split str "#") 0))
                  str))
  (string-trim ret)
  )

; Get next line ignoring empty lines and white-space.
(define (get-next-line in)
  (define line (remove-comments (read-line in)))
  (define ret (if (non-empty-string? line)
                  line
                  (get-next-line in)))
  ret
  )

; Read PBM.
(define (periodic2d-readpbm filename)
  (define dimensions (list))
  (define p2d (list))
  
  (define in (open-input-file filename))
  (define header (get-next-line in))
  (define indim (get-next-line in))
  (display "Reading pbm:\n\n")
  (display header)
  (newline)
  (define strdim (string-split indim))
  (set! dimensions (list (string->number (list-ref strdim 0)) (string->number (list-ref strdim 1))))
  (display dimensions)
  (newline)
  (define length (*(list-ref dimensions 0) (list-ref dimensions 1)))
  (do ((i 1 (+ i 1 ))) ((> i length))
    (set! p2d (append p2d (list (read in))))
    
    )
  (periodic2d-print p2d dimensions)
  (newline)
  (close-input-port in)
  (display "Done.\n")
  (list dimensions p2d)
  )

; Write PBM.
(define (periodic2d-writepbm filename p2d dimensions)
  (define w (list-ref dimensions 0))
  (define h (list-ref dimensions 1))
  (display (string-append "Writing PBM: " filename))
  (define out (open-output-file filename))
  
  ; Write header.
  (display "P1\n" out)
  (display "# Written by periodic2d.rkt\n" out)
  (display w out)
  (display " " out)
  (display h out)
  (display "\n" out)
  
  (define n 0)
  (do ((i 1 (+ i 1 ))) ((> i h))
    (do ((j 1 (+ j 1 ))) ((> j w))
      (display (list-ref p2d n) out)
      (display " " out)
      (set! n (+ n 1))
      )
    (display "\n" out)
    ) 
  (display " Done.\n")
  (close-output-port out)
  )
