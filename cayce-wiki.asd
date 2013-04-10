;;;; cayce-wiki.asd

(defpackage #:cayce-wiki-config (:export #:*base-directory*))
(defparameter cayce-wiki-config:*base-directory*
  (make-pathname :name nil :type nil :defaults *load-truename*))

(asdf:defsystem #:cayce-wiki
  :serial t
  :description "A personal markdown-based wiki system."
  :author "Kyle Isom <coder@kyleisom.net>"
  :license "ISC license"
  :depends-on (#:cl-who
               #:cl-markdown
               #:restas)
  :components ((:file "package")
               (:file "cayce-wiki")
               (:file "wiki")
               (:file "page")))
