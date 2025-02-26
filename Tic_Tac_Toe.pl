% Predicati che definiscono le condizioni di vittoria:

vittoria(Tavola, Giocatore) :- vittoria_riga(Tavola, Giocatore).
vittoria(Tavola, Giocatore) :- vittoria_colonna(Tavola, Giocatore).
vittoria(Tavola, Giocatore) :- vittoria_diagonale(Tavola, Giocatore).

vittoria_riga([G,G,G,_,_,_,_,_,_], G).
vittoria_riga([_,_,_,G,G,G,_,_,_], G).
vittoria_riga([_,_,_,_,_,_,G,G,G], G).

vittoria_colonna([G,_,_,G,_,_,G,_,_], G).
vittoria_colonna([_,G,_,_,G,_,_,G,_], G).
vittoria_colonna([_,_,G,_,_,G,_,_,G], G).

vittoria_diagonale([G,_,_,_,G,_,_,_,G], G).
vittoria_diagonale([_,_,G,_,G,_,G,_,_], G).

% Predicato per alternare i giocatori:

giocatore_opposto(x, o).
giocatore_opposto(o, x).

% Predicato per visualizzare la tavola:

mostra_tavola([A,B,C,D,E,F,G,H,I]) :-
  format('~w ~w ~w~n~w ~w ~w~n~w ~w ~w~n~n', [A,B,C,D,E,F,G,H,I]).
%Ho utilizzato questo format che andrà a sostituire a w le lettere scritte
%a destra. 
%n invece rappresenta una newline

% Predicato per eseguire una mossa:

effettua_mossa([b|Coda], Giocatore, [Giocatore|Coda]).
%Questo è il caso che si attiva quando il primo elemento è vuoto.
%A questo punto, il primo elemento viene sostituito con il simbolo
%del giocatore

effettua_mossa([Testa|Coda], Giocatore, [Testa|NuovaCoda]) :-
  effettua_mossa(Coda, Giocatore, NuovaCoda).
%Questo è il caso ricorsivo. Si attiva, a differenza di quello base,
%quando il primo elemento della lista non è vuoto. L'output risultante
%sarà una nuova tabella con il primo elemento rimasto invariato, e la 
%restante parte della lista aggiornata con la mossa dal giocatore

% Predicati per giocare una partita automatica:

partita_automatica :-
  inizia_partita([b,b,b,b,b,b,b,b,b], x).

inizia_partita(Tavola, Giocatore) :-
  mostra_tavola(Tavola),
  continua_partita(Tavola, Giocatore).

continua_partita(Tavola, Giocatore) :-
  vittoria(Tavola, Giocatore), !,
  format('Giocatore ~w vince!~n', [Giocatore]).
%Questo è il caso base, che si attiva quando il giocatore ha vinto
%la partita. Il cut mi serve per dire che se il giocatore ha vinto,
%non mi serve esplorare nient'altro.


continua_partita(Tavola, Giocatore) :-
  giocatore_opposto(Giocatore, AltroGiocatore),
  (   mossa_valida(Tavola, Giocatore, NuovaTavola)
  ->  mostra_tavola(NuovaTavola),
      continua_partita(NuovaTavola, AltroGiocatore)
  ;   format('Pareggio!~n')
  ).

%Se non rientro nel caso base (il giocatore non ha vinto), allora
%devo dare la possibilità all'altro giocatore di fare la sua mossa.
%A questo punto l'avversario effettua la sua mossa e ne sarà
%controllata la validità. 
%-> Indica che se la mossa è valida, allora potrà essere eseguito il
%resto. In particolare, sarà mostrata la tabella e continuerà la partita
%; sta a indicare un "else", dunque, nel caso in cui la mossa non è valida,
%va in pareggio.


mossa_valida(Tavola, Giocatore, NuovaTavola) :-
  effettua_mossa(Tavola, Giocatore, NuovaTavola),
  \+ vittoria(NuovaTavola, Giocatore), !.

%In questo caso sarà effettuata una mossa. 
%L'operatore \+ indica una negazione, dunque, in questo caso, controllo
%che la mossa non porti alla vittoria del giocatore stesso

mossa_valida(Tavola, Giocatore, NuovaTavola) :-
  mossa_qualsiasi(Tavola, Giocatore, NuovaTavola).

%Questo predicato viene chiamato se quelo precedente fallisce. Dunque,
%se quella mossa non porta alla vittoria, viene effettivamente fatta.

mossa_qualsiasi([b|Coda], Giocatore, [Giocatore|Coda]).

mossa_qualsiasi([Testa|Coda], Giocatore, [Testa|NuovaCoda]) :-
  mossa_qualsiasi(Coda, Giocatore, NuovaCoda).

% Predicati per giocare una partita con l'utente:

gioca_con_utente :- spiegazione, avvia_gioco([b,b,b,b,b,b,b,b,b]).

spiegazione :-
  write('Giochi con X inserendo le posizioni intere seguite da un punto.'),
  nl,
  mostra_tavola([1,2,3,4,5,6,7,8,9]).

avvia_gioco(Tavola) :- mostra_tavola(Tavola), turno_utente(Tavola).

turno_utente(Tavola) :-
  vittoria(Tavola, x), !, write('Hai vinto!').
turno_utente(Tavola) :-
  vittoria(Tavola, o), !, write('Ho vinto!').
turno_utente(Tavola) :-
  read(Posizione),
  aggiorna_tavola(Tavola, Posizione, x, NuovaTavola),
  mostra_tavola(NuovaTavola),
  turno_computer(NuovaTavola).

turno_computer(Tavola) :-
  mossa_computer(Tavola, NuovaTavola),
  mostra_tavola(NuovaTavola),
  turno_utente(NuovaTavola).

mossa_computer(Tavola, NuovaTavola) :-
  mossa_qualsiasi(Tavola, o, NuovaTavola),
  \+ x_puo_vincere(NuovaTavola), !.
mossa_computer(Tavola, NuovaTavola) :-
  mossa_qualsiasi(Tavola, o, NuovaTavola).

x_puo_vincere(Tavola) :-
  effettua_mossa(Tavola, x, NuovaTavola),
  vittoria(NuovaTavola, x).

aggiorna_tavola([b|Coda], 1, x, [x|Coda]).
aggiorna_tavola([Testa|Coda], Posizione, x, [Testa|NuovaCoda]) :-
  Posizione > 1,
  NuovaPosizione is Posizione - 1,
  aggiorna_tavola(Coda, NuovaPosizione, x, NuovaCoda).
aggiorna_tavola(Tavola, _, x, Tavola) :- write('Mossa non valida.'), nl.
