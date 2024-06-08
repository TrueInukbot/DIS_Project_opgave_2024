CREATE OR REPLACE VIEW available_cars AS
SELECT 
    b.bilid, 
    b.maerke, 
    b.model, 
    b.braendstoftype, 
    b.hestekraefter, 
    b.stelnummer,
    b.vognnummer, 
    b.odometer, 
    b.produktionsaar, 
    b.lokation, 
    b.billede
FROM 
    biler b
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM abonnementer a
        WHERE a.bilid = b.bilid
        AND (a.startdato <= current_date AND a.slutdato >= current_date)
    );

-- View to get cars by location and date range
CREATE OR REPLACE VIEW cars_by_location_and_date AS
SELECT
    b.bilid,
    b.maerke,
    b.model,
    b.braendstoftype,
    b.hestekraefter,
    b.stelnummer,
    b.vognnummer,
    b.odometer,
    b.produktionsaar,
    b.lokation,
    b.billede,
    a.startdato,
    a.slutdato
FROM
    biler b
LEFT JOIN
    abonnementer a ON b.bilid = a.bilid;