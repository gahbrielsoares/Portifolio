#!/usr/bin/env bash

#Cores==============================
pto="\e[30;1m"
verm="\e[31;1m"
verd="\e[32;1m"
ama="\e[33;1m"
az="\e[34;1m"
mag="\e[35;1m"
cia="\e[36;1m"
bra="\e[37;1m"
fim="\e[m"
#===================================

# Verificar se não é root ==========
if [[ $USER == "root" ]]
then
 echo -e "${verm}Saia do modo ROOT${fim}"
 exit 1
fi
#===================================

# Funções ===========================
function menu(){
echo -e "${verd}-------------------------------$fim"
echo "1) Adição"
echo "2) Subtração"
echo "3) Divisão"
echo "4) Multiplicação"
echo "5) Sair"
echo -e "${verd}-------------------------------$fim"

read -p "Escolha uma opção: " opcao
case $opcao in
"1") adicao ;;
"2") subt ;;
"3") divisao ;;
"4") multi ;;
"5") exit 0 ;;
*) echo "Opção invalida, escolha uma operação..." 
   menu
    ;;
esac
}
#================================================================
function adicao() {
	read -p "Valor A: " valA
	read -p "Valor B: " valB
	if [[ -z $valA ]] || [[ -z $valB ]] #Verificando campos vazio
	then
	echo -e "${verm}Campo vazio entre com um valor!!${fim}" 
	adicao
  fi
	sleep 1s
	total="$(( valA + valB ))" #Resultado
	echo -e "${verd}O resultado é: $total ${fim}" #Exibindo resultado
	sleep 5s
	clear
	menu

}
#===================================================================
function subt(){
	read -p "Valor A: " valA
	read -p "Valor B: " valB
	if [[ -z $valA ]] || [[ -z $valB ]]
	then
	echo -e "${verm}Campo vazio entre com um valor!!${fim}" 
	subt
	fi
	sleep 1s
	total="$(( $valA - $valB ))"
	echo -e "${verd}O resultado é: $total ${fim}" #Exibindo resultado
	sleep 5s
	clear
	menu
}
#=====================================================================

function divisao(){
	read -p "Valor A: " valA
	read -p "Valor B: " valB
	if [[ -z $valA ]] || [[ -z $valB ]]
	then
	echo -e "${verm}Campo vazio entre com um valor!!${fim}" 
	divisao
	fi
	sleep 1s
	total="$(( $valA / $valB ))"
	echo -e "${verd}O resultado é: $total ${fim}" #Exibindo resultado
	sleep 5s
	clear
	menu
}

#=====================================================================

function multi(){
	read -p "Valor A: " valA
	read -p "Valor B: " valB
	if [[ -z $valA ]] || [[ -z $valB ]]
	then
	echo -e "${verm}Campo vazio entre com um valor!!${fim}" 
	multi
	fi
	sleep 1s
	total="$(( $valA * $valB ))"
	echo -e "${verd}O resultado é: $total ${fim}" #Exibindo resultado
	sleep 5s
	clear
	menu
}

# Fecha funções =======================
menu #Iniciando calculadora


