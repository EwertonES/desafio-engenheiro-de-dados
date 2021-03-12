from bisect import bisect_left, bisect_right
import pandas as pd
import requests

def get_city(ceps, a_cep):
    """ Retorna cidade dado um CEP e o banco de dados """

    # Retorna índice mais à esquerda para inserir valor numa lista ordenada
    l_idx = bisect_left(ceps['CEP'].values, a_cep)
    # Retorna índice mais à direita para inserir valor numa lista ordenada
    r_idx = bisect_right(ceps['CEP'].values, a_cep)
    # Se forem iguais, valor não está exatamente na lista
    # Se forem diferentes, valor está exatamente na lista
    if l_idx != r_idx:
        return ceps.at[l_idx, 'Localidade']
    # Confere se uma linha atrás era o início do intervalo da cidade
    if ceps.at[l_idx - 1, 'Localidade'] == ceps.at[l_idx, 'Localidade']:
        return ceps.at[l_idx, 'Localidade']

    # Se não está na lista, nem em intervalos, olhar na API do viacep
    return requests.get(f'https://viacep.com.br/ws/{a_cep}/json/').json().get('localidade', '')

if __name__ == "__main__":
    # Lê banco de dados com CEPs.
    db_ceps = pd.read_excel('Banco_ceps.xlsx')
    # Transforma as colunas de CEP em uma, com a respectiva cidade em cada linha.
    cep_city = pd.concat([
         db_ceps[['CEP Inicial', 'Localidade']].rename(columns={"CEP Inicial": "CEP"}),
         db_ceps[['CEP Final'  , 'Localidade']].rename(columns={"CEP Final"  : "CEP"}),
         ]).drop_duplicates().sort_values(by=['CEP'], ignore_index=True)
    # Lê lista de novos CEPs.
    new_ceps = pd.read_csv('ceps.csv')
    # Cria nova coluna com CEPs sem pontos e traços.
    new_ceps['cep'] = new_ceps['zipcode'].replace(r'\D', '', regex=True)
    # Cria coluna que armazena as cidades.
    new_ceps['cidade'] = [get_city(cep_city, int(cep)) for cep in new_ceps['cep']]
    # Exporta resultados para um arquivo em .csv
    new_ceps[['cep', 'cidade']].to_csv('cep_cidade.csv', index=False)

# Performance:
# 4.3s para ler o banco na linha 25
# 3.5s para conferir 100 ceps na linha 36
