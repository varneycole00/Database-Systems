-- Homework 2 - Thomas Cole Varney - CS 3431

-- Part 3 Displaying number of unique customers who will visit a Location Type
select locationType, count(distinct customerID) AS NumberOfCustomers
from Location, Reservation
where Location.tourID = Reservation.tourID
group by locationType;  


-- Part 4 Displaying tours where the designated tour guide is not permitted to drive the tour vehicle.
select reservationID, tourName, Tour.vehicleType as TourVehicle, (guideFirstName || ' ' || guideLastName) as GuideName, Guide.vehicleType as GuidePermittedVehicle
from Reservation, Guide, Tour
where Reservation.guideID = Guide.guideID
and Tour.vehicleType != Guide.vehicleType
And Reservation.tourID = Tour.tourID;

-- Part 5 Displaying the city with the most reserved tours. 
select City, count(city) as NumberOfTours
from Reservation, Tour
Where Reservation.tourID = Tour.tourID
Group by city
Having Count(City) = 
        (Select Max(NumberOfTours) as MaxCount
         From (Select City, count(city) as NumberOfTours
               from Reservation, Tour
               Where Reservation.tourID = Tour.tourID
               Group by city)
);

-- Part 6 a and b, updating the tables to show the prices of boston tours with customer age greater than 21 set to 100
-- and boston tours with age less than or equal to 21 set to 25 	
update Reservation
Set price = 100 
Where tourID in
    (Select tourID 
     From Tour
     Where City = 'Boston')
AND customerID in
    (Select customerID 
     From Customer
     Where age > 21);
     
     
update Reservation
Set price = 25 
Where tourID in
    (Select tourID 
     From Tour
     Where City = 'Boston')
AND customerID in
    (Select customerID 
     From Customer
     Where age <= 21
);

-- Part 6c, Displaying the table including only tours that have a tour name containing the case sensitive string 'Tour', showing
-- ReservationID, customer name, tourName, city, customer age, and price of the reserved tour. 
Select reservationID, customerFirstName, customerLastName, tourName, city, age, price 
From Reservation, Customer, Tour
Where Reservation.customerID = Customer.customerID
AND Reservation.tourID = Tour.tourID
AND tourName in 
    (Select tourName
    From Tour
    Where tourName LIKE '%' || 'Tour' || '%')
Order By city, age;