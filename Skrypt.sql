--Tworzenie Bazy Danych
IF DB_ID('Serwis Naprawczy') IS NULL
	CREATE DATABASE [Serwis naprawczy]

GO
USE [Serwis naprawczy];
--Usuńmy wszystkie tabele, procedury, funkcje itd.

--Tabele
IF OBJECT_ID('Reklamacje', 'U')				  IS NOT NULL DROP TABLE Reklamacje
IF OBJECT_ID('Czesci uzyte do zlecenia', 'U') IS NOT NULL DROP TABLE [Czesci uzyte do zlecenia]
IF OBJECT_ID('Przebieg Zlecen', 'U')		  IS NOT NULL DROP TABLE [Przebieg Zlecen]
IF OBJECT_ID('Zlecenia', 'U')				  IS NOT NULL DROP TABLE Zlecenia
IF OBJECT_ID('Gwarancje', 'U')				  IS NOT NULL DROP TABLE Gwarancje
IF OBJECT_ID('Typ gwarancji', 'U')			  IS NOT NULL DROP TABLE [Typ gwarancji]
IF OBJECT_ID('Szczegoly zamowien', 'U')		  IS NOT NULL DROP TABLE [Szczegoly zamowien]
IF OBJECT_ID('Zamowienia', 'U')				  IS NOT NULL DROP TABLE Zamowienia
IF OBJECT_ID('Stan magazynowy czesci', 'U')   IS NOT NULL DROP TABLE [Stan magazynowy czesci]
IF OBJECT_ID('Czesci do naprawy', 'U')        IS NOT NULL DROP TABLE [Czesci do naprawy]
IF OBJECT_ID('Produkty do naprawy', 'U')      IS NOT NULL DROP TABLE [Produkty do naprawy]
IF OBJECT_ID('Kategorie', 'U')				  IS NOT NULL DROP TABLE Kategorie
IF OBJECT_ID('Hurtownie', 'U')				  IS NOT NULL DROP TABLE Hurtownie
IF OBJECT_ID('Urlopy', 'U')					  IS NOT NULL DROP TABLE Urlopy
IF OBJECT_ID('Pracownicy', 'U')               IS NOT NULL DROP TABLE Pracownicy
IF OBJECT_ID('Klienci', 'U')				  IS NOT NULL DROP TABLE Klienci
IF OBJECT_ID('Placowki', 'U')				  IS NOT NULL DROP TABLE Placowki
IF OBJECT_ID('Osoby', 'U')					  IS NOT NULL DROP TABLE Osoby
IF OBJECT_ID('Rabaty', 'U')					  IS NOT NULL DROP TABLE Rabaty

--Procedury
IF OBJECT_ID ('Insert_or_update', 'P')			 IS NOT NULL DROP PROCEDURE Insert_or_update
IF OBJECT_ID ( 'Bledy', 'P' )					 IS NOT NULL DROP PROCEDURE Bledy
IF OBJECT_ID ('Zysk_z_dnia', 'P')				 IS NOT NULL DROP PROCEDURE Zysk_z_dnia
IF OBJECT_ID ('Znajdz_produkt', 'FN')			 IS NOT NULL DROP FUNCTION Znajdz_produkt
IF OBJECT_ID ('Nowy_produkt', 'P')				 IS NOT NULL DROP PROCEDURE Nowy_produkt
IF OBJECT_ID ('Nowe_zlecenie', 'P')				 IS NOT NULL DROP PROCEDURE Nowe_zlecenie
IF OBJECT_ID ('Nowa_reklamacja', 'P')			 IS NOT NULL DROP PROCEDURE Nowa_reklamacja
IF OBJECT_ID ('Transfer_miedzy_placowkami', 'P') IS NOT NULL DROP PROCEDURE Transfer_miedzy_placowkami
IF OBJECT_ID ('Zamawianie', 'P')				 IS NOT NULL DROP PROCEDURE Zamawianie
IF OBJECT_ID ('Nowa_gwarancja', 'P')			 IS NOT NULL DROP PROCEDURE Nowa_gwarancja
IF OBJECT_ID ('Nowe_zlecenie_gwarancyjne', 'P')  IS NOT NULL DROP PROCEDURE Nowe_zlecenie_gwarancyjne
IF OBJECT_ID ('WstawAlboEdytujOsoby', 'P')		 IS NOT NULL DROP PROCEDURE WstawAlboEdytujOsoby
IF OBJECT_ID ('UsunOsoby', 'P')					 IS NOT NULL DROP PROCEDURE UsunOsoby

--Funkcje i widoki
IF OBJECT_ID ('Informacje_o_zamowieniu', 'IF')				 IS NOT NULL DROP FUNCTION Informacje_o_zamowieniu
IF OBJECT_ID ('Pracownicy_na_urlopie', 'V')                  IS NOT NULL DROP VIEW Pracownicy_na_urlopie
IF OBJECT_ID ('Aktualnie_zatrudnieni_pracownicy', 'V')		 IS NOT NULL DROP VIEW Aktualnie_zatrudnieni_pracownicy
IF OBJECT_ID ('Gwarancje_Klienta', 'IF')					 IS NOT NULL DROP FUNCTION Gwarancje_Klienta
IF OBJECT_ID ('Zlecenia_dla_kategorii', 'IF')                IS NOT NULL DROP FUNCTION Zlecenia_dla_kategorii
IF OBJECT_ID ('Czesci_ze_wszystkich_placowek', 'V')			 IS NOT NULL DROP VIEW Czesci_ze_wszystkich_placowek
IF OBJECT_ID ('Aktualne_rabaty', 'V')						 IS NOT NULL DROP VIEW Aktualne_rabaty
IF OBJECT_ID ('Przychody_miesieczne', 'V')					 IS NOT NULL DROP VIEW Przychody_miesieczne
IF OBJECT_ID ('Calkowity_koszt_zamowienia', 'FN')            IS NOT NULL DROP FUNCTION Calkowity_koszt_zamowienia
IF OBJECT_ID ('Wydatki_miesieczne', 'V')					 IS NOT NULL DROP VIEW Wydatki_miesieczne
IF OBJECT_ID ('Niezrealizowane_zlecenia', 'V')               IS NOT NULL DROP VIEW Niezrealizowane_zlecenia
IF OBJECT_ID ('Przebieg_zlecenia', 'IF')					 IS NOT NULL DROP FUNCTION Przebieg_zlecenia
IF OBJECT_ID ('Zlecenia_realizowane_przez_pracownika', 'IF') IS NOT NULL DROP FUNCTION Zlecenia_realizowane_przez_pracownika
IF OBJECT_ID ('Pracownicy_zarabiajacy_mniej_niz', 'IF')		 IS NOT NULL DROP FUNCTION Pracownicy_zarabiajacy_mniej_niz

--Wyzwalacze
IF OBJECT_ID ('Przenies_czesci', 'TR')												IS NOT NULL DROP TRIGGER Przenies_czesci
IF OBJECT_ID ('Blokada_aktualizacji_zlecen', 'TR')									IS NOT NULL DROP TRIGGER Blokada_aktualizacji_zlecen
IF OBJECT_ID ('Stworz_klienta', 'TR')												IS NOT NULL DROP TRIGGER Stworz_klienta
IF OBJECT_ID ('Przeslij_czesci_po_zakonczeniu_zamowienia', 'TR')					IS NOT NULL DROP TRIGGER Przeslij_czesci_po_zakonczeniu_zamowienia
IF OBJECT_ID ('Blokada_zwolnienia_pracownika_z_niezrealizowanymi_zleceniami', 'TR') IS NOT NULL DROP TRIGGER Blokada_zwolnienia_pracownika_z_niezrealizowanymi_zleceniami

--Typ własny
IF TYPE_ID('Czesci') IS NOT NULL DROP TYPE Czesci


--Tworzenie tabel


CREATE TABLE rabaty 
  ( 
     id_rabatu           INT PRIMARY KEY IDENTITY(1, 1), 
     nazwa               NVARCHAR(50) NOT NULL UNIQUE, 
     [procent znizki]    REAL NOT NULL, 
     [data wprowadzenia] DATE NOT NULL, 
     [data wygasniecia]  DATE 
  ) 

CREATE TABLE osoby 
  ( 
     id_osoby           INT PRIMARY KEY IDENTITY(1, 1), 
     imie               NVARCHAR(50) NOT NULL, 
     nazwisko           NVARCHAR(50) NOT NULL, 
     plec               CHAR(1) NOT NULL, 
     adres              NVARCHAR(60), 
     [numer kontaktowy] VARCHAR(24), 
     [e-mail]           NVARCHAR(60), 
     --Ograniczenie znaku płci 
     CONSTRAINT [Znak plci] CHECK(plec IN ('M', 'K')) 
  ) 

CREATE TABLE placowki 
  ( 
     id_placowki        INT PRIMARY KEY IDENTITY(1, 1), 
     adres              NVARCHAR(60) NOT NULL UNIQUE, 
     [numer kontaktowy] VARCHAR(24) 
  ) 

CREATE TABLE pracownicy 
  ( 
     id_pracownika                  INT PRIMARY KEY, 
     id_placowki                    INT NOT NULL, 
     pesel                          CHAR(11) NOT NULL UNIQUE, 
     zarobki                        INT NOT NULL CHECK(zarobki >= 0), 
     [data zatrudnienia]            DATE NOT NULL, 
     [przewidywana data zwolnienia] DATE, 
     [data zwolnienia]              DATE, 
     FOREIGN KEY (id_pracownika) REFERENCES osoby(id_osoby), 
     FOREIGN KEY (id_placowki) REFERENCES placowki(id_placowki) ON DELETE 
     CASCADE 
  ) 

CREATE TABLE klienci 
  ( 
     id_klienta         INT PRIMARY KEY, 
     rabat_indywidualny INT, 
     data_rejestracji   DATE NOT NULL, 
     FOREIGN KEY(id_klienta) REFERENCES osoby(id_osoby) ON DELETE CASCADE, 
     FOREIGN KEY(rabat_indywidualny) REFERENCES rabaty(id_rabatu) ON DELETE SET 
     NULL 
  ) 

CREATE TABLE urlopy 
  ( 
     id_pracownika INT, 
     od_kiedy      DATE NOT NULL, 
     do_kiedy      DATE NOT NULL, 
     PRIMARY KEY(id_pracownika, od_kiedy), 
     FOREIGN KEY (id_pracownika) REFERENCES pracownicy(id_pracownika) ON DELETE 
     CASCADE 
  ) 

CREATE TABLE hurtownie 
  ( 
     id_hurtowni        INT PRIMARY KEY IDENTITY(1, 1), 
     nazwa              NVARCHAR(30) NOT NULL UNIQUE, 
     adres              NVARCHAR(60) NOT NULL UNIQUE, 
     [numer kontaktowy] NVARCHAR(24), 
     [opis]             NVARCHAR(255) 
  ) 

CREATE TABLE kategorie 
  ( 
     id_kategorii INT PRIMARY KEY IDENTITY(1, 1), 
     nazwa        NVARCHAR(15) NOT NULL UNIQUE, 
     opis         NVARCHAR(255) 
  ) 

CREATE TABLE [produkty do naprawy] 
  ( 
     id_produktu  INT PRIMARY KEY IDENTITY(1, 1), 
     id_kategorii INT NOT NULL, 
     nazwa        NVARCHAR(15) NOT NULL UNIQUE, 
     producent    NVARCHAR(24) 
     FOREIGN KEY (id_kategorii) REFERENCES kategorie(id_kategorii) 
  ) 

CREATE TABLE [czesci do naprawy] 
  ( 
     id_czesci   INT PRIMARY KEY IDENTITY(1, 1), 
     nazwa       NVARCHAR(15) NOT NULL UNIQUE, 
     opis        NVARCHAR(255), 
     cena        MONEY NOT NULL, 
     id_hurtowni INT NOT NULL, 
     FOREIGN KEY (id_hurtowni) REFERENCES hurtownie(id_hurtowni) 
  ) 

CREATE TABLE [stan magazynowy czesci] 
  ( 
     id_placowki INT, 
     id_czesci   INT, 
     ilosc       INT NOT NULL CHECK(ilosc >= 0), 
     PRIMARY KEY(id_placowki, id_czesci), 
     FOREIGN KEY (id_placowki) REFERENCES placowki(id_placowki), 
     FOREIGN KEY (id_czesci) REFERENCES [czesci do naprawy](id_czesci), 
  ) 

CREATE TABLE zamowienia 
  ( 
     id_zamowienia     INT PRIMARY KEY IDENTITY(1, 1), 
     id_hurtowni       INT NOT NULL, 
     id_placowki       INT NOT NULL, 
     data_zamowienia   DATE NOT NULL, 
     data_dostarczenia DATE, 
     FOREIGN KEY (id_hurtowni) REFERENCES hurtownie(id_hurtowni), 
     FOREIGN KEY (id_placowki) REFERENCES placowki(id_placowki) 
  ) 

CREATE TABLE [szczegoly zamowien] 
  ( 
     id_zamowienia INT, 
     id_czesci     INT, 
     cena          MONEY NOT NULL, 
     ilosc         INT NOT NULL CHECK(ilosc >= 1), 
     PRIMARY KEY (id_zamowienia, id_czesci), 
     FOREIGN KEY (id_zamowienia) REFERENCES [zamowienia](id_zamowienia) ON 
     DELETE CASCADE, 
     FOREIGN KEY (id_czesci) REFERENCES [czesci do naprawy](id_czesci) 
  ) 

CREATE TABLE [typ gwarancji] 
  ( 
     id_typu_gwarancji INT PRIMARY KEY IDENTITY(1, 1), 
     id_kategorii      INT NOT NULL, 
     cena              MONEY NOT NULL, 
     [czas trwania]    INT NOT NULL, 
     nazwa             NVARCHAR(50) NOT NULL UNIQUE, 
     FOREIGN KEY (id_kategorii) REFERENCES kategorie(id_kategorii) ON DELETE 
     CASCADE 
  ) 

CREATE TABLE gwarancje 
  ( 
     id_gwarancji       INT PRIMARY KEY IDENTITY(1, 1), 
     id_produktu        INT NOT NULL, 
     id_klienta         INT NOT NULL, 
     id_pracownika      INT, 
     [typ gwarancji]    INT NOT NULL, 
     [data rozpoczecia] DATE NOT NULL, 
     [data zakonczenia] DATE NOT NULL, 
     FOREIGN KEY (id_klienta) REFERENCES klienci(id_klienta), 
     FOREIGN KEY (id_produktu) REFERENCES [produkty do naprawy](id_produktu), 
     FOREIGN KEY (id_pracownika) REFERENCES pracownicy(id_pracownika) ON DELETE 
     SET NULL, 
     FOREIGN KEY ([typ gwarancji]) REFERENCES [typ gwarancji](id_typu_gwarancji) 
  ) 

CREATE TABLE zlecenia 
  ( 
     id_zlecenia          INT PRIMARY KEY IDENTITY(1, 1), 
     id_klienta           INT NOT NULL, 
     id_pracownika        INT NOT NULL, 
     id_produktu          INT NOT NULL, 
     koszt                MONEY NOT NULL, 
     [data przyjecia]     DATE NOT NULL, 
     [data zrealizowania] DATE, 
     opis                 NVARCHAR(255), 
     id_rabatu            INT, 
     id_gwarancji         INT, 
     FOREIGN KEY (id_klienta) REFERENCES klienci(id_klienta), 
     FOREIGN KEY (id_pracownika) REFERENCES pracownicy(id_pracownika), 
     FOREIGN KEY (id_produktu) REFERENCES [produkty do naprawy](id_produktu), 
     FOREIGN KEY (id_gwarancji) REFERENCES gwarancje(id_gwarancji), 
     FOREIGN KEY (id_rabatu) REFERENCES rabaty(id_rabatu) 
  ) 

CREATE TABLE [przebieg zlecen] 
  ( 
     id_przebiegu_zlecenia INT PRIMARY KEY IDENTITY(1, 1), 
     id_zlecenia           INT NOT NULL, 
     data                  DATE NOT NULL, 
     opis                  NVARCHAR(255) NOT NULL, 
     FOREIGN KEY (id_zlecenia) REFERENCES zlecenia(id_zlecenia) ON DELETE 
     CASCADE 
  ) 

CREATE TABLE [czesci uzyte do zlecenia] 
  ( 
     id_zlecenia INT, 
     id_czesci   INT, 
     ilosc       INT NOT NULL CHECK(ilosc >= 1), 
     data        DATE NOT NULL, 
     PRIMARY KEY(id_zlecenia, id_czesci), 
     FOREIGN KEY (id_zlecenia) REFERENCES zlecenia(id_zlecenia) ON DELETE 
     CASCADE, 
     FOREIGN KEY (id_czesci) REFERENCES [czesci do naprawy](id_czesci), 
  ) 

CREATE TABLE reklamacje 
  ( 
     id_reklamacji      INT PRIMARY KEY IDENTITY(1, 1), 
     id_zlecenia        INT NOT NULL, 
     [nowe id_zlecenia] INT NOT NULL, 
     id_pracownika      INT, 
     id_klienta         INT NOT NULL, 
     data               DATE NOT NULL, 
     opis               NVARCHAR(255), 
     FOREIGN KEY (id_klienta) REFERENCES klienci(id_klienta), 
     FOREIGN KEY (id_zlecenia) REFERENCES zlecenia(id_zlecenia), 
     FOREIGN KEY ([nowe id_zlecenia]) REFERENCES zlecenia(id_zlecenia), 
     FOREIGN KEY (id_pracownika) REFERENCES pracownicy(id_pracownika) ON DELETE 
     SET NULL 
  ) 


--Tworzenie typu własnego

CREATE TYPE Czesci AS TABLE
(
	ID_placowki INT NOT NULL,
	ID_czesci INT NOT NULL,
	Ilosc INT NOT NULL CHECK(Ilosc >= 0)
);


--Tworzenie procedur

GO
CREATE PROCEDURE Insert_or_update(@Do_dodania Czesci READONLY)
AS
BEGIN
	DECLARE @Ilosc_do_dodania INT = (SELECT top 1 Ilosc FROM @Do_dodania)
	DECLARE	@Placowka INT = (SELECT TOP 1 ID_placowki FROM @Do_dodania)
	DECLARE @ID_czesci INT = (SELECT TOP 1 ID_czesci FROM @Do_dodania)
	
	IF EXISTS (SELECT * FROM [Stan magazynowy czesci] WHERE ID_placowki = @Placowka AND ID_czesci = @ID_czesci)
		UPDATE [Stan magazynowy czesci] SET
	 		Ilosc = Ilosc + @Ilosc_do_dodania
		WHERE ID_placowki = @Placowka
		AND ID_czesci = @ID_czesci;
	ELSE
		INSERT INTO [Stan magazynowy czesci] (ID_placowki, ID_czesci, Ilosc)
			VALUES (@Placowka, @ID_czesci, @Ilosc_do_dodania);
END




GO  
CREATE PROCEDURE Bledy
AS 
	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  
  
    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE()

    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);  




GO
CREATE PROCEDURE Zysk_z_dnia(@Dzien DATE)
AS
		SELECT Sum(Koszt) AS [Zysk z dnia]
		FROM Zlecenia AS Z
		WHERE Z.[Data przyjecia]=@Dzien




GO
CREATE PROCEDURE Nowy_produkt(@nazwa_produktu nvarchar(15), @producent nvarchar(24), @kategoria nvarchar(15), @ID INT OUTPUT)
AS
	DECLARE @id_kat INT
		
	SELECT @id_kat=K.ID_kategorii
	FROM Kategorie AS K
	WHERE @kategoria = K.Nazwa
	
	IF @id_kat IS NULL
		SET @ID = NULL --podana kategoria nie istnieje (a null nam pozwoli obsluzyc blad w pierwotnej procedurze
		
	ELSE
	BEGIN
		
		INSERT INTO [Produkty do naprawy](ID_kategorii,Nazwa,Producent)
		VALUES(@id_kat,@nazwa_produktu,@producent)

		SELECT @ID= @@IDENTITY
	END




GO
CREATE PROCEDURE Nowe_zlecenie(@klient_id INT, @pracownik_id INT, @nazwa_produktu nvarchar(15), @producent nvarchar(24), @kategoria nvarchar(15),
								@koszt MONEY, @rabat nvarchar(50), @opis nvarchar(255))
AS
BEGIN TRY
	DECLARE @tranCount INT = @@TRANCOUNT
	
	IF @tranCount =0
		BEGIN TRAN noweZlecenie

	IF @klient_id NOT IN ( SELECT ID_klienta FROM Klienci)
		RAISERROR(50002, -1, -1)--klient nie istnieje
		
	IF @pracownik_id NOT IN ( SELECT ID_pracownika FROM Pracownicy)
		RAISERROR(50003, -1, -1)--pracownik nie istnieje

	DECLARE @ID INT--produktu

	SELECT @ID = dbo.Znajdz_produkt(@nazwa_produktu,@producent,@kategoria)

	IF @ID IS NULL
	BEGIN
		EXEC dbo.Nowy_produkt @nazwa_produktu,@producent,@kategoria,@ID OUTPUT
		
		IF @ID IS NULL
			RAISERROR(50004, -1, -1)--produktu nie bylo w bazie i nie da sie go dodac bo kategoria jest niepoprawna
	END
			
	DECLARE @rabat_id INT
	DECLARE @rabat_id_2 INT
	DECLARE @rab REAL

	IF @rabat IS NOT NULL
	BEGIN
		SELECT @rabat_id=R.ID_rabatu, @rab = R.[Procent znizki]
		FROM RABATY AS R
		WHERE R.Nazwa = @rabat
	
		IF @rabat_id IS NULL
			RAISERROR(50005, -1, -1)--podany rabat jest bledny
		

		SET @koszt = @koszt * (1- @rab)
	END
	
	SELECT @rabat_id_2= K.Rabat_Indywidualny
	FROM Klienci AS K
	WHERE K.ID_klienta = @klient_id
	
	IF @rabat_id_2 IS NOT NULL
	BEGIN
		SELECT @rab=R.[Procent znizki]
		FROM Rabaty AS R
		WHERE R.ID_rabatu = @rabat_id_2
		
		SET @koszt = @koszt * (1- @rab)
	
	END
		
	INSERT INTO Zlecenia(ID_klienta,ID_pracownika,ID_produktu,Koszt,[Data przyjecia],Opis,ID_rabatu)
	VALUES(@klient_id,@pracownik_id,@ID,@koszt,GETDATE(),@opis,@rabat_id)


	INSERT INTO [Przebieg zlecen](ID_zlecenia,Data,Opis)
	VALUES(@@IDENTITY,GETDATE(),N'Przyjecie zlecenia')
	
	IF @tranCount = 0
		COMMIT TRAN noweZlecenie
	
END TRY
BEGIN CATCH
	ROLLBACK TRAN noweZlecenie
	EXEC Bledy
END CATCH




GO
CREATE PROCEDURE Nowa_reklamacja(@zlecenie_id INT,@klient_id INT, @pracownik_id INT,@opis nvarchar(255))
AS
BEGIN TRY
	DECLARE @tranCount INT = @@TRANCOUNT
	
	IF @tranCount =0
		BEGIN TRAN nowaReklamacja
		
	IF @klient_id NOT IN ( SELECT ID_klienta FROM Klienci)
		RAISERROR(50002, -1, -1)--klient nie istnieje
		
	IF @pracownik_id NOT IN ( SELECT ID_pracownika FROM Pracownicy)
		RAISERROR(50003, -1, -1)--pracownik nie istnieje

	DECLARE @ID INT--produktu
	
	SELECT @ID = Z.ID_produktu
	FROM Zlecenia AS Z
	WHERE Z.ID_zlecenia=@zlecenie_id

	IF @ID IS NULL
		RAISERROR(50006, -1, -1)--zlecenia nie ma w bazie

	INSERT INTO Zlecenia(ID_klienta,ID_pracownika,ID_produktu,Koszt,[Data przyjecia],Opis,ID_rabatu)
	VALUES(@klient_id,@pracownik_id,@ID,0,GETDATE(),@opis,NULL)

	SELECT @ID = @@IDENTITY

	INSERT INTO [Przebieg zlecen](ID_zlecenia,Data,Opis)
	VALUES(@ID,GETDATE(),N'Przyjecie reklamacji')

	INSERT INTO Reklamacje(ID_zlecenia,[Nowe ID_zlecenia],ID_pracownika,ID_klienta,Data,Opis)
	VALUES(@zlecenie_id,@ID,@pracownik_id,@klient_id,GETDATE(),@opis)
	
	IF @tranCount = 0
		COMMIT TRAN nowaReklamacja
	
END TRY
BEGIN CATCH
	ROLLBACK TRAN nowaReklamacja
	EXEC Bledy
END CATCH




GO
CREATE PROCEDURE Transfer_miedzy_placowkami(@placowka INT,@placowka_docelowa INT, @id_czesci INT,@ile INT)
AS
BEGIN TRY
	DECLARE @tranCount INT = @@TRANCOUNT
	
	IF @tranCount =0
		BEGIN TRAN transferMiedzyPlacowkami
		
		IF @placowka NOT IN ( SELECT ID_placowki FROM Placowki)
			RAISERROR(50007, -1, -1)--placowka nie istnieje
		
		IF @placowka_docelowa NOT IN ( SELECT ID_placowki FROM Placowki)
			RAISERROR(50008, -1, -1)--placowka docelowa nie istnieje
			
		IF @id_czesci NOT IN (SELECT ID_czesci FROM [Czesci do naprawy])
			RAISERROR(50009, -1, -1)--czesc nie istnieje
		
		DECLARE @stan INT
		
		SELECT @stan= SMC.Ilosc
		FROM [Stan magazynowy czesci] AS SMC
		WHERE SMC.ID_placowki=@placowka AND SMC.ID_czesci = @id_czesci

		IF @stan IS NULL
			RAISERROR(50011, -1, -1)--Brak czesci w placowce
		IF @stan < @ile
			RAISERROR(50012, -1, -1)--za malo czesci w placowce

		UPDATE [Stan magazynowy czesci]
		SET Ilosc= Ilosc - @ile
		WHERE ID_placowki=@placowka AND ID_czesci = @id_czesci

		DELETE FROM [Stan magazynowy czesci] WHERE Ilosc = 0

		SET @stan = NULL

		SELECT @stan= SMC.Ilosc
		FROM [Stan magazynowy czesci] AS SMC
		WHERE SMC.ID_placowki=@placowka_docelowa AND SMC.ID_czesci = @id_czesci

		IF @stan IS NULL--sprawdzam czy placowka docelowa ma dane o tej czesci 
		BEGIN
			INSERT INTO [Stan magazynowy czesci]
			VALUES (@placowka_docelowa,@id_czesci,@ile)
			END
		ELSE--jak ma to dodaje do ilosci
		BEGIN
			UPDATE [Stan magazynowy czesci]
			SET Ilosc= Ilosc + @ile
			WHERE ID_placowki=@placowka_docelowa AND ID_czesci = @id_czesci
		END

	IF @tranCount = 0
		COMMIT TRAN transferMiedzyPlacowkami
	
END TRY
BEGIN CATCH
	ROLLBACK TRAN transferMiedzyPlacowkami
	EXEC Bledy
END CATCH		




GO
CREATE PROCEDURE Zamawianie(@czesc INT,@placowka INT, @ile INT)
AS
BEGIN TRY
	DECLARE @tranCount INT = @@TRANCOUNT
	
	IF @tranCount =0
		BEGIN TRAN zamawianie
		
	IF @czesc NOT IN (SELECT ID_czesci FROM [Czesci do naprawy])
			RAISERROR(50009, -1, -1)--czesc nie istnieje
	
	IF @placowka NOT IN ( SELECT ID_placowki FROM Placowki)
			RAISERROR(50007, -1, -1)--placowka nie istnieje
			
	DECLARE @hurtownia INT
	DECLARE @cena MONEY
	SELECT @hurtownia = CDN.ID_hurtowni, @cena = CDN.Cena
	FROM [Czesci do naprawy] AS CDN
	WHERE CDN.ID_czesci = @czesc

	DECLARE @zamowienie INT

	SELECT @zamowienie= Z.ID_zamowienia
	FROM Zamowienia AS Z
	WHERE Z.ID_hurtowni = @hurtownia AND Z.Data_zamowienia = CAST(GETDATE() AS DATE) AND Z.ID_placowki = @placowka

	IF @zamowienie IS NULL --nie bylo dzisiaj takiego zamowienia
	BEGIN
		INSERT INTO Zamowienia(ID_hurtowni,ID_placowki,Data_zamowienia,Data_dostarczenia)
		VALUES(@hurtownia,@placowka,GETDATE(),NULL)

		SET @zamowienie = @@IDENTITY

		INSERT INTO [Szczegoly zamowien]
		VALUES(@zamowienie,@czesc,@cena,@ile)
	END
	ELSE--bylo dzisiaj zamowienie
	BEGIN
		DECLARE @ile_juz_bylo INT -- dla sprawdzenia czy moze juz byla ta czesc dzisiaj zamawiana i tylko zwiekszymy ilosc

		SELECT @ile_juz_bylo = SZ.Ilosc
		FROM [Szczegoly zamowien] AS SZ
		WHERE @zamowienie= SZ.ID_zamowienia AND @czesc=SZ.ID_czesci

		IF @ile_juz_bylo IS NULL --dzisiaj nie bylo tej czesci w zamowieniu
		BEGIN
			INSERT INTO [Szczegoly zamowien]
			VALUES(@zamowienie,@czesc,@cena,@ile)
		END
		ELSE --dopisujemy ilosc
		BEGIN
			UPDATE [Szczegoly zamowien]
			SET Ilosc = Ilosc + @ile
		WHERE @zamowienie= ID_zamowienia AND @czesc=ID_czesci
		END
	END

	IF @tranCount = 0
		COMMIT TRAN zamawianie
	
END TRY
BEGIN CATCH
	ROLLBACK TRAN zamawianie
	EXEC Bledy
END CATCH	




GO
CREATE PROCEDURE Nowa_gwarancja(@nazwa_produktu nvarchar(15), @producent nvarchar(24), @kategoria nvarchar(15), @klient_id INT, @pracownik_id INT, @gwarancja NVARCHAR(50) )
AS
BEGIN TRY
	DECLARE @tranCount INT = @@TRANCOUNT
	
	IF @tranCount =0
		BEGIN TRAN nowaGwarancja
		
	IF @klient_id NOT IN ( SELECT ID_klienta FROM Klienci)
		RAISERROR(50002, -1, -1)--klient nie istnieje
		
	IF @pracownik_id NOT IN ( SELECT ID_pracownika FROM Pracownicy)
		RAISERROR(50003, -1, -1)--pracownik nie istnieje
	
	DECLARE @kategoria_id INT
	
	SELECT @kategoria_id = K.ID_kategorii
	FROM Kategorie AS K
	WHERE K.Nazwa= @kategoria
	
	IF @kategoria_id IS NULL
		RAISERROR(50004, -1, -1)--to nie obslugujemy takiej kategorii
		
	DECLARE @gwarancja_id INT
	DECLARE @dlugosc_gwarancji INT
	
	SELECT @gwarancja_id = TG.ID_typu_gwarancji, @dlugosc_gwarancji=TG.[Czas trwania]
	FROM [Typ gwarancji] AS TG
	WHERE TG.Nazwa = @gwarancja AND TG.ID_kategorii = @kategoria_id
	
	IF @gwarancja_id IS NULL
		RAISERROR(50010, -1, -1)--to gwarancja nie istnieje
	
	DECLARE @produkt_id INT

	SELECT @produkt_id = dbo.Znajdz_produkt(@nazwa_produktu,@producent,@kategoria)

	IF @produkt_id IS NULL
		EXEC dbo.Nowy_produkt @nazwa_produktu,@producent,@kategoria,@produkt_id OUTPUT
		
	DECLARE @data DATE
	SET @data = GETDATE()
	
	INSERT INTO Gwarancje(ID_produktu, ID_klienta, ID_pracownika, [Typ gwarancji], [Data rozpoczecia], [Data zakonczenia])
	VALUES (@produkt_id,@klient_id,@pracownik_id,@gwarancja_id,@data,DATEADD(dd,@dlugosc_gwarancji,@data))

	IF @tranCount = 0
		COMMIT TRAN nowaGwarancja
	
END TRY
BEGIN CATCH
	ROLLBACK TRAN nowaGwarancja
	EXEC Bledy
END CATCH




GO
CREATE PROCEDURE Nowe_zlecenie_gwarancyjne(@gwarancja_id INT,@klient_id INT, @pracownik_id INT,@opis nvarchar(255))
AS
BEGIN TRY
	DECLARE @tranCount INT = @@TRANCOUNT
	
	IF @tranCount =0
		BEGIN TRAN noweZlecenieGwarancyjne
		
	IF @klient_id NOT IN ( SELECT ID_klienta FROM Klienci)
		RAISERROR(50002, -1, -1)--klient nie istnieje
		
	IF @pracownik_id NOT IN ( SELECT ID_pracownika FROM Pracownicy)
		RAISERROR(50003, -1, -1)--pracownik nie istnieje
	
	IF @gwarancja_id NOT IN ( SELECT ID_gwarancji FROM Gwarancje )
		RAISERROR(50010, -1, -1)--gwarancja nie istnieje
		
	DECLARE @produkt_id INT
	
	SELECT @produkt_id = G.ID_produktu
	FROM Gwarancje AS G
	WHERE G.ID_gwarancji = @gwarancja_id
	
	INSERT INTO Zlecenia(ID_klienta,ID_pracownika,ID_produktu,Koszt,[Data przyjecia],Opis,ID_rabatu,ID_gwarancji)
	VALUES(@klient_id,@pracownik_id,@produkt_id,0,GETDATE(),@opis,NULL,@gwarancja_id)


	INSERT INTO [Przebieg zlecen](ID_zlecenia,Data,Opis)
	VALUES(@@IDENTITY,GETDATE(),N'Przyjecie zlecenia z gwarancji')

	IF @tranCount = 0
		COMMIT TRAN noweZlecenieGwarancyjne
	
END TRY
BEGIN CATCH
	ROLLBACK TRAN noweZlecenieGwarancyjne
	EXEC Bledy
END CATCH	




GO
CREATE PROCEDURE WstawAlboEdytujOsoby(
	@ID_osoby INT,
	@Imie NVARCHAR(50),
	@Nazwisko NVARCHAR(50),
	@Plec CHAR(1),
	@Adres NVARCHAR(60),
	@NumerKontaktowy VARCHAR(24),
	@Email NVARCHAR(60))
AS
	IF @ID_osoby = 0
		INSERT INTO Osoby (Imie,Nazwisko,Plec,Adres,[Numer kontaktowy],[E-mail])
		VALUES (@Imie,@Nazwisko,@Plec,@Adres,@NumerKontaktowy,@Email)
	ELSE
		UPDATE Osoby
		SET
			Imie = @Imie,
			Nazwisko = @Nazwisko,
			Plec = @Plec,
			Adres = @Adres,
			[Numer kontaktowy] = @NumerKontaktowy,
			[E-mail] = @Email
		WHERE ID_osoby = @ID_osoby




GO
CREATE PROCEDURE UsunOsoby(@ID_osoby INT)
AS
	DELETE FROM Osoby
	WHERE ID_Osoby = @ID_osoby



GO
--Tworzenie funkcji i widoków

CREATE FUNCTION Informacje_o_zamowieniu (@ID_Zamowienia INT)
RETURNS TABLE
AS
RETURN (
		SELECT Z.ID_zamowienia, Z.ID_hurtowni, Z.ID_placowki, SUM(CAST(S.Cena AS MONEY)) AS Koszt, Z.Data_zamowienia, Z.Data_dostarczenia
			FROM Zamowienia AS Z
			JOIN [Szczegoly zamowien] AS S ON (Z.ID_zamowienia = S.ID_zamowienia)
		WHERE Z.ID_zamowienia = @ID_Zamowienia
		GROUP BY Z.ID_zamowienia, Z.ID_hurtowni, Z.ID_placowki, Z.Data_zamowienia, Z.Data_dostarczenia
)




GO
CREATE VIEW Pracownicy_na_urlopie
AS
	SELECT U.ID_pracownika, P.ID_placowki, U.Od_kiedy, U.Do_kiedy
		FROM Urlopy AS U
		JOIN Pracownicy AS P ON (P.ID_pracownika = U.ID_pracownika)
	WHERE Do_kiedy > GETDATE() --Przed końcem urlopu
	AND P.[Data zwolnienia] IS NULL --Pracownik który nie został zwolniony




GO
CREATE VIEW Aktualnie_zatrudnieni_pracownicy
AS
	SELECT P.ID_pracownika, P.ID_placowki, P.PESEL, P.[Data zatrudnienia], P.[Przewidywana data zwolnienia]
		FROM Pracownicy AS P
		JOIN Osoby AS O ON (O.ID_osoby = P.ID_pracownika)
		WHERE [Data zwolnienia] IS NULL




GO
CREATE FUNCTION Gwarancje_Klienta(@ID_Klienta INT)
RETURNS TABLE
AS
RETURN (
		SELECT G.*
		FROM Gwarancje AS G
		WHERE ID_klienta = @ID_Klienta
		AND G.[Data zakonczenia] > GETDATE()
)




GO
CREATE FUNCTION Zlecenia_dla_kategorii(@ID_kategorii INT)
RETURNS TABLE
AS
RETURN (
		SELECT Z.*
			FROM Zlecenia AS Z
			JOIN [Produkty do naprawy] AS P ON (P.ID_produktu = Z.ID_produktu)
		WHERE P.ID_kategorii = @ID_kategorii
		AND Z.[Data zrealizowania] IS NULL
)




GO
CREATE VIEW Czesci_ze_wszystkich_placowek
AS
	SELECT S.ID_czesci, COUNT(S.Ilosc) [Ilosc]
		FROM [Stan magazynowy czesci] AS S
	GROUP BY S.ID_czesci




GO
CREATE VIEW Aktualne_rabaty
AS
	SELECT *
		FROM Rabaty
	WHERE [Data wygasniecia] IS NULL
	OR [Data wygasniecia] < GETDATE()




GO
CREATE VIEW Przychody_miesieczne
AS
	SELECT
		R.Data AS Data,
		SUM(CAST(R.[Przychod ze zlecen] AS MONEY)) AS [Przychod ze zlecen],
		SUM(CAST(R.[Przychod z gwarancji] AS MONEY)) AS [Przychod z gwarancji],
		SUM(CAST(R.[Przychod ze zlecen] + R.[Przychod z gwarancji] AS MONEY)) AS [Suma przychodow] 
	FROM
		(SELECT 
			CAST(MONTH(Z.[Data przyjecia]) AS VARCHAR(2)) + '-' + CAST(YEAR(Z.[Data przyjecia]) AS VARCHAR(4)) AS Data,
			Z.Koszt AS [Przychod ze zlecen],
			0.00 AS [Przychod z gwarancji]
		FROM Zlecenia AS Z
		UNION ALL
		SELECT
			CAST(MONTH(G.[Data rozpoczecia]) AS VARCHAR(2)) + '-' + CAST(YEAR(G.[Data rozpoczecia]) AS VARCHAR(4)) AS Data,
			0.00 AS [Przychod ze zlecen],
			T.Cena AS [Przychod z gwarancji]
		FROM Gwarancje AS G
		JOIN [Typ gwarancji] T ON (G.[Typ gwarancji] = T.ID_typu_gwarancji)
		) AS R
	GROUP BY Data




GO
CREATE FUNCTION Calkowity_koszt_zamowienia(@ID_zamowienia INT)
RETURNS INT
AS
BEGIN
RETURN (
	SELECT SUM(S.Cena)
		FROM [Szczegoly zamowien] AS S
	WHERE S.ID_zamowienia = @ID_zamowienia
)
END




GO
CREATE VIEW Wydatki_miesieczne
AS
	SELECT 
		CAST(MONTH(Z.Data_dostarczenia) AS VARCHAR(2)) + '-' + CAST(YEAR(Z.Data_dostarczenia) AS VARCHAR(4)) AS Data,
		SUM(CAST(dbo.Calkowity_koszt_zamowienia(Z.ID_zamowienia) AS MONEY)) AS [Suma wydatkow]
	FROM Zamowienia AS Z
	GROUP BY CAST(MONTH(Z.Data_dostarczenia) AS VARCHAR(2)) + '-' + CAST(YEAR(Z.Data_dostarczenia) AS VARCHAR(4))




GO
CREATE VIEW Niezrealizowane_zlecenia
AS
	SELECT *
		FROM Zlecenia AS Z
	WHERE Z.[Data zrealizowania] IS NULL




GO 
CREATE FUNCTION Przebieg_zlecenia(@ID_zlecenia INT)
RETURNS TABLE
AS
RETURN (
	SELECT TOP 100 WITH TIES --Musi być TOP ponieważ nie da się dodać bez tego ORDER BY w funkcji :(
		P.ID_przebiegu_zlecenia,
		P.Data,
		P.Opis
	FROM [Przebieg Zlecen] AS P
	ORDER BY P.Data DESC
)




GO
CREATE FUNCTION Zlecenia_realizowane_przez_pracownika(@ID_Pracownika INT)
RETURNS TABLE
AS
RETURN (
	SELECT Z.ID_zlecenia, Z.ID_klienta, Z.[Data przyjecia], Z.ID_produktu, Z.Koszt, Z.ID_gwarancji, Z.ID_rabatu
		FROM Zlecenia AS Z
	WHERE Z.ID_pracownika = @ID_Pracownika
	AND Z.[Data zrealizowania] IS NULL
)




GO
CREATE FUNCTION Pracownicy_zarabiajacy_mniej_niz(@Kwota INT)
RETURNS TABLE
AS
RETURN (
	SELECT * 
		FROM Pracownicy
	WHERE Zarobki < @Kwota
)



GO
CREATE FUNCTION Znajdz_produkt(@nazwa_produktu nvarchar(15), @producent nvarchar(24), @kategoria nvarchar(15))
RETURNS INT
AS
BEGIN

	DECLARE @ID INT
	
	SELECT TOP 1 @ID=P.ID_produktu
	FROM [Produkty do naprawy] AS P RIGHT JOIN Kategorie AS K
	ON K.ID_kategorii = P.ID_kategorii
	WHERE @kategoria = K.Nazwa AND @nazwa_produktu = P.Nazwa AND @producent = P.Producent

	RETURN @ID
END



GO
--Tworzenie triggerów
CREATE TRIGGER Przenies_czesci
ON Placowki
INSTEAD OF DELETE
AS
BEGIN
	--Wybieramy placówkę do której wyślemy części
	DECLARE @Placowka_odbiorca INT;
	SET @Placowka_odbiorca = (SELECT TOP 1 ID_placowki
		FROM Placowki
	WHERE ID_placowki NOT IN (SELECT ID_placowki FROM deleted));

	--Jeżeli nie ma placówki-odbiorcy, to znaczy że usuwamy wszystkie placówki.
	IF @Placowka_odbiorca IS NULL
	BEGIN
		DELETE Placowki WHERE ID_placowki IN (SELECT ID_placowki FROM deleted);
		RETURN;
	END

	--Zadeklarujmy potrzebne rzeczy
	DECLARE @Przenoszone_czesci Czesci;
	DECLARE @VAL1 INT;
	DECLARE @VAL2 INT;
	DECLARE Iterator CURSOR
		FOR (--Wybieramy części do przerucenia bez podziału na placówki.
			SELECT S.ID_czesci, SUM(Ilosc)
				FROM deleted AS D
				JOIN [Stan magazynowy czesci] AS S ON (S.ID_placowki = D.ID_placowki)
			GROUP BY ID_czesci
			)
		FOR READ ONLY;

	--Iterujmy
	OPEN Iterator;
	FETCH Iterator INTO @VAL1, @VAL2;
	INSERT INTO @Przenoszone_czesci VALUES (@Placowka_odbiorca, @VAL1,@VAL2);

	WHILE @@FETCH_STATUS = 0
	BEGIN
		BEGIN TRY
			--Przenieśmy części
			EXEC Insert_or_update @Do_dodania = @Przenoszone_czesci;

			--Kolejna iteracja
			DELETE FROM @Przenoszone_czesci;
			FETCH Iterator INTO @VAL1, @VAL2;
			INSERT INTO @Przenoszone_czesci VALUES (@Placowka_odbiorca, @VAL1, @VAL2);

		END TRY
		BEGIN CATCH
			ROLLBACK
			EXEC Bledy
			BREAK
		END CATCH
	END

	--Zamykamy iterator
	CLOSE Iterator;
	DEALLOCATE Iterator;

	--Usuwamy części z placówek
	DELETE FROM [Stan magazynowy czesci]
	WHERE ID_placowki IN (SELECT ID_placowki FROM deleted)

	--Usuwamy placówki
	DELETE FROM Placowki
	WHERE ID_placowki IN (SELECT ID_placowki FROM deleted)
END




GO
CREATE TRIGGER Blokada_aktualizacji_zlecen
ON [Przebieg zlecen]
AFTER INSERT
AS
BEGIN
	DECLARE @data DATE;
	--Sprawdzenie czy zlecenie zostało już zakończone
	SET @data = (SELECT TOP 1 Z.[Data zrealizowania]
					FROM Zlecenia AS Z
					JOIN inserted AS I ON (Z.ID_zlecenia = I.ID_zlecenia)
				WHERE Z.[Data zrealizowania] IS NOT NULL) --Jeśli wszystkie będą NULLem to zapytanie nic nie zwróci (czyli NULL)

	IF @data IS NOT NULL 
	BEGIN
		RAISERROR(50001, -1, -1);
	END
END




GO
CREATE TRIGGER Stworz_klienta
ON Osoby
AFTER INSERT
AS
BEGIN
	INSERT INTO Klienci(ID_Klienta, Rabat_Indywidualny, Data_Rejestracji)
	SELECT I.ID_osoby, NULL, GETDATE()
		FROM inserted AS I
END




GO
CREATE TRIGGER Przeslij_czesci_po_zakonczeniu_zamowienia
ON Zamowienia
AFTER UPDATE
AS
BEGIN
	--Jeżeli użytkownik próbuje zmienić datę na NULL to operacja powinna zostać przerwana.
	--Gdyby użytkownik mógł zmienić na NULL'a to wtedy mógłby znowu ustawić datę zakończenia co ponownie przesłałoby towary.
	IF EXISTS (SELECT *
		 --FROM deleted AS D
		 --JOIN inserted AS I ON (D.ID_zamowienia = I.ID_zamowienia)
		 FROM Zamowienia AS D
		 JOIN Zamowienia aS I ON (D.ID_zamowienia = I.ID_zamowienia)
		 WHERE D.Data_dostarczenia IS NOT NULL AND I.Data_dostarczenia IS NULL
		)
	BEGIN
		RAISERROR(50013, -1, -1);
		RETURN;
	END

	--Zadeklarujmy pomocnicze zmienne
	DECLARE @Przenoszone_czesci Czesci;
	DECLARE @VAL1 INT;
	DECLARE @VAL2 INT;
	DECLARE @VAL3 INT;
	DECLARE Iterator CURSOR
		FOR (
			SELECT I.ID_placowki, SZ.ID_czesci, SUM(SZ.Ilosc)
				FROM inserted AS I
				JOIN deleted AS D ON (D.ID_zamowienia = I.ID_zamowienia)
				JOIN [Szczegoly zamowien] AS SZ ON (SZ.ID_zamowienia = I.ID_zamowienia)
			WHERE D.Data_dostarczenia IS NULL
			AND I.Data_dostarczenia IS NOT NULL --Sprawdzamy czy zamówienie zostało zrealizowane
			GROUP BY I.ID_placowki, SZ.ID_czesci
		)
		FOR READ ONLY;


	--Iterujemy po wszystkich częściach
	OPEN Iterator;
	FETCH Iterator INTO @VAL1, @VAL2, @VAL3;
	INSERT INTO @Przenoszone_czesci VALUES (@VAL1, @VAL2, @VAL3);

	WHILE @@FETCH_STATUS = 0
	BEGIN
		BEGIN TRY
			--Przenosimy części
			EXEC Insert_or_update @Do_dodania = @Przenoszone_czesci;

			--Wybieramy kolejne czesci
			DELETE FROM @Przenoszone_czesci;
			FETCH Iterator INTO @VAL1, @VAL2, @VAL3;
			INSERT INTO @Przenoszone_czesci VALUES (@VAL1, @VAL2, @VAL3);
		
		END TRY
		BEGIN CATCH
			ROLLBACK
			EXEC Bledy
			BREAK
		END CATCH
	END

	--Zamykamy iterator
	CLOSE Iterator;
	DEALLOCATE Iterator;
END




GO
CREATE TRIGGER Blokada_zwolnienia_pracownika_z_niezrealizowanymi_zleceniami
ON Pracownicy
AFTER UPDATE
AS 
BEGIN
	IF EXISTS (
		SELECT I.ID_pracownika
			FROM inserted AS I
			JOIN deleted AS D ON (I.ID_pracownika = D.ID_pracownika)
			JOIN Zlecenia AS Z ON (Z.ID_pracownika = I.ID_pracownika)
		WHERE (D.[Data zwolnienia] IS NULL AND I.[Data zwolnienia] IS NOT NULL) --Sprawdzamy czy pracownik został zwolniony
		AND (Z.[Data zrealizowania] IS NULL)
	)
	BEGIN
		ROLLBACK;
		RAISERROR(50014, -1, -1);
	END
END


--Przypisanie wiadomości do errorów

EXEC sp_addmessage 50001, 16,
	N'Zlecenie zostalo juz zakonczone, nie mozesz zaktualizowac przebiegu!', @replace = 'REPLACE';
GO

EXEC sp_addmessage 50002, 16,   
	N'Nieprawidlowy klient', @replace = 'REPLACE';  
GO  

EXEC sp_addmessage 50003, 16,   
	N'Nieprawidlowy pracownik', @replace = 'REPLACE';  
GO  

EXEC sp_addmessage 50004, 16,   
	N'Nieprawidlowa kategoria', @replace = 'REPLACE';  
GO  

EXEC sp_addmessage 50005, 16,   
	N'Nieprawidlowy rabat', @replace = 'REPLACE';  
GO  

EXEC sp_addmessage 50006, 16,   
	N'Nieprawidlowe zlecenie', @replace = 'REPLACE';  
GO  

EXEC sp_addmessage 50007, 16,   
	N'Nieprawidlowa placowka', @replace = 'REPLACE';  
GO

EXEC sp_addmessage 50008, 16,   
	N'Nieprawidlowa placowka docelowa', @replace = 'REPLACE';  
GO  

EXEC sp_addmessage 50009, 16,   
	N'Nieprawidlowa czesc', @replace = 'REPLACE';  
GO  

EXEC sp_addmessage 50010, 16,   
	N'Nieprawidlowa gwarancja', @replace = 'REPLACE';  
GO

EXEC sp_addmessage 50011, 16,   
	N'Brak czesci w placowce', @replace = 'REPLACE';  
GO  

EXEC sp_addmessage 50012, 16,   
	N'Za malo czesci w placowce', @replace = 'REPLACE';  
GO   

EXEC sp_addmessage 50013, 16,
	N'Nie mozesz zmienic daty zakonczenia zamowienia z powrotem na NULL!', @replace = 'REPLACE';
GO

EXEC sp_addmessage 50014, 16,
	N'Pracownik nie ukonczyl wszystkich zlecen!', @replace = 'REPLACE';
GO
