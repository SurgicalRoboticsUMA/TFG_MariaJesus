rosinit 
% GUARDAR TRAYECTORIA RECORRIDA POR EL ROBOT:
% Con este código, se guardan las posiciones del robot en la
% variable tray_recorrida. 
% Cuando se quiera dejar de guardar >> clear sub

% Se cargan los parametros de entrada y se calcula la trayectoria 
load experimento4.mat
tray = generador_trayectoria(p0, r1, r2, eul);

% Figura
figure('color','white')
plot3(tray(1,:),tray(2,:),tray(3,:),'g.'); grid; 
title('TRAYECTORIA RECORRIDA SOBRE PLANIFICADA // EXPERIMENTO 4')
hold on
xlabel('EJE X') 
ylabel('EJE Y') 
zlabel('EJE Z')

% Suscripcion a los topics. Publicacion y lectura de la trayecotira
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
