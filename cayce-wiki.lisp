;;;; cayce-wiki.lisp

(in-package #:cayce-wiki)

;;; "cayce-wiki" goes here. Hacks and glory await!
(defparameter *template-directory*
    (merge-pathnames #P"templates/" cayce-wiki-config:*base-directory*))

(defparameter *static-directory*
  (merge-pathnames #P"static/" cayce-wiki-config:*base-directory*))

(defparameter *stylesheets-directory*
  (merge-pathnames #P"styles/" *static-directory*))

(defparameter *images-directory*
  (merge-pathnames #P"img/" *static-directory*))

(defparameter *pages-directory*
  (merge-pathnames #P"pages/" cayce-wiki-config:*base-directory*))

(restas:define-route stylesheets ("/static/styles/:stylesheet" :method :get :content-type "text/css")
  (read-file-string (merge-pathnames stylesheet *stylesheets-directory*)))

(restas:define-route images ("/static/img/:image" :method :get :content-type "image/png")
  (read-file-binary (merge-pathnames image *images-directory*)))

(restas:define-route root ("/" :method :get) :content-type "text/html"
  (let ((page (load-page "index.md")))
    (render page)))
