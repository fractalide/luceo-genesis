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
     (set! number-of-rounds n)]
    [("-x" "--exchange-rate") x
     "The undiscounted exchange rate"
     (set! final-exchange-rate x)]
    [("-p" "--precision") p
     "The precision of the numbers given as the inverse of the smallest unit"
     (set! precision p)]
    #:args args (printf "args whaat ~a~n" args))

  (printf "~a~n"
    (map (lambda (n) (cons n (real->decimal-string 
           (* (/ 1.0 precision) (round (* precision
                (* final-exchange-rate 0.01
                   (+ (- 100 initial-discount)
                      (* n 
                         (/ initial-discount (sub1 number-of-rounds))))))))
           (exact-round (log precision 10)))))
      (range number-of-rounds))))
