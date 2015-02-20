
(cl:in-package :asdf)

(defsystem "phidgets_interface-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "SetOutputState" :depends-on ("_package_SetOutputState"))
    (:file "_package_SetOutputState" :depends-on ("_package"))
  ))