/*FECHA
TDA FECHA
lista con la forma
[DD,MM,YYYY] donde todos sus valores son numeros
*/
%primero revisa sus parametros
fecha(D,M,Y,_):- D>28,M=2,!,false.
fecha(D,M,Y,_):- D>30,(M=2;M=6;M=9;M=11),!,false.
%si no cumple  los anteriores entrara en esta 
fecha(D,M,Y,[D,M,Y]):-
    number(D),number(M),number(Y),
    D>0,(D<31;D=31), M>0 ,( M<12 ; M=12),!.
% SELECTORES
fechaGetD([D,M,Y],D).
fechaGetM([D,M,Y],M).
fechaGetY([D,M,Y],Y).

/*USER
lista con la forma
[ID,username,password,fecha,followers,posts]
integer x stringx x password x fecha x lista x lista
*/
usuario(ID,Nombre,Password,Fecha,Followers,Posts):-
    number(ID),not(ID<0),string(Nombre),string(Nombre),!.

% SELECTORES
getUsuarioID([ID,Nombre,Passowrd,Fecha,Followers,Posts],ID).    
getUsername([ID,Nombre,Passowrd,Fecha,Followers,Posts],Nombre).
getPassword([ID,Nombre,Passowrd,Fecha,Followers,Posts],Password).
getUserFecha([ID,Nombre,Passowrd,Fecha,Followers,Posts],Fecha).
getUserFollowers([ID,Nombre,Passowrd,Fecha,Followers,Posts],Followers).
getUserPosts([ID,Nombre,Passowrd,Fecha,Followers,Posts],Posts).

