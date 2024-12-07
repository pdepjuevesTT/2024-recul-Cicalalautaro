%*Nombre: Lautaro Cicala
%*Curso: Jueves a la mañana
%*Profesores: Lucas , Alf

%* 1) Hablar con propiedad

vive(juan , casa(120) , almagro).
vive(fer , casa(110) , flores).


vive(nico , depto(3 , 2)  , almagro).
vive(alf , depto(3 , 1) , almagro).
vive(vale , depto(4 , 1) , flores).


vive(julian , loft(2000) , almagro).


%* 2) Barrio copado, infierno chico

esCopada(casa(MetrosCuadrados)):- MetrosCuadrados > 100.
esCopada(depto(CantAmbientes , _)):- CantAmbientes > 3.
esCopada(depto(_ ,CantBanios)):- CantBanios > 1.
esCopada(loft(Anio)):- Anio > 2015.


%predicado principal
esCopado(Barrio):-
  vive(_ , _  , Barrio),
  forall(vive(_ , Propiedad  , Barrio) , esCopada(Propiedad)).


%%* 3) Barrio(caro) tal vez

%%todo esBarata(propiedad).
esBarata(loft(Anio)):- Anio < 2005.
esBarata(casa(MetrosCuadrados)):- MetrosCuadrados < 90.
esBarata(depto(CantAmbientes , _)):- CantAmbientes < 3. 

%!este ultimo predicado se podria definir como:
%! esBarata(depto(CantAmbientes , _)):- not(esCopada(depto(CantAmbientes , _))).
%! pero es mas declarativo de la otra forma.


%predicado principal (misma logica que el anterior predicado principal)
esCaro(Barrio):-
    vive(_ , _  , Barrio),
    forall(vive(_ , Propiedad  , Barrio) , not(esBarata(Propiedad))).


%* 4) Tasa Tasa , tasacion de la casa.

%%todo tasacion(Nombre de la Propiedad , valor).
tasacion(propiedadDeJuan , 150000).
tasacion(propiedadDeNico  , 80000).
tasacion(propiedadDeAlf  , 75000).
tasacion(propiedadDeJulian  , 140000).
tasacion(vapropiedadDeVale , 95000).
tasacion(propiedadDeFer , 60000). 


%predicado principal
queSePuedeComprar(PlataDisp , ListaFinal , PlataRestante):-
    propiedadesEnVenta(ListaDePropiedades),
    sublista(ListaDePropiedades , PosibleSublista),
    listaDePrecios(PosibleSublista , Precios),
    sum_list(Precios , PrecioFinal),
    puedePagarYPaga(PrecioFinal ,PlataDisp , PlataRestante),
    listaFinal(Precios, ListaFinal).

%*auxiliares (punto 4) --------------------------------------------------------------------------------------------

propiedadesEnVenta(ListaDePropiedades):-  findall(Propiedad , tasacion(Propiedad , _) , ListaDePropiedades).


listaDePrecios(PosibleSublista , ListaPrecios):- 
    findall(Precio, (tasacion(Nombre , Precio) , member(Nombre , PosibleSublista )) , ListaPrecios).


puedePagarYPaga(Valor , PlataDisp , PlataRestante):-
    Valor < PlataDisp,
    PlataRestante is PlataDisp - Valor.

listaFinal(X , ListaFinal):- findall(Nombre , (tasacion(Nombre, Precio) , member(Precio , X)), ListaFinal).

%TIP
sublista([] , []).
sublista([_|Cola] , Sublista):- sublista(Cola , Sublista).
sublista([Cabeza|Cola] , [Cabeza | Sublista]):- sublista(Cola , Sublista).

%*auxiliares (punto 4) --------------------------------------------------------------------------------------------




