/*
______        _           
|  ___|      | |          
| |_ ___  ___| |__   __ _ 
|  _/ _ \/ __| '_ \ / _` |
| ||  __/ (__| | | | (_| |
\_| \___|\___|_| |_|\__,_|
TDA FECHA
lista con la forma
[DD,MM,YYYY] donde todos sus valores son numeros
*/
%primero revisa sus parametros
fecha(D,M,Y,_):- D>28,M=2,!,false.
fecha(D,M,Y,_):- D>30,(M=2;M=6;M=9;M=11),!,false.
%si no cumple  los anteriores entrara en esta 
fecha(D,M,Y,Salida):-
    number(D),number(M),number(Y),
    D>0,(D<31;D=31), M>0 ,( M<12 ; M=12),!,
    Salida = [D,M,Y].   
% SELECTORES
getFechaD([D,_,_],D).
getFechaM([_,M,_],M).
getFechaY([_,_,Y],Y).


/*
 _   _               
| | | |              
| | | |___  ___ _ __ 
| | | / __|/ _ \ '__|
| |_| \__ \  __/ |   
 \___/|___/\___|_|   
lista con la forma
[ID,username,password,fecha,followers,posts]
integer x stringx x password x fecha x lista x lista
*/
% CONTRUCTOR

crearUsuario(ID,Username,Password,Fecha,Followers,Posts,Salida):-
    number(ID),not(ID<0),not(ID=0),string(Username),string(Password),
    is_list(Followers),is_list(Posts),
    Salida = [ID,Username,Password,Fecha,Followers,Posts].

% SELECTORES
getUsuarioID([ID,_,_,_,_,_],ID).    
getUsername([_,Username,_,_,_,_],Username).
getPassword([_,_,Password,_,_,_],Password).
getUserFecha([_,_,_,Fecha,_,_],Fecha).
getUserFollowers([_,_,_,_,Followers,_],Followers).
getUserPosts([_,_,_,_,_,Posts],Posts).

/*
______      _     _ _                _                       
| ___ \    | |   | (_)              (_)                      
| |_/ /   _| |__ | |_  ___ __ _  ___ _  ___  _ __   ___  ___ 
|  __/ | | | '_ \| | |/ __/ _` |/ __| |/ _ \| '_ \ / _ \/ __|
| |  | |_| | |_) | | | (_| (_| | (__| | (_) | | | |  __/\__ \
\_|   \__,_|_.__/|_|_|\___\__,_|\___|_|\___/|_| |_|\___||___/
lista de forma
[ID,formato texto, reacciones,comentarios,fecha,tags,shared]
integer x string x lista x lista x fecha x lista x lista
*/
% CONSTRUCTOR
crearPublicacion(ID,Texto,Reacts,Comments,Fecha,Tags,Shared,Salida):-
    number(ID),not(ID<0),not(ID=0),string(Texto),
    is_list(Reacts),is_list(Comments),is_list(Tags),is_list(Shared),
    Salida = [ID,Texto,Reacts,Comments,Fecha,Tags,Shared].

% SELECTORES
getPublicacionID([ID,_,_,_,_,_,_],ID).
getPublicacionTexto([_,Texto,_,_,_,_,_],Texto).
getPublicacionReacts([_,_,Reacts,_,_,_,_],Reacts).
getPublicacionComments([_,_,_,Comments,_,_,_],Comments).
getPublicacionFecha([_,_,_,_,Fecha,_,_],Fecha).
getPublicacionTags([_,_,_,_,_,Tags,_],Tags).
getPublicacionShared([_,_,_,_,_,_,Shared],Shared).
/*
 _____            _       _ _   _      _                      _    
/  ___|          (_)     | | \ | |    | |                    | |   
\ `--.  ___   ___ _  __ _| |  \| | ___| |___      _____  _ __| | __
 `--. \/ _ \ / __| |/ _` | | . ` |/ _ \ __\ \ /\ / / _ \| '__| |/ /
/\__/ / (_) | (__| | (_| | | |\  |  __/ |_ \ V  V / (_) | |  |   < 
\____/ \___/ \___|_|\__,_|_\_| \_/\___|\__| \_/\_/ \___/|_|  |_|\_\

lista de la forma
[nombre,fecha,usuarios,publicaciones,usuarioOnline]
string x fecha x lista x lista x integer
*/
% CONSTRUCTOR
crearRS(Nombre,Fecha,RS):-
    crearRedSocial(Nombre,Fecha,[],[],0,RS).

crearRedSocial(Nombre,Fecha,Usuarios,Publicaciones,UsuarioOnline,RS):-
    string(Nombre),is_list(Fecha),is_list(Usuarios),is_list(Publicaciones),number(UsuarioOnline),
    RS = [Nombre,Fecha,Usuarios,Publicaciones,UsuarioOnline].

% SELECTORES
getNombreRedSocial([Nombre,_,_,_,_],Nombre).
getFechaRedSocial([_,Fecha,_,_,_],Fecha).
getUsuariosRedSocial([_,_,Usuarios,_,_],Usuarios).
getPublicacionesRedSocial([_,_,_,Publciaciones,_],Publicaciones).
getUsuarioOnline([_,_,_,_,UsuarioOnline],UsuarioOnline).

