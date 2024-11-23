from flask import Flask, jsonify
from mysql.connector import Error

import mysql.connector
import requests

app = Flask(__name__)

@app.route('/api/jogos', methods=['GET'])
def get_jogos():
    out = ""
    r = 1
    while r <= 38:
        print(r)        
        url = f"https://api.globoesporte.globo.com/tabela/d1a37fa4-e948-43a6-ba53-ab24ab3a45b1/fase/fase-unica-campeonato-brasileiro-2024/rodada/{r}/jogos"
        lsItem = requests.get(url).json()
        # data.append(response.json())
        i = 0
        while i < 10:
            dataJogo = lsItem[i]['data_realizacao']
            gol_mandante = lsItem[i]['placar_oficial_mandante']
            gol_visitante = lsItem[i]['placar_oficial_visitante']
            mandante = times[lsItem[i]['equipes']['mandante']['sigla']]
            visitante = times[lsItem[i]['equipes']['visitante']['sigla']]
            estadio = estadios[lsItem[i]['equipes']['mandante']['sigla']]
            out += f",({r},'{dataJogo}',{gol_mandante},{gol_visitante},{mandante},{visitante},{estadio})"
            i += 1
            out = out.replace("None", "null")
        r += 1
    sql = "INSERT INTO partida(rodada, horario, gol_mandante, gol_visitante, id_mandante, id_visitante, id_estadio) VALUES " + out[1:]    
    inserir(sql)
    return sql

times = { 'ACG': 1, 'CAP': 2, 'CAM': 3, 'BAH': 4, 'BOT': 5, 'COR': 6, 'CRI': 7, 'CRU': 8, 'CUI': 9, 'FLA': 10, 'FLU': 11, 'FOR': 12, 'JUV': 13, 'GRE': 14, 'INT': 15, 'PAL': 16, 'RBB': 17, 'VIT': 18, 'SAO': 19, 'VAS': 20 }
estadios = { 'ACG': 21, 'CAP': 11, 'CAM': 3, 'BAH': 7, 'BOT': 10, 'COR': 9, 'CRI': 22, 'CRU': 3, 'CUI': 12, 'FLA': 1, 'FLU': 1, 'FOR': 8, 'JUV': 23, 'GRE': 4, 'INT': 6, 'PAL': 5, 'RBB': 2, 'VIT': 24, 'SAO': 2, 'VAS': 17 }

@app.route('/api/time', methods=['GET'])
def get_time():
    lsTimes = [1211,1222,1778,1215,1219,1225,1213,1767,1267,1227,1228,1218,1210,1775,1216,1780,1273,9188,1209,5918]
    i = 0
    while i < 20:
        data = []
        url = f"https://webws.365scores.com/web/squads/?appTypeId=5&langId=31&timezoneName=America/Sao_Paulo&userCountryId=21&competitors={lsTimes[i]}"
        response = requests.get(url)
        data.append(response.json())
        ls = data[0]['squads'][0]['athletes']
        idTime = data[0]['competitors'][0]['symbolicName']
        idTime = times[idTime.replace("ATL","CAM").replace("AGO","ACG")]
        jogador(ls, idTime)
        print(lsTimes[i])
        i += 1
    return jogador(ls, idTime)

def jogador(ls, idTime):
    i = 0
    qt = len(ls)
    out = ""
    while i < qt:
        nome = ls[i]['name']
        num = ls[i].get('jerseyNum', 'null') 
        dtNascimento = ls[i]['birthdate']
        posicao = ls[i]['formationPosition']['name']
        out += f",('{nome}',{num},'{dtNascimento[:10]}','{posicao}',{idTime})<br>"
        i += 1
    
    sql = "INSERT INTO jogador(nome, numero, dt_nascimento, posicao, id_time) VALUES " + out[1:]
    inserir(sql.replace("<br>",""))
    return sql

def inserir(sql):
    resultado = ""
    try:
        conexao = mysql.connector.connect(
            host='localhost',        # Endereço do servidor MySQL
            database='campeonatobrasileiro', # Nome do banco de dados
            user='root',       # Usuário do banco de dados
            password='senai@123'      # Senha do usuário
        )
        if conexao.is_connected():   
            cursor = conexao.cursor()
            resultado = cursor.execute(sql)
        conexao.commit()
    except Error as e:
        print("Erro ao conectar ao MySQL", e)
    finally:
        if conexao.is_connected():
            cursor.close()
            conexao.close()
    return resultado


if __name__ == '__main__':
    app.run(port=5000)

# https://webws.365scores.com/web/game/?appTypeId=5&langId=31&timezoneName=America/Sao_Paulo&userCountryId=21&gameId=4058634&topBookmaker=161
# "events"
# "members"