% COMUNICACION ROS
rosinit


% Leer la configuracion de las articulaciones
sub = rossubscriber("/UR3_1/outputs/joints","sensor_msgs/JointState")
msg = rosmessage(sub);
msg.Position  = sub.LatestMessage.Position;
conf_articulaciones = msg.Position

% Leer velocidad cartesiana (en cada momento)
sub = rossubscriber("/UR3_1/outputs/velocity","std_msgs/Float64MultiArray")
msg = rosmessage(sub)
msg.Data  = sub.LatestMessage.Data;
velocidad = msg.Data

% Tranformaciones entre dos sistemas de ref: /tf
sub = rossubscriber("/tf","tf2_msgs/TFMessage")
msg = rosmessage(sub)
msg.Transforms = sub.LatestMessage.Transforms;
tf = msg.Transforms.Transform;
tf_Translation = tf.Translation
tf_Rotation = tf.Rotation     % Quaternion
   

    
    
% INPUTS TOPICS
% Enviar la configuracion de las articulaciones
pub = rospublisher("/UR3_1/inputs/move_joints","sensor_msgs/JointState");
msg = rosmessage(pub);
msg.Position = [pi/2,-pi/2,0,0,pi/2,0];
send(pub,msg)
   
% Eviar velocidad de la articulacion y de la pose
pub2 = rospublisher("/UR3_1/inputs/speed_joints","sensor_msgs/JointState")
msg2 = rosmessage(pub2);
msg2.Velocity = 0.1;
send(pub2,msg2)

pub = rospublisher("/UR3_1/inputs/speed_pose","std_msgs/Float64MultiArray")
msg = rosmessage(pub)
msg.Data= [0,0,0,0,0,0];
send(pub,msg)

rosshutdown

