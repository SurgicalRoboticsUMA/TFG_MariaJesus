function callback(src,msg)

global tray_recorrida

tray_recorrida(:,end+1) = msg.Data;
plot3(msg.Data(1),msg.Data(2),msg.Data(3),'r*'); hold on
