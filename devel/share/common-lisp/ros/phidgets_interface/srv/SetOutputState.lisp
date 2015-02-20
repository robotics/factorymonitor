; Auto-generated. Do not edit!


(cl:in-package phidgets_interface-srv)


;//! \htmlinclude SetOutputState-request.msg.html

(cl:defclass <SetOutputState-request> (roslisp-msg-protocol:ros-message)
  ((Index
    :reader Index
    :initarg :Index
    :type cl:fixnum
    :initform 0)
   (State
    :reader State
    :initarg :State
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SetOutputState-request (<SetOutputState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetOutputState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetOutputState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name phidgets_interface-srv:<SetOutputState-request> is deprecated: use phidgets_interface-srv:SetOutputState-request instead.")))

(cl:ensure-generic-function 'Index-val :lambda-list '(m))
(cl:defmethod Index-val ((m <SetOutputState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets_interface-srv:Index-val is deprecated.  Use phidgets_interface-srv:Index instead.")
  (Index m))

(cl:ensure-generic-function 'State-val :lambda-list '(m))
(cl:defmethod State-val ((m <SetOutputState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets_interface-srv:State-val is deprecated.  Use phidgets_interface-srv:State instead.")
  (State m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetOutputState-request>) ostream)
  "Serializes a message object of type '<SetOutputState-request>"
  (cl:let* ((signed (cl:slot-value msg 'Index)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'State)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetOutputState-request>) istream)
  "Deserializes a message object of type '<SetOutputState-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'Index) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'State) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetOutputState-request>)))
  "Returns string type for a service object of type '<SetOutputState-request>"
  "phidgets_interface/SetOutputStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetOutputState-request)))
  "Returns string type for a service object of type 'SetOutputState-request"
  "phidgets_interface/SetOutputStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetOutputState-request>)))
  "Returns md5sum for a message object of type '<SetOutputState-request>"
  "fbfa7b3e79c838fbceaa8082ba51df74")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetOutputState-request)))
  "Returns md5sum for a message object of type 'SetOutputState-request"
  "fbfa7b3e79c838fbceaa8082ba51df74")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetOutputState-request>)))
  "Returns full string definition for message of type '<SetOutputState-request>"
  (cl:format cl:nil "int16 Index~%int16 State~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetOutputState-request)))
  "Returns full string definition for message of type 'SetOutputState-request"
  (cl:format cl:nil "int16 Index~%int16 State~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetOutputState-request>))
  (cl:+ 0
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetOutputState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetOutputState-request
    (cl:cons ':Index (Index msg))
    (cl:cons ':State (State msg))
))
;//! \htmlinclude SetOutputState-response.msg.html

(cl:defclass <SetOutputState-response> (roslisp-msg-protocol:ros-message)
  ((ret
    :reader ret
    :initarg :ret
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SetOutputState-response (<SetOutputState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetOutputState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetOutputState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name phidgets_interface-srv:<SetOutputState-response> is deprecated: use phidgets_interface-srv:SetOutputState-response instead.")))

(cl:ensure-generic-function 'ret-val :lambda-list '(m))
(cl:defmethod ret-val ((m <SetOutputState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader phidgets_interface-srv:ret-val is deprecated.  Use phidgets_interface-srv:ret instead.")
  (ret m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetOutputState-response>) ostream)
  "Serializes a message object of type '<SetOutputState-response>"
  (cl:let* ((signed (cl:slot-value msg 'ret)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetOutputState-response>) istream)
  "Deserializes a message object of type '<SetOutputState-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ret) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetOutputState-response>)))
  "Returns string type for a service object of type '<SetOutputState-response>"
  "phidgets_interface/SetOutputStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetOutputState-response)))
  "Returns string type for a service object of type 'SetOutputState-response"
  "phidgets_interface/SetOutputStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetOutputState-response>)))
  "Returns md5sum for a message object of type '<SetOutputState-response>"
  "fbfa7b3e79c838fbceaa8082ba51df74")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetOutputState-response)))
  "Returns md5sum for a message object of type 'SetOutputState-response"
  "fbfa7b3e79c838fbceaa8082ba51df74")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetOutputState-response>)))
  "Returns full string definition for message of type '<SetOutputState-response>"
  (cl:format cl:nil "int16 ret~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetOutputState-response)))
  "Returns full string definition for message of type 'SetOutputState-response"
  (cl:format cl:nil "int16 ret~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetOutputState-response>))
  (cl:+ 0
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetOutputState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetOutputState-response
    (cl:cons ':ret (ret msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetOutputState)))
  'SetOutputState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetOutputState)))
  'SetOutputState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetOutputState)))
  "Returns string type for a service object of type '<SetOutputState>"
  "phidgets_interface/SetOutputState")