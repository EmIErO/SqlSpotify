CREATE TRIGGER check_user_exist
  BEFORE INSERT ON account
  for each row
  execute procedure check_if_user_exists();

--trigger test
insert into account(login, password, firstname, surname, gender, email) values ('yoni9q37m96m9sb','AxmcDZo`hH]sFHajvI','Jewell','Mccaskin','male','metalshemika@msn.com');
