## Sintaxe Triggers

No MySQL, triggers são gatilhos que executam automaticamente uma ação em resposta a eventos específicos 
(como INSERT, UPDATE, ou DELETE) em uma tabela. 
Elas são úteis para validar dados, registrar auditorias ou implementar regras de negócios diretamente no banco de dados.

Sintaxe para Criar uma Trigger
```sql
DELIMITER $$

CREATE TRIGGER nome_da_trigger
{ BEFORE | AFTER } { INSERT | UPDATE | DELETE }
ON nome_da_tabela
FOR EACH ROW
BEGIN
    -- Corpo da trigger
    -- Lógica SQL que será executada
END$$

DELIMITER ;
```
Explicação dos Elementos:
- CREATE TRIGGER: Inicia a criação da trigger.
- BEFORE ou AFTER:
- BEFORE: A ação ocorre antes do evento especificado.
- AFTER: A ação ocorre após o evento especificado.
- Eventos:
- INSERT: Quando um registro é inserido.
- UPDATE: Quando um registro é atualizado.
- DELETE: Quando um registro é excluído.
- ON nome_da_tabela: Especifica a tabela associada à trigger.
- FOR EACH ROW: Define que a trigger será executada para cada linha afetada.
- Corpo da Trigger: Contém a lógica SQL que será executada.

Exemplo de Trigger BEFORE INSERT
Este exemplo verifica e define um valor padrão antes de inserir dados:
```sql
DELIMITER $$

CREATE TRIGGER antes_de_inserir_usuario
BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        SET NEW.nome = 'Nome Padrão';
    END IF;
END$$

DELIMITER ;
```
Como funciona:
- NEW: Representa os valores sendo inseridos na tabela.
- Se o campo nome estiver vazio ou nulo, a trigger define um valor padrão (Nome Padrão).
- Exemplo de Trigger AFTER UPDATE
- Este exemplo registra alterações em uma tabela de auditoria:

```sql
DELIMITER $$

CREATE TRIGGER apos_atualizar_usuario
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_usuarios (id_usuario, nome_antigo, nome_novo, data_alteracao)
    VALUES (OLD.id, OLD.nome, NEW.nome, NOW());
END$$

DELIMITER ;
```
Como funciona:
- OLD: Representa os valores antes da alteração.
- NEW: Representa os valores após a alteração.
- A trigger insere informações na tabela de auditoria sempre que o nome do usuário for atualizado.
- Exemplo de Trigger BEFORE DELETE
- Este exemplo impede a exclusão de registros específicos:

```sql
DELIMITER $$

CREATE TRIGGER antes_de_excluir_usuario
BEFORE DELETE ON usuarios
FOR EACH ROW
BEGIN
    IF OLD.id = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido excluir o usuário administrador';
    END IF;
END$$

DELIMITER ;
```
Como funciona:
- Antes de excluir, verifica se o id é igual a 1.
- Se for, uma mensagem de erro é lançada usando o comando SIGNAL.
Observações:
> Triggers Não Retornam Valores: Diferentemente de funções ou procedures, triggers não têm retorno.
> Performance: Use triggers com cuidado em tabelas de alta carga, pois podem impactar o desempenho.
> Debugging: Adicione temporariamente comandos como INSERT em uma tabela de log para depurar o comportamento da trigger.
