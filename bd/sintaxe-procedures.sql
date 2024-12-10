No MySQL, stored procedures (procedimentos armazenados) são blocos de código SQL 
armazenados no servidor que podem ser chamados diretamente para executar tarefas específicas. 
Elas são úteis para encapsular lógica complexa e promover o reuso.

Sintaxe para Criar uma Stored Procedure

DELIMITER $$

CREATE PROCEDURE nome_da_procedura(parametro1 TIPO [IN | OUT | INOUT], parametro2 TIPO [IN | OUT | INOUT], ...)
BEGIN
    -- Corpo da procedure
    DECLARE variavel_nome TIPO;
    -- Lógica SQL
    -- Exemplo: SELECT, INSERT, UPDATE, etc.
END$$

DELIMITER ;

Explicação dos Elementos:
DELIMITER: Modifica temporariamente o delimitador (como $$) para que o MySQL não interprete os ; dentro da procedure como o final do comando.
Parâmetros:
IN: O parâmetro é apenas de entrada (valor passado pelo chamador, padrão).
OUT: O parâmetro é apenas de saída (retorna valor para o chamador).
INOUT: O parâmetro pode ser usado tanto para entrada quanto para saída.
DECLARE: Usado para declarar variáveis locais dentro da procedure.
Corpo da Procedure: Contém a lógica SQL, como comandos SELECT, INSERT, UPDATE, etc.

Exemplo Simples:
Uma procedure que insere um registro em uma tabela:

DELIMITER $$

CREATE PROCEDURE adicionar_usuario(nome VARCHAR(100), email VARCHAR(100))
BEGIN
    INSERT INTO usuarios (nome, email) VALUES (nome, email);
END$$

DELIMITER ;

Como usar:

CALL adicionar_usuario('João Silva', 'joao@email.com');
Exemplo com Parâmetro de Saída:
Uma procedure que retorna a quantidade de usuários em uma tabela:


DELIMITER $$

CREATE PROCEDURE contar_usuarios(OUT quantidade INT)
BEGIN
    SELECT COUNT(*) INTO quantidade FROM usuarios;
END$$

DELIMITER ;
Como usar:

CALL contar_usuarios(@total);
SELECT @total; -- Mostra o valor retornado pela procedure


Exemplo com Lógica Condicional:
Uma procedure que atualiza um registro somente se ele existir:

DELIMITER $$

CREATE PROCEDURE atualizar_email(id_usuario INT, novo_email VARCHAR(100))
BEGIN
    IF EXISTS (SELECT 1 FROM usuarios WHERE id = id_usuario) THEN
        UPDATE usuarios SET email = novo_email WHERE id = id_usuario;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuário não encontrado';
    END IF;
END$$

DELIMITER ;

Como usar:
CALL atualizar_email(1, 'novoemail@email.com');
Observações:
Permissões: É necessário ter permissões CREATE ROUTINE para criar procedures.
Retorno de Dados:
Procedures não têm retorno direto como funções. Para retornar dados, use OUT ou execute consultas dentro da procedure.
Debugging: Adicione logs com SELECT temporários para depuração em ambientes de desenvolvimento.
