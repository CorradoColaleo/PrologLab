% Definizione del vocabolario italiano-inglese
traduci(italiano, io, inglese, i).
traduci(italiano, tu, inglese, you).
traduci(italiano, mangio, inglese, eat).
traduci(italiano, bevi, inglese, drink).
traduci(italiano, una, inglese, a).
traduci(italiano, un, inglese, a).
traduci(italiano, mela, inglese, apple).
traduci(italiano, banana, inglese, banana).
traduci(italiano, libro, inglese, book).
traduci(italiano, leggo, inglese, read).
traduci(italiano, scrivi, inglese, write).
traduci(italiano, caffè, inglese, coffee).

% Frasi di esempio
frase(italiano, [io, mangio, una, mela]).
frase(italiano, [tu, bevi, un, caffè]).
frase(italiano, [io, leggo, un, libro]).
frase(italiano, [tu, scrivi, un, libro]).

% Predicato principale per tradurre una frase
traduci_frase(Origine, Frase, Destinazione, Traduzione) :-
    frase(Origine, Frase),
    traduci_frase_ricorsiva(Origine,Frase, Destinazione, Traduzione).

traduci_frase_ricorsiva(_Origine,[], _, []).
traduci_frase_ricorsiva(Origine,[ParolaOrigine | RestoOrigine], Destinazione, [ParolaTradotta | RestoTraduzione]) :-
    traduci(Origine, ParolaOrigine, Destinazione, ParolaTradotta),
    traduci_frase_ricorsiva(Origine,RestoOrigine, Destinazione, RestoTraduzione).


% Esempio di utilizzo:
% ?- traduci_frase(italiano, [io, mangio, una, mela], inglese, Traduzione).
% Traduzione = [i, eat, an, apple].

% Esempio di utilizzo:
% ?- traduci_frase(italiano, [tu, bevi, un, caffè], inglese, Traduzione).
% Traduzione = [you, drink, a, coffee].

% Esempio di utilizzo:
% ?- traduci_frase(italiano, [io, leggo, un, libro], inglese, Traduzione).
% Traduzione = [i, read, a, book].

% Esempio di utilizzo:
% ?- traduci_frase(italiano, [tu, scrivi, un, libro], inglese, Traduzione).
% Traduzione = [you, write, a, book].
