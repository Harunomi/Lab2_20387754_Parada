/*
%     set_prolog_flag(answer_write_options,[max_depth(0)]).
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
    string(Nombre),number(UsuarioOnline),is_list(Fecha),is_list(Usuarios),is_list(Publicaciones),
    RS = [Nombre,Fecha,Usuarios,Publicaciones,UsuarioOnline].

% SELECTORES
getNombreRedSocial([Nombre,_,_,_,_],Nombre).
getFechaRedSocial([_,Fecha,_,_,_],Fecha).
getUsuariosRedSocial([_,_,Usuarios,_,_],Usuarios).
getPublicacionesRedSocial([_,_,_,Publicaciones,_],Publicaciones).
getUsuarioOnline([_,_,_,_,UsuarioOnline],UsuarioOnline).

/*
  ___             _ _ _                     
 / _ \           (_) (_)                    
/ /_\ \_   ___  ___| |_  __ _ _ __ ___  ___ 
|  _  | | | \ \/ / | | |/ _` | '__/ _ \/ __|
| | | | |_| |>  <| | | | (_| | | |  __/\__ \
\_| |_/\__,_/_/\_\_|_|_|\__,_|_|  \___||___/
*/
% Dominio: lista x String
% Descripcion: permite buscar en una lista de usuarios si este existe o no
buscarUsuario([H|_],Usuario):-
    getUsername(H,Username),
    (Usuario = Username).

buscarUsuario([_|T],Usuario):-
    buscarUsuario(T,Usuario).

% Dominio: string x list x Var
% Descripcion: retorna la id de un usuario si es que existe.
buscarIDUsuario([H|_],Usuario,Retorno):-
    getUsername(H,Username),
    (Usuario = Username),
    getUsuarioID(H,Retorno).
buscarIDUsuario([_|T],Usuario,Retorno):-
    buscarIDUsuario(T,Usuario,Retorno).        

% Dominio: list x string x string
% Descripcion: permite buscar un usuario por su nombre de usuario y contrasena
buscarUsuarioPassword([H|_],Usuario,Password):-
    getUsername(H,Username),
    getPassword(H,Contrasena),
    (Usuario = Username),
    (Password = Contrasena).
buscarUsuarioPassword([_|T],Usuario,Password):-
    buscarUsuarioPassword(T,Usuario,Password).

% Dominio: list x Var
% Descripcion: Permite obtener el largo de una lista
largo_lista(Xs,L) :- largo_lista(Xs,1,L) .

largo_lista( []     , L , L ) .
largo_lista( [_|Xs] , T , L ) :-
  T1 is T+1 ,
  largo_lista(Xs,T1,L).


/*
______                _                   _           
|  ___|              (_)                 | |          
| |_ _   _ _ __   ___ _  ___  _ __   __ _| | ___  ___ 
|  _| | | | '_ \ / __| |/ _ \| '_ \ / _` | |/ _ \/ __|
| | | |_| | | | | (__| | (_) | | | | (_| | |  __/\__ \
\_|  \__,_|_| |_|\___|_|\___/|_| |_|\__,_|_|\___||___/
                                                      
*/

% Dominio: red social x fecha x string x string x RedSocial 
% Descripcion: Funcion que toma una red social y permite registrar un nuevo usuario
socialNetworkRegister(RSin,Fecha,Username,Password,RSout):-
    string(Username),
    string(Password),
    getNombreRedSocial(RSin,Nombre),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    getPublicacionesRedSocial(RSin,Publicaciones),
    getUsuarioOnline(RSin,UsuarioOnline),
    not(buscarUsuario(Usuarios,Username)),!,
    largo_lista(Usuarios,ID),
    crearUsuario(ID,Username,Password,Fecha,[],[],NuevoUsuario),
    append(Usuarios,[NuevoUsuario],UsuariosNuevos),
    crearRedSocial(Nombre,FechaRS,UsuariosNuevos,Publicaciones,UsuarioOnline,RSout).

% Dominio: red social x string x string x socialnetwork
% Descripcion: funcion que permite iniciar sesion a un usuario en una red social
socialNetworkLogin(RSin,Username,Password,RSout):-
    string(Username),
    string(Password),
    getNombreRedSocial(RSin,Nombre),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    buscarUsuarioPassword(Usuarios,Username,Password),!,
    getPublicacionesRedSocial(RSin,Publicaciones),
    buscarIDUsuario(Usuarios,Username,ID),
    crearRedSocial(Nombre,FechaRS,Usuarios,Publicaciones,ID,RSout).

