
# CRIANDO TABELAS E CARREGANDOS OS DADOS VIA LINHA DE COMANDO
# Cria a tabela
CREATE TABLE `exercicio_4`.`channels` (
  `channel_id` int DEFAULT NULL,
  `channel_name` text,
  `channel_type` text);

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/channels.csv' INTO TABLE `exercicio_4`.`channels` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria a tabela
CREATE TABLE `exercicio_4`.`hubs` (
  `hub_id` int DEFAULT NULL,
  `hub_name` text,
  `hub_city` text,
  `hub_state` text,
  `hub_latitude` double DEFAULT NULL,
  `hub_longitude` double DEFAULT NULL);

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/hubs.csv' INTO TABLE `exercicio_4`.`hubs` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria a tabela
CREATE TABLE `exercicio_4`.`stores` (
  `store_id` int DEFAULT NULL,
  `hub_id` int DEFAULT NULL,
  `store_name` text,
  `store_segment` text,
  `store_plan_price` int DEFAULT NULL,
  `store_latitude` text,
  `store_longitude` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/stores.csv' INTO TABLE `exercicio_4`.`stores` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria tabela
CREATE TABLE `exercicio_4`.`drivers` (
  `driver_id` int DEFAULT NULL,
  `driver_modal` text,
  `driver_type` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/drivers.csv' INTO TABLE `exercicio_4`.`drivers` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria tabela
CREATE TABLE `exercicio_4`.`deliveries` (
  `delivery_id` int DEFAULT NULL,
  `delivery_order_id` int DEFAULT NULL,
  `driver_id` int DEFAULT NULL,
  `delivery_distance_meters` int DEFAULT NULL,
  `delivery_status` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/deliveries.csv' INTO TABLE `exercicio_4`.`deliveries` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria tabela
CREATE TABLE `exercicio_4`.`payments` (
  `payment_id` int DEFAULT NULL,
  `payment_order_id` int DEFAULT NULL,
  `payment_amount` double DEFAULT NULL,
  `payment_fee` double DEFAULT NULL,
  `payment_method` text,
  `payment_status` text);

  # Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/payments.csv' INTO TABLE `exercicio_4`.`payments` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

# Cria a tabela
CREATE TABLE `exercicio_4`.`orders` (
  `order_id` int DEFAULT NULL,
  `store_id` int DEFAULT NULL,
  `channel_id` int DEFAULT NULL,
  `payment_order_id` int DEFAULT NULL,
  `delivery_order_id` int DEFAULT NULL,
  `order_status` text,
  `order_amount` double DEFAULT NULL,
  `order_delivery_fee` int DEFAULT NULL,
  `order_delivery_cost` text,
  `order_created_hour` int DEFAULT NULL,
  `order_created_minute` int DEFAULT NULL,
  `order_created_day` int DEFAULT NULL,
  `order_created_month` int DEFAULT NULL,
  `order_created_year` int DEFAULT NULL,
  `order_moment_created` text,
  `order_moment_accepted` text,
  `order_moment_ready` text,
  `order_moment_collected` text,
  `order_moment_in_expedition` text,
  `order_moment_delivering` text,
  `order_moment_delivered` text,
  `order_moment_finished` text,
  `order_metric_collected_time` text,
  `order_metric_paused_time` text,
  `order_metric_production_time` text,
  `order_metric_walking_time` text,
  `order_metric_expediton_speed_time` text,
  `order_metric_transit_time` text,
  `order_metric_cycle_time` text);

# Carrega os dados
LOAD DATA LOCAL INFILE '/Users/dmpm/Dropbox/DSA/SQL-Para-Data-Science/Cap06/Exercicio4/archive/orders.csv' INTO TABLE `exercicio_4`.`orders` CHARACTER SET UTF8
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;



#1- Qual o número de hubs por cidade?
SELECT 
  hub_city, 
  count(*) as hubs_por_cidade
FROM exercicio_4.hubs
GROUP BY hub_city
ORDER BY hubs_por_cidade DESC;

#2- Qual o número de pedidos (orders) por status?
SELECT 
  order_status, 
  COUNT(*) AS pedidos_por_status 
FROM exercicio_4.orders
GROUP BY order_status
ORDER BY pedidos_por_status DESC;

#3- Qual o número de lojas (stores) por cidade dos hubs?
SELECT 
	hub_city, 
  COUNT(store_id) AS lojas_por_cidade_dos_hubs
FROM exercicio_4.stores s, exercicio_4.hubs h
WHERE s.hub_id = h.hub_id
GROUP BY hub_city
ORDER BY lojas_por_cidade_dos_hubs DESC;

#4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?
SELECT 
	MAX(payment_amount) AS maior_valor_de_pagamento, 
	MIN(payment_amount) AS menor_valor_de_pagamento
FROM exercicio_4.payments;

#5- Qual tipo de driver (driver_type) fez o maior número de entregas?
SELECT
	driver_type, 
  COUNT(e.driver_id)
FROM exercicio_4.drivers d, exercicio_4.deliveries e
WHERE d.driver_id = e.driver_id
GROUP BY driver_type 
ORDER BY count(e.driver_id) DESC;

#6- Qual a distância média das entregas por modo de driver (driver_modal)?
SELECT
	driver_modal, 
  ROUND(AVG(e.delivery_distance_meters), 2) AS distancia_media_entregas
FROM exercicio_4.drivers d, exercicio_4.deliveries e
WHERE d.driver_id = e.driver_id
GROUP BY driver_modal; 

#7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?
SELECT
	store_name, 
  ROUND(AVG(o.order_amount),2) AS valor_medio_de_pedido
FROM exercicio_4.stores s, exercicio_4.orders o
WHERE s.store_id = o.store_id
GROUP BY store_name
ORDER BY valor_medio_de_pedido DESC;

#8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?
SELECT COALESCE(store_name, "Sem Loja"), COUNT(order_id) AS contagem
FROM exercicio_4.orders orders LEFT JOIN exercicio_4.stores stores
ON stores.store_id = orders.store_id
GROUP BY store_name
ORDER BY contagem DESC;	

#9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?
SELECT 
    ROUND(SUM(order_amount),2) AS valor_total
FROM exercicio_4.channels c, exercicio_4.orders o
WHERE c.channel_id = o.channel_id
AND channel_name = 'FOOD PLACE';

#10- Quantos pagamentos foram cancelados (chargeback)?
SELECT 
	payment_status,
  COUNT(payment_status) AS contagem_pagamento
FROM exercicio_4.payments
WHERE payment_status = 'CHARGEBACK'
GROUP BY payment_status;

#11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?
SELECT 
	payment_status,
  ROUND(AVG(payment_amount),2) AS contagem
FROM exercicio_4.payments
WHERE payment_status = 'CHARGEBACK'
GROUP BY payment_status;

#12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?
SELECT
	payment_method,
  ROUND(AVG(payment_amount),2) AS valor_medio_pagamento
FROM exercicio_4.payments
GROUP BY payment_method
ORDER BY valor_medio_pagamento DESC;

#13- Quais métodos de pagamento tiveram valor médio superior a 100?
SELECT
	payment_method,
  ROUND(AVG(payment_amount),2) AS valor_medio_pagamento
FROM exercicio_4.payments
GROUP BY payment_method
HAVING valor_medio_pagamento >100
ORDER BY valor_medio_pagamento DESC;

#14- Qual a média de valor de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
SELECT
	hub_state, 
  store_segment, 
  channel_type,
  ROUND(AVG(order_amount), 2) AS media_pedido
FROM exercicio_4.orders o, exercicio_4.hubs h, exercicio_4.stores s, exercicio_4.channels c
WHERE h.hub_id = s.hub_id
AND s.store_id = o.store_id
AND c.channel_id = o.channel_id
GROUP BY hub_state, store_segment, channel_type;
    
#15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type) teve média de valor de pedido (order_amount) maior que 450?
SELECT
	hub_state, 
  store_segment, 
  channel_type, 
  ROUND(AVG(order_amount),2) AS media_pedido
FROM exercicio_4.hubs h, exercicio_4.stores s, exercicio_4.channels c, exercicio_4.orders o
WHERE h.hub_id = s.hub_id
AND s.store_id = o.store_id
AND c.channel_id = o.channel_id
GROUP BY  hub_state, store_segment, channel_type
HAVING media_pedido>450;

#16- Qual o valor total de pedido (order_amount) por estado do hub (hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?
# Demonstre os totais intermediários e formate o resultado.
SELECT
    IF(GROUPING(hub_state), 'Total Hub State', hub_state) AS hub_state, 
    IF(GROUPING(store_segment), 'Total Segmento', store_segment) AS store_segment,
    IF(GROUPING(channel_type), 'Total Tipo de Canal', channel_type) AS channel_type,
    ROUND(SUM(order_amount), 2)
FROM exercicio_4.orders o, exercicio_4.hubs h, exercicio_4.stores s, exercicio_4.channels c
WHERE h.hub_id = s.hub_id
AND s.store_id = o.store_id
AND c.channel_id = o.channel_id
GROUP BY hub_state, store_segment, channel_type WITH ROLLUP;

#17- Quando o pedido era do Hub do Rio de Janeiro (hub_state), segmento de loja 'FOOD', tipo de canal Marketplace e foi cancelado, qual foi a média de valor do pedido (order_amount)?
SELECT
	hub_state, 
  store_segment, 
  channel_type, 
  ROUND(AVG(order_amount), 2)
FROM exercicio_4.orders o, exercicio_4.hubs h, exercicio_4.stores s, exercicio_4.channels c
WHERE h.hub_id = s.hub_id
AND s.store_id = o.store_id
AND c.channel_id = o.channel_id
AND hub_state = 'RJ'
AND store_segment = 'FOOD'
AND channel_type = 'MARKETPLACE'
AND order_status = 'CANCELED'
GROUP BY hub_state, store_segment, channel_type;

#18- Quando o pedido era do segmento de loja 'GOOD', tipo de canal Marketplace e foi cancelado, algum hub_state teve total de valor do pedido superior a 100.000?
SELECT
	hub_state, 
  store_segment, 
  channel_type, 
  ROUND(SUM(order_amount), 2) AS total_pedido
FROM exercicio_4.orders o, exercicio_4.hubs h, exercicio_4.stores s, exercicio_4.channels c
WHERE h.hub_id = s.hub_id
AND s.store_id = o.store_id
AND c.channel_id = o.channel_id
AND order_status = 'CANCELED'
AND store_segment = 'GOOD'
AND channel_type = 'MARKETPLACE'
GROUP BY hub_state, store_segment, channel_type
HAVING total_pedido > 100000;

#19- Em que data houve a maior média de valor do pedido (order_amount)?
SELECT
	SUBSTRING(order_moment_created, 1, 9) AS data_pedido, 
  ROUND(AVG(order_amount), 2) AS media
FROM exercicio_4.orders
GROUP BY data_pedido
ORDER BY media DESC;


#20- Em quais datas o valor do pedido foi igual a zero (ou seja, não houve venda)?
SELECT
	SUBSTRING(order_moment_created, 1, 9) AS data_pedido, 
  MIN(order_amount) AS min
FROM exercicio_4.orders
GROUP BY data_pedido
HAVING min = 0
ORDER BY min ASC;
