-- 01. Atualize na tabela evento as descrições 
-- DE "Substitution" PARA "Substituição"
-- DE "Woodwork" PARA "Bola na Trave"
-- DE "Cartão Vermelho (Second Yellow Card)" PARA "Cartão Vermelho (Segundo Cartão Amarelo)"

-- 02. Atualize o resultado das partidas do brasileirão 
-- que já aconteceram e ainda não foi gravado o resultado.

-- 03. Elabore um relatório por minuto e a quantidade de gols (não contar "Gol anulado (Var)")
-- e ordene pela quantidade do maior para o menor

-- 04. Elabore um relatório por idade e quantidade de jogadores
-- remover data nula e posições "Auxiliar técnico" e "Técnico"
-- ordene pela idade do mais velho ao mais novo

-- 05. Elabore um relatório por jogador e quantidade de cartões, 
-- detalhar também a quantidade de Cartões Vermelho e Amarelo
-- ordene pela quantidade total de Cartões'
/* exemplo:
numero 	nome 			qt_amarelo 	qt_vermelho qt_total
16		Jadson			15			1			16
19		Emanuel Brítez	12			2			14
3		Zé Marcos		12			2			14
10		Luciano			12			1			13
.
.
*/
-- 06. Deseja-se saber qual a quantidade de jogos que aconteceram por dia
/* exemplo:
dia		quantidade
sábado	98
domingo	121
terça	11
quarta	64
quinta	29
segunda	11
sexta	8
*/

-- 07. Desejase saber a quantidade total de cada evento 
-- e quantos aconteceram ate os 45min e depois dos 45min
/*exemplo:
descricao									total	ate_45		depois_45
Gol (Gol de campo)							734		327			407
Cartão Amarelo								1806	658			1148
Substituição								3256	112			3144
Bola na Trave								217		93			124
Pênalti Perdido								23		12			11
Cartão Vermelho								80		25			55
Gol anulado (Var)							39		17			22
Cartão Vermelho (Segundo Cartão Amarelo)	44		7			37
Gol (Pênalti)								71		37			34
Gol (Gol Contra)							14		5			9
*/

-- 08. Deseja-se saber a quantidade dos eventos:
-- "Bola na Trave", "Pênalti Perdido" , "Gol anulado (Var)" pelos clubes
/*exemplo:
sigla 	Bola na Trave 	Pênalti Perdido Gol anulado (Var)
ACG		4				2				2
CAP		12				1				1
CAM		16				1				3
BAH		12				0				1
BOT		10				2				1
.
.
*/

