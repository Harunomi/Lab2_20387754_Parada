/*
%     set_prolog_flag(answer_write_options,[max_depth(0)]),use_module(library(theme/dark)),write('\e[2J').

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
fecha(5,10,2021,F),crearRS("Twitter",F,RSout).
fecha(30,4,2021,F),crearRS("Insta",F,RSout).
fecha(1,1,2021,F),crearRS("Facebook",F,RSout).
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

% Dominio: lista x ID
% Descripcion: permite buscar en una lista de usuarios si este existe o no
buscar_user_por_ID([H|_],ID):-
    getUsuarioID(H,ID2),
    (ID = ID2).

buscar_user_por_ID([_|T],ID):-
    buscar_user_por_ID(T,ID).    

% Dominio: lista x number x var
% Descripcion: permite saber si existe una publicacion dada su id en una lista de publicaciones
id_to_publicacion([H|_],ID,Retorno):-
    getPublicacionID(H,ID2),
    (ID2 = ID),
    H = Retorno.

id_to_publicacion([_|T],ID,Retorno):-
    id_to_publicacion(T,ID,Retorno).

% Dominio: lista x number.
% Descripcion: permite saber si existe una ID en una lista
buscarID([H|_],ID):-
    (H = ID).
buscarID([_|T],ID):-
    buscarID(T,ID).          

% Dominio: list x string x Var
% Descripcion: retorna la id de un usuario si es que existe.
buscarIDUsuario([H|_],Usuario,Retorno):-
    getUsername(H,Username),
    (Usuario = Username),
    getUsuarioID(H,Retorno).
buscarIDUsuario([_|T],Usuario,Retorno):-
    buscarIDUsuario(T,Usuario,Retorno).     

% Dominio: string x list x Var
% Descripcion: a partir de un username, permite obtener el usuario completo.
username_to_usuario([H|_],Usuario,Retorno):-
    getUsername(H,Username),
    (Usuario = Username),
    Retorno = H.
username_to_usuario([_|T],Usuario,Retorno):-
    username_to_usuario(T,Usuario,Retorno). 

% Dominio: list x number x Var
% Descripcion: a partir de un ID, obtiene el usuario completo de una lista.
id_to_usuario([H|_],IDaBuscar,Retorno):-
    getUsuarioID(H,IDEncontrada),
    (IDaBuscar = IDEncontrada),
    H = Retorno.

id_to_usuario([_|T],IDaBuscar,Retorno):-
    id_to_usuario(T,IDaBuscar,Retorno).               


% Dominio: list x string x string
% Descripcion: permite buscar un usuario por su nombre de usuario y contrasena
buscarUsuarioPassword([H|_],Usuario,Password):-
    getUsername(H,Username),
    getPassword(H,Contrasena),
    (Usuario = Username),
    (Password = Contrasena).
buscarUsuarioPassword([_|T],Usuario,Password):-
    buscarUsuarioPassword(T,Usuario,Password).

% Dominio: number x list x Var
% Descripcion: permite eliminar un usuario o publicacion dada una ID de una lista
eliminar_por_ID(_,[],[]).

eliminar_por_ID(Y,[[Y|_]|Xs],Salida):-
    eliminar_por_ID(Y,Xs,Salida),!.

eliminar_por_ID(X,[Y|Xs],[Y|Salida]):-
    eliminar_por_ID(X,Xs,Salida).    
% Dominio: lista x list
% Descripcion: busca de la lista de usuarios si la lista de etiquetados existe

buscarEtiquetados([],L).
buscarEtiquetados([H|T],L):-
    buscarUsuario(L,H),
    buscarEtiquetados(T,L).

% Dominio: fecha x Var
% Descripcion: funcion que recibe una fecha como TDA y la retorna como string
fecha_to_string([D,M,Y],Retorno):-
    string_concat(D,"/",S1),
    string_concat(M,"/",S2),
    string_concat(S1,S2,S3),
    string_concat(S3,Y,Retorno).    

% Dominio: list x Var
% Descripcion: Permite obtener el largo de una lista para el ID de un usuario o publicacion
id_counter(Lista,ID) :- id_counter(Lista,1,ID).

id_counter( []     , ID , ID ).
id_counter( [_|Lista] , T , ID ) :-
  T1 is T+1 ,
  id_counter(Lista,T1,ID).

% Dominio: list x Var
% Descripcion: Funcion que permite obtener el largo de una lista
largo_lista(Lista,L) :- largo_lista(Lista,0,L).

largo_lista( []     , L , L ).
largo_lista( [_|Lista] , T , L ) :-
  T1 is T+1 ,
  largo_lista(Lista,T1,L).  

% Dominio: list x string, Var
% Descripcion: Funcion intermediaria que toma un Usuario de una lista de usuarios y lo convierte a string
iterar_usuarios([H|T],String,Salida):-
    largo_lista(T,LargoT),
    not(LargoT = 0),!,
    usuario_to_string(H,UserString),
    string_concat(String,UserString,NewString),
    iterar_usuarios(T,NewString,Salida).    

iterar_usuarios([H|T],String,Salida):-
    usuario_to_string(H,UserString),
    string_concat(String,UserString,NewString),
    Salida = NewString.    


% Dominio: list x Var
% Descripcion: Funcion que imprime los datos de un usuario
usuario_to_string(User,Retorno):-
    getUsername(User,Username),
    getUserFecha(User,Fecha),
    fecha_to_string(Fecha,FechaCreacion),
    getUserFollowers(User,Followers),
    largo_lista(Followers,CFollowers),
    atom_concat(CFollowers,"",CantFollowers),
    getUserPosts(User,Posts),
    largo_lista(Posts,CPosts),
    atom_concat(CPosts,"",CantPosts),
    string_concat("\nNombre de usuario: ",Username,S1),
    string_concat(S1,"\nCuenta creada en la fecha: ",S3),
    string_concat(S3,FechaCreacion,S4),
    string_concat(S4,"\nTiene un total de: ",S5),
    string_concat(S5,CantFollowers,S6),
    string_concat(S6," followers\n",S7),
    string_concat(S7,"Tiene un total de: ",S8),
    string_concat(S8,CantPosts,S9),
    string_concat(S9," publicaciones\n\n",S10),
    S10 = Retorno.

% Dominio: list x string x Var
% Descripcion: Funcion intermediara que permite tomar una publicacion y hacer el llamado de publicacion_to_string, asi con todas las publciaciones
iterar_publicaciones([H|T],String,Salida):-
    largo_lista(T,LargoT),
    not(LargoT = 0),!,
    publicacion_to_string(H,PublicacionString),
    string_concat(String,PublicacionString,NewString),
    iterar_publicaciones(T,NewString,Salida).

iterar_publicaciones([H|T],String,Salida):-
    publicacion_to_string(H,PublicacionString),
    string_concat(String,PublicacionString,NewString),
    Salida = NewString.    

% Dominio: Publicacion x var
% Descripcion: Funcion que genera un string con todos los datos de una publicacion
publicacion_to_string(Publicacion,Retorno):-
    getPublicacionTexto(Publicacion,Texto),
    getPublicacionReacts(Publicacion,Reacts),
    largo_lista(Reacts,LargoReacts),
    % Cantidad de reacciones como string
    atom_concat(LargoReacts,"",CantReacts),
    getPublicacionComments(Publicacion,Comments),
    largo_lista(Comments,LargoComments),
    % Cantidad de comentarios como string
    atom_concat(LargoComments,"",CantComments),
    getPublicacionFecha(Publicacion,PublicacionFecha),
    fecha_to_string(PublicacionFecha,FechaString),
    getPublicacionTags(Publicacion,Tags),
    largo_lista(Tags,LargoTags),
    % Cantidad de etiquetados como string
    atom_concat(LargoTags,"",CantTags),
    atomic_list_concat(Tags,",",TagsAtom),
    % Etiquetados como string
    atom_concat(TagsAtom,"",TagsString),
    getPublicacionShared(Publicacion,Shared),
    largo_lista(Shared,LargoShared),
    % Cantidad de compartidas como string
    atom_concat(LargoShared,"",CantShared),
    string_concat("\nPublicacion creada en la fecha: ",FechaString,S1),
    string_concat(S1,"\nTiene como contenido: ",S2),
    string_concat(S2,Texto,S3),
    string_concat(S3,"\nTiene un total de ",S4),
    string_concat(S4,CantReacts,S5),
    string_concat(S5," reacciones\n",S6),
    string_concat(S6,"Tiene un total de ",S7),
    string_concat(S7,CantComments,S8),
    string_concat(S8," comentarios\n",S9),
    string_concat(S9,"Tiene un total de ",S10),
    string_concat(S10,CantTags,S11),
    string_concat(S11," etiquetados, los cuales son: ",S12),
    string_concat(S12,TagsString,S13),
    string_concat(S13,"\nHa sido compartida ",S14),
    string_concat(S14,CantShared,S15),
    string_concat(S15," veces\n\n",S16),
    S16 = Retorno.

% Descripcion: Funcion que permite saber si una ID es un comentario de una publicacion
% Dominio: list x integer
buscar_comentario([H|_],ID):-
    getPublicacionComments(H,Comments),
    buscarID(Comments,ID).
buscar_comentario([_|T],ID):-
    buscar_comentario(T,ID).    
    



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
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"UsuarioNuevo","Contrasena",RedSocial2).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"UsuarioDuplicado","Duplicado",RedSocial2),socialNetworkRegister(RedSocial2,F,"UsuarioDuplicado","Contrasena",RedSocial3).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3).
socialNetworkRegister(RSin,Fecha,Username,Password,RSout):-
    string(Username),
    string(Password),
    getNombreRedSocial(RSin,Nombre),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    getPublicacionesRedSocial(RSin,Publicaciones),
    getUsuarioOnline(RSin,UsuarioOnline),
    not(buscarUsuario(Usuarios,Username)),!,
    id_counter(Usuarios,ID),
    crearUsuario(ID,Username,Password,Fecha,[],[],NuevoUsuario),
    append(Usuarios,[NuevoUsuario],UsuariosNuevos),
    crearRedSocial(Nombre,FechaRS,UsuariosNuevos,Publicaciones,UsuarioOnline,RSout).

% Dominio: red social x string x string x socialnetwork
% Descripcion: funcion que permite iniciar sesion a un usuario en una red social
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"UsuarioNuevo","Contrasena",RedSocial2),socialNetworkLogin("RedSocial2,"UsuarioNuevo","Contrasena",Redsocial3).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"Noexiste","NoHayUsuario",RedSocial2),socialNetworkLogin(RedSocial2,"Intentar","Loggear",RedSocial3).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkLogin(RedSocial3,F,"User2","Pass2",RedSocial4).
socialNetworkLogin(RSin,Username,Password,RSout):-
    string(Username),
    string(Password),
    getNombreRedSocial(RSin,Nombre),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    buscarUsuarioPassword(Usuarios,Username,Password),!,
    getPublicacionesRedSocial(RSin,Publicaciones),
    buscarIDUsuario(Usuarios,Username,ID),!,
    crearRedSocial(Nombre,FechaRS,Usuarios,Publicaciones,ID,RSout).

% Dominio: RedSocial x fecha x string x string list x RedSocial
% Descripcion: funcion que permite a un usuario loggeado en la red social realizar una publicacion
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkLogin(RedSocial3,F,"User2","Pass2",RedSocial4),socialNetworkPost(RedSocial4,F,"Mi primer post",[],RedSocial5).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No etiquetar a gente que no me sigue",["User1"],RedSocial8).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8).
socialNetworkPost(RSin,Fecha,Texto,Etiquetados,RSout):-
    string(Texto),
    is_list(Etiquetados),
    getNombreRedSocial(RSin,NombreRS),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    getPublicacionesRedSocial(RSin,Publicaciones),
    getUsuarioOnline(RSin,UsuarioOnline),
    (UsuarioOnline>0),
    buscarEtiquetados(Etiquetados,Usuarios),
    id_counter(Publicaciones,IDpublicacion),
    % Creo la publicacion
    crearPublicacion(IDpublicacion,Texto,[],[],Fecha,Etiquetados,[],PublicacionNueva),
    % busco al usuario
    id_to_usuario(Usuarios,UsuarioOnline,Autor),
    % obtengo sus datos
    getUsername(Autor,AutorUsername),
    getPassword(Autor,AutorPassword),
    getUserFecha(Autor,AutorFecha),
    getUserFollowers(Autor,AutorFollowers),
    getUserPosts(Autor,AutorPosts),
    % Agrego la publicacion nueva a la lista de publicaciones de la red social y del autor
    append(Publicaciones,[PublicacionNueva],PublicacionesNuevas),
    append(AutorPosts,[PublicacionNueva],AutorPostsNuevo),
    eliminar_por_ID(UsuarioOnline,Usuarios,UsuariosNuevos),!,
    crearUsuario(UsuarioOnline,AutorUsername,AutorPassword,AutorFecha,AutorFollowers,AutorPostsNuevo,NuevoAutor),
    append(UsuariosNuevos,[NuevoAutor],UsuariosFinal),
    crearRedSocial(NombreRS,FechaRS,UsuariosFinal,PublicacionesNuevas,0,RSout).


% Dominio: RedSocial x string x SocialNetwork
% Descripcion: funcion que permite a un usuario con sesion iniciada darle follow a otro usuario que ya exista en la plataforma
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14).
socialNetworkFollow(RSin,Username,RSout):-
    string(Username),
    getNombreRedSocial(RSin,Nombre),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    getPublicacionesRedSocial(RSin,Publicaciones),
    getUsuarioOnline(RSin,UsuarioOnline),
    (UsuarioOnline>0),
    buscar_user_por_ID(Usuarios,UsuarioOnline),
    % me aseguro que el usuario objetivo exista
    buscarUsuario(Usuarios,Username),!,
    % retorno completamente el usuario dado su username
    username_to_usuario(Usuarios,Username,Objetivo),
    getUsuarioID(Objetivo,ObjetivoID),
    getUsername(Objetivo,ObjetivoUsername),
    getPassword(Objetivo,ObjetivoPassword),
    getUserFecha(Objetivo,ObjetivoFecha),
    getUserFollowers(Objetivo,ObjetivoFollowers),
    getUserPosts(Objetivo,ObjetivoPosts),
    % me aseguro que el usuario objetivo no tenga ya de amigo al usuario conectado
    not(buscarID(ObjetivoFollowers,UsuarioOnline)),!,
    append(ObjetivoFollowers,[UsuarioOnline],ObjetivoFollowersNuevo),
    % Elimino el usuario objetivo para agregarlo nuevamente con el nuevo amigo
    eliminar_por_ID(ObjetivoID,Usuarios,UsuariosNuevos),
    crearUsuario(ObjetivoID,ObjetivoUsername,ObjetivoPassword,ObjetivoFecha,ObjetivoFollowersNuevo,ObjetivoPosts,UsuarioFinal),
    append(UsuariosNuevos,[UsuarioFinal],UsuariosFinal),
    crearRedSocial(Nombre,FechaRS,UsuariosFinal,Publicaciones,0,RSout).

% Dominio: red social x fecha x number x list x red social
% Descripcion: funcion que permite compartir una publicacion en las publicaciones del usuario
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,3,[],RedSocial18).
socialNetworkShare(RSin,Fecha,IDpost,Etiquetados,RSout):-
    number(IDpost),
    is_list(Etiquetados),
    getNombreRedSocial(RSin,NombreRS),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    getPublicacionesRedSocial(RSin,Publicaciones),
    getUsuarioOnline(RSin,UsuarioOnline),
    (UsuarioOnline>0),
    buscar_user_por_ID(Usuarios,UsuarioOnline),
    id_to_publicacion(Publicaciones,IDpost,PublicacionACompartir),!,
    buscarEtiquetados(Etiquetados,Usuarios),!,
    getPublicacionTexto(PublicacionACompartir,PublicacionNT),
    id_counter(Publicaciones,PublicacionNID),
    % creo la publicacion compartida
    crearPublicacion(PublicacionNID,PublicacionNT,[],[],Fecha,Etiquetados,[],PublicacionCompartida),
    id_to_usuario(Usuarios,UsuarioOnline,Autor),!,
    getUsername(Autor,AutorUsername),
    getPassword(Autor,AutorPassword),
    getUserFecha(Autor,AutorFecha),
    getUserFollowers(Autor,AutorFollowers),
    getUserPosts(Autor,AutorPosts),
    append(AutorPosts,[PublicacionCompartida],AutorPostsNuevos),
    getPublicacionID(PublicacionACompartir,NewPublicacionID),
    getPublicacionReacts(PublicacionACompartir,NewPublicacionReacts),
    getPublicacionComments(PublicacionACompartir,NewPublicacionComments),
    getPublicacionFecha(PublicacionACompartir,NewPublicacionFecha),
    getPublicacionTags(PublicacionACompartir,NewPublicacionTags),
    getPublicacionShared(PublicacionACompartir,NewPublicacionShared),
    append(NewPublicacionShared,[UsuarioOnline],PublicacionSharedFinal),
    % creo la publicacion con la lista de compartidas actualizada
    crearPublicacion(NewPublicacionID,PublicacionNT,NewPublicacionReacts,NewPublicacionComments,NewPublicacionFecha,NewPublicacionTags,PublicacionSharedFinal,PublicacionActualizada),
    crearUsuario(UsuarioOnline,AutorUsername,AutorPassword,AutorFecha,AutorFollowers,AutorPostsNuevos,UsuarioActualizado),
    eliminar_por_ID(UsuarioOnline,Usuarios,Usuarios2),!,
    eliminar_por_ID(NewPublicacionID,Publicaciones,Publicaciones1),!,
    append(Publicaciones1,[PublicacionCompartida],Publicaciones2),
    append(Publicaciones2,[PublicacionActualizada],PublicacionesFinal),
    append(Usuarios2,[UsuarioActualizado],UsuariosFinal),
    crearRedSocial(NombreRS,FechaRS,UsuariosFinal,PublicacionesFinal,0,RSout).

% Dominmio: Red Social X Var
% Descripcion: Funcion que permite obtener un string con toda la informacion de una red social o un usuario online
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkToString(RedSocial8,String).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkToString(RedSocial19,String).
socialNetworkToString(RSin,Salida):-
    % Verifico el caso que no haya ningun usuario online
    getUsuarioOnline(RSin,UsuarioOnline),
    (UsuarioOnline = 0),!,
    % Obtengo todos los datos de la red social y los transformo a string
    getNombreRedSocial(RSin,NombreRS),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    largo_lista(Usuarios,CantUsuarios),
    atom_concat(CantUsuarios,"",CantUsuariosStr),
    largo_lista(Publicaciones,CantPublicaciones),
    atom_concat(CantPublicaciones,"",CantPublicacionesStr),
    getPublicacionesRedSocial(RSin,Publicaciones),
    fecha_to_string(FechaRS,FechaString),
    % Armo el esqueleto de la Salida
    string_concat("La red social tiene como nombre: ",NombreRS,S1),
    string_concat(S1,"\n",S2),
    string_concat(S2,"Fue creada la fecha: ",S3),
    string_concat(S3,FechaString,S4),
    string_concat(S4,"\n",S5),
    string_concat(S5,"Cuenta con ",S6),
    string_concat(S6,CantUsuariosStr,S7),
    string_concat(S7," usuarios, los cuales son:\n",S8),
    iterar_usuarios(Usuarios,"",StringUsuarios),
    string_concat(S8,StringUsuarios,S9),
    string_concat(S9,"\nCuenta con ",S10),
    string_concat(S10,CantPublicacionesStr,S11),
    string_concat(S11," publicaciones, las cuales son:\n",S12),
    iterar_publicaciones(Publicaciones,"",StringPublicaciones),
    string_concat(S12,StringPublicaciones,S13),
    Salida = S13,!.

socialNetworkToString(RSin,Salida):-
    getUsuarioOnline(RSin,UsuarioOnline),
    (UsuarioOnline>0),!,
    getUsuariosRedSocial(RSin,Usuarios),
    buscar_user_por_ID(Usuarios,UsuarioOnline),
    id_to_usuario(Usuarios,UsuarioOnline,User),
    getUsername(User,Username),
    getUserFecha(User,FechaCreacion),
    fecha_to_string(FechaCreacion,FechaStr),
    getUserFollowers(User,Followers),
    largo_lista(Followers,LargoFollowers),
    atom_concat(LargoFollowers,"",CantFollowers),
    getUserPosts(User,Posts),
    largo_lista(Posts,LargoPosts),
    atom_concat(LargoPosts,"",CantPublicaciones),
    iterar_publicaciones(Posts,"",PublicacionesString),
    string_concat("Nombre de usuario: ",Username,S1),
    string_concat(S1,"\nFecha de creacion de la cuenta: ",S2),
    string_concat(S2,FechaStr,S3),
    string_concat(S3,"\nTotal de followers: ",S4),
    string_concat(S4,CantFollowers,S5),
    string_concat(S5,"\nEl usuario tiene en total ",S6),
    string_concat(S6,CantPublicaciones,S7),
    string_concat(S7,", las cuales son:\n",S8),
    string_concat(S8,PublicacionesString,S9),
    S9 = Salida,!.


% Dominio: red social x fecha x integer x integer x string x red social
% Descripcion: Funcion que permite comentar una publicacion
% caso donde se comente en un comentario
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22),socialNetworkLogin(RedSocial22,"User2","Pass2",RedSocial23),socialNetworkComment(RedSocial23,F,4,6,"Gracias",RedSocial24).
socialNetworkComment(RSin,Fecha,IDPost,IDComment,Texto,RSout):-
    number(IDPost),
    number(IDComment),
    (IDPost>0),
    not(IDComment = 0),!,
    getNombreRedSocial(RSin,NombreRS),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    getPublicacionesRedSocial(RSin,Publicaciones),
    getUsuarioOnline(RSin,UsuarioOnline),
    % me aseguro que IDComment sea un comentario
    buscar_comentario(Publicaciones,IDComment),!,
    id_to_publicacion(Publicaciones,IDPost,PublicacionEncontrada),
    getPublicacionComments(PublicacionEncontrada,PublicacionEComments),
    buscarID(PublicacionEComments,IDComment),!,
    id_to_publicacion(Publicaciones,IDComment,ComentarioEncontrado),
    % creo el comentario
    id_counter(Publicaciones,IDNuevoComentario),
    crearPublicacion(IDNuevoComentario,Texto,[],[],Fecha,[],[],NuevoComentario),
    % borro la publicacion a comentar
    eliminar_por_ID(IDPost,Publicaciones,Publicaciones1),
    % Actualizo el comentario comentado, agregando el ID del comentario
    getPublicacionTexto(ComentarioEncontrado,ComentarioETexto),
    getPublicacionReacts(ComentarioEncontrado,ComentarioEReacts),
    getPublicacionComments(ComentarioEncontrado,ComentarioEComments),
    getPublicacionFecha(ComentarioEncontrado,ComentarioEFecha),
    getPublicacionTags(ComentarioEncontrado,ComentarioETags),
    getPublicacionShared(ComentarioEncontrado,ComentarioEShared),
    append(ComentarioEComments,[IDNuevoComentario],ComentarioNEComments),
    crearPublicacion(IDPost,ComentarioETexto,ComentarioEReacts,ComentarioNEComments,ComentarioEFecha,ComentarioETags,ComentarioEShared,ComentarioActualizado),
    append(Publicaciones1,[ComentarioActualizado],Publicaciones2),
    append(Publicaciones2,[NuevoComentario],Publicaciones3),
    crearRedSocial(NombreRS,FechaRS,Usuarios,Publicaciones3,0,RSout),!.

socialNetworkComment(RSin,Fecha,IDPost,IDComment,Texto,RSout):-
    number(IDPost),
    number(IDComment),
    (IDPost>0),
    (IDComment = 0),
    getNombreRedSocial(RSin,NombreRS),
    getFechaRedSocial(RSin,FechaRS),
    getUsuariosRedSocial(RSin,Usuarios),
    getPublicacionesRedSocial(RSin,Publicaciones),
    getUsuarioOnline(RSin,UsuarioOnline),
    % verifico si la publicacion existe y la retorno
    id_to_publicacion(Publicaciones,IDPost,PublicacionEncontrada),!,
    % creo el comentario
    id_counter(Publicaciones,IDNuevoComentario),
    crearPublicacion(IDNuevoComentario,Texto,[],[],Fecha,[],[],NuevoComentario),
    % Borro la publicacion comentada de la lista de publicaciones
    eliminar_por_ID(IDPost,Publicaciones,Publicaciones1),
    % Actualizo la publicacion con la ID del nuevo comentario
    getPublicacionTexto(PublicacionEncontrada,PublicacionETexto),
    getPublicacionReacts(PublicacionEncontrada,PublicacionEReacts),
    getPublicacionComments(PublicacionEncontrada,PublicacionEComments),
    getPublicacionFecha(PublicacionEncontrada,PublicacionEFecha),
    getPublicacionTags(PublicacionEncontrada,PublicacionETags),
    getPublicacionShared(PublicacionEncontrada,PublicacionEShared),
    append(PublicacionEComments,[IDNuevoComentario],PublicacionENComments),
    % creo la publicacion actualizada y la agrego a la lista de publicaciones
    crearPublicacion(IDPost,PublicacionETexto,PublicacionEReacts,PublicacionENComments,PublicacionEFecha,PublicacionETags,PublicacionEShared,PublicacionActualizada),
    append(Publicaciones1,[PublicacionActualizada],Publicaciones2),
    append(Publicaciones2,[NuevoComentario],Publicaciones3),
    id_to_usuario(Usuarios,UsuarioOnline,Autor),
    getUsername(Autor,Username),
    getPassword(Autor,Password),
    getUserFecha(Autor,AutorFecha),
    getUserFollowers(Autor,Followers),
    getUserPosts(Autor,AutorPosts),
    append(AutorPosts,[NuevoComentario],AutorPosts1),
    eliminar_por_ID(UsuarioOnline,Usuarios,Usuarios1),!,
    crearUsuario(UsuarioOnline,Username,Password,AutorFecha,Followers,AutorPosts1,NuevoAutor),
    append(Usuarios1,[NuevoAutor],Usuarios2),
    crearRedSocial(NombreRS,FechaRS,Usuarios2,Publicaciones3,0,RSout),!.

    

% Dominio: red social x fecha x integer x red social
% Descripcion: funcion que permite darle like a una publicacion o comentario
% PARA TENER EN CUENTA
% dentro de mi vision de la red social, un comentario hecho a una publicacion, es una nueva publicacion
% linkeada a la que se comentó, por lo que evité el uso de la entrada commentID, ya que no hay un TDA para los comentarios.
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22),socialNetworkLogin(RedSocial22,"User2","Pass2",RedSocial23),socialNetworkComment(RedSocial23,F,4,6,"Gracias",RedSocial24),socialNetworkLogin(RedSocial24,"User1","Pass1",RedSocial25),socialNetworkLike(RedSocial25,F,7,RedSocial26).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22),socialNetworkLogin(RedSocial22,"User2","Pass2",RedSocial23),socialNetworkComment(RedSocial23,F,4,6,"Gracias",RedSocial24),socialNetworkLogin(RedSocial24,"User1","Pass1",RedSocial25),socialNetworkLike(RedSocial25,F,5,RedSocial26).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22),socialNetworkLogin(RedSocial22,"User2","Pass2",RedSocial23),socialNetworkComment(RedSocial23,F,4,6,"Gracias",RedSocial24),socialNetworkLogin(RedSocial24,"User1","Pass1",RedSocial25),socialNetworkLike(RedSocial25,F,1,RedSocial26).
socialNetworkLike(RSin,Fecha,ID,RSout):-
    number(ID),
    is_list(Fecha),
    getNombreRedSocial(RSin,NombreRS),
    getFechaRedSocial(RSin,FechaRS),
    getUsuarioOnline(RSin,UsuarioOnline),
    getUsuariosRedSocial(RSin,Usuarios),
    (UsuarioOnline>0),!,
    buscar_user_por_ID(Usuarios,UsuarioOnline),
    getPublicacionesRedSocial(RSin,Publicaciones),
    id_to_publicacion(Publicaciones,ID,Publicacion),!,
    getPublicacionTexto(Publicacion,Texto),
    getPublicacionReacts(Publicacion,Reacts),
    getPublicacionComments(Publicacion,Comments),
    getPublicacionFecha(Publicacion,FechaP),
    getPublicacionTags(Publicacion,Tags),
    getPublicacionShared(Publicacion,Shared),
    append(Reacts,[UsuarioOnline],NewReacts),
    crearPublicacion(ID,Texto,NewReacts,Comments,FechaP,Tags,Shared,NewPost),
    eliminar_por_ID(ID,Publicaciones,NuevasPublicaciones),
    append(NuevasPublicaciones,[NewPost],PublicacionesFinal),
    crearRedSocial(NombreRS,FechaRS,Usuarios,PublicacionesFinal,0,RSout).

    
/*
 _____ _                      _           
|  ___(_)                    | |          
| |__  _  ___ _ __ ___  _ __ | | ___  ___ 
|  __|| |/ _ \ '_ ` _ \| '_ \| |/ _ \/ __|
| |___| |  __/ | | | | | |_) | | (_) \__ \
\____/| |\___|_| |_| |_| .__/|_|\___/|___/
     _/ |              | |                
    |__/               |_|                   
*/
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"UsuarioNuevo","Contrasena",RedSocial2).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"UsuarioDuplicado","Duplicado",RedSocial2),socialNetworkRegister(RedSocial2,F,"UsuarioDuplicado","Contrasena",RedSocial3).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"UsuarioNuevo","Contrasena",RedSocial2),socialNetworkLogin("RedSocial2,"UsuarioNuevo","Contrasena",Redsocial3).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"Noexiste","NoHayUsuario",RedSocial2),socialNetworkLogin(RedSocial2,"Intentar","Loggear",RedSocial3).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkLogin(RedSocial3,F,"User2","Pass2",RedSocial4).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkLogin(RedSocial3,F,"User2","Pass2",RedSocial4),socialNetworkPost(RedSocial4,F,"Mi primer post",[],RedSocial5).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No etiquetar a gente que no me sigue",["User1"],RedSocial8).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,3,[],RedSocial18).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkToString(RedSocial8,String).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkToString(RedSocial19,String).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22),socialNetworkLogin(RedSocial22,"User2","Pass2",RedSocial23),socialNetworkComment(RedSocial23,F,4,6,"Gracias",RedSocial24).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22),socialNetworkLogin(RedSocial22,"User2","Pass2",RedSocial23),socialNetworkComment(RedSocial23,F,4,6,"Gracias",RedSocial24),socialNetworkLogin(RedSocial24,"User1","Pass1",RedSocial25),socialNetworkLike(RedSocial25,F,7,RedSocial26).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22),socialNetworkLogin(RedSocial22,"User2","Pass2",RedSocial23),socialNetworkComment(RedSocial23,F,4,6,"Gracias",RedSocial24),socialNetworkLogin(RedSocial24,"User1","Pass1",RedSocial25),socialNetworkLike(RedSocial25,F,5,RedSocial26).
% fecha(20,11,2021,F),crearRS("Twitter",F,RedSocial1),socialNetworkRegister(RedSocial1,F,"User1","Pass1",RedSocial2),socialNetworkRegister(RedSocial2,F,"User2","Pass2",RedSocial3),socialNetworkRegister(RedSocial3,F,"User3","Pass3",RedSocial4),socialNetworkLogin(RedSocial4,"User2","Pass2",RedSocial5),socialNetworkPost(RedSocial5,F,"Mi primer post",[],RedSocial6),socialNetworkLogin(RedSocial6,"User3","Pass3",RedSocial7),socialNetworkPost(RedSocial7,F,"No puedo etiquetar a nadie",[],RedSocial8),socialNetworkLogin(RedSocial8,"User2","Pass2",RedSocial9),socialNetworkFollow(RedSocial9,"User1",RedSocial10),socialNetworkLogin(RedSocial10,"User3","Pass3",RedSocial11),socialNetworkFollow(RedSocial11,"User1",RedSocial12),socialNetworkLogin(RedSocial12,"User1","Pass1",RedSocial13),socialNetworkFollow(RedSocial13,"User2",RedSocial14),socialNetworkLogin(RedSocial14,"User1","Pass1",RedSocial15),socialNetworkShare(RedSocial15,F,2,["User3"],RedSocial16),socialNetworkLogin(RedSocial16,"User1","Pass1",RedSocial17),socialNetworkShare(RedSocial17,F,1,[],RedSocial18),socialNetworkLogin(RedSocial18,"User1","Pass1",RedSocial19),socialNetworkComment(RedSocial19,F,4,0,"Felicidades",RedSocial20),socialNetworkLogin(RedSocial20,"User3","Pass3",RedSocial21),socialNetworkComment(RedSocial21,F,4,5,"Bienvenido a la la red social",RedSocial22),socialNetworkLogin(RedSocial22,"User2","Pass2",RedSocial23),socialNetworkComment(RedSocial23,F,4,6,"Gracias",RedSocial24),socialNetworkLogin(RedSocial24,"User1","Pass1",RedSocial25),socialNetworkLike(RedSocial25,F,1,RedSocial26).
