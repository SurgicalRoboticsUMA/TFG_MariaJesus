% Funcion que dado el punto de inicio del taladro (herramienta), los radios
% de la elipse y la orientacion en el eje Z, devuelva el array del
% conjuntos de puntos de la trayectria. GENERADOR DE TRAYECTORIAS.

function trayectoria = gen_trayectoria(p0, r1, r2,theta)
    
    close all;
    
    %Nos aseguramos que la pose p0 sean 3x1
    if size(p0,1) ~= 3,
        error('p0 is not 3x1 vector');
    end;

    % Punto inicial 
    x0 = p0(1);
    y0 = p0(2);
    z0 = p0(3);
    plot3(x0,y0,z0,'rO');
    hold on;
    
    % Orientación 
    eulZYX = [theta, 0, 0];     %Euler = rotZ*rotY*rotX
    mat = eul2rotm(eulZYX);
    
    % Pose inicial
    T = [[mat, p0]; [0 0 0 1]];
    createFRAME(T,'r','To',2);
    
    t = 0:pi/200:2*pi;
    
    % Calculamos el centro de la elipse
    T(1,4) = x0 - r1*cos(0);
    T(2,4) = y0 - r2*sin(0);
    T(3,4) = z0;
    C = [T(1,4), T(2,4), T(3,4)];       % Centro de la elipse. (posición).
    % Pintamos el centro de la elipse
    plot3(C(1),C(2),C(3),'b*');
    
    % Definimos componentes de la trayectoria de la elipse [x_,y_,z_]
    x_ = [];
    y_ = [];
    z_ = [];
    
    % Asociamos los puntos del array.
    for i = 1:length(t)
         x_(i) = C(1) - r1*cos(i);
         y_(i) = C(2) - r2*sin(i);
         z_(i) = z0;
        
        % Dibujamos los puntos de la trayectoria
        plot3(x_(i),y_(i),z_(i),'g.'); 
        
%         % Calculamos el array de puntos de la elipse.
%         T(1,4) = x_(i);
%         T(2,4) = y_(i);
%         T(3,4) = z_(i);
%       
%        % Dibujamos los ejes cada 100 iteraciones para comprobar
%        % orientación
%         if (mod(i)) == 0
%             createFRAME(T,'g','T',2);
%         end
    end
    trayectoria  = [x_ , y_ , z_];
end
