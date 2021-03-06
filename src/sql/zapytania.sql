/* 1.	Przeszukiwanie postu w podkategorii fauna. Dodatkowo użytkownik życzy sobie posortować wyniki wyszukiwania po liczbie polubień. */
	SELECT * 
	FROM post 
	JOIN kategoria_postu 
		  ON ID_post=PostID_post 
	ORDER BY Liczba_polubien DESC;

/* 2.	Przeszukiwanie użytkowników względem liczby napisanych postów posortowanych malejąco. */
	SELECT count(*) as ilosc_postow, login, mail 
	FROM `post` 
	JOIN uzytkownik 
		    ON Autor = Login 
	GROUP BY Login 
	ORDER BY ilosc_postow DESC;

/* 3.	Wyświetlenie wszystkich profili osób pochodzących z Krakowa, posorotowanych względem daty urodzin. */
	SELECT * 
	FROM `profil` 
	WHERE Lokalizacja = 'Krakow'
	ORDER BY Urodziny;

/* 4.	Wyświetlenie komentarzy dla postu z największą liczbą nielubień. */
	SELECT * 
	FROM `post` 
	JOIN komentarz 
		    ON PostId_post = ID_post 
	WHERE Liczba_nielubien = (SELECT max(Liczba_nielubien) FROM `post`);

/* 5.	Posortowanie podkategorii postu względem ilości wstawionych postów. */
	SELECT count(*),Nazwa_podkategorii 
	FROM `podkategoria` 
	LEFT JOIN `kategoria_postu` 
		 ON ID_podkategoria = PodkategoriaID_podkategoria  
		 	JOIN post 
				ON PostId_post = ID_post 
	GROUP BY Nazwa_podkategorii;

/* 6.	Wyświetlenie wszystkich postów w podkategorii nauki ścisłe (albo innej) względem daty dodania. */
	SELECT * 
	FROM post 
	JOIN kategoria_postu 
		  ON ID_post=PostID_post 
	WHERE PodkategoriaID_podkategoria = 171;

/* 7.	Wyświetlenie postów użytkownika Jan Kowalski. */
	SELECT * FROM post 
	JOIN profil 
		  ON Autor=Login 
	WHERE imie="Jan" && nazwisko="Kowalski";

/* 8.	Wyświetlenie komentarzy napisanych przez Jana Kowalskiego. */
	SELECT * 
	FROM komentarz 
	JOIN profil 
		  ON Autor_komentarza=Login 
	WHERE imie="Jan" && nazwisko="Kowalski";
	
/* 9.  Wyświetlenie profilu i preferowanych kategorii użytkownika o loginie mkoperek. */
	SELECT Login, Imie, Nazwisko, Plec, Lokalizacja, Urodziny, Zainteresowania, Cele, Opis, Wybrana_kategoria
	FROM preferencje_uzytkownika
    	FULL JOIN profil 
		  ON Login='mkoperek'
	WHERE Wlasciciel='mkoperek';
	
/* 10. Wyświetlenie wszystkich postów zawierających w tytule słowo "sukienki", posortowanych według daty ostatniej modyfikacji. */
	SELECT *
	FROM post
	WHERE Tytul LIKE '%sukienki%'
	ORDER BY Data_ostatniej_modyfikacji;
	
/* 11. Aktualizowanie profilu zalogowanego użytkownika zbigniewduda */
	UPDATE profil 
	SET Zainteresowania='Sport na swiezym powietrzu', Cele='Poprzedni cel zdobyty, kolejny to zdobyc Mount Everest', Opis='Pozytywnie zakrecony', Lokalizacja='Olsztyn' 
	WHERE Login='zbigniewduda';
	
/* 12. Wyświetlenie danych zalogowanego użytkownika nowakanna. */
	SELECT Login,Mail,Data_utworzenia_konta 
	FROM uzytkownik 
	WHERE Login='nowakanna';
	
/* 13.  Użytkownik ma możliwość zarejestrowania się. */
	INSERT INTO `uzytkownik` (`Login`, `Mail`, `Haslo`, `Data_utworzenia_konta`) 
		VALUES('Karen2035', 'dyrda.karina@gmail.com', 'eloelo320', '2020-06-02');
	INSERT INTO `profil` (`Login`, `Plec`, `Lokalizacja`, `Urodziny`, `Imie`, `Nazwisko`) 
		VALUES ('Karen2035', 'Kobieta', 'Krakow', '1999-01-02', 'Karina', 'Dyrda');

/* 14. Użytkownik ma mozliwość wyswietlenia wszystkich istniejących kategorii według nazwy kategorii w odwróconej kolejności alfabetycznej. */
	SELECT Nazwa_kategorii 
	FROM kategoria
	ORDER BY Nazwa_kategorii DESC;

/* 15. 	Użytkownik ma mozliwość wyświetlenia wszystkich istniejących podkategorii dla wybranej kategorii (np. dla kategorii moda). */
	SELECT ID_podkategoria,Nazwa_podkategorii 
	FROM podkategoria 
	WHERE Kategoria_glowna='Moda';
	
/* 16. Użytkownik ma możliowsc wyświetlania wszystkich napisanych postów posortowanych alfabetycznie według loginu autora. */
	SELECT ID_post,Autor,Tytul,Data_dodania,Data_ostatniej_modyfikacji,Tresc, Liczba_polubien,Liczba_nielubien 
	FROM post 
	ORDER BY Autor;
	
/* 17.  Użytkownik ma mozliwość wstawienia swojego własnego posta. */
	INSERT INTO post(Tytul,Data_dodania,Data_ostatniej_modyfikacji,Tresc,Autor)
		VALUES('Moj pierwszy post', CURDATE(), CURDATE(), 'Witam witam', 'mkoperek');
	
/* 18. Użytkownik może stworzyć profil związany ze swoim kontem. */
	INSERT INTO `profil` (`Login`,`Imie`,`Nazwisko`,`Urodziny`,`Plec`) 
		VALUES('Whitiee', 'Julia', 'Fajer', '1999-10-20', 'Kobieta');
	
/* 19. Polubienie postu (funkcjonalność bierze ID postu, który aktualnie przegląda użytkownik) gdzie ID przeglądanego postu wynosi 6 . */
	UPDATE post 
	SET Liczba_polubien = Liczba_polubien + 1 
	WHERE ID_post='6';

/* 20. Dodanie komentarza o treści "Witam" przez zalogowanego użytkownika jankowalski do aktualnie wyświetlanego postu 
	(data generowana automatycznie, użytkownik aktualnie przegląda post o ID = 6). */
	INSERT INTO komentarz(Data_dodania,Tresc_komentarza,PostID_post,Autor_komentarza) 
		VALUES(CURDATE(),'Witam','6','jankowalski');
