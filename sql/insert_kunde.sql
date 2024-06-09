INSERT INTO kunder (fornavn, efternavn, adresse, email, telefon)
VALUES (:fornavn, :efternavn, :adresse, :email, :telefon)
RETURNING kundeid;