(use-modules (guix inferior) (guix channels) (srfi srfi-1))

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
            "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))

(define inferior
  ;; An inferior representing the above revision.
  (inferior-for-channels channels))

(define (inferior->package name)
  (first (lookup-inferior-packages inferior name)))

;; Now create a manifest with the old packages.
(packages->manifest
 (map inferior->package
      (list "lmdb" "libyaml" "libxml2" "mysql" "leveldb" "libsecp256k1" "bash")))
