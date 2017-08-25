

#Função genérica para saída do programa.
sair () {
	echo "Deseja sair?"
	echo
	echo "1. Sair"
	echo "2. Voltar"
	read saida
	case $saida in
	 1) exit ;;
	 2) Principal ;;
	esac
}




pesquisarPalavra(){

	clear
	echo -n "Qual é o assunto da Notícia?"
	echo ""

	read palavra 

	echo
	echo
	echo
	echo
	echo
	echo "NOTÍCIA ENCONTRADA NOS SEGUINTES SITES: "
	echo
	temNoticia=0 
	for((j=1;j<=5;j++)); do
	
		nomeSite=$(sed "$j!d" sites.txt)
		cd html
		resultadoGrep=$(grep -i "$palavra" site$j.txt)
		if [ "$resultadoGrep" != "" ]; then
			
			echo "- $nomeSite"
			temNoticia=1
		
		fi
		cd ..

	done


	if [ "$temNoticia" = 0 ]; then

		echo "Nenhuma notícia desse assunto foi encontrada"

	fi


	echo
	echo "####################################################################"



	sair

}







baixarSites () {
	clear
	echo "Baixando..."

	rm html/*

	for((i=1;i<=5;i++)); do

	
		resultado=$(sed "$i!d" sites.txt)
		cd html
		lynx --dump $resultado > site$i.txt
		cd ..

	done

	pesquisarPalavra

}





#Função principal, responsável por ordenar as demais.
Principal () {
	clear
	echo "###########################################"
	echo "########### Encontrar Notícias ############"
	echo "###########################################"
	echo "Opções:"
	echo
	echo "1. Pesquisar Notícia Online"
	echo "2. Pesquisar Notícia Offline"
	echo "3. Sair"
	echo
	echo -n "Qual opção desejada?"
	echo ""
	read opcao
	#Case para detectar a intenção do usuário
	case $opcao in
	 1) baixarSites ;;
	 2) pesquisarPalavra ;;
	 3) sair ;;
	 *) echo "Opção desconhecida" ; echo ; Principal ;;
	esac
}


#Início do programa
Principal
