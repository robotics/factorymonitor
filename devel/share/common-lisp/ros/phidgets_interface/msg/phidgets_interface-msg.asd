
(cl:in-package :asdf)

(defsystem "phidgets_interface-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Int16MultiArrayStamped" :depends-on ("_package_Int16MultiArrayStamped"))
    (:file "_package_Int16MultiArrayStamped" :depends-on ("_package"))
    (:file "Float32Stamped" :depends-on ("_package_Float32Stamped"))
    (:file "_package_Float32Stamped" :depends-on ("_package"))
  ))