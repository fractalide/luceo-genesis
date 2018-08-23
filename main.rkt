# !/usr/bin/env racket
#lang racket

(module+ main
  (define initial-discount 25)
  (define number-of-rounds 101)
  (define final-exchange-rate 1)
  (define precision 100000000)

  (command-line
    #:program "ceo"
    #:usage-help "Prints out the ADA exchange rate during the CEO ICO."
    #:once-each
    [("-i" "--initial-discount") i
     "The initial discount to the exchange rate, in percent"
     (set! initial-discount (string->number i))]
    [("-n" "--number-of-rounds") n
     "The number of rounds"
     (set! number-of-rounds (string->number n))]
    [("-x" "--exchange-rate") x
     "The undiscounted exchange rate"
     (set! final-exchange-rate (string->number x))]
    [("-p" "--precision") p
     ("The precision of the numbers given as the inverse of the smallest unit, that is, say 400 if you want 1/400th precision."
      "The output will be rounded to this precision, and the number of decimals shown will be within the order of magnitude required to render the precision.")
     (set! precision (string->number p))]
    #:args args (when (> (length args) 0) (raise-user-error (format "ceo: No <args> expected, ~a given." (length args)))))

  (printf "~a~n"
    (map (lambda (n) (cons n (real->decimal-string 
           (* (/ 1.0 precision) (round (* precision
                (* final-exchange-rate 0.01
                   (+ (- 100 initial-discount)
                      (* n 
                         (/ initial-discount (sub1 number-of-rounds))))))))
           (exact-round (log (* (sqrt (/ 1000.0 10001)) precision) 10)))))
      (range number-of-rounds))))
