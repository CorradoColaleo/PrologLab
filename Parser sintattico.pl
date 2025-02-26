% Articoli
articolo(il).
articolo(la).
articolo(lo).
articolo(i).
articolo(gli).
articolo(le).

% Nomi
nome(ragazzo).
nome(ragazza).
nome(libro).
nome(cane).
nome(gatto).
nome(penna).

% Aggettivi
aggettivo(grande).
aggettivo(piccolo).
aggettivo(rosso).
aggettivo(veloce).

% Verbi
verbo(corre).
verbo(mangia).
verbo(legge).
verbo(scrive).


% Frase (S) -> Sintagma Nominale (NP) + Sintagma Verbale (VP)
frase(S) :- sintagma_nominale(NP), sintagma_verbale(VP), append(NP, VP, S).

% Sintagma Nominale (NP) -> Articolo (D) + Nome (N) + [Aggettivo (Adj)]
sintagma_nominale(NP) :- articolo(D), nome(N), aggettivo(Adj), NP = [D, N, Adj].
sintagma_nominale(NP) :- articolo(D), nome(N), NP = [D, N].

% Sintagma Verbale (VP) -> Verbo (V) + [Sintagma Nominale (NP)]
sintagma_verbale(VP) :- verbo(V), sintagma_nominale(NP), VP = [V | NP].
sintagma_verbale(VP) :- verbo(V), VP = [V].

% Verifica se una frase è corretta
verifica_frase(Frase) :-
    frase(Frase),
    write('Frase corretta!'), nl.

verifica_frase(_) :-
    write('Frase non corretta.'), nl.

%Query per testing...

%verifica_frase([il, ragazzo, corre]). 

%verifica_frase([la, ragazza, grande, legge, il, libro]).

%verifica_frase([il, cane, veloce, mangia, la, penna]).

%verifica_frase([il,cane,mangia,corre]).

%verifica_frase([ragazzo,mangia]).
