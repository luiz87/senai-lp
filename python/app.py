from flask import Flask, jsonify
from mysql.connector import Error

import mysql.connector
import requests

app = Flask(__name__)

@app.route('/api/teste', methods=['GET'])
def get_carregar(): # 4057955, 4057957, 4057958, 4057959, 4058639, 4059029, 4057961,
    ls = [4057856,4057949,4057950,4057951,4057952,4057954,4058637,4057947,4057953,4058636,4057948,4057845,4057941,4057942,4058634,4057945,4057946,4058633,4058635,4057944,4057939,4057943,4057933,4057940,4057934,4057935,4058630,4057937,4057938,4058631,4058632,4057936,4057826,4057932,4057928,4057926,4057929,4058627,4058628,4057931,4057927,4057930,4058629,4057840,4057829,4058626,4057919,4058624,4057925,4058625,4057920,4057921,4057923,4057922,4057924,4241289,4057916,4057917,4058620,4057913,4057915,4057918,4058622,4057912,4058623,4057914,4058621,4057908,4057910,4057911,4057905,4058617,4058619,4057906,4057909,4057907,4057824,4058558,4057898,4057901,4057897,4057902,4057904,4058618,4057900,4058616,4057899,4057903,4057891,4057895,4058614,4058615,4057890,4057892,4057893,4058613,4057896,4057894,4057839,4059026,4057883,4057884,4057886,4057885,4057888,4057889,4058611,4058612,4059027,4057887,4057740,4058597,4057880,4057878,4057882,4058610,4058608,4057876,4057879,4058609,4057881,4057877,4058605,4057873,4057875,4058607,4057872,4058606,4057869,4057870,4057874,4057871,4058559,4058604,4057864,4057867,4058602,4057862,4058603,4057868,4057863,4057865,4057866,4057857,4057860,4058600,4057855,4059028,4057858,4057861,4058601,4057859,4057852,4057850,4057847,4057848,4057854,4058598,4058599,4057849,4057851,4057853,4057844,4057617,4058596,4057843,4058595,4057841,4057846,4058592,4057833,4057834,4057837,4057842,4058594,4057838,4058593,4057835,4057836,4057832,4057831,4057830,4058590,4058591,4058589,4057827,4057828,4057822,4057821,4058588,4057820,4058587,4057819,4057823,4057825,4057812,4057817,4058586,4057811,4057815,4057818,4058585,4057814,4057813,4057816,4057804,4058581,4057806,4058583,4057810,4057808,4058584,4057805,4057807,4057809,4057801,4057798,4057797,4057802,4058580,4057799,4058579,4058582,4057800,4057803,4058576,4058577,4057791,4057793,4057794,4057796,4058578,4057790,4057792,4057795,4057785,4057786,4057788,4057784,4058573,4058574,4058575,4057783,4057789,4057787,4058570,4057778,4057780,4057779,4058571,4057781,4057782,4058572,4057775,4057777,4057770,4057773,4057774,4058568,4057769,4057772,4057776,4058569,4058567,4057771,4057762,4057761,4057764,4058565,4057763,4057765,4057768,4058566,4057766,4057767,4059025,4058560,4057606,4057755,4057756,4058564,4057758,4057759,4057754,4058563,4057760,4058562,4057757,4057751,4057750,4057752,4057753,4057748,4058561,4057749,4057747,4057744,4058554,4057742,4057746,4057741,4057745,4057743,4057737,4057733,4057736,4058556,4057738,4058557,4057735,4058555,4057739,4057734,4057610,4057613,4057615,4057612,4057616,4057611,4057608,4057614,4057609,4057602,4057598,4057604,4057599,4057603,4057605,4057607,4057601,4057600,4057579,4057589,4057590,4057591,4057576,4057577,4057575,4057592,4057578,4057596]
    i = 0
    while i < len(ls):
        get_evetos_partida(ls[i])  
        i += 1
    return ""

def get_id(sql):
    resultado = inserir(sql)
    id = ""
    for linha in resultado:
        id = linha[0]
    return id

def get_evetos_partida(id):
    try:
        sql = "" 
        url = f"https://webws.365scores.com/web/game/?appTypeId=5&langId=31&timezoneName=America/Sao_Paulo&userCountryId=21&gameId={id}"
        obj = requests.get(url).json() 
        # awayCompetitor
        id_mandante = times365[str(obj['game']['homeCompetitor']['id'])]
        id_visitante = times365[str(obj['game']['awayCompetitor']['id'])]
        id_partida = f"(SELECT id_partida FROM partida WHERE id_mandante = {id_mandante} AND id_visitante = {id_visitante})"
        id_partida = get_id(id_partida)
        eventos = obj['game']['events']
        members = obj['game']['members']
        i = 0
        while i < len(eventos):
            minuto = eventos[i]['gameTime']
            descricao = eventos[i]['eventType']['name']
            if eventos[i]['eventType'].get('subTypeName') != None:
                descricao = descricao + f" ({eventos[i]['eventType']['subTypeName']})"
            playerId = eventos[i]['playerId']        
            resultado = next((member for member in members if member["id"] == playerId), None)
            jogador_nome = resultado['name']
            jogador_time = times365[str(resultado['competitorId'])]
            jogador_num = resultado.get('jerseyNum', 'null') 
            id_jogador = f"(SELECT max(id_jogador) FROM jogador WHERE nome = '{jogador_nome}' AND id_time = {jogador_time})"
            id_jogador = get_id(id_jogador)
            if id_jogador == None :
                id_jogador = inserir(f"INSERT INTO jogador(nome, numero, id_time) VALUES ('{jogador_nome}',{jogador_num},{jogador_time})")
            sql += f",({minuto},'{descricao}',{id_partida},{id_jogador})"
            i += 1
        sql = "INSERT INTO evento(minuto, descricao, id_partida, id_jogador) VALUES " + sql[1:]
        inserir(sql)
    except Error as e:
        print(id)

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
            # id_partida = f"(SELECT id_partida FROM partida WHERE id_mandante = {mandante} AND id_visitante = {visitante})"
            # id_partida = get_id(id_partida) 
            # out += f"UPDATE parida SET gol_mandante = {gol_mandante}, gol_visitante = {gol_visitante} WHERE id_partida = {id_partida};"
            i += 1
            out = out.replace("None", "null")
        r += 1
    sql = "INSERT INTO partida(rodada, horario, gol_mandante, gol_visitante, id_mandante, id_visitante, id_estadio) VALUES " + out[1:]    
    inserir(sql)
    return sql

times = { 'ACG': 1, 'CAP': 2, 'CAM': 3, 'BAH': 4, 'BOT': 5, 'COR': 6, 'CRI': 7, 'CRU': 8, 'CUI': 9, 'FLA': 10, 'FLU': 11, 'FOR': 12, 'JUV': 13, 'GRE': 14, 'INT': 15, 'PAL': 16, 'RBB': 17, 'VIT': 18, 'SAO': 19, 'VAS': 20 }
estadios = { 'ACG': 21, 'CAP': 11, 'CAM': 3, 'BAH': 7, 'BOT': 10, 'COR': 9, 'CRI': 22, 'CRU': 3, 'CUI': 12, 'FLA': 1, 'FLU': 1, 'FOR': 8, 'JUV': 23, 'GRE': 4, 'INT': 6, 'PAL': 5, 'RBB': 2, 'VIT': 24, 'SAO': 2, 'VAS': 17 }
times365 = { "1209":3,"1210":2,"1211":5,"1213":8,"1215":10,"1216":11,"1218":14,"1219":15,"1222":16,"1225":19,"1227":20,"1228":18,"1267":6,"1273":17,"1767":4,"1775":13,"1778":12,"1780":7,"5918":1,"9188":9}
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
        #times365[lsTimes[i]] = idTime
        i += 1
    return times365

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
            cursor.execute(sql)
            if sql[0:6] == "INSERT":
                resultado = cursor.lastrowid
            else:
                resultado = cursor.fetchall()
        conexao.commit()
    except Error as e:
        print("Erro ao conectar ao MySQL", e)
        print(sql)
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