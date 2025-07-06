# Pactravel Data Warehouse
# Requirement Gathering
## Description

Pactravel is a travel domain company who can handle hotel and flight booking. As the business grows, Pactravel faces the challenge of managing and analyzing large volumes of transactional data.

## Problem
To maintain its competitive edge and improve decision-making processes, Pactravel has identified several key areas where in-depth data analysis is crucial:
* Trips Growth Prediction
* Sales Growth Prediction

## Solution
To achieve these objectives, Pactravel needs a data infrastructure that allows them to store, manage, and analyze large volumes of diverse data efficiently. Pactravel requires a dedicated data warehouse to support advanced analytics and data-driven decision-making.

# Designing Data Warehouse Model
## Design Dimensional Model Process
### Business Process 1 : Trips including Hotel & Flight Bookings
#### Grain
A single data represents an individual trip, including outbound flight details, return flight details, hotel booking details, and customer id.
#### Dimension
* dim_date
* dim_airline
* dim_airport
* dim_aircrafts
* dim_customers
* dim_hotels
#### Facts
* fct_trip
#### Slowly Changing Dimension Strategy
The SCD strategy that is going to be used in these dimension tables is Type 1, which is overwriting data in the data warehouse. We implemented this strategy to all dimension tables.

### Business Process 2 : Monitor Daily Flight Bookings
#### Grain
A single data represents a summary of flights booked in one day.
#### Dimension
* dim_date
* dim_airline
* dim_airport
* dim_aircrafts
#### Facts
* fct_daily_flight
#### Slowly Changing Dimension Strategy
The SCD strategy that is going to be used in these dimension tables is Type 1, which is overwriting data in the data warehouse. We implemented this strategy to all dimension tables.

### Business Process 3 : Monitor Daily Hotel Bookings
#### Grain
A single data represents a summary of hotels booked in one day.
#### Dimension
* dim_date
* dim_hotel
#### Facts
* fct_daily_hotel
#### Slowly Changing Dimension Strategy
The SCD strategy that is going to be used in these dimension tables is Type 1, which is overwriting data in the data warehouse. We implemented this strategy to all dimension tables.

# Data Pipeline Implementation
As you can see in the repository, I use python for the extract & load process, dbt for the transformation process, orchestrated with Luigi.

## Extract & Load
In this step, all raw data from the data source will be extracted to the local directory as csv files. The files then will be loaded to the 'public' schema of the data warehouse.

## Transform
The data from 'public' schema then will be ingested by dbt, and put into staging area as a view. These views then will be used as the data source for final transformation.
