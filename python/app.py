from flask import Flask, jsonify
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

if __name__ == '__main__':
    app.run(port=5000)