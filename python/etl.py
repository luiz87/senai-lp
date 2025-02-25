import requests
from mysql.connector import Error

import mysql.connector
url = 'https://api.anota.ai/clientauth/nm-category/menu-merchant?displaySources=DIGITAL_MENU'
headers = {
    'Authorization': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZHBhZ2UiOiI2NGY4ZTUwZGRlYTRkNDAwMTI2OTlmMzMiLCJpYXQiOjE3NDAxODIyNDV9.I2lnunYQlYmtE6I4pQL2-eYoTlqKUiqb5VdoNewSKY0'
}
response = requests.get(url, headers=headers)

def banco(sql):
    resultado = ""
    try:
        conexao = mysql.connector.connect(
            host='localhost',        # Endereço do servidor MySQL
            database='pizzaria', # Nome do banco de dados
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

if response.status_code == 200:
    print("Resposta recebida com sucesso!")
    # print(response.json())  # Exibe a resposta no formato JSON
    obj = response.json()
    # print(obj['data']['menu']['menu'][1]['itens'][0]['title'])
    ls = obj['data']['menu']['menu'][1]['itens']
    i = 0
    while i < len(ls):
        titulo = ls[i]['title']
        descricao = ls[i]['description']
        sql = f"INSERT INTO pizza(sabor, ingredientes) VALUES ('{titulo}', '{descricao}');"
        i += 1
        banco(sql)
else:
    print(f"Erro {response.status_code}: {response.text}")