﻿implement main
    open core, stdio, file

domains
    themes = спорт; готовка; финансы; мода.

class facts - editionDbase
    sub : (integer IDs, string Name, integer Age, string Adress).
    edition : (integer IDe, string NameE, integer Price).
    subscribition : (integer IDe, integer IDs, string When, integer Time).
    edition_theme : (integer IDe, themes Theme).

class facts
    smm : (integer Summa) single.

clauses
    smm(0).

class predicates
    /*budget_summary : () failure anyflow.*/
    subs : (integer IDe, integer IDs, string Name, integer Age, string Adress) nondeterm anyflow.
    edition_themes : (integer IDe, themes Theme, string Name) nondeterm anyflow.
    edition_discount : (integer IDe, string NameE, integer Price, real DiscountPrice) nondeterm anyflow.

clauses
    /* Кто является подписчиком издания*/
    subs(IDe, IDs, Name, Age, Adress) :-
        subscribition(IDe, IDs, _, _),
        sub(IDs, Name, Age, Adress).

    /* Какая тема у изданий/ Поиск всех изданий заданной темы*/
    edition_themes(IDe, Theme, Name) :-
        edition(IDe, Name, _),
        edition_theme(IDe, Theme).

    /* Скидка полцены*/
    edition_discount(IDe, NameE, Price, DiscountPrice) :-
        edition(IDe, NameE, Price),
        DiscountPrice = Price / 2.

clauses
    run() :-
        console::init(),
        reconsult("../db.txt", editionDbase),
        fail.
    run() :-
        stdio::write(" \n"), /* разделения */
        fail.
    run() :-
        edition_discount(IDe, NameE, Price, DiscountPrice),
        stdio::write("Старая цена ", NameE, ": ", Price, ". Цена после скидки: ", DiscountPrice, "\n"),
        fail.

    run() :-
        stdio::write(" \n"), /* разделения */
        fail.
    run() :-
        subs(IDe, IDs, Name, Age, _Adress),
        stdio::write("Подписчик издания, ID которого:  ", IDe, " ID: ", Name, ", его возраст: ", Age, "\n"),
        fail.
    run() :-
        stdio::write(" \n"), /* разделения */
        fail.
    run() :-
        edition_themes(IDe, Theme, Name),
        stdio::write("Тема издания ", Name, ": ", Theme, "\n"),
        fail.
    run() :-
        stdio::write(" \n"), /* разделения */
        fail.
    run() :-
        stdio::write("Программа завершена! Успех!\n").

end implement main

goal
    console::runUtf8(main::run).
