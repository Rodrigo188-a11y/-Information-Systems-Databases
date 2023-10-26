------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------Simple SQL Queries---------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--A. The name of all boats that are used in some trip.
SELECT name_boat
FROM trip t join boat b
                 on t.cni = b.cni
                     and t.name_country=b.name_country
;


--B. The name of all boats that are not used in any trip.
SELECT name_boat
FROM boat
WHERE name_boat NOT IN(
    SELECT name_boat
    FROM trip t join boat b
                     on t.cni = b.cni
                         and t.name_country=b.name_country
);

--C. The name of all boats registered in 'PRT' (ISO code) for
-- which at least one responsible for a
--reservation has a surname that ends with 'Santos'.

SELECT name_boat
FROM country c JOIN boat b
                    ON c.name_country= b.name_country
               JOIN reservation r
                    ON r.cni = b.cni AND r.name_country = b.name_country
               JOIN sailor sa
                    ON r.responsible_senior=sa.email
WHERE iso_code = 'PRT' AND surname LIKE '%Santos';


--D. The full name of all skippers without
-- any certificate corresponding to the class of the trip’s boat.

SELECT DISTINCT first_name, surname, email
FROM sailor s
JOIN trip t
    ON s.email = t.skipper_email
WHERE (first_name, surname) NOT IN(
    SELECT DISTINCT first_name, surname
        FROM(SELECT first_name, surname, has_name_boatclass as boat_class, for_class as sailor_certificate
             FROM sailor s
                 JOIN sailing_certificate sc
                     ON s.email = sc.email
                 JOIN trip t
                     ON s.email = t.skipper_email
                 JOIN reservation r
                     ON t.name_country = r.name_country
                         AND t.cni = r.cni AND t.start_date = r.start_date AND t.end_date = r.end_date
                 JOIN boat b
                     ON b.name_country = r.name_country
                         AND b.cni = r.cni) as sstrb
        WHERE boat_class = sailor_certificate);