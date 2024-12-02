-- lista de functions no MySQL usar o help pra entender como usar cada função.

-- 1. String Functions
-- ASCII(): Retorna o código ASCII do primeiro caractere.
SELECT ASCII('2');
SELECT ASCII(2);
SELECT ASCII('dx');

-- BIN(): Converte um número decimal para binário.
SELECT BIN(11);

-- CHAR_LENGTH() / LENGTH(): Retorna o tamanho de uma string (em caracteres ou bytes).
SELECT CHAR_LENGTH('senai'), LENGTH('SENAI');

-- CONCAT(): Concatena strings.
SELECT CONCAT('senai','@','123');

-- CONCAT_WS(): Concatena strings com separador.
SELECT CONCAT_WS(' ','senai','@','123');

-- ELT(): Retorna a string em uma posição da lista.
SELECT ELT(4,'A','B','C','D');

-- FIELD(): Retorna a posição de uma string na lista fornecida.
SELECT FIELD('A','A','B','C','D');

-- FIND_IN_SET(): Retorna a posição de uma string dentro de uma lista separada por vírgulas.
SELECT FIND_IN_SET('A','A,B,C,D');

-- FORMAT(): Formata um número.
SELECT FORMAT(12332.123456, 3);
SELECT FORMAT(12332.1,4);
SELECT FORMAT(12332.2,0);
SELECT FORMAT(12332.2,2,'de_DE');

-- INSTR(): Retorna a posição da primeira ocorrência de uma substring.
SELECT INSTR('senai','na');

-- LEFT() / RIGHT(): Retorna os primeiros ou últimos caracteres de uma string.
SELECT LEFT('SENAI', 2), RIGHT('SENAI',2);

-- LOCATE(): Similar ao INSTR(), mas permite especificar uma posição inicial.
SELECT INSTR('SENAI SENAI','A'), LOCATE('A','SENAI SENAI',INSTR('SENAI SENAI','A')+1);

-- LOWER() / UPPER(): Converte strings para minúsculas ou maiúsculas.
SELECT LOWER('seNai') , UPPER('SeNai');

-- LPAD() / RPAD(): Preenche uma string no início ou no fim.
SELECT LPAD('Hi',10,'0'), RPAD('Hi',10,'0');

-- LTRIM() / RTRIM(): Remove espaços à esquerda ou direita.
-- TRIM(): Remove caracteres das extremidades.
SELECT LTRIM('   NOME   '), RTRIM('   NOME   '), TRIM('   NOME   ');

-- MID() / SUBSTRING(): Extrai parte de uma string.
-- REPLACE(): Substitui parte de uma string.
-- REVERSE(): Inverte a string.
-- SOUNDEX(): Retorna um código fonético de uma string.
-- SPACE(): Retorna uma string de espaços.
-- STRCMP(): Compara strings.

-- 2. Numeric Functions
-- ABS(): Retorna o valor absoluto.
-- CEIL() / CEILING(): Arredonda para cima.
-- DIV: Realiza divisão inteira.
-- FLOOR(): Arredonda para baixo.
-- MOD(): Retorna o resto da divisão.
-- PI(): Retorna o valor de π.
-- POW() / POWER(): Eleva um número à potência.
-- RAND(): Retorna um número aleatório.
-- ROUND(): Arredonda um número.
-- SIGN(): Retorna o sinal de um número (-1, 0, 1).
-- SQRT(): Calcula a raiz quadrada.
-- TRUNCATE(): Trunca um número para o número especificado de casas decimais.

 -- 3. Date and Time Functions
-- ADDDATE() / DATE_ADD(): Adiciona um intervalo a uma data.
-- CURDATE() / CURRENT_DATE(): Retorna a data atual.
-- CURTIME() / CURRENT_TIME(): Retorna a hora atual.
-- DATEDIFF(): Retorna a diferença em dias entre duas datas.
-- DATE_FORMAT(): Formata uma data para um formato especificado.
-- DAY(), MONTH(), YEAR(): Extrai partes da data.
-- DAYNAME(), MONTHNAME(): Retorna o nome do dia/mês.
-- DAYOFMONTH(), DAYOFWEEK(), DAYOFYEAR(): Retorna o dia do mês/semana/ano.
-- EXTRACT(): Extrai partes de uma data ou hora.
-- FROM_DAYS(): Converte dias desde o ano 0 para uma data.
-- HOUR(), MINUTE(), SECOND(): Extrai partes da hora.
-- LAST_DAY(): Retorna o último dia do mês.
-- MAKEDATE(): Cria uma data com base no ano e dia do ano.
-- MAKETIME(): Cria um tempo com base em hora, minuto e segundo.
-- NOW(): Retorna a data e hora atual.
-- STR_TO_DATE(): Converte uma string em data.
-- TIMESTAMP(): Retorna data e hora combinadas.
-- WEEK(), WEEKDAY(), WEEKOFYEAR(): Funções de semana.

-- 4. Control Flow Functions
-- IF(): Condicional simples.
-- CASE: Estrutura de múltiplas condições.
-- IFNULL(): Substitui NULL por um valor especificado.
-- NULLIF(): Retorna NULL se os valores forem iguais.

-- 5. Encryption and Hashing Functions
-- AES_ENCRYPT(), AES_DECRYPT(): Criptografia AES.
-- MD5(): Retorna o hash MD5.
-- SHA1(), SHA2(): Retorna hashes SHA.

-- 6. Miscellaneous Functions
-- VERSION(): Retorna a versão do MySQL.
-- DATABASE(): Retorna o banco de dados atual.
-- USER() / CURRENT_USER(): Retorna o usuário conectado.
-- UUID(): Gera um identificador único.alter

-- 7. Aggregate Functions
-- AVG(): Calcula a média.
-- COUNT(): Conta os registros.
-- MAX(), MIN(): Retorna o maior ou menor valor.
-- SUM(): Soma os valores.