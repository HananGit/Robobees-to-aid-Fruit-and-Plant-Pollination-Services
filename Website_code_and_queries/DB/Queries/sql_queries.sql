
use new;
SELECT * FROM Request;
select * from robobee;
select * from DRONE;

create table robobee(ID INTEGER PRIMARY KEY AUTO_INCREMENT,Stat varchar(50),DroneId INTEGER,RequestId INTEGER,CONSTRAINT request2_fk FOREIGN KEY(DroneId) REFERENCES Drone(DroneId),CONSTRAINT request1_fk FOREIGN KEY(RequestId) REFERENCES Request(RequestId));


create table request(RequestId INTEGER PRIMARY KEY AUTO_INCREMENT,username varchar(30) not null, status varchar(50));
INSERT INTO request(username, status) VALUES ('yash2','pending approval') ;

DELIMITER $$
create trigger after_request_insert
AFTER INSERT on Request
for each row
begin
INSERT INTO Drone
   SET Stat = 'working',
       RequestId = (
       SELECT RequestId
         FROM Request
        WHERE status = 'pending approval');
end $$
DELIMITER ;


create table drone(DroneId INTEGER PRIMARY KEY AUTO_INCREMENT,Stat varchar(50),RequestId INTEGER,CONSTRAINT request_fk FOREIGN KEY(RequestId) REFERENCES Request(RequestId));
 

DELIMITER $$
create trigger after_drone_insert1
after insert on Drone
for each row
begin
call insert_drone2();
end$$
DELIMITER $$

DELIMITER $$
create procedure insert_drone2()
BEGIN
declare x int;
set x = 1 ;
   while (x < 50) do
   insert into robobee 
     SET Stat='busy',
     DroneId = (
     SELECT DroneId from Drone where Stat='working'),
     RequestId = (
     SELECT RequestId from Request where status='Pending approval');
     set x=x+1;
    end while;
END$$
DELIMITER $$


set global event_scheduler = on;
DELIMITER $$
CREATE EVENT a_update
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 10 SECOND
DO 
BEGIN
 call changeStatus1();
END $$
DELIMITER ;

set global event_scheduler = on;
DELIMITER $$
CREATE EVENT b_update
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 20 SECOND
DO 
BEGIN
 call changeStatus2();
END $$
DELIMITER ;

set global event_scheduler = on;
DELIMITER $$
CREATE EVENT c_update
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 30 SECOND
DO 
BEGIN
 call changeStatus3();
END $$
DELIMITER ;

show events;

DELIMITER //
CREATE procedure changeStatus1()
BEGIN
UPDATE robobee SET Stat='In Transit'
WHERE Stat='busy';
END //
DELIMITER ;

DELIMITER //
CREATE procedure changeStatus2()
BEGIN
update robobee set Stat='Pollination in Process'
where Stat='In Transit';
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE changeStatus3()
BEGIN
UPDATE robobee SET Stat='Pollinated'
WHERE Stat='Pollination in process';
END //
DELIMITER ;

CREATE TABLE Flower(FlowerId INTEGER PRIMARY KEY auto_increment,FlowerName VARCHAR(50) NOT NULL,PollinatedFlowersNumber INTEGER NOT NULL);
START transaction;
INSERT INTO Flower VALUES (121, 'Aster', 12);
INSERT INTO Flower VALUES (122, 'Sunflowers', 10);
INSERT INTO Flower VALUES (123, 'Marigold', 6);
INSERT INTO Flower VALUES (124, 'Primulas', 14);
INSERT INTO Flower VALUES (125, 'Rudbekia', 9);
INSERT INTO Flower VALUES (126, 'Cornflowers', 11);
INSERT INTO Flower VALUES (127, 'Lavender', 15);
INSERT INTO Flower VALUES (128, 'Bluebells', 8);
INSERT INTO Flower VALUES (129, 'Fennel', 4);
INSERT INTO Flower VALUES (130, 'Lantana', 13);
INSERT INTO Flower VALUES (131, 'Borage', 14);
INSERT INTO Flower VALUES (132, 'Oregano', 18);
INSERT INTO Flower VALUES (133, 'Alstroemeria', 15);
INSERT INTO Flower VALUES (134, 'Penstemon', 9);
INSERT INTO Flower VALUES (135, 'Salvia', 16);
INSERT INTO Flower VALUES (136, 'Daisy', 14);
INSERT INTO Flower VALUES (137, 'Coneflower', 16);
INSERT INTO Flower VALUES (138, 'Yarrow', 13);
INSERT INTO Flower VALUES (139, 'Goldenrod', 14);
INSERT INTO Flower VALUES (140, 'Crocus', 15);
INSERT INTO Flower VALUES (141, 'Roses', 17);
INSERT INTO Flower VALUES (142, 'Catmint', 22);
INSERT INTO Flower VALUES (143, 'Sedum', 12);
INSERT INTO Flower VALUES (144, 'Foxglove', 23);
COMMIT;

CREATE VIEW request_view AS 
SELECT request.RequestId, request.status, robobee.DroneId, robobee.Stat
FROM request JOIN robobee ON request.RequestId= robobee.RequestId;

SELECT * FROM request_view;
select * from robobee where RequestId=(select RequestId from request where username='yash2');

create user newuser identified by '123a';

grant select on flower to newuser;
grant update (flowername) on flower to newuser;

grant insert on flower to newuser;
Revoke insert on flower from newuser;

INSERT INTO Flower VALUES (122, 'Sunflowers', 10);
update flower set flowername='new' where flowerid=122;

DELIMITER $$
CREATE TRIGGER requestStatus
AFTER INSERT ON robobee
FOR EACH ROW
BEGIN
UPDATE request set status= 'robobees created' where RequestId=new.RequestId;
END $$
DELIMITER ;


create user newuser identified by '123a';

grant select on robobee to newuser;

grant select on request to newuser;
grant update(status) on request to newuser;

grant select on flower to newuser;
grant update (flowername) on flower to newuser;

grant insert on flower to newuser;
Revoke insert on flower from newuser;

select * from robobee where requestId=(select RequestId from request where userid=001257945);

select * from requestdetails where requestId=(select requestid from request where userid=001257945);

SELECT robobee.Stat from robobee inner join request on robobee.RequestId=request.RequestId 
where request.RequestId=1;

CREATE VIEW Robobee_request AS
SELECT robobee.Stat from robobee inner join request on robobee.RequestId=request.RequestId 
where request.RequestId=1;

DELIMITER//
Create Procedure droneScan()
BEGIN
Update Drone set X_Coordinate=FLOOR(RAND()*(50-1+1))+1,Y_Coordinate=FLOOR(RAND()*(50-1+1))+1
where PlantCategory is not null;
END
DELIMITER;

set global event_scheduler=on;
DELIMITER $$
Create Event generateCoordinates
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 5 SECOND
DO
BEGIN
CALL droneScan();
END$$
DELIMITER;
