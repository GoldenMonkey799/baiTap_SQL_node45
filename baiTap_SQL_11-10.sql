CREATE TABLE users (
	users_id INT PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(255),
	email VARCHAR(255),
	pass_word VARCHAR(255)
);

INSERT INTO users (users_id, full_name, email, pass_word) VALUES
(1, "Chris Smith", "chris.smith1@example.com", "pass3129"),
(2, "Chris Davis", "chris.davis2@example.com", "pass6177"),
(3, "Katie Williams", "katie.williams3@example.com", "pass1448"),
(4, "Chris Johnson", "chris.johnson4@example.com", "pass5957"),
(5, "Lucy Miller", "lucy.miller5@example.com", "pass3271"),
(6, "Katie Davis", "katie.davis6@example.com", "pass1353"),
(7, "Sarah Johnson", "sarah.johnson7@example.com", "pass6607"),
(8, "Michael Martinez", "michael.martinez8@example.com", "pass9521"),
(9, "Michael Garcia", "michael.garcia9@example.com", "pass6089"),
(10, "Jane Davis", "jane.davis10@example.com", "pass8850"),
(11, "Lucy Brown", "lucy.brown11@example.com", "pass3372"),
(12, "Katie Miller", "katie.miller12@example.com", "pass1487"),
(13, "David Wilson", "david.wilson13@example.com", "pass9705"),
(14, "Sarah Davis", "sarah.davis14@example.com", "pass3391"),
(15, "Michael Williams", "michael.williams15@example.com", "pass6936"),
(16, "Katie Williams", "katie.williams16@example.com", "pass8816"),
(17, "Lucy Garcia", "lucy.garcia17@example.com", "pass9040"),
(18, "Jane Wilson", "jane.wilson18@example.com", "pass4197"),
(19, "Jane Davis", "jane.davis19@example.com", "pass7444"),
(20, "Chris Brown", "chris.brown20@example.com", "pass4233");

CREATE TABLE foods (
    foods_id INT PRIMARY KEY AUTO_INCREMENT,
    foods_name VARCHAR(255),
    image VARCHAR(255),
    price FLOAT,
    description TEXT,
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES food_type(type_id)
);
 
INSERT INTO foods (foods_id, foods_name, price, description) VALUES
(1, "trà sữa trân châu hoàng kim", "80", "trà sữa" ),
(2, "trà sữa trân châu đường đen", "70", "trà sữa" ),
(3, "trà sữa trân châu", "40", "trà sữa" ),
(4, "chanh tuyết", "80", "nước trái cây" ),
(5, "sinh tố ép", "80", "nước trái cây" );



CREATE TABLE food_type(
	type_id INT PRIMARY KEY AUTO_INCREMENT,
	type_name VARCHAR(255)	
);

INSERT INTO food_type (type_id, type_name) VALUES
(1, "trà sữa"),
(2, "nước trái cây");

CREATE TABLE sub_food (
	sub_id INT PRIMARY KEY AUTO_INCREMENT,
	sub_name VARCHAR(255),
	sub_price FLOAT,
	foods_id INT,
	FOREIGN KEY (foods_id) REFERENCES foods(foods_id)
)


CREATE TABLE orders(
	orders_id INT PRIMARY KEY AUTO_INCREMENT,
	users_id INT, FOREIGN KEY (users_id) REFERENCES users(users_id) ,
	foods_id INT, FOREIGN KEY (foods_id) REFERENCES foods(foods_id), 
	amount INT,
	codes VARCHAR(255),
	arr_sub_id VARCHAR(255)
);



CREATE TABLE restaurant (
	res_id INT PRIMARY KEY AUTO_INCREMENT,
	res_name VARCHAR(255),
	image VARCHAR(255),
	descs VARCHAR(255)
	);
INSERT INTO restaurant(res_id, res_name) VALUES
(1, "nhà hàng đệ nhất"),
(2, "nhà hàng đệ nhị"),


CREATE TABLE rate_res (
	rate_res_id INT PRIMARY KEY AUTO_INCREMENT,
	users_id INT,
	FOREIGN KEY (users_id) REFERENCES users (users_id),
	res_id INT,
	FOREIGN KEY (res_id) REFERENCES restaurant (res_id),
	amount INT,
	date_rate TIMESTAMP
);
CREATE TABLE like_res(
	like_res_id INT PRIMARY KEY AUTO_INCREMENT,
	users_id INT,
	FOREIGN KEY (users_id) REFERENCES users(users_id),
	res_id INT,
	FOREIGN KEY (res_id) REFERENCES restaurant(res_id),
	date_like TIMESTAMP
)

INSERT INTO like_res(like_res_id, users_id, res_id) VALUES
(1,2,1),
(2,5,1),
(3,6,2),
(4,20,1),
(5,13,2),
(6,7,2),
(7,7,2),
(8,8,1),
(9,11,1),
(10,2,2);

-- Câu hỏi bài tập SQL
-- Câu 1: Tìm 5 người đã like nhà hàng nhiều nhất
SELECT COUNT(like_res_id) AS "Người like nhiều nhất", users.full_name, users.email
FROM like_res
INNER JOIN users ON like_res.users_id = users.users_id
GROUP BY like_res.users_id
ORDER BY `Người like nhiều nhất` DESC
LIMIT 5


-- Câu 2: Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT COUNT(like_res.res_id) AS "Lượt like nhà hàng", like_res.res_id, restaurant.res_name
FROM like_res
INNER JOIN restaurant ON like_res.res_id = restaurant.res_id
GROUP BY like_res.res_id
ORDER BY `Lượt like nhà hàng` DESC
LIMIT 2


-- Câu 3: Tìm người đã đặt hàng nhiều nhất
SELECT COUNT(orders.users_id), orders.users_id, users.full_name
FROM orders
INNER JOIN users ON orders.users_id = users.users_id
GROUP BY orders.users_id
ORDER BY `COUNT(orders.users_id)` DESC
LIMIT 1


-- Câu 4: Tìm người dùng không hoạt động trong hệ thống ( không đặt hàng, không like, không đánh giá nhà hàng )
SELECT *
FROM users
LEFT JOIN orders ON users.users_id = orders.users_id
LEFT JOIN like_res ON users.users_id = like_res.users_id
LEFT JOIN rate_res ON users.users_id = rate_res.users_id
WHERE orders.users_id IS NULL AND like_res.users_id IS NULL AND rate_res.users_id IS NULL

