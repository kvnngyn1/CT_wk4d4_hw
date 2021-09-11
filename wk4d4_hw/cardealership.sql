CREATE TABLE "customer"(customer_id serial PRIMARY KEY,
						first_name VARCHAR(50),
						last_name VARCHAR(50),
						username VARCHAR(50)
					   );
					   
INSERT INTO "customer"(customer_id, first_name, last_name, username)
VALUES
(1, 'Kevin', 'Nguyen ', 'Kevin Nguyen'),
(2, 'Andrea', 'Pirela ', 'Andrea Pirela'),
(3, 'Bren', 'Joy', 'Bren Joy')
RETURNING *;

CREATE TABLE "mechanic"(mechanic_id serial PRIMARY KEY,
						first_name VARCHAR(50),
						last_name VARCHAR(50),
						username VARCHAR(50)
					   );
					   
INSERT INTO "mechanic"(mechanic_id, first_name, last_name, username)
VALUES
(1, 'Derek', 'Hawkins ', 'Derek Hawkins'),
(2, 'Lucas', 'Lang ', 'Lucas Lang')
RETURNING *;

CREATE TABLE "salesperson"(salesperson_id serial PRIMARY KEY,
						   first_name VARCHAR(50),
						   last_name VARCHAR(50),
						   username VARCHAR(50)
						  );
						  
INSERT INTO "salesperson"(salesperson_id, first_name, last_name, username)
VALUES
(1, 'Antonio', 'Turner ', 'Antonio Turner'),
(2, 'Brittany', 'Jones ', 'Brittany Jones')
RETURNING *;

CREATE TABLE "serviced_car"(servicedcar_id serial PRIMARY KEY,
							Model VARCHAR(50),
							Year_ integer,
							customer_id integer,
							FOREIGN KEY(customer_id) REFERENCES "customer"(customer_id)
						   );
-- decided to add a make
ALTER TABLE "serviced_car"
ADD COLUMN Make VARCHAR(50);
-- Noticed I accidentally added a username column
ALTER TABLE "serviced_car"
DROP COLUMN username

INSERT INTO "serviced_car"(servicedcar_id, Make, Model, Year_, customer_id)
VALUES
(3, 'Subaru', 'Forester ', '2004', 1),
(4, 'Subaru', 'WRX', '2021', 2)
RETURNING *;
		
-- -- links the two tables without having to run into a loop error
CREATE TABLE "mechanic_serviced_car"(mechanic_serviced_car_id serial PRIMARY KEY, 
									 mechanic_id integer,
									 servicedcar_id integer,
									 FOREIGN KEY(mechanic_id) REFERENCES "mechanic"(mechanic_id),
									 FOREIGN KEY(servicedcar_id) REFERENCES "serviced_car"(servicedcar_id)
									);

CREATE TABLE "dealership_car"(dealership_car_id serial PRIMARY KEY,
							  Model VARCHAR(50),
							  Year_ VARCHAR(50),
							  sale_price float,
							  customer_id integer,
							  salesperson_id integer,
							  FOREIGN KEY(customer_id) REFERENCES "customer"(customer_id),
							  FOREIGN KEY(salesperson_id) REFERENCES "salesperson"(salesperson_id)
							 );
-- decided to add a make
ALTER TABLE "dealership_car"
ADD COLUMN Make VARCHAR(50);

INSERT INTO "dealership_car"(dealership_car_id, Make, Model, Year_, sale_price, customer_id, salesperson_id)
VALUES
(12, 'Jeep', 'Wrangler ', '2021', 40000, 3, 1 ),
(34, 'Toyota', 'RAV4', '2021', 45000, 3, 2 )
RETURNING *;

CREATE TABLE "invoice"(invoice_id serial PRIMARY KEY, 
					   price float,
					   dealership_car_id integer,
					   customer_id integer,
					   salesperson_id integer,
					   FOREIGN KEY(dealership_car_id) REFERENCES "dealership_car"(dealership_car_id),
					   FOREIGN KEY(customer_id) REFERENCES "customer"(customer_id),
					   FOREIGN KEY(salesperson_id) REFERENCES "salesperson"(salesperson_id)
					  );

INSERT INTO "invoice"(invoice_id, price, dealership_car_id, customer_id, salesperson_id)
VALUES
(1, 40000, 12, 3, 1 ),
(2, 45000, 34, 3, 2 )
RETURNING *;

CREATE TABLE "service_ticket"(serviceticket_id serial PRIMARY KEY,
							  price float,
							  service_type VARCHAR(50),
							  customer_id integer,
							  servicedcar_id integer,
							  FOREIGN KEY(customer_id) REFERENCES "customer"(customer_id),
							  FOREIGN KEY(servicedcar_id) REFERENCES "serviced_car"(servicedcar_id)
							  );
						 
INSERT INTO "service_ticket"(serviceticket_id, price, service_type, customer_id, servicedcar_id)
VALUES
(1, 80, 'oil change', 1, 3),
(2, 400, 'brake pad change', 2, 4)
RETURNING *;


CREATE TABLE "service_history"(servicehistory_id serial PRIMARY KEY, 
							   service_type VARCHAR(50),
							   service_price float,
							   servicedcar_id integer, 
							   customer_id integer,
							   service_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
							   FOREIGN KEY(servicedcar_id) REFERENCES "serviced_car"(servicedcar_id),
							   FOREIGN KEY(customer_id) REFERENCES "customer"(customer_id)
							  );
							  
INSERT INTO "service_history"(servicehistory_id, service_type, service_price, servicedcar_id, customer_id)
VALUES
(123, 'oil change', 80, 3, 1)
RETURNING *;

INSERT INTO "service_history"(servicehistory_id, service_type, service_price, servicedcar_id, customer_id)
VALUES
(456, 'brake pad change', 400, 4, 2)
RETURNING *;




