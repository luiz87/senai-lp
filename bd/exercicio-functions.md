## 01. function valor_aleatorio

Implemente uma função no MySQL chamada valor_aleatorio que receba dois parâmetros inteiros: min (valor mínimo) e max (valor máximo). 
A função deve retornar um número inteiro aleatório dentro do intervalo fechado definido pelos parâmetros fornecidos, ou seja, o valor retornado deve estar entre min e max (inclusive).

Requisitos:
- A função deve ser not determinística, pois cada execução pode gerar um valor diferente.
- Utilize a função interna RAND() do MySQL para gerar números aleatórios.
- Garanta que o número retornado seja arredondado para o inteiro mais próximo, sem casas decimais.
- Valide os cálculos de modo que o número gerado esteja adequadamente dentro do intervalo fornecido pelos parâmetros.

```sql
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
```
