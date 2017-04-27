--
-- The data tables of TTVG
--

set sql_mode='';
set storage_engine=myisam;

-- Tables for the Users
-- Define all persons
CREATE TABLE IF NOT EXISTS person ( Id int unsigned not null, ParentId int, GivenName char(128) binary DEFAULT '' NOT NULL, LastName char(128) binary DEFAULT '' NOT NULL, MiddleName char(128) binary DEFAULT '', Phone char(128) binary DEFAULT '', Mobile char(128) binary DEFAULT '', Address char(255) binary DEFAULT '', PRIMARY KEY Id (Id), FOREIGN KEY (ParentId) REFERENCES person (Id) ) engine=MyISAM CHARACTER SET utf8 COLLATE utf8_bin comment='Database privileges';

-- Define all user accounts and link to the person
CREATE TABLE IF NOT EXISTS account ( Id int unsigned not null, PersonId int unsigned not null, Email char(128) binary DEFAULT '' NOT NULL, Password char(128) binary DEFAULT '' NOT NULL, PRIMARY KEY Id (Id), FOREIGN KEY (PersonId) REFERENCES person (Id) ) engine=MyISAM CHARACTER SET utf8 COLLATE utf8_bin comment='Database privileges';

