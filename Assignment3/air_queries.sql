REM:1. Display the flight number,departure date and time of a flight, its  route details and aircraft  name of type either Schweizer or Piper that departs during 8.00 PM and 9.00 PM. 

SELECT flights.flightno,fl_schedule.departs,fl_schedule.dtime,
routes.routeid,routes.orig_airport,routes.dest_airport,routes.distance,
aircraft.aname,aircraft.type
FROM flights,fl_schedule,routes,aircraft
WHERE fl_schedule.flno=flights.flightno AND routes.routeid=flights.rid AND 
flights.aid=aircraft.aid AND (fl_schedule.dtime BETWEEN 2000 AND 2100) 
AND (aircraft.type = 'Schweizer' OR aircraft.type = 'Piper');

REM:2. For all the routes, display the flight number, origin and destination airport, if a flight is  assigned for that route
select flightno,orig_airport,dest_airport from routes
inner join flights on routeid = rid
where flightno is not null;

s
REM:3.For all aircraft with cruisingrange over 5,000 miles, find the name of the aircraft and the  average salary of all pilots certified for this aircraft.

SELECT aircraft.aname,avg(employee.salary)
FROM aircraft,employee,certified
WHERE aircraft.aid=certified.aid AND certified.eid=employee.eid
AND aircraft.cruisingrange > 5000
GROUP BY aircraft.aname;

REM:4. Show the employee details such as id, name and salary who are not pilots and whose salary is more than the average salary of pilots.
select e.eid,e.ename,e.salary from employee e 
where e.eid not in (select e.eid from employee 
e,certified c where e.eid=c.eid) and e.salary>
(select avg(e.salary) from employee e,certified c 
where e.eid=c.eid);


REM: 5.Find the id and name of pilots who were certified to operate some aircrafts but at least one  of that aircraft is not scheduled from any routes. 

select e.eid,e.ename 
from employee e,certified c 
where e.eid=c.eid and c.aid not in (select distinct(aid) from flights);

REM: 6.Display the origin and destination of the flights having at least three departures with  maximum distance covered. 

select r.orig_airport,r.dest_airport 
from routes r,aircraft a,flights f 
where((f.aid=a.aid) and (f.rid=r.routeid) and (r.distance=(select max(distance) from routes))) 
having (count(f.rid)>=3) group by r.routeid,r.orig_airport,r.dest_airport;

REM: 7. Display the origin and destination of the flights having at least three departures with  maximum distance covered. 

select distinct e.ename,e.salary 
from employee e,certified c,routes r 
where((e.eid=c.eid) and (e.eid in (select distinct(eid) from certified)) and (e.salary>(select avg(e.salary) 
from employee e,certified c where e.eid=c.eid)) and (r.routeid not in(select routeid from routes where orig_airport not like 'Madison')));

REM: 8.Display the flight number, aircraft type, source and destination airport of the aircraft having  maximum number of flights to Honolulu.

SELECT f.flightno,a.type,r.orig_airport,r.dest_airport
FROM Routes r,aircraft a ,Flights f
WHERE (f.rid = r.routeid and f.aid = a.aid) AND (r.dest_airport = 'Honolulu')
AND f.aid = (select f.aid from Routes r,Flights f
WHERE (f.rid = r.routeid) AND (r.dest_airport = 'Honolulu')
GROUP BY f.aid
HAVING count(f.aid) = (select max(count(f.aid)) from Routes r,Flights f
where (f.rid = r.routeid) AND (r.dest_airport = 'Honolulu')
group by f.aid))
;

REM:9.Display the pilot(s) who are certified exclusively to pilot all aircraft in a type.
select distinct(c.eid), a.type from certified c, aircraft a 
where c.eid in (select c1.eid from certified c1, aircraft a1 where c1.aid=a1.aid 
having count(distinct a1.type)=1 group by c1.eid) and c.aid=a.aid group by c.eid,a.type 
having count(*)=(select count(air.aid) from aircraft air where air.type=a.type); 

REM:10. Name the employee(s) who is earning the maximum salary among the airport having
maximum number of departures.

select ename,salary
from employee
where salary=(select max(e.salary)
from aircraft a,employee e,certified c,routes r,flights f,fl_schedule fl
where r.routeid=f.rid AND f.aid=a.aid AND a.aid=c.aid AND c.eid=e.eid AND fl.flno=f.flightno
AND f.flightno=(select flno
from fl_schedule
group by flno
having count(flno)=(select max(count(flno)) from fl_schedule group by flno)));

REM:11. Display the departure chart as follows:flight number, departure(date,airport,time), destination airport, arrival time, aircraft name for the flights from New York airport during 15 to 19th April 2005. Make sure that the route
REM:contains at least two flights in the above specified condition.

select f.flightNo,fs.departs,r.orig_airport,fs.dtime,
r.dest_airport,fs.arrives,fs.atime,a.type
from fl_schedule fs,flights f,routes r,aircraft a
where fs.flno=f.flightNo and f.rID=r.routeID and f.aid=a.aid
and (r.orig_airport='New York') and 
(fs.departs between '15-apr-2005' and '19-apr-2005') and
(select count(fs.flno) from fl_schedule fs,flights f 
where f.rID=r.routeID and f.flightNo=fs.flno)>=2;

REM:12. A customer wants to travel from Madison to New York with no more than two changes of flight. List the flight numbers from Madison if the customer wants to arrive in New York by 6.50 p.m.

select distinct flno from fl_schedule where flno in
((select fs.flno from fl_schedule fs,flights f,routes r 
where fs.flno=f.flightNo and f.rID=r.routeID and r.orig_airport='Madison'
and r.dest_airport='New York' and fs.atime<=1850) 
union all
(select fs.flno from fl_schedule fs,fl_schedule fs1,flights f,
flights f1,routes r,routes r1 
where (fs.flno=f.flightNo and f.rID=r.routeID) and 
(fs1.flno=f1.flightNo and f1.rID=r1.routeID) 
and r.orig_airport='Madison' and r.dest_airport=r1.orig_airport
and r1.dest_airport='New York' and fs1.atime<=1850) 
union all
(select fs.flno from fl_schedule fs,fl_schedule fs1,fl_schedule fs2,
flights f,flights f1,flights f2,routes r,routes r1,routes r2 
where (fs.flno=f.flightNo and f.rID=r.routeID) and 
(fs1.flno=f1.flightNo and f1.rID=r1.routeID) and 
(fs2.flno=f2.flightNo and f2.rID=r2.routeID) and r.orig_airport='Madison' 
and r.dest_airport=r1.orig_airport and r1.dest_airport=r2.orig_airport 
and r2.dest_airport='New York' and fs2.atime<=1850));

REM:13. Display the id and name of employee(s) who are not pilots.

select eid,ename
from employee
MINUS
select e.eid,e.ename
from certified c,employee e
where e.eid = c.eid;

REM:14. Display the id and name of employee(s) who pilots the aircraft from Los Angels and Detroit airport.

select distinct e.eid,e.ename from employee e,certified c,flights f,routes r 
where e.eid=c.eid and c.aid=f.aid and f.rID=r.routeID and r.orig_airport='Los Angeles' 
intersect
select distinct e1.eid,e1.ename from employee e1,certified c1,flights f1,routes r1 
where e1.eid=c1.eid and c1.aid=f1.aid and f1.rID=r1.routeID and r1.orig_airport='Detroit';






