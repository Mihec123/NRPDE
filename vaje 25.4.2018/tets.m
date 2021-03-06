%locimo dva seznama za triangulacijo
%X,Y so x,y koordinate za tocke p zlozene v stolpec
%TRI velikosti n x 3, kjer je n stevilo tirkotnikov
%v vrstico pisemo indekse koordinat v X,Y
% primer iz vaj:
%[1 3 4; 1 3 10; ... ; 2 7 8]
%triplot rise triangulacijo triplot(TRI,X,Y) ali t = TriRep(TRI,X,Y) triplot(t)

%primer iz vaj
X = [1/4;3/4;0;1/2;1;1;1;1/2;0;0];
Y = [1/2;1/2;0;0;0;1/2;1;1;1;1/2];
TRI = [1 3 4; 1 3 10;1 9 10; 1 8 9; 1 2 8; 1 2 4; 2 4 5;2 5 6;2 6 7;2 7 8];
t = TriRep(TRI,X,Y);
%triangulacija obmocja
figure;
triplot(t)
%visine v dolocenih tockah
%to bo fi_1
Z = [1;0;0;0;0;0;0;0;0;0];
t1 = TriRep(TRI,X,Y,Z);
%trisuf ali trimesh
figure;
trisurf(t1);

Z1 = [0;1;0;0;0;0;0;0;0;0];

t2 = TriRep(TRI,X,Y,Z1);
%trisuf ali trimesh
figure;
trisurf(t2)