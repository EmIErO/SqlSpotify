DELETE FROM account_subscription;

INSERT INTO account_subscription (id_account, id_subscription, start_date)
SELECT id_account,
       random_subscription(),
       random_date('2018-01-01', '2018-11-29')
FROM account
WHERE id_account % 7 > 3 AND firstname LIKE '%a%';




CREATE OR REPLACE FUNCTION random_date (fromDate DATE, toDate DATE) RETURNS DATE  AS $$
DECLARE
 days_between INT;
 days_rand INT;

BEGIN
 SELECT $2 - $1 INTO days_between;
 SELECT cast(random() * days_between as INT) INTO days_rand;
 RETURN $1 + days_rand;
END;
$$ LANGUAGE 'plpgsql';



CREATE OR REPLACE FUNCTION random_subscription () RETURNS INT AS $$
DECLARE
 id INT;

 BEGIN
 SELECT id_subscription FROM subscription ORDER BY random() LIMIT 1 INTO id;
 RETURN id;
 END;
$$ LANGUAGE  'plpgsql';

CREATE VIEW invalidSubscription AS
    SELECT a.firstname || ' ' || a.surname AS fullName,
           asub.start_date AS startDate,
           asub.start_date + s.days AS endDate,
           s.name AS subsriptionType
        FROM account_subscription asub
             INNER JOIN account a ON  asub.id_account = a.id_account
             INNER JOIN subscription s on asub.id_subscription = s.id_subscription
WHERE asub.start_date + s.days < current_date
ORDER BY endDate DESC;


SELECT * FROM invalidSubscription;
DROP VIEW invalidSubscription;


