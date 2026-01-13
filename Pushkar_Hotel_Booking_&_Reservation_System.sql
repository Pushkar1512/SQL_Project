--  HOTEL BOOKING & RESERVATION SYSTEM - CASE STUDY (MySQL Project)

-- Creating database
create database hotel_booking_db;
select count(*) from bookings;

use hotel_booking_db;

-- Creating Hotels table
create table hotels( hotel_id int primary key,
             hotel_name varchar(100) not null,
             city varchar(90),
             rating decimal(2,1) check (rating between 0 and 5)
              );

-- Inserting sample data into hotels table
insert into hotels(hotel_id, hotel_name,city,rating) values
         (1, 'Resort Hotel', 'Lisbon', 4.5),
         (2, 'City Hotel', 'Porto', 4.3),
         (3, 'Grand Palace', 'New York', 4.8),
         (4, 'Royal Stay', 'London', 4.6),
	     (5, 'Seaside Inn', 'Barcelona', 4.2),
         (6, 'Skyline Towers', 'Dubai', 4.9),
         (7, 'Sunset Resort', 'Goa', 4.4),
         (8, 'Mountain View', 'Zurich', 4.7);
         
         
-- Creating Agents table
create table agents (
           agent_id int primary key,
           agent_name varchar(100) not null unique
           );

-- inserting sample data into Agents
insert into agents (agent_id, agent_name) values
          (1, 'Alpha Travels'),
          (2, 'Beta Holidays'),
		  (3, 'Gamma Corp'),
          (4, 'Delta Tours'),
          (5, 'Epsilon Travels'),
          (6, 'Zeta Bookings'),
          (7, 'Eta Holidays'),
          (8, 'Theta Corp');
          
-- Queries :

-- 1. Insert a new hotel into hotels table
insert into hotels (hotel_id, hotel_name,city,rating) values
        (9, 'Ocean Pearl', 'Sydney', 4.5);
-- Insight: This query adds a new hotel record. It shows how the system expands to include new properties, supporting business growth.

-- 2. update a hotel rating of Ocean Pearl
update hotels set rating = 4 where hotel_name = 'Ocean Pearl';
-- Insight: Updates the rating of an existing hotel, reflecting changes in customer reviews and satisfaction over time.

-- 3. Delete a hotel 
delete from hotels where hotel_name = 'Grand Palace';
-- Insight: Removes a hotel from the database, useful when a property is closed or no longer active.

-- 4. Display all unique hotel types from bookings
select distinct hotel from bookings;
-- Insight: Lists distinct hotel categories (Resort, City). Helps understand the variety of accommodations offered.

-- 5. Count total bookings
select count(*) as total_bookings from bookings;
-- Insight: Provides the total number of bookings, offering a snapshot of business volume.

-- 6. Find bookings where ADR (average daily rate) is greater than 200.
select * from bookings where adr > 200;
-- Insight: Identifies premium, high-paying bookings. Useful for targeting luxury customers.

-- 7. Find bookings with lead_time BETWEEN 10 AND 20 days
select * from bookings where lead_time between 10 and 20;
-- Insight: Identifies bookings made with a lead time of 10–20 days, highlighting customers who book on short notice but not last-minute.

-- 8. Show top 5 bookings with highest ADR
select booking_id, hotel, adr from bookings order by adr desc limit 5;
-- Insight: Finds the top 5 highest-revenue bookings, useful for analyzing premium clients.

-- 9. Show bookings where meal type is "BB" (Bed and Breakfast)
select * from bookings where meal = 'BB';
-- Insight: Shows bookings with Bed & Breakfast plan, showing its popularity among customers.

-- 10. Find bookings with children
select * from bookings where children > 0;
-- Insight: Identifies family-oriented bookings, useful for planning kids’ services and amenities.

-- 11. Find bookings where stay is longer than 5 nights
select * from bookings where (stays_in_weekend_nights + stays_in_week_nights) > 5;
-- Insight: Captures long-stay guests who have stayed more than 5 nights, which provide stable and higher revenue.

-- 12. Find minimum and maximum ADR(average daily rate)
select min(adr) as minimum_adr, max(adr) as maximum_adr from bookings where adr > 0;
-- Insight: Identifies the lowest and highest daily rates, useful for analyzing pricing strategy and market positioning.

-- 13. Find average lead time.
select avg(lead_time) as avg_lead_time from bookings;
-- Insight: Calculates the average lead time, showing how far in advance customers typically book their stays.

-- 14. Count how many bookings are cancelled
select count(*) AS cancelled_bookings from bookings where is_canceled = 1;
-- Insight: Counts the total number of cancelled bookings, providing visibility into overall cancellation volume.

-- 15. Count bookings for each hotel type.
select hotel, count(*) as total_bookings from bookings group by hotel;
-- Insight: Counts bookings for each hotel type, helping to compare demand distribution across different hotel categories.

-- 16. Find months with more than 100 bookings.
select arrival_date_month, count(*) as bookings_count from bookings group by arrival_date_month having count(*) > 100;
-- Insight: Identifies peak booking months, useful for seasonal marketing campaigns.

-- 17. Find country with maximum bookings.
select country, count(*) as total_bookings from bookings group by country order by total_bookings desc limit 1;
-- Insight: Identifies the country with the highest number of bookings, highlighting the top source market for the hotel.

-- 18. Find customer type with highest ADR on average.
select customer_type, avg(adr) as avg_adr from bookings group by customer_type order by avg_adr desc;
-- Insight: Finds the customer type with the highest average ADR, showing which segment is the most profitable per day.

-- 19. Find Distinct countries of guests
select distinct country from bookings;
-- Insight: Lists all distinct guest countries, providing visibility into the geographic diversity of customers.

-- 20. Find top 3 months with highest bookings.
select arrival_date_month, count(*) as total from bookings group by arrival_date_month order by total desc limit 3;
-- Insight: Identifies the top 3 months with the highest bookings, revealing peak demand months for the hotel.

-- 21. Show hotel with maximum special requests.
select hotel, avg(total_of_special_requests) as avg_requests from bookings group by hotel order by avg_requests desc limit 1;
-- Insight: Finds the hotel with the highest average special requests, showing where guests demand the most personalized services.

-- 22. Show percentage of repeated guests.
select (sum(is_repeated_guest) / count(*)) * 100 as repeated_guests_percent from bookings;
-- Insight: Calculates the percentage of repeated guests, showing the level of customer loyalty and retention.

-- 23. Find most frequent guest country
select country, count(*) as total from bookings group by country order by total desc limit 1;
-- Insight: Identifies the country with the most bookings, showing the largest source market for the hotel.

-- 24. Show cancellation percentage per agent.
select agent, (sum(is_canceled) / count(*)) * 100 as cancel_pct from bookings group by agent;
-- Insight: Measures the cancellation rate per agent, helping evaluate agent reliability.

-- 25. Show yearly booking trend.
select arrival_date_year, count(*) as total from bookings group by arrival_date_year order by arrival_date_year;
-- Insight: Displays the yearly booking trend, useful for identifying growth or decline in demand.

-- 26. Find the country contributing maximum revenue.
select country, sum(adr * (stays_in_weekend_nights + stays_in_week_nights)) as revenue from bookings where is_canceled = 0 group by country order by revenue desc limit 1;
-- Insight: Finds the top revenue-generating country, highlighting the most valuable market.

-- 27. . Find most common room type reserved.
select reserved_room_type, count(*) as total from bookings group by reserved_room_type order by total desc limit 1;
-- Insight: Identifies the most popular room type, showing customer preference patterns.

-- 28. Rank hotels by average ADR.
select hotel, avg(adr) as avg_adr, rank() over (order by avg(adr) desc) as rank_adr from bookings group by hotel;
-- Insight: Ranks hotels by average ADR, revealing which hotel type earns the most per night.

-- 29. Show dense rank of lead times.
select booking_id, lead_time, dense_rank() over (order by lead_time desc) as lead_rank from bookings;
-- Insight: Assigns a dense rank to bookings by lead time, highlighting how early or late guests book.

-- 30. Show booking id, hotel, and agent name.
select b.booking_id, b.hotel, a.agent_name from bookings b join agents a on b.agent = a.agent_id;
-- Insight: Displays bookings with their agents, connecting reservations to their sources.

-- 31. Identify which cities have the highest number of bookings across all hotels.
select h.city, count(b.booking_id) as total_bookings 
from bookings b join hotels h on b.hotel = h.hotel_name 
group by h.city order by total_bookings desc;
-- Insight: Shows cities with maximum bookings, useful for location-based demand analysis.

-- 32. Analyze which agents bring the most customers to each hotel.
select h.hotel_name, a.agent_name, count(*) as total_bookings from bookings b
join agents a on b.agent = a.agent_id
join hotels h on b.hotel = h.hotel_name
group by h.hotel_name, a.agent_name
order by h.hotel_name, total_bookings desc;
-- Insight: Analyzes top-performing agents per hotel, supporting partnership evaluation.

-- 33. Determine which hotels attract the highest-paying customers (based on ADR).
select h.hotel_name, avg(b.adr) as avg_adr from bookings b
join hotels h on b.hotel = h.hotel_name
group by h.hotel_name
order by avg_adr desc;
-- Insight: Identifies hotels with the highest ADR-paying customers, highlighting premium market segments.

-- 34. Find the seasonal trends by comparing bookings across months for each hotel.
select h.hotel_name, b.arrival_date_month, count(*) as monthly_bookings from bookings b
join hotels h on b.hotel = h.hotel_name
group by h.hotel_name, b.arrival_date_month
order by h.hotel_name, monthly_bookings desc;
-- Insight: Reveals seasonal booking patterns per hotel, aiding demand forecasting and promotions.

-- 35. Show all agents with related bookings (even if no booking).
select a.agent_name, b.booking_id 
from bookings b
right join agents a on b.agent = a.agent_id;
-- Insight: Lists all agents with their bookings, ensuring visibility into inactive and active agents.

-- 36. List all hotels and their booking counts (even if no bookings).
select h.hotel_name, count(b.booking_id) as total_bookings
from hotels h
left join bookings b on h.hotel_name = b.hotel
group by h.hotel_name;
-- Insight: Shows all hotels with booking counts, highlighting hotels with zero or high demand.

-- 37. Show bookings where two different agents booked the same hotel.
select b1.booking_id as booking1, b2.booking_id as booking2, b1.hotel
from bookings b1
join bookings b2 on b1.hotel = b2.hotel and b1.agent <> b2.agent;
-- Insight: Identifies multiple agents booking the same hotel, showing shared demand sources.

-- 38. Find bookings with ADR greater than overall average.
select * from bookings
where adr > (select avg(adr) from bookings);
-- Insight: Finds bookings with above-average ADR, representing premium stays.

-- 39. Create a view of confirmed bookings only.
create view confirmed_bookings as
select * from bookings where is_canceled = 0;
-- Insight: Creates a view of confirmed bookings, simplifying analysis of valid reservations.

-- 40. Show total confirmed bookings.
select count(*) from confirmed_bookings;
-- Insight: Counts the total confirmed bookings, showing the actual volume of stays.



























