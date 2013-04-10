;;;; package.lisp

(restas:define-module #:cayce-wiki
  (:use #:cl))


;;; let's use all five hatemails
(setf (who:html-mode) :HTML5)
