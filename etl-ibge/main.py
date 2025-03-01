import requests # pip install requests
import mysql.connector # pip install mysql-connector-python
def banco(sql):
    conexao = mysql.connector.connect(
        host='localhost',
        database='dbibge',
        user='root',
        password='senai@123'
    )
    cursor = conexao.cursor()
    cursor.execute(sql)
    conexao.commit()
    cursor.close()
    conexao.close()

def insert_regiao():
    url = 'https://servicodados.ibge.gov.br/api/v1/localidades/regioes'
    response = requests.get(url)
    lista =  response.json()
    i = 0
    while i < len(lista):
        id = lista[i]['id']
        sigla = lista[i]['sigla']
        nome = lista[i]['nome']
        sql = f"INSERT INTO regiao VALUES({id},'{sigla}','{nome}');"
        print(sql)
        banco(sql)
        i = i + 1

def insert_estado():
    url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados'
    response = requests.get(url)
    lista =  response.json()
    i = 0
    while i < len(lista):
        id = lista[i]['id']
        sigla = lista[i]['sigla']
        nome = lista[i]['nome']
        id_regiao = lista[i]['regiao']['id']
        sql = f"INSERT INTO estado VALUES({id},'{sigla}','{nome}',{id_regiao});"
        print(sql)
        banco(sql)
        i = i + 1

def insert_municipio():
    url = 'https://servicodados.ibge.gov.br/api/v1/localidades/municipios'
    response = requests.get(url)
    lista =  response.json()
    i = 0
    while i < len(lista):
        id = lista[i]['id']
        nome = lista[i]['nome'].replace("'","''")
        id_estado = lista[i]['microrregiao']['mesorregiao']['UF']['id']
        sql = f"INSERT INTO municipio VALUES({id},'{nome}',{id_estado});"
        print(sql)
        banco(sql)
        i = i + 1

insert_regiao()
insert_estado()
insert_municipio()