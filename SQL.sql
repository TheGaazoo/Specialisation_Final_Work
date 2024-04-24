/*7. В подключенном MySQL репозитории создать базу данных “Друзья человека”*/
CREATE DATABASE Human_friends;
/*8. Создать таблицы с иерархией из диаграммы в БД*/
USE Human_friends;
CREATE TABLE HUMAN_FRIENDS
(
	Id INT AUTO_INCREMENT PRIMARY KEY, 
	Class_name VARCHAR(20)
);

INSERT INTO HUMAN_FRIENDS (Class_name)
VALUES ('Вьючные животные'),
('Домашние животные');  


CREATE TABLE Packed_animals
(
	  Id INT AUTO_INCREMENT PRIMARY KEY,
    Animal_name VARCHAR (20),
    Class_id INT,
    FOREIGN KEY (Class_id) REFERENCES HUMAN_FRIENDS (Id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO Packed_animals (Animal_name, Class_id)
VALUES ('Лошади', 1),
('Ослы', 1),  
('Верблюды', 1); 
    
CREATE TABLE Pets
(
	  Id INT AUTO_INCREMENT PRIMARY KEY,
    Animal_name VARCHAR (20),
    Class_id INT,
    FOREIGN KEY (Class_id) REFERENCES HUMAN_FRIENDS (Id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO Pets (Animal_name, Class_id)
VALUES ('Кошки', 2),
('Собаки', 2),  
('Хомяки', 2); 

/*
9. Заполнить низкоуровневые таблицы именами (животных), 
командами которые они выполняют и датами рождения.
*/

CREATE TABLE Cats 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    animal_id int,
    Foreign KEY (animal_id) REFERENCES Pets (Id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO Cats (Name, Birthday, Commands, animal_id)
VALUES ('Барсик', '2020-01-31', 'Кушать', 1),
('Мурзик', '2018-11-05', "Какать!", 1),  
('Рыжик', '2023-02-02', "Спать!", 1); 

CREATE TABLE Dogs 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    animal_id int,
    Foreign KEY (animal_id) REFERENCES Pets (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Dogs (Name, Birthday, Commands, animal_id)
VALUES ('Тузик', '2021-10-02', 'Голос!', 2),
('Антон', '2021-05-10', "Лежать!", 2),  
('Рэкс', '2020-06-06', "Убить!", 2);

CREATE TABLE Hamsters 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    animal_id int,
    Foreign KEY (animal_id) REFERENCES Pets (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Hamsters (Name, Birthday, Commands, animal_id)
VALUES ('Хома', '2022-01-05', 'Бежать!', 3),
('Монстр', '2021-10-12', 'Жрать!', 3),  
('Пушок', '2022-02-02', 'Какать!', 3);

CREATE TABLE Horses 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    animal_id int,
    Foreign KEY (animal_id) REFERENCES Packed_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Horses (Name, Birthday, Commands, animal_id)
VALUES ('Смельчак', '2018-04-05', 'Галоп!', 1),
('Слевин', '2020-12-02', "Прыжок!", 1),  
('Оптимус Прайм', '2017-07-01', "Бежать!", 1);

CREATE TABLE Donkeys 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    animal_id int,
    Foreign KEY (animal_id) REFERENCES Packed_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Donkeys (Name, Birthday, Commands, animal_id)
VALUES ('Моисей', '2020-05-09', 'Не тупи!', 2),
('Соломон', '2020-03-12', 'Неси!', 2),  
('Магомед', '2021-07-12', 'Иди!', 2);

CREATE TABLE Camels 
(       
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(20), 
    Birthday DATE,
    Commands VARCHAR(50),
    animal_id int,
    Foreign KEY (animal_id) REFERENCES Packed_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO Camels (Name, Birthday, Commands, animal_id)
VALUES ('Алладин', '2020-02-11', 'Бегом!', 3),
('Камел', '2019-08-08', 'Стой!', 3),  
('Джаффар', '2016-09-09', 'Неси!', 3);

/*
10. Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой 
питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.
*/
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Camels;

SELECT Name, Birthday, Commands FROM Horses
UNION SELECT  Name, Birthday, Commands FROM Donkeys;

/*
11. Создать новую таблицу “молодые животные” в которую попадут 
все животные старше 1 года, но младше 3 лет и в отдельном 
столбце с точностью до месяца подсчитать возраст животных в новой таблице.
*/
CREATE TEMPORARY TABLE Animals AS 
SELECT *, 'Лошади' AS animal_type FROM Horses
UNION SELECT *, 'Ослы' AS animal_type FROM Donkeys
UNION SELECT *, 'Собаки' AS animal_type FROM Dogs
UNION SELECT *, 'Кошки' AS animal_type FROM Cats
UNION SELECT *, 'Хомяки' AS animal_type FROM Hamsters;

CREATE TABLE Young_animal AS
SELECT Name, Birthday, Commands, animal_type, TIMESTAMPDIFF(MONTH, Birthday, CURDATE()) AS Age_in_month
FROM Animals WHERE Birthday BETWEEN ADDDATE(curdate(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);
 
SELECT * FROM Young_animal;

/*
12. Объединить все таблицы в одну, при этом
 сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.
*/
SELECT h.Name, h.Birthday, h.Commands, pa.Animal_name, ya.Age_in_month 
FROM Horses h
LEFT JOIN Young_animal ya ON ya.Name = h.Name
LEFT JOIN Packed_animals pa ON pa.Id = h.animal_id
UNION 
SELECT d.Name, d.Birthday, d.Commands, pa.Animal_name, ya.Age_in_month 
FROM Donkeys d 
LEFT JOIN Young_animal ya ON ya.Name = d.Name
LEFT JOIN Packed_animals pa ON pa.Id = d.animal_id
UNION
SELECT c.Name, c.Birthday, c.Commands, p.Animal_name, ya.Age_in_month 
FROM Cats c
LEFT JOIN Young_animal ya ON ya.Name = c.Name
LEFT JOIN Pets p ON p.Id = c.animal_id
UNION
SELECT d.Name, d.Birthday, d.Commands, p.Animal_name, ya.Age_in_month 
FROM Dogs d
LEFT JOIN Young_animal ya ON ya.Name = d.Name
LEFT JOIN Pets p ON p.Id = d.animal_id
UNION
SELECT hm.Name, hm.Birthday, hm.Commands, p.Animal_name, ya.Age_in_month 
FROM Hamsters hm
LEFT JOIN Young_animal ya ON ya.Name = hm.Name
LEFT JOIN Pets p ON p.Id = hm.animal_id;