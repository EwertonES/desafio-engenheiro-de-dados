
# Desafio Engenheiro de dados

## Parte 1 Modelagem.

Você recebeu o desafio de fazer a modelagem de um banco de dados relacional MySQL, para um aplicativo que é uma cópia do Instagram. Entregue os diagramas no formato PNG, e o código em SQL para a construção do banco. sugestão de app para a modelagem (https://app.dbdesigner.net/).

### Resolução:

![SQLagram EER diagram](https://github.com/EwertonES/desafio-engenheiro-de-dados/blob/main/sqlagram.png?raw=true)

*Diagrama criado com auxílio do MySQL Workbench 8.0 CE.*

[Script](https://github.com/EwertonES/desafio-engenheiro-de-dados/blob/main/sqlagram.sql) em SQL para a construção do banco.

## Parte 2 Desenvolvimento.

O arquivo Ceps.csv possui uma lista de CEPs que precisamos descobrir o nome das cidades, busque as cidades no arquivo Banco_ceps.xlsx,(o arquivo informa uma faixa de ceps, se o cep estiver entre a faixa considere que ele pertence a cidade), se o cep não for encontrado no excel use a api do VIACEP (https://viacep.com.br/) para encontrar o nome da cidade. Desenvolva um Script em Python3 que resolva o problema acima e salve o nome das cidades em outro arquivo csv. 

Suba em seu github pessoal a resolução do problema e a documentação dele, liste quais as bibliotecas usadas e explique como executar o script.

### Resolução:

[Script](https://github.com/EwertonES/desafio-engenheiro-de-dados/blob/main/get_city_from_zipcode.py) criado com Python 3.8.8. Foram utilizadas as seguintes bibliotecas:

 - pandas 1.2.3
 - requests 2.25.1

Para rodá-lo, basta digitar:

    python get_city_from_zipcode.py

Ele irá gerar um novo arquivo em CSV com o nome [cep_cidade.csv](https://github.com/EwertonES/desafio-engenheiro-de-dados/blob/main/cep_cidade.csv), contendo 2 colunas: CEP e a respectiva cidade. 
