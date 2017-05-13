## MySQL.
##

    desc <table>; - Опис таблиці
      
## Docker mysql:
        
    docker pull mysql
    docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=admin -d mysql
    mysql -uroot -h 127.0.0.1 -p

## query
    create database sport;
    use sport;
    create table countries ( country_id int unsigned not null primary key auto_increment, country_name varchar(255) not null                            );
    
    insert countries (country_id, country_name) values (1, 'Ukraine'), (NULL, 'Spaine'), (NULL, 'England'), (NULL, 'Italy'), (NULL, 'Germany'), (NULL, 'France');
    
    select * from countries;
    
    create table teams (team_id int unsigned auto_increment primary key, country_id int unsigned, team_name varchar(50), foreign key(country_id) references countries(country_id));
    
    insert into teams (team_id, country_id, team_name) values (1,1, 'Karpaty'), (2,2, 'Real Madryd'), (3,3, 'Manchester United'), (4,4, 'Lacio'), (5,5, 'Bavaria'), (6,6, 'PSZ');
    
    create table players (player_id int unsigned not null auto_increment primary key, player_name varchar(100), team_id int unsigned, country_id int unsigned, foreign key(team_id) references teams(team_id), foreign key(country_id) references countries(country_id));
    
    insert players (player_id, player_name, team_id, country_id) values (1, 'Ivan Ivanov', 1, 1), (2, 'Ronaldo', 3, 3), (3, 'Marco Veratti', 6, 4);















# SS course
    CREATE TABLE ORDERS (ID INT primary key, 
    PRODUCT_NAME VARCHAR(30), 
    PRODUCT_PRICE FLOAT,
    DATE_ORDER DATE,
    ID_CUSTOMER INT,
    AMOUNT INT,
    FOREIGN KEY(ID_CUSTOMER) REFERENCES CUSTOMERS(ID) on delete cascade);
    
## Aggreagation
    select max(AMOUNT) MAX_RATE from ORDERS;
