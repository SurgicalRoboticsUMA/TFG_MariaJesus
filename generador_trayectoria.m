% Funcion que dado el punto de inicio del taladro (herramienta), los radios
% de la elipse y la orientacion en ángulos de euler, devuelva el array del
% conjuntos de puntos de la trayectria. GENERADOR DE TRAYECTORIAS.

function trayectoria = generador_trayectoria(p0, r1, r2, eul)
    close all;
    
    % Nos aseguramos que la pose p0 sean 1x3
    if size(p0,1) ~= 3
         error('p0 is not 3x1 vector');
    end

    % Nos aseguramos que el vector de orientación sea 1x3
    if size(eul,1) ~= 1
        error('eul is not 1x3 vector');
    end   
    
    % Matriz de orientación
    rotmZYX  = eul2rotm(eul);
    
    
    
    % Punto inicial
    x0 = p0(1);
    y0 = p0(2);
    z0 = p0(3);
    pini = rotmZYX*[x0; y0; z0];
    plot3(pini(1), pini(2), pini(3),'mO');
    hold on;
       
    % Sistema de referencia
    T = [[rotmZYX, [0;0;0]]; [0 0 0 1]];
    createFRAME(T,'m','To',2);
    
    
    t = 0:pi/200:2*pi;
    
    % Calculamos el centro de la elipse
    xC = x0 - r1*cos(0);
    yC = y0 - r2*sin(0);
    zC = 0;
    
    C = rotmZYX*[xC; yC; zC];
    plot3(C(1), C(2), C(3), 'b*')

    % Calculamos el array de puntos de la elipse sin orientacion
    for i = 1:length(t)
        x_(i) = xC - r1*cos(i);
        y_(i) = yC - r2*sin(i);
        z_(i) = z0;
  
        % Calculamos el array de puntos de la elipse CON orientacion.
        tray(:,i) = rotmZYX*[x_(i); y_(i); z_(i)];
    end
    
    plot3(tray(1,:),tray(2,:),tray(3,:),'g.'); grid; title('Trayectoria generada');
    xlabel('EJE X') 
    ylabel('EJE Y') 
    zlabel('EJE Z')
    trayectoria = tray;
end
