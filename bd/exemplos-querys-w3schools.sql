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
A palavra-chave ORDER BY é usada para classificar o conjunto de resultados em ordem crescente ou decrescente.
*/
SELECT * FROM Products ORDER BY Price;
SELECT * FROM Products ORDER BY Price DESC;
SELECT * FROM Products ORDER BY Price, ProductID;
SELECT * FROM Customers ORDER BY Country ASC, City ASC, CustomerName DESC;

/*
O operador SQL AND
A cláusula WHERE pode conter um ou muitos operadores AND.
O operador AND é usado para filtrar registros com base em mais de uma condição, 
*/
-- Exemplo: Selecione todos os clientes da Espanha que começam com a letra 'G':
SELECT * FROM Customers WHERE Country = 'Spain' AND CustomerName LIKE 'G%';

/*
Operadores AND vs OR
O operador AND exibe um registro se todas as condições forem VERDADEIRAS.
O operador OR exibe um registro se qualquer uma das condições for VERDADEIRA.
*/

/*
(AND) Todas as condições devem ser verdadeiras
A seguinte instrução SQL seleciona todos os campos Customersonde 
Country "Alemanha" E City "Berlim" E PostalCode é maior que 12000:
*/
SELECT * FROM Customers WHERE Country = 'Germany' AND City = 'Berlin' AND PostalCode > 12000;

/*
Combinando AND e OR
Você pode combinar os operadores AND e OR
A seguinte instrução SQL seleciona todos os clientes da Espanha que começam com "G" ou "R".
Certifique-se de usar parênteses para obter o resultado correto.
*/
SELECT * FROM Customers WHERE Country = 'Spain' AND (CustomerName LIKE 'G%' OR CustomerName LIKE 'R%');

/*
O operador SQL OR
A cláusula WHERE pode conter um ou mais operadores OR.
O operador OR é usado para filtrar registros com base em mais de uma condição, 
se você quisesse retornar todos os clientes da Alemanha, mas também aqueles da Espanha:
*/
SELECT * FROM Customers WHERE Country = 'Germany' OR Country = 'Spain';

/*
Operador NOT
O operador NOT é usado em combinação com outros operadores para fornecer o resultado oposto, 
também chamado de resultado negativo.
*/
-- Na instrução select abaixo, queremos retornar todos os clientes que NÃO são da Espanha:
SELECT * FROM Customers WHERE NOT Country = 'Spain';

-- Selecione clientes que não começam com a letra 'A':
SELECT * FROM Customers WHERE CustomerName NOT LIKE 'A%' ORDER BY CustomerName;

/*
O que é um valor NULL?
Um campo com valor NULL é um campo sem valor.
Se um campo em uma tabela for opcional, é possível inserir um novo registro ou atualizar um registro sem adicionar um valor a esse campo. 
Então, o campo será salvo com um valor NULL.
Nota: Um valor NULL é diferente de um valor zero ou de um campo que contém espaços. 
Um campo com um valor NULL é aquele que foi deixado em branco durante a criação do registro!
Como testar valores NULL?
Não é possível testar valores NULL com operadores de comparação, como =, < ou <>.
Teremos que usar os operadores IS NULLand IS NOT NULLem vez disso.
*/
-- Deixar alguns registros com o endereço NULL
UPDATE Customers SET Address = NULL WHERE CustomerID = 3 OR CustomerID = 5;
-- Selecionar espeficicamente os registro que não tem preenchimento no endereço
SELECT * FROM Customers WHERE Address IS NULL;

/*
Operador SQL IN
O operador IN permite que você especifique vários valores em uma cláusula WHERE.
O operador IN é uma abreviação para múltiplas condições OR.
*/
-- Retornar todos os clientes da 'Alemanha', 'França' ou 'Reino Unido'
SELECT * FROM Customers WHERE Country IN ('Germany', 'France', 'UK');

-- Retornar todos os clientes que NÃO são da 'Alemanha', 'França' ou 'Reino Unido':
SELECT * FROM Customers WHERE Country NOT IN ('Germany', 'France', 'UK');

/*
IN (SELECT)
Você também pode usar IN com uma subconsulta na cláusula WHERE.
Com uma subconsulta, você pode retornar todos os registros da consulta principal que estão presentes no resultado da subconsulta.
Nota: subconsulta é um select dentro de outro select isolado por ()
*/
-- Seleciona todos os clientes : Total 91
SELECT count(*) FROM Customers;
-- Retorna o ID de todos os clientes que fizeram algum pedido
SELECT DISTINCT CustomerID FROM Orders;
-- Retorna todos os clientes que têm um pedido na tabela Pedidos : Total 74
SELECT count(*) FROM Customers WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);
-- Retorna todos os clientes que NÃO fizeram nenhum pedido na tabela Pedidos : Total 17
SELECT count(*) FROM Customers WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

/*
Função MySQL SUBSTR()
*/
-- Extraia uma substring de uma string (comece na posição 5, extraia 3 caracteres)
SELECT SUBSTR("SQL Tutorial", 5, 3) AS ExtractString; -- Retorno: Tut

-- Extraia uma substring de uma string (comece do final, na posição -5, extraia 5 caracteres):
SELECT SUBSTR("SQL Tutorial", -5, 5) AS ExtractString; -- Retorno: orial

/*
A cláusula SQL SELECT LIMIT 
A cláusula SELECT LIMIT é usada para especificar o número de registros a serem retornados.
A cláusula SELECT LIMIT é útil em tabelas grandes com milhares de registros. 
Retornar um grande número de registros pode impactar o desempenho.
*/
SELECT * FROM Customers LIMIT 5;

/*
Funções de agregação SQL
Uma função agregada é uma função que executa um cálculo em um conjunto de valores e retorna um único valor.
Funções agregadas são frequentemente usadas com a cláusula GROUP BY da instrução SELECT. 
A cláusula GROUP BY divide o conjunto de resultados em grupos de valores e a função agregada pode ser usada para retornar um único valor para cada grupo.
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
Operador LIKE
O operador LIKE é usado em uma cláusula WHERE para procurar um padrão especificado em uma coluna.
Existem dois curingas frequentemente usados ​​em conjunto com o operador LIKE:
O sinal de porcentagem % representa zero, um ou vários caracteres
O sinal de sublinhado _ representa um único caractere
*/

/*
Curinga _
O curinga _ representa um único caractere.
Pode ser qualquer caractere ou número, mas cada um _ representa um, e somente um, caractere.
*/
-- Retorna todos os clientes de uma cidade que começa com 'L' seguido por um caractere curinga, depois 'nd' e depois dois caracteres curinga:
SELECT * FROM Customers WHERE city LIKE 'L_nd__';

/*
Curinga %
O curinga % representa qualquer número de caracteres, até mesmo zero caracteres.
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
Operador BETWEEN
O operador BETWEEN seleciona valores dentro de um intervalo dado. Os valores podem ser números, texto ou datas.
O operador BETWEEN é inclusivo: o valor inicial e final são incluídos. 
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
Alias ​​(AS)
Aliases SQL são usados ​​para dar a uma tabela, ou a uma coluna em uma tabela, um nome temporário.
Aliases são frequentemente usados ​​para tornar os nomes das colunas mais legíveis.
Um alias só existe enquanto durar essa consulta.
Um alias é criado com a palavra-chave (AS).
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

-- Usando "aspas duplas" para alias com caracteres de espaço:
SELECT ProductName AS "My Great Products" FROM Products;

-- A seguinte instrução SQL cria um alias chamado "Endereço" que combina quatro colunas (Endereço, Código Postal, Cidade e País):
SELECT CustomerName, CONCAT(Address,', ',PostalCode,', ',City,', ',Country) AS "Endereço" FROM Customers;

/*
Pode parecer inútil usar aliases em tabelas, mas quando você usa mais de uma tabela em suas consultas, 
isso pode tornar as instruções SQL mais curtas.
A seguinte declaração SQL seleciona todos os pedidos do cliente com CustomerID=4 (Around the Horn). 
Usamos as tabelas "Customers" e "Orders" e damos a elas os aliases de tabela "c" e "o" respectivamente 
*/
-- (Aqui usamos aliases para tornar o SQL mais curto):
SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName='Around the Horn' AND c.CustomerID=o.CustomerID;

/*
JOIN SQL
Uma cláusula JOIN é usada para combinar linhas de duas ou mais tabelas, 
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
Aqui estão os diferentes tipos de JOINs em SQL:
INNER JOIN: Retorna registros que possuem valores correspondentes em ambas as tabelas
LEFT  JOIN: Retorna todos os registros da tabela da esquerda e os registros correspondentes da tabela da direita
RIGHT JOIN: Retorna todos os registros da tabela da direita e os registros correspondentes da tabela da esquerda
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

/*
Operador SQL UNION
O operador UNION é usado para combinar o conjunto de resultados de duas ou mais instruções de SELECT.
Cada declaração SELECT deve ter o mesmo número de colunas
As colunas também devem ter tipos de dados semelhantes
As colunas em cada declaração SELECT também devem estar na mesma ordem

Sintaxe:
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

O operador UNION seleciona apenas valores distintos por padrão. 
Para permitir valores duplicados, use UNION ALL:

Sintaxe:
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;
*/

-- A seguinte instrução SQL retorna as cidades (apenas valores distintos) das tabelas "Clientes" e "Fornecedores":
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;

-- A seguinte instrução SQL retorna as cidades (valores duplicados também) das tabelas "Clientes" e "Fornecedores":
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;

-- A seguinte instrução SQL lista todos os clientes e fornecedores:
SELECT 'Cliente' AS Type, ContactName, City, Country
FROM Customers
UNION
SELECT 'Fornecedor', ContactName, City, Country
FROM Suppliers;

/*
A instrução SQL GROUP BY
A instrução GROUP BY agrupa linhas que têm os mesmos valores em linhas de resumo, 
como "encontrar o número de clientes em cada país".
A instrução GROUP BY é frequentemente usada com funções de agregação (COUNT(), MAX(), MIN(), SUM(), AVG()) 
para agrupar o conjunto de resultados por uma ou mais colunas.
*/
-- A seguinte instrução SQL lista o número de clientes em cada país:
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country;

-- A seguinte instrução SQL lista o número de pedidos enviados por cada remetente:
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;

/*
Cláusula HAVING do SQL
A cláusula HAVING foi adicionada ao SQL porque a palavra-chave WHERE não pode ser usada com funções de agregação.
*/

-- A seguinte declaração SQL lista o número de clientes em cada país. Inclua apenas países com mais de 5 clientes:
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;

-- A seguinte instrução SQL lista o número de clientes em cada país, 
-- classificados do maior para o menor (inclui apenas países com mais de 5 clientes):
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY COUNT(CustomerID) DESC;

-- A seguinte instrução SQL lista os funcionários que registraram mais de 10 pedidos:
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM (Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID)
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 10;

-- A seguinte instrução SQL lista se os funcionários "Davolio" ou "Fuller" registraram mais de 25 pedidos:
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'Davolio' OR LastName = 'Fuller'
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 25;

/*
Operador SQL EXISTS
O operador EXISTS é usado para testar a existência de qualquer registro em uma subconsulta.
O operador EXISTS retorna TRUE se a subconsulta retornar um ou mais registros.

Sintaxe EXISTS
SELECT column_name(s)
FROM table_name
WHERE EXISTS
(SELECT column_name FROM table_name WHERE condition);
*/
-- A seguinte instrução SQL retorna TRUE e lista os fornecedores com preço de produto menor que 20:
SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price < 20);

-- A seguinte instrução SQL retorna TRUE e lista os fornecedores com preço de produto igual a 22:
SELECT SupplierName
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.supplierID AND Price = 22);

/*
Expressão CASE do SQL
A expressão CASE passa por condições e retorna um valor quando a primeira condição é atendida (como uma declaração if-then-else). 
Então, uma vez que uma condição é verdadeira, ela para de ler e retorna o resultado. 
Se nenhuma condição for verdadeira, ela retorna o valor na cláusula ELSE.
Se não houver nenhuma parte ELSE e nenhuma condição for verdadeira, ele retornará NULL.
Sintaxe:
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
*/

-- O SQL a seguir analisa as condições e retorna um valor quando a primeira condição é atendida:
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'A quantidade é maior que 30'
    WHEN Quantity = 30 THEN 'A quantidade é 30'
    ELSE 'A quantidade é menor que 30'
END AS QuantityText
FROM OrderDetails;

-- O SQL a seguir ordenará os clientes por City. No entanto, se City for NULL, então ordenará por Country:
SELECT CustomerName, City, Country
FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END);

