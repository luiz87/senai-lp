# **Aula: Controle de Acessos e Transações no MySQL**  

## **Objetivo da Aula**  
- Compreender o controle de acessos com **GRANT** e **REVOKE**.  
- Aprender a gerenciar transações com **COMMIT**, **ROLLBACK** e **SAVEPOINT**.  
- Aplicar os conceitos na prática com exemplos.  

---

# **Parte 1: Controle de Acesso com GRANT e REVOKE**  

## **1. Introdução ao Controle de Acessos no MySQL**  
O MySQL permite definir **quem** pode acessar o banco e **o que** pode fazer. Os comandos principais são:  
- **GRANT**: Concede permissões.  
- **REVOKE**: Revoga permissões.  

Os privilégios podem ser concedidos por:  
✔️ Usuário  
✔️ Banco de Dados  
✔️ Tabela  
✔️ Coluna  
✔️ Procedimentos  

---

## **2. Criando Usuários no MySQL**  

```sql
CREATE USER 'joao'@'localhost' IDENTIFIED BY 'senha123';
```

---

## **3. Comando GRANT - Concedendo Permissões**  

**Conceder todos os privilégios em um banco:**  
```sql
GRANT ALL PRIVILEGES ON meu_banco.* TO 'joao'@'localhost';
```

**Permissões específicas em tabelas:**  
```sql
GRANT SELECT, INSERT ON meu_banco.clientes TO 'joao'@'localhost';
```

**Aplicar mudanças imediatamente:**  
```sql
FLUSH PRIVILEGES;
```

---

## **4. Comando REVOKE - Removendo Permissões**  

**Revogar um privilégio específico:**  
```sql
REVOKE INSERT ON meu_banco.* FROM 'joao'@'localhost';
```

**Remover todas as permissões:**  
```sql
REVOKE ALL PRIVILEGES ON meu_banco.* FROM 'joao'@'localhost';
```

**Excluir um usuário do sistema:**  
```sql
DROP USER 'joao'@'localhost';
```

---

## **5. Consultando Permissões**  

**Verificar permissões de um usuário:**  
```sql
SHOW GRANTS FOR 'joao'@'localhost';
```

---

# **Parte 2: Controle de Transações - COMMIT e ROLLBACK**  

## **6. Introdução às Transações no MySQL**  
Uma **transação** é um conjunto de operações SQL que podem ser confirmadas (**COMMIT**) ou desfeitas (**ROLLBACK**).  

As transações seguem o princípio **ACID**:  
✅ **Atomicidade**: Todas as operações ocorrem ou nenhuma ocorre.  
✅ **Consistência**: O banco fica em estado válido antes e depois.  
✅ **Isolamento**: Transações não interferem entre si.  
✅ **Durabilidade**: Alterações confirmadas são salvas permanentemente.  

> 📌 Importante: O MySQL só suporta transações em tabelas **InnoDB** (não em MyISAM).

---

## **7. Comando COMMIT - Confirmando Alterações**  

```sql
SET AUTOCOMMIT = 0; -- Desativa o autocommit
START TRANSACTION;   -- Inicia a transação

INSERT INTO clientes (nome, email) VALUES ('Carlos', 'carlos@email.com');
UPDATE clientes SET email = 'novo@email.com' WHERE nome = 'Carlos';

COMMIT; -- Confirma as alterações
```

---

## **8. Comando ROLLBACK - Desfazendo Alterações**  

```sql
START TRANSACTION;

INSERT INTO clientes (nome, email) VALUES ('Ana', 'ana@email.com');
DELETE FROM clientes WHERE nome = 'Carlos';

ROLLBACK; -- Desfaz todas as mudanças feitas na transação
```

---

## **9. SAVEPOINT - Criando Pontos de Controle**  

```sql
START TRANSACTION;

INSERT INTO clientes (nome, email) VALUES ('Pedro', 'pedro@email.com');
SAVEPOINT sp1; -- Criamos um ponto de salvamento

INSERT INTO clientes (nome, email) VALUES ('Laura', 'laura@email.com');

ROLLBACK TO sp1; -- Apenas 'Laura' será desfeita, 'Pedro' permanece

COMMIT; -- Confirma a transação
```

---

## **10. Exercícios Práticos**  
1️⃣ Crie um usuário chamado **luiz-maia** e conceda a ele permissões apenas de insert, update e select no banco **pizzaria** senha **senai@123**.  
2️⃣ Informe o ip do seu computador para o instrutor.  
3️⃣ Monitore as operações realizadas na tabela de auditoria **au_pizza**.  
4️⃣ Construa uma trigger para identificar os updates na tabela pizza e grave as antigas informações na tabela au_pizza.  

---

## **11. Conclusão**  
- **GRANT e REVOKE** controlam permissões no MySQL.  
- **COMMIT** confirma alterações no banco.  
- **ROLLBACK** desfaz operações antes de um commit.  
- **SAVEPOINT** permite reverter partes específicas de uma transação.  

