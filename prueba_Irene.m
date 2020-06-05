%% GUARDAR TRAYECTORIA RECORRIDA POR EL ROBOT:
% Con este código de abajo, se guardan las posiciones del robot en la
% variable tray_recorrida. 
% Cuando quieras dejar de grabar, hay que hacer 
% >> clear sub

global tray_recorrida
tray_recorrida(1,:) = zeros(1,6);
sub = rossubscriber("/UR3_1/outputs/pose","std_msgs/Float64MultiArray",@callback);

%% CODIGO PRUEBA 1
load aplicacion1.mat
tray = tray';
plot3(tray(:,1),tray(:,2),tray(:,3),'b.');
hold on

pub = rospublisher("/UR3_1/inputs/move_pose","std_msgs/Float64MultiArray");
msg = rosmessage(pub);

%figure('color','white')
for i = 1:1:length(tray)
    %msg.Data = tray(i,:);
    plot3(tray(i,1),tray(i,2),tray(i,3),'r*'); hold on
    %send(pub,msg)
    pause(0.008)
end
clear sub

%% CODIGO PRUEBA 2
load aplicacion1.mat
tray = generador_trayectoria2(p0, r1, r2, eul);
tray = tray';
figure('color','white')
plot3(tray(:,1),tray(:,2),tray(:,3),'b.');
hold on

for i = 1:1:length(tray)
    plot3(tray(i,1),tray(i,2),tray(i,3),'r*'); hold on
    pause(0.008)
end


%% CODIGO PRUEBA 3
load aplicacion1.mat
tray = generador_trayectoria2(p0, r1, r2, eul);

figure('color','white')
plot3(tray(1,:),tray(2,:),tray(3,:),'b.');
hold on

pub = rospublisher("/UR3_1/inputs/move_pose","std_msgs/Float64MultiArray");
msg = rosmessage(pub);

global tray_recorrida
tray_recorrida(:,1) = zeros(6,1);
sub = rossubscriber("/UR3_1/outputs/pose","std_msgs/Float64MultiArray",@callback);

for i = 1:1:length(tray)
    msg.Data = tray(:,i);
    send(pub,msg)
    pause(0.008)
end
clear sub

