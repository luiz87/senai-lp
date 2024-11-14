-- link da base w3schools
-- https://github.com/AndrejWeb/w3schools-database/blob/master/w3schools.sql
use w3schools;

/*
A instrução SQL SELECT
A SELECTinstrução é usada para selecionar dados de um banco de dados.
*/

SELECT CustomerName, City FROM Customers;

/*
A instrução SQL SELECT DISTINCT
A SELECT DISTINCTinstrução é usada para retornar apenas valores distintos (diferentes).
*/

SELECT DISTINCT Country FROM Customers;

/*
A cláusula SQL WHERE
A WHERE cláusula é usada para filtrar registros.
Ele é usado para extrair apenas os registros que atendem a uma condição especificada.
*/

SELECT * FROM Customers WHERE Country='Mexico';

/*
A ORDEM SQL POR
A ORDER BY palavra-chave é usada para classificar o conjunto de resultados em ordem crescente ou decrescente.
*/

SELECT * FROM Products ORDER BY Price;
SELECT * FROM Products ORDER BY Price DESC;
SELECT * FROM Products ORDER BY Price, ProductID;
SELECT * FROM Customers ORDER BY Country ASC, City ASC, CustomerName DESC;

/*
O operador SQL AND
A WHERE cláusula pode conter um ou muitos AND operadores.
O AND operador é usado para filtrar registros com base em mais de uma condição, 
como se você quisesse retornar todos os clientes da Espanha que começam com a letra 'G':
*/

-- Exemplo: Selecione todos os clientes da Espanha que começam com a letra 'G':
SELECT * FROM Customers WHERE Country = 'Spain' AND CustomerName LIKE 'G%';

/*
E vs OU
O ANDoperador exibe um registro se todas as condições forem VERDADEIRAS.
O ORoperador exibe um registro se qualquer uma das condições for VERDADEIRA.
*/

/*
Todas as condições devem ser verdadeiras
A seguinte instrução SQL seleciona todos os campos Customersonde 
Country"Alemanha" E City"Berlim" E PostalCodeé maior que 12000:
*/
SELECT * FROM Customers WHERE Country = 'Germany' AND City = 'Berlin' AND PostalCode > 12000;

/*
Combinando AND e OR
Você pode combinar os operadores AND e .OR
A seguinte instrução SQL seleciona todos os clientes da Espanha que começam com "G" ou "R".
Certifique-se de usar parênteses para obter o resultado correto.
*/

SELECT * FROM Customers WHERE Country = 'Spain' AND (CustomerName LIKE 'G%' OR CustomerName LIKE 'R%');

/*
O operador SQL OR
A WHERE cláusula pode conter um ou mais OR operadores.
O OR operador é usado para filtrar registros com base em mais de uma condição, 
se você quisesse retornar todos os clientes da Alemanha, mas também aqueles da Espanha:
*/

SELECT * FROM Customers WHERE Country = 'Germany' OR Country = 'Spain';

/*
O operador NOT
O NOT operador é usado em combinação com outros operadores para fornecer o resultado oposto, 
também chamado de resultado negativo.
Na instrução select abaixo, queremos retornar todos os clientes que NÃO são da Espanha:
*/

SELECT * FROM Customers WHERE NOT Country = 'Spain';

-- Selecione clientes que não começam com a letra 'A':
SELECT * FROM Customers WHERE CustomerName NOT LIKE 'A%' ORDER BY CustomerName;

/*
O que é um valor NULL?
Um campo com valor NULL é um campo sem valor.
Se um campo em uma tabela for opcional, é possível inserir um novo registro ou atualizar um registro sem adicionar um valor a esse campo. Então, o campo será salvo com um valor NULL.
Nota: Um valor NULL é diferente de um valor zero ou de um campo que contém espaços. Um campo com um valor NULL é aquele que foi deixado em branco durante a criação do registro!
Como testar valores NULL?
Não é possível testar valores NULL com operadores de comparação, como =, < ou <>.
Teremos que usar os operadores IS NULLand IS NOT NULLem vez disso.
*/
UPDATE Customers SET Address = NULL WHERE CustomerID = 3 OR CustomerID = 5;
SELECT * FROM Customers WHERE Address IS NULL;

/*
O operador SQL IN
O IN operador permite que você especifique vários valores em uma WHERE cláusula.
O IN operador é uma abreviação para múltiplas OR condições.
*/
-- Retornar todos os clientes da 'Alemanha', 'França' ou 'Reino Unido'
SELECT * FROM Customers WHERE Country IN ('Germany', 'France', 'UK');

-- Retornar todos os clientes que NÃO são da 'Alemanha', 'França' ou 'Reino Unido':
SELECT * FROM Customers WHERE Country NOT IN ('Germany', 'France', 'UK');

/*
IN (SELECT)
Você também pode usar INcom uma subconsulta na WHERE cláusula.
Com uma subconsulta, você pode retornar todos os registros da consulta principal que estão presentes no resultado da subconsulta.
*/
-- Total de cliente 91
SELECT count(*) FROM Customers;
-- Retorna o ID de todos os clientes que fizeram algum pedido
SELECT DISTINCT CustomerID FROM Orders;
-- Retorna todos os clientes que têm um pedido na tabela Pedidos : Total 74
SELECT count(*) FROM Customers WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);
-- Retorna todos os clientes que NÃO fizeram nenhum pedido na tabela Pedidos : Total 17
SELECT count(*) FROM Customers WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

/*
Função MySQL SUBSTR()
Extraia uma substring de uma string (comece na posição 5, extraia 3 caracteres)
*/

SELECT SUBSTR("SQL Tutorial", 5, 3) AS ExtractString;

/*
Extraia uma substring de uma string (comece do final, na posição -5, extraia 5 caracteres):
*/

SELECT SUBSTR("SQL Tutorial", -5, 5) AS ExtractString;

/*
A cláusula SQL SELECT LIMIT 
A SELECT LIMIT cláusula é usada para especificar o número de registros a serem retornados.
A SELECT LIMIT cláusula é útil em tabelas grandes com milhares de registros. 
Retornar um grande número de registros pode impactar o desempenho.
*/

SELECT * FROM Customers LIMIT 5;

/*
Funções de agregação SQL
Uma função agregada é uma função que executa um cálculo em um conjunto de valores e retorna um único valor.
Funções agregadas são frequentemente usadas com a GROUP BYcláusula da SELECT instrução. A GROUP BYcláusula divide o conjunto de resultados em grupos de valores e a função agregada pode ser usada para retornar um único valor para cada grupo.
As funções de agregação SQL mais comumente usadas são:
MIN()- retorna o menor valor dentro da coluna selecionada
MAX()- retorna o maior valor dentro da coluna selecionada
COUNT()- retorna o número de linhas em um conjunto
SUM()- retorna a soma total de uma coluna numérica
AVG()- retorna o valor médio de uma coluna numérica
Funções de agregação ignoram valores nulos (exceto para COUNT()).
*/

SELECT MIN(Price), MAX(Price), COUNT(*), SUM(Price), AVG(Price) FROM Products;

/*
O operador SQL LIKE
O LIKE operador é usado em uma WHERE cláusula para procurar um padrão especificado em uma coluna.
Existem dois curingas frequentemente usados ​​em conjunto com o LIKE operador:
O sinal de porcentagem % representa zero, um ou vários caracteres
O sinal de sublinhado _ representa um único caractere
*/

/*
O _ curinga
O _ curinga representa um único caractere.
Pode ser qualquer caractere ou número, mas cada um _ representa um, e somente um, caractere.
*/
-- Retorna todos os clientes de uma cidade que começa com 'L' seguido por um caractere curinga, depois 'nd' e depois dois caracteres curinga:
SELECT * FROM Customers WHERE city LIKE 'L_nd__';

/*
O % curinga
O % curinga representa qualquer número de caracteres, até mesmo zero caracteres.
*/
-- Retorna todos os clientes de uma cidade que contém a letra 'L':
SELECT * FROM Customers WHERE city LIKE '%L%';

-- Selecione todos os clientes que começam com a letra "a":
SELECT * FROM Customers WHERE CustomerName LIKE 'a%';

-- Retorna todos os clientes que terminam com 'a':
SELECT * FROM Customers WHERE CustomerName LIKE '%a';

-- Retorna todos os clientes que começam com "b" e terminam com "s":
SELECT * FROM Customers WHERE CustomerName LIKE 'b%s';

-- Retorna todos os clientes que começam com "a" e têm pelo menos 3 caracteres de comprimento:
SELECT * FROM Customers WHERE CustomerName LIKE 'a__%';

-- Se nenhum curinga for especificado, a frase precisará ter uma correspondência exata para retornar um resultado.
-- Retornar todos os clientes da Espanha:
SELECT * FROM Customers WHERE Country LIKE 'Spain';

/*
O operador SQL BETWEEN
O BETWEEN operador seleciona valores dentro de um intervalo dado. Os valores podem ser números, texto ou datas.
O BETWEEN operador é inclusivo: os valores inicial e final são incluídos. 
*/
-- Seleciona todos os produtos com preço entre 10 e 20:
SELECT * FROM Products WHERE Price BETWEEN 10 AND 20;
-- Se não existice o BETWEEN 
SELECT * FROM Products WHERE Price >= 10 AND Price <= 20;

-- Para exibir os produtos fora do intervalo do exemplo anterior, use NOT BETWEEN:
SELECT * FROM Products WHERE Price NOT BETWEEN 10 AND 20;

-- A seguinte instrução SQL seleciona todos os produtos com um preço entre 10 e 20. 
-- Além disso, o CategoryID deve ser 1, 2 ou 3:
SELECT * FROM Products WHERE Price BETWEEN 10 AND 20 AND CategoryID IN (1,2,3);

-- A seguinte instrução SQL seleciona todos os produtos com um ProductName em ordem alfabética 
-- entre Carnarvon Tigers e Mozzarella di Giovanni:
SELECT * FROM Products
WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY ProductName;

-- A seguinte instrução SQL seleciona todos os produtos com um ProductName que não esteja 
-- entre Carnarvon Tigers e Mozzarella di Giovanni:
SELECT * FROM Products
WHERE ProductName NOT BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY ProductName;

-- A seguinte instrução SQL seleciona todos os pedidos com uma OrderDate entre '01-julho-1996' e '31-julho-1996':
SELECT * FROM Orders WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';

/*
Alias ​​SQL
Aliases SQL são usados ​​para dar a uma tabela, ou a uma coluna em uma tabela, um nome temporário.
Aliases são frequentemente usados ​​para tornar os nomes das colunas mais legíveis.
Um alias só existe enquanto durar essa consulta.
Um alias é criado com a ASpalavra-chave.
*/

SELECT CustomerID AS ID FROM Customers;

-- Na verdade, na maioria das linguagens de banco de dados, você pode pular a palavra-chave AS e obter o mesmo resultado:
SELECT CustomerID ID FROM Customers;

/*
Sintaxe
Quando alias é usado na coluna:
SELECT column_name AS alias_name FROM table_name;
Quando alias é usado na tabela:
SELECT column_name(s) FROM table_name AS alias_name;
*/

-- Usando "aspas duplas" para aliases com caracteres de espaço:
SELECT ProductName AS "My Great Products" FROM Products;

-- A seguinte instrução SQL cria um alias chamado "Endereço" que combina quatro colunas (Endereço, Código Postal, Cidade e País):
SELECT CustomerName, CONCAT(Address,', ',PostalCode,', ',City,', ',Country) AS Address FROM Customers;

/*
Pode parecer inútil usar aliases em tabelas, mas quando você usa mais de uma tabela em suas consultas, 
isso pode tornar as instruções SQL mais curtas.
A seguinte declaração SQL seleciona todos os pedidos do cliente com CustomerID=4 (Around the Horn). 
Usamos as tabelas "Customers" e "Orders" e damos a elas os aliases de tabela "c" e "o" respectivamente 
(Aqui usamos aliases para tornar o SQL mais curto):
*/

SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName='Around the Horn' AND c.CustomerID=o.CustomerID;


/*
JOIN SQL
Uma JOIN cláusula é usada para combinar linhas de duas ou mais tabelas, 
com base em uma coluna relacionada entre elas.
Observe que a coluna "CustomerID" na tabela "Orders" se refere ao "CustomerID" na tabela "Customers". 
O relacionamento entre as duas tabelas acima é a coluna "CustomerID".
Então, podemos criar a seguinte instrução SQL (que contém um INNER JOIN), 
que seleciona registros que tenham valores correspondentes em ambas as tabelas:
*/

SELECT o.OrderID, c.CustomerName, o.OrderDate
FROM Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID;

/*
Diferentes tipos de SQL JOINs
Aqui estão os diferentes tipos de JOINs em SQL:
(INNER) JOIN: Retorna registros que possuem valores correspondentes em ambas as tabelas
(LEFT)  JOIN: Retorna todos os registros da tabela da esquerda e os registros correspondentes da tabela da direita
(RIGHT) JOIN: Retorna todos os registros da tabela da direita e os registros correspondentes da tabela da esquerda
(FULL)  JOIN: Retorna todos os registros quando há uma correspondência na tabela esquerda ou direita
*/

-- Junte produtos e categorias com a palavra-chave INNER JOIN:
SELECT ProductID, ProductName, CategoryName FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;

-- JOIN a três tabelas
-- A seguinte instrução SQL seleciona todos os pedidos com informações do cliente e do remetente:
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);
-- SELECT * FROM Customers , Orders WHERE Customers.CustomerID = Orders.CustomerID;

-- Exemplo de SQL LEFT JOIN
-- A seguinte instrução SQL selecionará todos os clientes e quaisquer pedidos que eles possam ter:
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;

-- A seguinte instrução SQL retornará todos os funcionários e quaisquer pedidos que eles possam ter feito:
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;







