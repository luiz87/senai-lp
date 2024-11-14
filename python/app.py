from flask import Flask, jsonify
from mysql.connector import Error

import mysql.connector
import requests

app = Flask(__name__)

@app.route('/api/jogos', methods=['GET'])
def get_jogos():
    data = []
    contador = 1
    while contador <= 38:
        print(contador)        
        url = f"https://api.globoesporte.globo.com/tabela/d1a37fa4-e948-43a6-ba53-ab24ab3a45b1/fase/fase-unica-campeonato-brasileiro-2024/rodada/{contador}/jogos"
        response = requests.get(url)
        data.append(response.json())
        contador += 1
        
    return jsonify(data)

@app.route('/api/time', methods=['GET'])
def get_time():
    data = []
    url = f"https://webws.365scores.com/web/squads/?appTypeId=5&langId=31&timezoneName=America/Sao_Paulo&userCountryId=21&competitors=1215"
    response = requests.get(url)
    data.append(response.json())
    ls = data[0]['squads'][0]['athletes']    
    return jogador(ls)

def jogador(ls):
    i = 0
    qt = len(ls)
    out = []
    while i < qt:
        nome = ls[i]['name']
        num = ls[i].get('jerseyNum', 'null') 
        dtNascimento = ls[i]['birthdate']
        posicao = ls[i]['formationPosition']['name']
        out.append(f"('{nome}',{num},'{dtNascimento[:10]}','{posicao}')")
        i += 1
    inserir(out)
    return out

def inserir(out):
    try:
        conexao = mysql.connector.connect(
            host='localhost',        # Endereço do servidor MySQL
            database='campeonatobrasileiro', # Nome do banco de dados
            user='root',       # Usuário do banco de dados
            password='senai@123'      # Senha do usuário
        )
        i = 0
        while i < len(out):
            if conexao.is_connected():   
                cursor = conexao.cursor()
                sql_insert = f"""
                    INSERT INTO jogador (nome, numero, dt_nascimento, posicao)
                    VALUES {out[i]}
                """            
                cursor.execute(sql_insert)
                i += 1            
            conexao.commit()
    except Error as e:
        print("Erro ao conectar ao MySQL", e)
    finally:
        if conexao.is_connected():
            cursor.close()
            conexao.close()


if __name__ == '__main__':
    app.run(port=5000)

# https://webws.365scores.com/web/game/?appTypeId=5&langId=31&timezoneName=America/Sao_Paulo&userCountryId=21&gameId=4058634&topBookmaker=161
# "events"
# "members"