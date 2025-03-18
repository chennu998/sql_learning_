
/*Short database description "Computer firm":

Скрыть|Hide
The database scheme consists of four tables:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, screen, price)
Printer(code, model, color, type, price)
The Product table contains data on the maker, model number, and type of product ('PC', 'Laptop', or 'Printer'). 
It is assumed that model numbers in the Product table are unique for all makers and product types. Each personal computer in the PC table is unambiguously identified by a unique code, and is additionally characterized by its model (foreign key referring to the Product table), processor speed (in MHz) – speed field, RAM capacity (in Mb) - ram, hard disk drive capacity (in Gb) – hd, CD-ROM speed (e.g, '4x') - cd, and its price. The Laptop table is similar to the PC table, except that instead of the CD-ROM speed, it contains the screen size (in inches) – screen. For each printer model in the Printer table, its output type 
(‘y’ for color and ‘n’ for monochrome) – color field, printing technology ('Laser', 'Jet', or 'Matrix') – type, and price are specified.*/



--question 1 
Find the model number, speed and hard drive capacity for all the PCs with prices below $500.
Result set: model, speed, hd.
--answer
select model,speed,hd from PC where price<500

--question 2 
List all printer makers. Result set: maker.
--answer 
select distinct maker from Product where type='printer'


--question 3 
Find the model number, RAM and screen size of the laptops with prices over $1000.
--answer
select model,ram,screen from Laptop where price>1000


--question 4 
Find all records from the Printer table containing data about color printers.
--answer
select * from Printer where color='y'


--question 5 
Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive.
--answer
select model,speed,hd from PC 
where price<600 and (cd='12x' or cd='24x')

--question 6 
For each maker producing laptops with a hard drive capacity of 10 Gb or higher, 
find the speed of such laptops. Result set: maker, speed.
--answer
select p.maker,l.speed from Product p
inner join Laptop l on p.model=l.model
where l.hd>=10 


--question 7 
Get the models and prices for all commercially available products (of any type) produced by maker B.
--answer
select PC.model as model,
PC.price  as price 
from Product inner join 
PC on Product.model=PC.model
where Product.maker='B'
union 
select Laptop.model as model,
Laptop.price  as price 
from Product inner join 
Laptop on Product.model=Laptop.model
where Product.maker='B'
union
select Printer.model as model,
Printer.price  as price 
from Product inner join 
Printer on Product.model=Printer.model
where Product.maker='B'

--question 8 
Find the makers producing PCs but not laptops.
--answer 
select distinct maker from Product
where type='PC' and maker not in (select distinct maker from Product
where type='laptop')

--question 9 
Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker.
--answer
select distinct Product.maker as maker
from Product inner join PC 
on Product.model=PC.model
where PC.speed>=450

--question 10
Find the printer models having the highest price. Result set: model, price.
--answer
select model,price from Printer
where price=(select max(price) from Printer)

--question 11
Find out the average speed of PCs.
--answer
select avg(speed) from PC


--question 12
Find out the average speed of the laptops priced over $1000.
--answer
select avg(speed) as avgspeed from Laptop
where price>1000

--question 13
Find out the average speed of the PCs produced by maker A
--answer
select avg(PC.speed) as avgspeed 
from Product inner join PC
on Product.model=PC.model
where Product.maker='A'


--question 15
Get hard drive capacities that are identical for two or more PCs.
Result set: hd.
--answer
select hd from PC
group by hd
having count(hd)>=2

--question 16
Get pairs of PC models with identical speeds and the same RAM capacity. 
Each resulting pair should be displayed only once, i.e. (i, j) but not (j, i).
Result set: model with the bigger number, model with the smaller number, speed, and RAM.
--answer
select distinct case when a.model>b.model then a.model else b.model end as model,
case when a.model<b.model then a.model else b.model end as model,a.speed,a.ram from PC a,PC b
where a.speed=b.speed and a.ram=b.ram and a.code!=b.code
and a.model!=b.model


--question 17
Get the laptop models that have a speed smaller than the speed of any PC.
Result set: type, model, speed.
--answer
select distinct Product.type,Laptop.model,Laptop.speed
from Product inner join Laptop
on Product.model=Laptop.model
where Laptop.speed<(select min(speed) from PC)

--question 18
Find the makers of the cheapest color printers.
Result set: maker, price.
--answer
select distinct Product.maker as Maker,Printer.price as price
from Product inner join Printer
on Product.model=Printer.model
where price=(select min(price) from Printer where color='y')
and Printer.color='y'

--question 19
For each maker having models in the Laptop table, 
find out the average screen size of the laptops he produces.
Result set: maker, average screen size.
--answer
select Product.maker as maker,avg(Laptop.screen)
from Product inner join Laptop 
on Product.model=Laptop.model
group by Product.maker


--question 20 
Find the makers producing at least three distinct models of PCs.
Result set: maker, number of PC models.
--answer
select Product.maker as Maker,
count(distinct Product.model)
from Product left join PC
on Product.model=PC.model
where Product.type='PC'
group by Maker
having count(distinct Product.model)>=3

--question 21
Find out the maximum PC price for each maker having models in the PC table. Result set: maker, maximum price.
--answer
select Product.maker as Maker,
max(PC.price) as maximum_price
from Product join PC 
on Product.model=PC.model
group by Product.maker


--question 22
For each value of PC speed that exceeds 600 MHz, find out the average price of PCs with identical speeds.
Result set: speed, average price.
--answer
select speed,avg(price) as average_price
from PC 
where speed>600
group by speed

--question 23 
Get the makers producing both PCs having a speed of 750 MHz or higher and laptops with a speed of 750 MHz or higher.
Result set: maker
--answer1
select Product.maker as Maker
from Product inner join PC 
on Product.model=PC.model
where PC.speed>=750
intersect
select Product.maker as Maker
from Product inner join Laptop
on Product.model=Laptop.model
where Laptop.speed>=750
--answer2
SELECT DISTINCT p1.maker 
FROM Product p1
INNER JOIN PC ON p1.model = PC.model
WHERE PC.speed >= 750
AND p1.maker IN (
    SELECT DISTINCT p2.maker
    FROM Product p2
    INNER JOIN Laptop ON p2.model = Laptop.model
    WHERE Laptop.speed >= 750
)
--answer3
SELECT DISTINCT p1.maker
FROM Product p1
INNER JOIN PC ON p1.model = PC.model
WHERE PC.speed >= 750
AND EXISTS (
    SELECT 1 
    FROM Product p2
    INNER JOIN Laptop ON p2.model = Laptop.model
    WHERE p2.maker = p1.maker
    AND Laptop.speed >= 750
)

--question 24 
List the models of any type having the highest price of all products present in the database.
--answer
with table1 as (select model,price from PC
where price=(select max(price) from PC)
union
select model,price from Laptop
where price=(select max(price) from Laptop)
union
select model,price from Printer
where price=(select max(price) from Printer))
select model from table1 where price = (select max(price) from table1)

--question 25 
Find the printer makers also producing PCs with the lowest RAM capacity and the highest processor speed of all PCs having the lowest RAM capacity.
Result set: maker.
--answer
select distinct Product.maker as maker from Product
inner join Printer on 
Product.model=Printer.model
where maker in (select Product.maker from Product
inner join PC on 
Product.model=PC.model
where PC.speed=(select max(speed) from PC
where ram=(select min(ram) from PC)))


--question 26 
Find out the average price of PCs and laptops produced by maker A.
Result set: one overall average price for all items.
--answer
select avg(price)
from (select PC.price as price from Product inner join 
PC on Product.model=PC.model 
where Product.maker='A'
union all
select Laptop.price as price from Product inner join 
Laptop on Product.model=Laptop.model 
where Product.maker='A') as temp_table

--question 27 
Find out the average hard disk drive capacity of PCs produced by makers who also manufacture printers.
Result set: maker, average HDD capacity.
--answer
select Product.maker as maker,avg(hd)
from Product inner join PC 
on Product.model=PC.model
where maker in (select Product.maker
from Product inner join Printer
on Product.model=Printer.model
group by Product.maker)
group by maker

--question 28 
Using Product table, find out the number of makers who produce only one model.
--answer
select count(maker) from 
Product 
where maker in (select maker from Product
group by maker
having count(maker)=1)

--question 40(once check with girish)
Get the makers who produce only one product type and more than one model. Output: maker, type.
--answer1
select maker,min(type) AS type from Product
group by maker
having count(distinct type)=1 and count(distinct  model)>1
--answer2
select maker,type 
from
(select maker,min(type) AS type,count(distinct type) as tc,count(distinct model) as mc from Product
group by maker
having count(distinct type)=1 and count(distinct  model)>1)
as temp_table

--question 41(one test case failed)
For each maker who has models at least in one of the tables PC, Laptop, or Printer, 
determine the maximum price for his products.
Output: maker; if there are NULL values among the prices for the products of a given maker, 
display NULL for this maker, otherwise, the maximum price.
--answer1
select maker,max(m_price )
from(select Product.maker as maker,max(PC.price) as m_price 
from Product inner join PC on
Product.model=PC.model
group by Product.maker
union
select Product.maker as maker,max(Laptop.price) as m_price 
from Product inner join Laptop on
Product.model=Laptop.model
group by Product.maker
union
select Product.maker as maker,max(Printer.price) as m_price 
from Product inner join Printer on
Product.model=Printer.model
group by Product.maker
) as temp_table
group by maker










/*Short database description "Ships":

Скрыть|Hide
The database of naval ships that took part in World War II is under consideration. The database consists of the following relations:
Classes(class, type, country, numGuns, bore, displacement)
Ships(name, class, launched)
Battles(name, date)
Outcomes(ship, battle, result)
Ships in classes all have the same general design. 
A class is normally assigned either the name of the first ship built according to the corresponding design,
 or a name that is different from any ship name in the database. 
 The ship whose name is assigned to a class is called a lead ship.
The Classes relation includes the name of the class, 
type (can be either bb for a battle ship, or bc for a battle cruiser), 
country the ship was built in, the number of main guns, gun caliber (bore diameter in inches), 
and displacement (weight in tons). The Ships relation holds information about the ship name, 
the name of its corresponding class, and the year the ship was launched. The Battles relation contains names and dates of battles the ships participated in, and the Outcomes relation - the battle result for a given ship (may be sunk, damaged, or OK, the last value meaning the ship survived the battle unharmed).
Notes: 1) The Outcomes relation may contain ships not present in the Ships relation. 2) A ship sunk can’t participate in later battles. 3) For historical reasons, lead ships are referred to as head ships in many exercises.4) A ship found in the Outcomes table but not in the Ships table is still considered in the database. This is true even if it is sunk.*/

--Question 14  
For the ships in the Ships table that have at least 10 guns, get the class, name, and country.
--answer 
select Classes.class as class,Ships.name as name,
Classes.country as country
from Classes inner join Ships on
Classes.class=Ships.class
where Classes.numGuns>=10

--Question 31  
For ship classes with a gun caliber of 16 in. or more, display the class and the country.
--answer 
select class,country from Classes
where bore>=16

--Question 32 pending
One of the characteristics of a ship is one-half the cube of the calibre of its main guns (mw).
Determine the average ship mw with an accuracy of two decimal places for each country having ships in the database.
--answer
select Classes.country,
CAST(ROUND(AVG(POWER(Classes.bore, 3) / 2), 2) AS DECIMAL(10,2)) AS mw
from Classes inner join Ships
on Classes.class=Ships.class
group by Classes.country

--Question 33  
Get the ships sunk in the North Atlantic battle.
Result set: ship.
--answer 
select ship from Outcomes
where battle='North Atlantic' and result='sunk'

--Question 34 
In accordance with the Washington Naval Treaty concluded in the beginning of 1922, it was prohibited to build battle ships with a displacement of more than 35 thousand tons.
Get the ships violating this treaty (only consider ships for which the year of launch is known).
List the names of the ships.
--answer
select Ships.name from Classes inner join 
Ships on Ships.class=Classes.class
where Ships.launched IS NOT NULL and
Ships.launched>=1922 and Classes.displacement>35000

--Question 35 pending
Find models in the Product table consisting either of digits only or Latin letters (A-Z, case insensitive) only.
Result set: model, type.

--Question 36  
List the names of lead ships in the database (including the Outcomes table).
--answer 
select name from 
Ships where name in (select class from Classes)
union 
select ship from Outcomes
where ship in (select class from Classes)

--Question 37 p(one failed)
--answer 
with temp as (
select s.class as class from Classes c inner join 
Ships s on c.class=s.class
union all
select c.class as class from Classes c inner join Outcomes o
on c.class=o.ship)
select class from temp 
group by class
having count(*)=1

--Question 38  
Find countries that ever had classes of both battleships (‘bb’) and cruisers (‘bc’).
--answer 
select country from 
(SELECT country,type FROM Classes
WHERE type = 'bb'
union 
SELECT country,type FROM Classes
WHERE type = 'bc') as nt
group by country
having count(country)=2
--modified answer
SELECT country 
FROM Classes
WHERE type IN ('bb', 'bc')
GROUP BY country
HAVING COUNT(distinct type) = 2

--Question 39  
Find the ships that `survived for future battles`;
that is, after being damaged in a battle, they participated in another one, which occurred later.
--answer 
with temp as (
select * 
from Outcomes o 
inner join Battles b on b.name=o.battle
where o.result='damaged'),
temp1 as (
select * 
from Outcomes o 
inner join Battles b on b.name=o.battle)
select distinct a.ship from temp a inner join temp1 b
on a.ship=b.ship and a.date<b.date

--question 42 
Find the names of ships sunk at battles, along with the names of the corresponding battles.
--answer
select ship,battle
from Outcomes
where result='sunk'

--question 43 c
Get the battles that occurred in years when no ships were launched into water.
--answer
select distinct b.name 
from battles b
where year(b.date) not in (select distinct launched from ships where launched is not null);


--question 44 
Find all ship names beginning with the letter R.
--answer
Select name from 
Ships 
where name like 'R%'
union
Select ship from 
Outcomes
where ship like 'R%'


--question 45 p



--question 46 
For each ship that participated in the Battle of Guadalcanal, 
get its name, displacement, and the number of guns.
--answer1
select s.name,c.displacement,c.numGuns from
Classes c inner join Ships s on s.class=c.class
inner join Outcomes o on o.ship=s.name
where o.battle='Guadalcanal'
union
select o.ship,c.displacement,c.numGuns from
Classes c inner join Outcomes o on o.ship=c.class
where o.battle='Guadalcanal'
--answer2
SELECT o.ship, c.displacement, c.numGuns
FROM Outcomes o
LEFT JOIN Ships s ON o.ship = s.name
LEFT JOIN Classes c ON s.class = c.class OR o.ship = c.class
WHERE o.battle = 'Guadalcanal'


--question 48 
Find the ship classes having at least one ship sunk in battles.
--answer
with temp as (
select s.class as class,o.result as result from Ships s inner join Outcomes o 
on s.name=o.ship
union all
select c.class,o.result from Classes c inner join Outcomes o 
on c.class=o.ship)
,temp1 as (
select class,count(case when result='sunk' then 1 end) as sunkc 
from temp 
group by class)
select class from temp1
where sunkc>=1


--question 49 
Find the names of the ships having a gun caliber of 16 inches (including ships in the Outcomes table).
--answer
select s.name as name from Ships s inner join Classes c 
on s.class=c.class
where c.bore=16.0
union 
select c.class from Classes c inner join Outcomes o 
on c.class=o.ship
where c.bore=16.0



--Question 50 
Find the battles in which Kongo-class ships from the Ships table were engaged.
--answer 
select  distinct Outcomes.battle from Ships
inner join Outcomes on 
Ships.name=Outcomes.ship
where Ships.class='Kongo'
