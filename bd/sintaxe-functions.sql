A criação de funções definidas pelo usuário no MySQL segue a sintaxe básica abaixo. 
Para criar uma função, você precisa de permissões adequadas, como CREATE ROUTINE.

Sintaxe Básica:

DELIMITER $$

CREATE FUNCTION nome_da_funcao(parametro1 TIPO, parametro2 TIPO, ...)
RETURNS tipo_de_retorno
DETERMINISTIC
BEGIN
    -- Corpo da função
    DECLARE variavel_tipo TIPO;
    -- Lógica
    RETURN valor;
END$$

DELIMITER ;

Explicação dos Elementos:
DELIMITER: Como o corpo da função pode conter múltiplos ;, mudamos temporariamente o delimitador para outro símbolo (como $$) durante a criação.
CREATE FUNCTION: Declara que você está criando uma função.
Parâmetros: Lista de parâmetros que a função aceita.
RETURNS: Define o tipo de dado que a função retornará (ex.: INT, VARCHAR, etc.).
DETERMINISTIC / NOT DETERMINISTIC:
DETERMINISTIC: Indica que a função sempre retorna o mesmo valor para os mesmos parâmetros.
NOT DETERMINISTIC: Indica que o resultado pode variar (ex.: se usar funções como RAND() ou NOW()).
Corpo da função: Contém as instruções SQL e a lógica para calcular o valor retornado.

Exemplo Prático:
Aqui está um exemplo de uma função simples que retorna o quadrado de um número:

DELIMITER $$

CREATE FUNCTION quadrado(numero INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN numero * numero;
END$$

DELIMITER ;

Como usar:
SELECT quadrado(5); -- Retorna 25

Outro Exemplo com Lógica:
Uma função que verifica se um número é par ou ímpar:

DELIMITER $$

CREATE FUNCTION eh_par(numero INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF numero % 2 = 0 THEN
        RETURN 'Par';
    ELSE
        RETURN 'Ímpar';
    END IF;
END$$

DELIMITER ;

Como usar:

SELECT eh_par(7); -- Retorna 'Ímpar'
SELECT eh_par(10); -- Retorna 'Par'

Observações Importantes:
Permissões: Você precisa de permissões administrativas (CREATE ROUTINE) para criar funções.
Funções não podem modificar dados: Diferentemente de procedimentos armazenados,ou seja funções não podem usar comandos como INSERT, UPDATE ou DELETE.
Uso com Cuidado: Funções devem ser usadas em consultas com cuidado, pois podem impactar a performance dependendo da lógica.
