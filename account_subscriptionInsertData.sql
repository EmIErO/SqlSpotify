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



CREATE  FUNCTION random_subscription () RETURNS INT AS $$

DECLARE
 id INT;

 BEGIN

 SELECT id_subscription FROM subscription ORDER BY random() LIMIT 1 INTO id;
 RETURN id;

 END;
$$ LANGUAGE  'plpgsql';

