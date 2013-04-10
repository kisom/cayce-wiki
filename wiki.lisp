;;;; cayce-wiki is a Common Lisp implementation of my personal wiki
;;;; system

(in-package #:cayce-wiki)

(defun read-file-string (path)
  (with-open-file (stream path)
    (let ((data (make-string (file-length stream))))
      (read-sequence data stream)
      data)))

(defun read-file-binary (path)
  (with-open-file (stream path :element-type '(unsigned-byte 8))
    (let ((data (make-array (file-length stream) :element-type '(unsigned-byte 8))))
      (read-sequence data stream)
      data)))

(defun read-page-source (path)
  (read-file-string (pathname path)))
