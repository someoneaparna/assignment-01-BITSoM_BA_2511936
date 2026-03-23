PRAGMA foreign_keys = ON;

CREATE TABLE offices (
    office_id TEXT PRIMARY KEY,
    office_name TEXT NOT NULL,
    city TEXT NOT NULL,
    address_line TEXT NOT NULL,
    postal_code TEXT NOT NULL
);

CREATE TABLE sales_representatives (
    sales_rep_id TEXT PRIMARY KEY,
    sales_rep_name TEXT NOT NULL,
    sales_rep_email TEXT NOT NULL UNIQUE,
    office_id TEXT NOT NULL,
    is_active INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (office_id) REFERENCES offices(office_id)
);

CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    customer_name TEXT NOT NULL,
    customer_email TEXT NOT NULL UNIQUE,
    customer_city TEXT NOT NULL
);

CREATE TABLE products (
    product_id TEXT PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    unit_price NUMERIC NOT NULL CHECK (unit_price >= 0)
);

CREATE TABLE orders (
    order_id TEXT PRIMARY KEY,
    customer_id TEXT NOT NULL,
    sales_rep_id TEXT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_representatives(sales_rep_id)
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id TEXT NOT NULL,
    product_id TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC NOT NULL CHECK (unit_price >= 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO offices (office_id, office_name, city, address_line, postal_code) VALUES
('OFF01', 'Mumbai HQ', 'Mumbai', 'Nariman Point', '400021'),
('OFF02', 'Delhi Office', 'New Delhi', 'Connaught Place', '110001'),
('OFF03', 'South Zone', 'Bangalore', 'MG Road', '560001'),
('OFF04', 'Hyderabad Hub', 'Hyderabad', 'Hitech City', '500081'),
('OFF05', 'Chennai Branch', 'Chennai', 'Anna Salai', '600002');

INSERT INTO sales_representatives (sales_rep_id, sales_rep_name, sales_rep_email, office_id, is_active) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'OFF01', 1),
('SR02', 'Anita Desai', 'anita@corp.com', 'OFF02', 1),
('SR03', 'Ravi Kumar', 'ravi@corp.com', 'OFF03', 1),
('SR04', 'Meera Kulkarni', 'meera@corp.com', 'OFF04', 1),
('SR05', 'Suresh Balan', 'suresh@corp.com', 'OFF05', 1);

INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
('C004', 'Sneha Iyer', 'sneha@gmail.com', 'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai');

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop', 'Electronics', 55000),
('P002', 'Mouse', 'Electronics', 800),
('P003', 'Desk Chair', 'Furniture', 8500),
('P004', 'Notebook', 'Stationery', 120),
('P005', 'Headphones', 'Electronics', 3200);

INSERT INTO orders (order_id, customer_id, sales_rep_id, order_date) VALUES
('ORD1114', 'C001', 'SR01', '2023-08-06'),
('ORD1002', 'C002', 'SR02', '2023-01-17'),
('ORD1132', 'C003', 'SR02', '2023-03-07'),
('ORD1075', 'C005', 'SR03', '2023-04-18'),
('ORD1185', 'C003', 'SR03', '2023-06-15');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
('ORD1114', 'P004', 2, 120),
('ORD1002', 'P005', 1, 3200),
('ORD1132', 'P004', 5, 120),
('ORD1075', 'P003', 3, 8500),
('ORD1185', 'P005', 1, 3200);
