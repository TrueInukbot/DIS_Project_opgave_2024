UPDATE kunder
SET fornavn = :fornavn,
    efternavn = :efternavn,
    adresse = :adresse,
    email = :email,
    telefon = :telefon
WHERE kundeid = :kundeid;