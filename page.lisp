;;; class and method definitions for the wiki pages

(in-package #:cayce-wiki)

(defclass wiki-page ()
  ((body     :initarg :body      :accessor get-body)
   (rendered :initarg :rendered  :reader get-rendered)
   (path     :initarg :path      :reader get-path))
  (:documentation "CLOS model of a wiki page."))

(defun load-page (path)
  (let ((page-file (merge-pathnames *pages-directory* (pathname path))))
    (when (probe-file page-file)
      (let* ((body (read-file-string page-file)))
        (multiple-value-bind (doc rendered) (markdown:markdown body :stream nil :format :html)
          (declare (ignore doc))
          (make-instance 'wiki-page :body body
                         :rendered rendered
                         :path (pathname path)))))))

(defun wiki-header ())
(defun wiki-sidebar ())

(defun index (page-body)
  (who:with-html-output-to-string (out nil :prologue t :indent t)
    (:html
     (:head
      (:meta :http-equiv "Content-Type"
             :content    "text/html;charset=utf8")
      (:title "cayce-wiki")
      (:link :href "/static/styles/reset.css"
             :rel "stylesheet"
             :type "text/css")
      (:link :href "/static/styles/noir.css"
             :rel "stylesheet"
             :type "text/css")
      (:link :href "/static/styles/gist.css"
             :rel "stylesheet"
             :type "text/css"))
     (:body
      (:div :id "wrapper"
            (:div :id "content"
                  (:div :id "header"
                        (wiki-header))
                  (:div :id "sidebar"
                        (wiki-sidebar))
                  (who:str page-body)))))))

(defmethod render ((p wiki-page))
  (index (get-rendered p)))
