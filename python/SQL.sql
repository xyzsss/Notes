CREATE DATABASE dy2018 DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

create table film ( \
id int(4) primary key not null auto_increment, \
name char(40) not null default '' ,\
rank char(10) not null default '0', \
type varchar(30) not null default '', \
redate varchar(20) default null , \
content text not null , \
downlinks varchar(100) default null \
) CHARACTER SET utf8 COLLATE utf8_bin ;

# If created, then change it.
# ALTER DATABASE dy2018 CHARACTER SET utf8 COLLATE utf8_general_ci;


# clear/delete/truncate table
>>> truncate table table_name; 
    fast; but no log without to restore.
>>> delete from table_name;
    slow; but restoreable


# Alter column
ALTER TABLE film CHANGE name name CHAR(40);