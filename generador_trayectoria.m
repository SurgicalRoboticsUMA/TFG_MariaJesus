% Funcion que dado el punto de inicio del taladro (herramienta), los radios 
% de la elipse y la orientacion en vector de rotación, devuelva el array 
% de conjuntos de puntos y la orientación de la trayectria. 
% tray = [pos, anlge-axis]. GENERADOR DE TRAYECTORIAS.

function tray = generador_trayectoria(p0, r1, r2, eul)
    close all;
    
    % Nos aseguramos de que la pose p0 sean 1x3
    if size(p0,1) ~= 3
         error('p0 is not 3x1 vector');
    end

    % Nos aseguramos de que el vector de orientación sea 1x3
    if size(eul,1) ~= 1
        error('eul is not 1x3 vector');
    end   
   
    % Nos aseguramos de que los radios no sean negativos ni = 0
    if r1 <= 0 || r2 <= 0
        error('r1 o r2 <= 0');
    end   
   
    
    % Matriz de orientación
    rotm = eul2rotm(eul);
    
    % Punto inicial
    x0 = p0(1);
    y0 = p0(2);
    z0 = p0(3);
    pini = rotm*[x0; y0; z0];
    plot3(pini(1), pini(2), pini(3),'mO');
    hold on;
       
    % Sistema de referencia
    T = [[rotm, pini]; [0 0 0 1]];
    createFRAME(T,'m','To',0.03);
    T0 = [[rotm,[0;0;0]]; [0 0 0 1]];
    createFRAME(T0,'y','T0',0.03);
   
    t = 0:pi/180:2*pi;
    
    % Calculamos el centro de la elipse
    Cx = x0 - r1*cos(0);
    Cy = y0 - r2*sin(0);
    Cz = z0;
    
    C = rotm*[Cx; Cy; Cz];
    plot3(C(1), C(2), C(3), 'b*')

    % Calculamos el array de puntos de la elipse sin orientacion
    for i = 1:length(t)
        x_(i) = Cx + r1*cos(t(i));
        y_(i) = Cy + r2*sin(t(i));
        z_(i) = z0;
        
        % Calculamos el array de puntos de la elipse CON orientacion.
        pos(:,i) = rotm*[x_(i); y_(i); z_(i)];
        
        % Calculamos el array de orientacion
        angle_axis(:,i) = rotationMatrixToVector(rotm); 
    end
    tray = [pos; angle_axis];
    
    plot3(pos(1,:),pos(2,:),pos(3,:),'g.'); grid; title('Trayectoria planificada');
    xlabel('EJE X') 
    ylabel('EJE Y') 
    zlabel('EJE Z')
    
end