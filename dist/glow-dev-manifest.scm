(use-modules (guix inferior) (guix channels)
             (srfi srfi-1))   ;for 'first'

(define channels
  ;; This is the old revisions from which we want to
  ;; extract glow and friends.
  (list
     (channel
       (name 'guix)
       (url "https://git.savannah.gnu.org/git/guix.git")
       (commit
         "9d32e6cdad050b8c12cfda753cf4bb21910416dc")
       (introduction
         (make-channel-introduction
           "9edb3f66fd807b096b48283debdcddccfea34bad"
           (openpgp-fingerprint
             "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
     (channel
       (name 'druix)
       (url "https://github.com/drewc/druix.git")
       (commit
         "c5aa26ea91b3caea4aac03899d4d7731e0b6d2a9"))))

(define inferior
  ;; An inferior representing the above revision.
  (inferior-for-channels channels))

(define (inferior->package name)
  (first (lookup-inferior-packages inferior name)))

;; Now create a manifest with the old packages.
(packages->manifest
 (map inferior->package
      (list "gambit-c-unstable"
            "go-ethereum"
            "gerbil-ethereum"
            "glow-lang"
            "glow")))
