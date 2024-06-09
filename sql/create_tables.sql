DROP TABLE IF EXISTS Abonnementer;
DROP TABLE IF EXISTS Kunder;
DROP TABLE IF EXISTS Biler;

CREATE TABLE Kunder (  

    KundeID SERIAL PRIMARY KEY,  

    Fornavn VARCHAR(50),  

    Efternavn VARCHAR(50),  

    Adresse VARCHAR(100),  

    Email VARCHAR(100),  

    Telefon VARCHAR(20)  

);  

  

CREATE TABLE Biler (  

    BilID SERIAL PRIMARY KEY ,  

    Maerke VARCHAR(50),  

    Model VARCHAR(50),  

    Braendstoftype VARCHAR(50),  

    Hestekraefter INT,  

    Stelnummer VARCHAR(50),  

    Vognnummer VARCHAR(50),  

    Odometer INT,  

    Produktionsaar INT,  

    Lokation VARCHAR(50),  

    Billede VARCHAR(50)  

);  

  

CREATE TABLE Abonnementer (  

    AbonnementID SERIAL PRIMARY KEY,  

    KundeID INT,  

    BilID INT,  

    Startdato DATE,  

    Slutdato DATE,  

    PrisPrMaaned INT,  

    Maxkm INT,  

    FOREIGN KEY (KundeID) REFERENCES Kunder(KundeID),  

    FOREIGN KEY (BilID) REFERENCES Biler(BilID)  

);  

  

  

  

INSERT INTO Biler (Maerke, Model, Braendstoftype, Hestekraefter, Stelnummer, Vognnummer, Odometer, Produktionsaar, Lokation, Billede) VALUES ('Toyota', 'Corolla', 'Benzin', 120, 'ABC123456', 'VN001', 10000, 2023, 'Københavns Universitet', 'bil1.jpg'), ('Ford', 'Fiesta', 'Diesel', 90, 'DEF123456', 'VN002', 5000, 2023, 'Syddansk Universitet', 'bil2.jpg'),  

  

('Honda', 'Civic', 'Benzin', 150, 'GHI123456', 'VN003', 15000, 2023, 'Aarhus Universitet', 'bil3.jpg'),  

  

('Tesla', 'Model 3', 'Elektrisk', 350, 'JKL123456', 'VN004', 2000, 2024, 'Roskilde Universitet', 'bil4.jpg'),   

  

('BMW', 'X5', 'Diesel', 300, 'MNO123456', 'VN005', 12000, 2024, 'Københavns Universitet', 'bil5.jpg'),   

  

('Audi', 'A4', 'Benzin', 200, 'PQR123456', 'VN006', 8000, 2023, 'Syddansk Universitet', 'bil6.jpg'),  

  

('Volkswagen', 'Golf', 'Diesel', 110, 'STU123456', 'VN007', 9500, 2023, 'Aarhus Universitet', 'bil7.jpg'),   

  

('Nissan', 'Leaf', 'Elektrisk', 150, 'VWX123456', 'VN008', 3000, 2024, 'Roskilde Universitet', 'bil8.jpg'), ('Hyundai', 'Tucson', 'Benzin', 180, 'YZA123456', 'VN009', 7000, 2023, 'Københavns Universitet', 'bil9.jpg'),   

  

('Kia', 'Sorento', 'Diesel', 250, 'BCD123456', 'VN010', 10000, 2024, 'Syddansk Universitet', 'bil10.jpg'),  

  

('Mercedes', 'C-Class', 'Benzin', 220, 'EFG123456', 'VN011', 5000, 2023, 'Aarhus Universitet', 'bil1.jpg'),  

  

('Renault', 'Clio', 'Diesel', 85, 'HIJ123456', 'VN012', 10000, 2024, 'Roskilde Universitet', 'bil2.jpg'),  

  

('Peugeot', '208', 'Benzin', 110, 'KLM123456', 'VN013', 8000, 2023, 'Københavns Universitet', 'bil3.jpg'), ('Mazda', 'CX-5', 'Diesel', 190, 'NOP123456', 'VN014', 12000, 2024, 'Syddansk Universitet', 'bil4.jpg'),  

  

('Subaru', 'Forester', 'Benzin', 175, 'QRS123456', 'VN015', 6000, 2023, 'Aarhus Universitet', 'bil5.jpg'),  

  

('Chevrolet', 'Malibu', 'Benzin', 160, 'TUV123456', 'VN016', 4000, 2024, 'Roskilde Universitet', 'bil6.jpg'),  

  

('Jaguar', 'XF', 'Diesel', 240, 'WXY123456', 'VN017', 3000, 2023, 'Københavns Universitet', 'bil7.jpg'),  

  

('Lexus', 'RX', 'Benzin', 295, 'ZAB123456', 'VN018', 5000, 2024, 'Syddansk Universitet', 'bil8.jpg'),  

  

('Dodge', 'Charger', 'Benzin', 370, 'CDE123456', 'VN019', 9000, 2023, 'Aarhus Universitet', 'bil9.jpg'),  

  

('Chrysler', '300', 'Diesel', 292, 'FGH123456', 'VN020', 11000, 2024, 'Roskilde Universitet', 'bil10.jpg'),   

  

('Fiat', '500', 'Benzin', 100, 'IJK123456', 'VN021', 2000, 2023, 'Københavns Universitet', 'bil1.jpg'), ('Alfa Romeo', 'Giulia', 'Diesel', 280, 'LMN123456', 'VN022', 7000, 2024, 'Syddansk Universitet', 'bil2.jpg'),   

  

('Volvo', 'XC60', 'Benzin', 250, 'OPQ123456', 'VN023', 8000, 2023, 'Aarhus Universitet', 'bil3.jpg'),   

  

('Land Rover', 'Discovery', 'Diesel', 300, 'RST123456', 'VN024', 15000, 2024, 'Roskilde Universitet', 'bil4.jpg'), ('Jeep', 'Grand Cherokee', 'Benzin', 295, 'UVW123456', 'VN025', 10000, 2023, 'Københavns Universitet', 'bil5.jpg'), ('Mini', 'Cooper', 'Benzin', 135, 'XYZ123456', 'VN026', 5000, 2024, 'Syddansk Universitet', 'bil6.jpg'), ('Porsche', 'Macan', 'Benzin', 355, 'BCD234567', 'VN027', 7000, 2023, 'Aarhus Universitet', 'bil7.jpg'), ('Mitsubishi', 'Outlander', 'Diesel', 225, 'EFG234567', 'VN028', 4000, 2024, 'Roskilde Universitet', 'bil8.jpg'), ('Suzuki', 'Swift', 'Benzin', 105, 'HIJ234567', 'VN029', 6000, 2023, 'Københavns Universitet', 'bil9.jpg'), ('Acura', 'MDX', 'Benzin', 290, 'KLM234567', 'VN030', 2000, 2024, 'Syddansk Universitet', 'bil10.jpg'), ('Infiniti', 'QX60', 'Diesel', 295, 'NOP234567', 'VN031', 8000, 2023, 'Aarhus Universitet', 'bil1.jpg'), ('Genesis', 'GV80', 'Benzin', 375, 'QRS234567', 'VN032', 12000, 2024, 'Roskilde Universitet', 'bil2.jpg'), ('Lincoln', 'Navigator', 'Benzin', 450, 'TUV234567', 'VN033', 3000, 2023, 'Københavns Universitet', 'bil3.jpg'), ('Cadillac', 'Escalade', 'Benzin', 420, 'WXY234567', 'VN034', 9000, 2024, 'Syddansk Universitet', 'bil4.jpg'), ('Bentley', 'Bentayga', 'Benzin', 542, 'ZAB234567', 'VN035', 7000, 2023, 'Aarhus Universitet', 'bil5.jpg'), ('Aston Martin', 'DBX', 'Benzin', 542, 'CDE345678', 'VN036', 5000, 2024, 'Roskilde Universitet', 'bil6.jpg'), ('Rolls Royce', 'Cullinan', 'Benzin', 563, 'FGH345678', 'VN037', 4000, 2023, 'Københavns Universitet', 'bil7.jpg'), ('Maserati', 'Levante', 'Diesel', 424, 'IJK345678', 'VN038', 3000, 2024, 'Syddansk Universitet', 'bil8.jpg'), ('Ferrari', 'Purosangue', 'Benzin', 715, 'LMN345678', 'VN039', 2000, 2023, 'Aarhus Universitet', 'bil9.jpg'), ('Lamborghini', 'Urus', 'Benzin', 641, 'OPQ345678', 'VN040', 8000, 2024, 'Roskilde Universitet', 'bil10.jpg'), ('Bugatti', 'Veyron', 'Benzin', 1200, 'RST345678', 'VN041', 6000, 2023, 'Københavns Universitet', 'bil1.jpg'), ('McLaren', '720S', 'Benzin', 710, 'UVW345678', 'VN042', 10000, 2024, 'Syddansk Universitet', 'bil2.jpg'), ('Koenigsegg', 'Jesko', 'Benzin', 1600, 'XYZ345678', 'VN043', 9000, 2023, 'Aarhus Universitet', 'bil3.jpg'), ('Pagani', 'Huayra', 'Benzin', 720, 'BCD456789', 'VN044', 5000, 2024, 'Roskilde Universitet', 'bil4.jpg'), ('Hennessey', 'Venom GT', 'Benzin', 1451, 'EFG456789', 'VN045', 7000, 2023, 'Københavns Universitet', 'bil5.jpg'), ('Tesla', 'Model S', 'Elektrisk', 1020, 'HIJ456789', 'VN046', 2000, 2024, 'Syddansk Universitet', 'bil6.jpg'), ('Rimac', 'Nevera', 'Elektrisk', 1914, 'KLM456789', 'VN047', 1000, 2023, 'Aarhus Universitet', 'bil7.jpg'), ('Lucid', 'Air', 'Elektrisk', 1080, 'NOP456789', 'VN048', 3000, 2024, 'Roskilde Universitet', 'bil8.jpg'), ('Pininfarina', 'Battista', 'Elektrisk', 1900, 'QRS456789', 'VN049', 4000, 2023, 'Københavns Universitet', 'bil9.jpg'), ('Nio', 'EP9', 'Elektrisk', 1341, 'TUV456789', 'VN050', 5000, 2024, 'Syddansk Universitet', 'bil10.jpg'), ('Faraday Future', 'FF 91', 'Elektrisk', 1050, 'WXY456789', 'VN051', 6000, 2023, 'Aarhus Universitet', 'bil1.jpg'), ('Fisker', 'Ocean', 'Elektrisk', 300, 'ZAB456789', 'VN052', 7000, 2024, 'Roskilde Universitet', 'bil2.jpg'), ('Polestar', '2', 'Elektrisk', 408, 'CDE567890', 'VN053', 8000, 2023, 'Københavns Universitet', 'bil3.jpg'), ('Lotus', 'Evija', 'Elektrisk', 2000, 'FGH567890', 'VN054', 9000, 2024, 'Syddansk Universitet', 'bil4.jpg'),  

  

('MG', 'ZS EV', 'Elektrisk', 150, 'HIJ567890', 'VN055', 5000, 2023, 'Aarhus Universitet', 'bil5.jpg'),   

  

('BYD', 'Tang EV', 'Elektrisk', 490, 'KLM567890', 'VN056', 4000, 2024, 'Roskilde Universitet', 'bil6.jpg'),  

  

('XPeng', 'P7', 'Elektrisk', 430, 'NOP567890', 'VN057', 3000, 2023, 'Københavns Universitet', 'bil7.jpg'),   

  

('VinFast', 'VF e34', 'Elektrisk', 285, 'QRS567890', 'VN058', 2000, 2024, 'Syddansk Universitet', 'bil8.jpg'), ('Aiways', 'U5', 'Elektrisk', 204, 'TUV567890', 'VN059', 1000, 2023, 'Aarhus Universitet', 'bil9.jpg'), ('Ora', 'Good Cat', 'Elektrisk', 143, 'WXY567890', 'VN060', 8000, 2024, 'Roskilde Universitet', 'bil10.jpg'), ('Great Wall', 'Cannon', 'Diesel', 160, 'ZAB567890', 'VN061', 7000, 2023, 'Københavns Universitet', 'bil1.jpg'), ('Haval', 'H6', 'Benzin', 170, 'CDE678901', 'VN062', 6000, 2024, 'Syddansk Universitet', 'bil2.jpg'), ('Chery', 'Tiggo 8', 'Diesel', 190, 'FGH678901', 'VN063', 5000, 2023, 'Aarhus Universitet', 'bil3.jpg'), ('Geely', 'Atlas', 'Benzin', 180, 'HIJ678901', 'VN064', 4000, 2024, 'Roskilde Universitet', 'bil4.jpg'), ('Lynk & Co', '01', 'Benzin', 190, 'KLM678901', 'VN065', 3000, 2023, 'Københavns Universitet', 'bil5.jpg'), ('Roewe', 'RX5', 'Benzin', 200, 'NOP678901', 'VN066', 2000, 2024, 'Syddansk Universitet', 'bil6.jpg'), ('Wey', 'VV7', 'Benzin', 220, 'QRS678901', 'VN067', 1000, 2023, 'Aarhus Universitet', 'bil7.jpg'), ('Neta', 'U', 'Elektrisk', 300, 'TUV678901', 'VN068', 9000, 2024, 'Roskilde Universitet', 'bil8.jpg'), ('Arcfox', 'Alpha S', 'Elektrisk', 435, 'WXY678901', 'VN069', 8000, 2023, 'Københavns Universitet', 'bil9.jpg'), ('Seres', 'SF5', 'Elektrisk', 510, 'ZAB678901', 'VN070', 7000, 2024, 'Syddansk Universitet', 'bil10.jpg'), ('WM Motor', 'EX5', 'Elektrisk', 214, 'CDE789012', 'VN071', 6000, 2023, 'Aarhus Universitet', 'bil1.jpg'), ('Leapmotor', 'C11', 'Elektrisk', 368, 'FGH789012', 'VN072', 5000, 2024, 'Roskilde Universitet', 'bil2.jpg'), ('Nissan', 'Ariya', 'Elektrisk', 389, 'HIJ789012', 'VN073', 4000, 2023, 'Københavns Universitet', 'bil3.jpg'), ('Renault', 'Megane E-Tech', 'Elektrisk', 218, 'KLM789012', 'VN074', 3000, 2024, 'Syddansk Universitet', 'bil4.jpg'), ('Hyundai', 'Ioniq 5', 'Elektrisk', 306, 'NOP789012', 'VN075', 2000, 2023, 'Aarhus Universitet', 'bil5.jpg'), ('Kia', 'EV6', 'Elektrisk', 325, 'QRS789012', 'VN076', 1000, 2024, 'Roskilde Universitet', 'bil6.jpg'), ('Ford', 'Mustang Mach-E', 'Elektrisk', 459, 'TUV789012', 'VN077', 9000, 2023, 'Københavns Universitet', 'bil7.jpg'), ('Volkswagen', 'ID.4', 'Elektrisk', 204, 'WXY789012', 'VN078', 8000, 2024, 'Syddansk Universitet', 'bil8.jpg'), ('Skoda', 'Enyaq iV', 'Elektrisk', 265, 'ZAB789012', 'VN079', 7000, 2023, 'Aarhus Universitet', 'bil9.jpg'), ('SEAT', 'Mii Electric', 'Elektrisk', 83, 'CDE890123', 'VN080', 6000, 2024, 'Roskilde Universitet', 'bil10.jpg'), ('Audi', 'Q4 e-tron', 'Elektrisk', 300, 'FGH890123', 'VN081', 5000, 2023, 'Københavns Universitet', 'bil1.jpg'), ('Porsche', 'Taycan', 'Elektrisk', 522, 'HIJ890123', 'VN082', 4000, 2024, 'Syddansk Universitet', 'bil2.jpg'), ('Mercedes', 'EQC', 'Elektrisk', 408, 'KLM890123', 'VN083', 3000, 2023, 'Aarhus Universitet', 'bil3.jpg'), ('BMW', 'iX3', 'Elektrisk', 286, 'NOP890123', 'VN084', 2000, 2024, 'Roskilde Universitet', 'bil4.jpg'), ('Jaguar', 'I-Pace', 'Elektrisk', 400, 'QRS890123', 'VN085', 1000, 2023, 'Københavns Universitet', 'bil5.jpg'), ('Volvo', 'XC40 Recharge', 'Elektrisk', 402, 'TUV890123', 'VN086', 9000, 2024, 'Syddansk Universitet', 'bil6.jpg'), ('Polestar', '3', 'Elektrisk', 489, 'WXY890123', 'VN087', 8000, 2023, 'Aarhus Universitet', 'bil7.jpg'), ('Mazda', 'MX-30', 'Elektrisk', 145, 'ZAB890123', 'VN088', 7000, 2024, 'Roskilde Universitet', 'bil8.jpg'), ('Honda', 'e', 'Elektrisk', 154, 'CDE901234', 'VN089', 6000, 2023, 'Københavns Universitet', 'bil9.jpg'),  

  

('Mini', 'Electric', 'Elektrisk', 184, 'FGH901234', 'VN090', 5000, 2024, 'Syddansk Universitet', 'bil10.jpg'),  

  

('Peugeot', 'e-208', 'Elektrisk', 136, 'HIJ901234', 'VN091', 4000, 2023, 'Aarhus Universitet', 'bil1.jpg'),   

  

('Opel', 'Corsa-e', 'Elektrisk', 136, 'KLM901234', 'VN092', 3000, 2024, 'Roskilde Universitet', 'bil2.jpg'), ('Citroen', 'e-C4', 'Elektrisk', 136, 'NOP901234', 'VN093', 2000, 2023, 'Københavns Universitet', 'bil3.jpg'),   

  

('DS', '3 Crossback E-Tense', 'Elektrisk', 136, 'QRS901234', 'VN094', 1000, 2024, 'Syddansk Universitet', 'bil4.jpg'),   

  

('Fiat', '500 Electric', 'Elektrisk', 118, 'TUV901234', 'VN095', 9000, 2023, 'Aarhus Universitet', 'bil5.jpg'),   

  

('Renault', 'Twingo Electric', 'Elektrisk', 81, 'WXY901234', 'VN096', 8000, 2024, 'Roskilde Universitet', 'bil6.jpg'),  

  

('Smart', 'EQ fortwo', 'Elektrisk', 82, 'ZAB901234', 'VN097', 7000, 2023, 'Københavns Universitet', 'bil7.jpg'),   

  

('MG', 'Marvel R', 'Elektrisk', 288, 'CDE012345', 'VN098', 6000, 2024, 'Syddansk Universitet', 'bil8.jpg'),   

  

('BYD', 'Han EV', 'Elektrisk', 494, 'FGH012345', 'VN099', 5000, 2023, 'Aarhus Universitet', 'bil9.jpg'),   

  

('Nio', 'ES8', 'Elektrisk', 544, 'HIJ012345', 'VN100', 4000, 2024, 'Roskilde Universitet', 'bil10.jpg');  

  

INSERT INTO Kunder (Fornavn, Efternavn, Adresse, Email, Telefon) VALUES   

  

('Anna', 'Hansen', 'Vej 1', 'anna.hansen@example.com', '12345678'),   

  

('Bent', 'Jensen', 'Vej 2', 'bent.jensen@example.com', '23456789'),   

  

('Carl', 'Nielsen', 'Vej 3', 'carl.nielsen@example.com', '34567890'),   

  

('Diana', 'Larsen', 'Vej 4', 'diana.larsen@example.com', '45678901'),  

  

('Erik', 'Christensen', 'Vej 5', 'erik.christensen@example.com', '56789012'),  

  

('Fie', 'Pedersen', 'Vej 6', 'fie.pedersen@example.com', '67890123'),   

  

('Gitte', 'Andersen', 'Vej 7', 'gitte.andersen@example.com', '78901234'),  

  

('Hans', 'Thomsen', 'Vej 8', 'hans.thomsen@example.com', '89012345'),   

  

('Ingrid', 'Møller', 'Vej 9', 'ingrid.moller@example.com', '90123456'),   

  

('Jens', 'Olsen', 'Vej 10', 'jens.olsen@example.com', '01234567'),   

  

('Karen', 'Petersen', 'Vej 11', 'karen.petersen@example.com', '11234567'),  

  

('Lars', 'Sørensen', 'Vej 12', 'lars.sorensen@example.com', '12234567'),  

  

('Mette', 'Krogh', 'Vej 13', 'mette.krogh@example.com', '13234567'),   

  

('Nina', 'Jørgensen', 'Vej 14', 'nina.jorgensen@example.com', '14234567'),   

  

('Ole', 'Frandsen', 'Vej 15', 'ole.frandsen@example.com', '15234567'),   

  

('Pia', 'Mortensen', 'Vej 16', 'pia.mortensen@example.com', '16234567'),   

  

('Rasmus', 'Christiansen', 'Vej 17', 'rasmus.christiansen@example.com', '17234567'), ('Sanne', 'Schmidt', 'Vej 18', 'sanne.schmidt@example.com', '18234567'),   

  

('Tina', 'Bro', 'Vej 19', 'tina.bro@example.com', '19234567'),   

  

('Ulla', 'Nørgaard', 'Vej 20', 'ulla.norgaard@example.com', '20234567'),  

  

('Viggo', 'Bang', 'Vej 21', 'viggo.bang@example.com', '21234567'),   

  

('Winnie', 'Holm', 'Vej 22', 'winnie.holm@example.com', '22234567'),   

  

('Xenia', 'Bach', 'Vej 23', 'xenia.bach@example.com', '23234567'),   

  

('Yvonne', 'Lauritsen', 'Vej 24', 'yvonne.lauritsen@example.com', '24234567'),  

  

('Zenia', 'Knudsen', 'Vej 25', 'zenia.knudsen@example.com', '25234567'),  

  

('Arthur', 'Brandt', 'Vej 26', 'arthur.brandt@example.com', '26234567'),  

  

('Berit', 'Bonde', 'Vej 27', 'berit.bonde@example.com', '27234567'),   

  

('Clara', 'Klint', 'Vej 28', 'clara.klint@example.com', '28234567'),   

  

('Dennis', 'Skov', 'Vej 29', 'dennis.skov@example.com', '29234567'),   

  

('Eva', 'Lund', 'Vej 30', 'eva.lund@example.com', '30234567'),   

  

('Frederik', 'Eg', 'Vej 31', 'frederik.eg@example.com', '31234567'),   

  

('Grethe', 'Dahl', 'Vej 32', 'grethe.dahl@example.com', '32234567'),   

  

('Henrik', 'Kruse', 'Vej 33', 'henrik.kruse@example.com', '33234567'),  

  

('Ida', 'Storm', 'Vej 34', 'ida.storm@example.com', '34234567'),   

  

('Jakob', 'Dam', 'Vej 35', 'jakob.dam@example.com', '35234567'),   

  

('Lone', 'Frost', 'Vej 36', 'lone.frost@example.com', '36234567'),   

  

('Morten', 'Hedegaard', 'Vej 37', 'morten.hedegaard@example.com', '37234567'),   

  

('Niels', 'Mejer', 'Vej 38', 'niels.mejer@example.com', '38234567'),   

  

('Pernille', 'Birk', 'Vej 39', 'pernille.birk@example.com', '39234567'),   

  

('Søren', 'Vestergaard', 'Vej 40', 'soren.vestergaard@example.com', '40234567'),   

  

('Therese', 'Sand', 'Vej 41', 'therese.sand@example.com', '41234567'),   

  

('Ulrik', 'Overgaard', 'Vej 42', 'ulrik.overgaard@example.com', '42234567'),  

  

('Vibeke', 'Strand', 'Vej 43', 'vibeke.strand@example.com', '43234567'),   

  

('Willy', 'Nielsen', 'Vej 44', 'willy.nielsen@example.com', '44234567'),   

  

('Åse', 'Juhl', 'Vej 45', 'ase.juhl@example.com', '45234567'),   

  

('Bente', 'Holst', 'Vej 46', 'bente.holst@example.com', '46234567'),   

  

('Carsten', 'Ebbesen', 'Vej 47', 'carsten.ebbesen@example.com', '47234567'),   

  

('Dorte', 'Bo', 'Vej 48', 'dorte.bo@example.com', '48234567'),   

  

('Flemming', 'Frost', 'Vej 49', 'flemming.frost@example.com', '49234567'),   

  

('Gunhild', 'Sund', 'Vej 50', 'gunhild.sund@example.com', '50234567'),  

  

('Helga', 'Jensen', 'Vej 51', 'helga.jensen@example.com', '51234567'),   

  

('Iver', 'Brøndum', 'Vej 52', 'iver.brondum@example.com', '52234567'),   

  

('Jette', 'Holm', 'Vej 53', 'jette.holm@example.com', '53234567'),   

  

('Karl', 'Gade', 'Vej 54', 'karl.gade@example.com', '54234567'),   

  

('Lisbeth', 'Overby', 'Vej 55', 'lisbeth.overby@example.com', '55234567'),   

  

('Mads', 'Schou', 'Vej 56', 'mads.schou@example.com', '56234567'),   

  

('Olga', 'Andresen', 'Vej 57', 'olga.andresen@example.com', '57234567'),   

  

('Per', 'Daugaard', 'Vej 58', 'per.daugaard@example.com', '58234567'),   

  

('Randi', 'Sørensen', 'Vej 59', 'randi.sorensen@example.com', '59234567'),   

  

('Stig', 'Friis', 'Vej 60', 'stig.friis@example.com', '60234567'),   

  

('Tom', 'Bak', 'Vej 61', 'tom.bak@example.com', '61234567'),   

  

('Ursula', 'Koch', 'Vej 62', 'ursula.koch@example.com', '62234567'),   

  

('Verner', 'Vang', 'Vej 63', 'verner.vang@example.com', '63234567'),  

  

('Yngve', 'Østergård', 'Vej 64', 'yngve.ostergard@example.com', '64234567'),   

  

('Åge', 'Holm', 'Vej 65', 'age.holm@example.com', '65234567');  

  

  

INSERT INTO Abonnementer (KundeID, BilID, Startdato, Slutdato, PrisPrMaaned, Maxkm) VALUES  

  

(1, 1, '2023-01-01', '2023-12-31', 3000, 20000),  

  

(2, 2, '2023-02-01', '2023-12-31', 3500, 25000),  

  

(3, 3, '2023-03-01', '2023-12-31', 4000, 30000),  

  

(4, 4, '2023-04-01', '2023-12-31', 4500, 35000),  

  

(5, 5, '2023-05-01', '2023-12-31', 5000, 40000),  

  

(6, 6, '2023-06-01', '2023-12-31', 3200, 22000),  

  

(7, 7, '2023-07-01', '2023-12-31', 3700, 27000),  

  

(8, 8, '2023-08-01', '2023-12-31', 4200, 32000),  

  

(9, 9, '2023-09-01', '2023-12-31', 4700, 37000),  

  

(10, 10, '2023-10-01', '2023-12-31', 5200, 42000),  

  

(11, 11, '2023-11-01', '2023-12-31', 3300, 23000),  

  

(12, 12, '2023-12-01', '2023-12-31', 3800, 28000),  

  

(13, 13, '2024-01-01', '2024-12-31', 4300, 33000),  

  

(14, 14, '2024-02-01', '2024-12-31', 4800, 38000),  

  

(15, 15, '2024-03-01', '2024-12-31', 5300, 43000),  

  

(16, 16, '2024-04-01', '2024-12-31', 3400, 24000),  

  

(17, 17, '2024-05-01', '2024-12-31', 3900, 29000),  

  

(18, 18, '2024-06-01', '2024-12-31', 4400, 34000),  

  

(19, 19, '2024-07-01', '2024-12-31', 4900, 39000),  

  

(20, 20, '2024-08-01', '2024-12-31', 5400, 44000),  

  

(21, 21, '2024-09-01', '2024-12-31', 3500, 25000),  

  

(22, 22, '2024-10-01', '2024-12-31', 4000, 30000),  

  

(23, 23, '2024-11-01', '2024-12-31', 4500, 35000),  

  

(24, 24, '2024-12-01', '2024-12-31', 5000, 40000),  

  

(25, 25, '2023-01-01', '2023-12-31', 3100, 21000),  

  

(26, 26, '2023-02-01', '2023-12-31', 3600, 26000),  

  

(27, 27, '2023-03-01', '2023-12-31', 4100, 31000),  

  

(28, 28, '2023-04-01', '2023-12-31', 4600, 36000),  

  

(29, 29, '2023-05-01', '2023-12-31', 5100, 41000),  

  

(30, 30, '2023-06-01', '2023-12-31', 3200, 22000),  

  

(31, 31, '2023-07-01', '2023-12-31', 3700, 27000),  

  

(32, 32, '2023-08-01', '2023-12-31', 4200, 32000),  

  

(33, 33, '2023-09-01', '2023-12-31', 4700, 37000),  

  

(34, 34, '2023-10-01', '2023-12-31', 5200, 42000),  

  

(35, 35, '2023-11-01', '2023-12-31', 3300, 23000),  

  

(36, 36, '2023-12-01', '2023-12-31', 3800, 28000),  

  

(37, 37, '2024-01-01', '2024-12-31', 4300, 33000),  

  

(38, 38, '2024-02-01', '2024-12-31', 4800, 38000),  

  

(39, 39, '2024-03-01', '2024-12-31', 5300, 43000),  

  

(40, 40, '2024-04-01', '2024-12-31', 3400, 24000),  

  

(41, 41, '2024-05-01', '2024-12-31', 3900, 29000),  

  

(42, 42, '2024-06-01', '2024-12-31', 4400, 34000),  

  

(43, 43, '2024-07-01', '2024-12-31', 4900, 39000),  

  

(44, 44, '2024-08-01', '2024-12-31', 5400, 44000),  

  

(45, 45, '2024-09-01', '2024-12-31', 3500, 25000),  

  

(46, 46, '2024-10-01', '2024-12-31', 4000, 30000),  

  

(47, 47, '2024-11-01', '2024-12-31', 4500, 35000),  

  

(48, 48, '2024-12-01', '2024-12-31', 5000, 40000),  

  

(49, 49, '2023-01-01', '2023-12-31', 3100, 21000),  

  

(50, 50, '2023-02-01', '2023-12-31', 3600, 26000),  

  

(51, 51, '2023-03-01', '2023-12-31', 4100, 31000),  

  

(52, 52, '2023-04-01', '2023-12-31', 4600, 36000),  

  

(53, 53, '2023-05-01', '2023-12-31', 5100, 41000),  

  

(54, 54, '2023-06-01', '2023-12-31', 3200, 22000),  

  

(55, 55, '2023-07-01', '2023-12-31', 3700, 27000),  

  

(56, 56, '2023-08-01', '2023-12-31', 4200, 32000),  

  

(57, 57, '2023-09-01', '2023-12-31', 4700, 37000),  

  

(58, 58, '2023-10-01', '2023-12-31', 5200, 42000),  

  

(59, 59, '2023-11-01', '2023-12-31', 3300, 23000),  

  

(60, 60, '2023-12-01', '2023-12-31', 3800, 28000),  

  

(61, 61, '2024-01-01', '2024-12-31', 4300, 33000),  

  

(62, 62, '2024-02-01', '2024-12-31', 4800, 38000),  

  

(63, 63, '2024-03-01', '2024-12-31', 5300, 43000),  

  

(64, 64, '2024-04-01', '2024-12-31', 3400, 24000),  

  

(65, 65, '2024-05-01', '2024-12-31', 3900, 29000),  

  

(12, 66, '2023-06-01', '2023-12-31', 4200, 32000),  

  

(28, 67, '2023-07-01', '2023-12-31', 4700, 37000),  

  

(32, 68, '2023-08-01', '2023-12-31', 5200, 42000),  

  

(49, 69, '2023-09-01', '2023-12-31', 3300, 23000),  

  

(53, 70, '2023-10-01', '2023-12-31', 3800, 28000); 