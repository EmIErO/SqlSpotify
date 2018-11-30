
--index with tests
EXPLAIN SELECT login FROM account WHERE login = 'h7ft42';

CREATE INDEX login_index ON account(login);

EXPLAIN SELECT login FROM account WHERE login = 'h7ft42';

DROP INDEX login_index;