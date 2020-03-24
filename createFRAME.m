function F=createFRAME(T,c,e,L)

if nargin==3,
    L=1;
end

XF=T*[L;0;0;1]; YF=T*[0;L;0;1]; ZF=T*[0;0;L;1];

EjeX.x=[T(1,4),XF(1)];
EjeX.y=[T(2,4),XF(2)];
EjeX.z=[T(3,4),XF(3)];

EjeY.x=[T(1,4),YF(1)];
EjeY.y=[T(2,4),YF(2)];
EjeY.z=[T(3,4),YF(3)];

EjeZ.x=[T(1,4),ZF(1)];
EjeZ.y=[T(2,4),ZF(2)];
EjeZ.z=[T(3,4),ZF(3)];

F.x=line(EjeX.x, EjeX.y,EjeX.z,'Color',c); 
F.y=line(EjeY.x, EjeY.y,EjeY.z,'Color',c); 
F.z=line(EjeZ.x, EjeZ.y,EjeZ.z,'Color',c); 

F.tx=text(XF(1),XF(2),XF(3),strcat(e,'x'),'Color',c);
F.ty=text(YF(1),YF(2),YF(3),strcat(e,'y'),'Color',c);
F.tz=text(ZF(1),ZF(2),ZF(3),strcat(e,'z'),'Color',c);

F.T=T;
F.L=L;