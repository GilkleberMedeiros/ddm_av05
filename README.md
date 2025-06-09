# ddm_av05

Projeto em Flutter criado para a avaliação 04 da disciplina de Desenvolvimento para Dispositivos Móveis do curso de Sistemas Para Internet do IFRN. 

## Objetivo 
Aprender a utilizar requisições HTTP com Flutter e a utilização do flutter_map, incluindo: 
    - Requisições HTTP.
    - Consumo de APIs RestFul.
    - Uso de Mapas com o flutter_map.

## Tarefa
Construir um aplicativo que: 
    - Permita que o usuário digite um CEP.
    - Ao clicar em um botão, faça uma requisição HTTP para a API ViaCEP (https://viacep.com.br/) ou BrasilAPI (https://brasilapi.com.br/) e/ou use serviços complementares (geocoding foi usado) para obter o endereço/coordenadas do CEP informado.
    - Mostre a localização do CEP em um mapa utilizando flutter_map e um marcador (flutter_map.MarkerLayer).

## O que foi feito
Foi criado um aplicativo que permite que o usuário consulte a localização de um CEP. Utilizando a BrasilAPI e geocoding (quando a BrasilAPI não retorna as coordenadas) para a busca do endereço e flutter_map.FlutterMap e flutter_map.MarkerLayer para exibir o mapa com o marcador da localização do CEP consultado.

## Instalação 
Para instalar e rodar o projeto, você deve: 
    - ter o Flutter e o dart instalados na sua máquina. 
    - ter um emulador ou dispositivo conectado à sua IDE de escolha.

Se já tiver, clone este repo, vá para a pasta root e: 
    - rode `flutter pub get` para instalar as dependênmcias do projeto.
    - rode `flutter run` para rodar o projeto.   