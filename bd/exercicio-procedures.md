## Exemplo Procedure com While

```sql
DELIMITER $$
CREATE PROCEDURE exemplo_while()
BEGIN
    DECLARE contador INT DEFAULT 1;  
    WHILE contador <= 5 DO
        SELECT CONCAT('Contador: ', contador);
        SET contador = contador + 1;
    END WHILE;
END$$
DELIMITER ;
call exemplo_while();
```
## 01. procedure gerar_resultado_aleatorio
Crie uma Stored Procedure chamada gerar_resultado_aleatorio que preencha aleatoriamente os campos de gols em uma tabela chamada partida. A procedure deve:

- Iterar por todos os registros da tabela partida, utilizando um contador para identificar o campo id_partida.
- Gerar valores aleatórios para os campos:
  - gol_mandante: Um número inteiro aleatório entre 0 e 6.
  - gol_visitante: Um número inteiro aleatório entre 0 e 6.
- Atualizar os valores gerados para cada registro identificado pelo id_partida.
- Parar a execução ao atingir o último registro (ou quando o contador chegar a 380, que representa o número total de partidas no contexto fornecido).

```sql
call gerar_resultado_aleatorio();
select * from classificacao;
```
