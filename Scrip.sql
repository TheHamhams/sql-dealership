CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "address" VARCHAR(150),
  billing_info VARCHAR(150),
  PRIMARY KEY ("customer_id")
);

CREATE TABLE "car" (
  car_id SERIAL,
  customer_id INTEGER,
  "make" VARCHAR(30),
  "model" VARCHAR(30),
  "year" INTEGER,
  PRIMARY KEY (car_id),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE "history" (
  "history_id" SERIAL,
  "car_id" INTEGER,
  "customer_id" INTEGER,
  PRIMARY KEY ("history_id"),
  FOREIGN KEY (car_id) REFERENCES car(car_id)
);

CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  PRIMARY KEY ("mechanic_id")
);

CREATE TABLE "salesperson" (
  "salesperson_id" INTEGER,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  PRIMARY KEY ("salesperson_id")
);


CREATE TABLE "order_" (
  "order_id" SERIAL,
  order_date DATE DEFAULT CURRENT_DATE,
  "total_cost" Numeric(10,2),
  "car_id" INTEGER,
  PRIMARY KEY ("order_id"),
  FOREIGN KEY (car_id) REFERENCES car(car_id)
);



CREATE TABLE "invoice" (
  "invoice_id" SERIAL,
  "customer_id" INTEGER,
  "order_id" INTEGER,
  "salesperson_id" INTEGER,
  PRIMARY KEY ("invoice_id"),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (order_id) REFERENCES order_(order_id),
  FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id)
);


CREATE TABLE "ticket" (
  "ticket_id" SERIAL,
  "customer_id" INTEGER,
  "mechanic_id" INTEGER,
  "history_id" INTEGER,
  "car_id" INTEGER,
  PRIMARY KEY ("ticket_id"),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY (mechanic_id) REFERENCES mechanic(mechanic_id),
  FOREIGN KEY (history_id) REFERENCES history(history_id),
  FOREIGN KEY (car_id) REFERENCES car(car_id)
);

CREATE OR REPLACE FUNCTION add_customer(_customer_id INTEGER, _first_name VARCHAR, _last_name VARCHAR, _address VARCHAR, _billing_info VARCHAR)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO customer(customer_id, first_name, last_name, address, billing_info)
	VALUES(_customer_id, _first_name, _last_name, _address, _billing_info);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_customer(1, 'Corey', 'Hamren', '13732 61st st', 'credit card');
SELECT add_customer(2, 'Shelley', 'Rappleye', '13732 61st st', 'credit card');


CREATE OR REPLACE FUNCTION add_car(_car_id INTEGER, _customer_id INTEGER, _make VARCHAR, _model VARCHAR, _year INTEGER)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO car(car_id, customer_id, make, model, year)
	VALUES(_car_id, _customer_id, _make, _model, _year);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_car(1, 2, 'honda', 'civic', 2014);
SELECT add_car(2, 1, 'Nissan', 'Altima', 2014);	
	
CREATE OR REPLACE FUNCTION add_history(_history_id INTEGER, _car_id INTEGER, _customer_id INTEGER)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO history(history_id, car_id, customer_id)
	VALUES(_history_id, _car_id, _customer_id);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_history(1, 1, 2);
SELECT add_history(2, 2, 1);

CREATE OR REPLACE FUNCTION add_mechanic(_mechanic_id INTEGER, _first_name VARCHAR, _last_name VARCHAR)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO mechanic(mechanic_id, first_name, last_name)
	VALUES(_mechanic_id, _first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_mechanic(1, 'Ron', 'Pura');
SELECT add_mechanic(2, 'Aaron', 'Rodgers');

CREATE OR REPLACE FUNCTION add_salesperson(_salesperson_id INTEGER, _first_name VARCHAR, _last_name VARCHAR)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO salesperson(salesperson_id, first_name, last_name)
	VALUES (_salesperson_id, _first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_salesperson(1, 'Ben', 'Pervis');
SELECT add_salesperson(2, 'Liz', 'Lemon');

CREATE OR REPLACE FUNCTION add_order_(_order_id INTEGER, _order_date TIMESTAMP, _total_cost NUMERIC(5,2), _car_id INTEGER)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO order_(order_id, order_date, total_cost, car_id)
	VALUES (_order_id, _order_date, _total_cost, _car_id);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_order_(1, NOW()::TIMESTAMP, 30000, 1);
SELECT add_order_(2, NOW()::TIMESTAMP, 20000, 2);

CREATE OR REPLACE FUNCTION add_invoice(_invoice_id INTEGER, _customer_id INTEGER, _order_id INTEGER, _salesperson_id INTEGER)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO invoice(invoice_id, customer_id, order_id, salesperson_id)
	VALUES (_invoice_id, _customer_id, _order_id, _salesperson_id);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_invoice(1, 1, 1, 1);
SELECT add_invoice(2, 2, 2, 2);

CREATE OR REPLACE FUNCTION add_ticket(_ticket_id INTEGER, _customer_id INTEGER, _mechanic_id INTEGER, _history_id INTEGER, _car_id INTEGER)
RETURNS void
AS $MAIN$
BEGIN 
	INSERT INTO ticket(ticket_id, customer_id, mechanic_id, history_id, car_id)
	VALUES (_ticket_id, _customer_id, _mechanic_id, _history_id, _car_id);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_ticket(1, 1, 1, 1, 2);
SELECT add_ticket(2, 2, 2, 2, 1);








	
	
