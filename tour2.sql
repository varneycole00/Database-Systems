-- assignment 1: Thomas Cole Varney, CS 3431

select lastName, firstName, tourName
from Customer Natural Join Reservation Natural Join Tour
where tourID = 1 
    OR tourID = 5
order by lastName, firstName;

select travelDate, (customerFirstName || ' ' || customerLastName) as CustomerName , age, (guideFirstName || ' ' || guideLastName) as GuideName
from Reservation res, Customer cus, Guide gui
where res.customerID = cus.customerID 
and res.guideID = gui.guideID
and age > 21
and gui.vehicleType = 'bus';

select distinct tourName, guideFirstName, guideLastName
from Reservation res, Customer cus, Guide gui, Tour tour
where res.customerID = cus.customerID 
and res.guideID = gui.guideID
and tour.tourID = res.tourID
order by tourname DESC, guideLastName DESC