#!/bin/bash

# Lista de animais
animais=("Cachorro" "Gato" "Pássaro" "Peixe")

# Inicializar contadores de votos
declare -A votos

# Inicializar contadores para cada animal
for animal in "${animais[@]}"; do
    votos["$animal"]=0
done

# Função para exibir a lista de animais e contar votos
exibir_votacao() {
    clear
    echo "Escolha seu animal favorito:"
    echo "--------------------------"
    for (( i=0; i<${#animais[@]}; i++ )); do
        echo "$(($i+1)). ${animais[$i]}"
    done
}

# Função para registrar votos
registrar_voto() {
    read -p "Digite o número do seu animal favorito: " voto
    if [[ $voto =~ ^[0-9]+$ && $voto -ge 1 && $voto -le ${#animais[@]} ]]; then
        animal_votado=${animais[$(($voto-1))]}
        ((votos["$animal_votado"]++))
        clear
        echo "Seu voto para $animal_votado foi registrado!"
    else
        echo "Opção inválida. Por favor, digite o número do seu animal favorito."
    fi
}

# Função para exibir resultado da votação
exibir_resultado() {
    clear
    echo "--------------------------"
    echo "Resultado da votação:"
    echo "--------------------------"
    for animal in "${animais[@]}"; do
        echo "$animal: ${votos["$animal"]} votos"
    done
}

# Loop da votação
while true; do
    exibir_votacao
    registrar_voto
    read -p "Deseja continuar votando? (S/N): " continuar
    if [[ $continuar != "S" && $continuar != "s" ]]; then
        break
    fi
done

# Exibir resultado final
exibir_resultado