	.data
menu1:	.asciiz	"\n 1- Cadastrar"
menu2:	.asciiz	"\n 2- Login \n"

prompt1:.asciiz "\n Informe o numero da conta: "
prompt2:.asciiz "\n Informe o CPF: "
prompt3:.asciiz "\n Informe o nome: "
prompt4:.asciiz "\n Informe a senha: "
prompt5:.asciiz "\n Informe o saldo: "

login1:	.asciiz "\n Senha: "

prompt6:.asciiz "\n 1- Deposito"
prompt7:.asciiz "\n 2- Retirada"
prompt8:.asciiz "\n 3- Transferencia "
prompt9:.asciiz "\n 4- Menu Principal "
prompt10: .asciiz "\n 0- Sair do Programa \n"

depost1:.asciiz "\n Informe o valor a ser depositado: R$"
retira1:.asciiz "\n Informe o valor a ser retirado: R$"
saldo: .asciiz "\n Seu Saldo é: R$"
saldo2: .asciiz "\n O Saldo da outra conta é: R$"
transf: .asciiz "\n Digite quanto deseja transferir: "
ncont: .asciiz "\n Digite o Número da conta na qual deseja realizar o depósito: \n"
erro: .asciiz "\n Erro, conta informada não existe. \n"

buffer: .space 20

	.text
	.globl main
main:	
	ori $t1, $0, 1		#coloca o valor 1 no reg
	ori $t2, $0, 2		#coloca o valor 2 no reg
	ori $t4, $0, 3		#coloca o valor 3 no reg. é usado só no login
	ori $t5, $0, 4		#coloca o valor 4 no reg. é usado só no login
	
	#PRINTANDO O MENU
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, menu1		#especifica que a string a ser printada é menu1
	syscall			#imprime a string
	
	li $v0, 4		#vai imprimir outra string
	la $a0, menu2		#dessa vez menu2
	syscall			#imprime a string
	
	#LEITURA DO MENU
	li $v0, 5		#vai ler um inteiro
	syscall			#chamado para fazer a leitura
	move $t3, $v0		#coloca o valor lido no reg
	
	#COMPARA E CHAMA
	beq $t1, $t3, cadastro	#se o usuario digita a opçao 1- cadastro
	nop
	beq $t2, $t3, login	#se o usuario digita a opçao 2- login
	nop
	
cadastro:
	move $s4,$s2
	move $s6,$t7
	andi $t7,$t7,0
	#NUMERO DA CONTA
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, prompt1		#especifica que a string é o prompt1
	syscall			#imprime a string na tela
	li $v0, 5		#especifica que vai ler um inteiro
	syscall
	move $s2,$v0			#chamado para fazer a leitura do inteiro
	#sw $t6, ($v0)
	
	#move $t0, $v0		#move o valor lido para o reg $t0
	#add $s0, [$v0]		#adiciona a $t0 o conteudo de memoria cujo ponteiro de endereço esta no reg $v0
	
	#CPF
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, prompt2		#especifica qua a string é o prompt2
	syscall			#imprime a string
	li $v0, 5		#especifica que vai ler um inteiro
	syscall			#chamado para leitura do inteiro
	move $s3,$v0
	#sw $t7, $($v0)
	
	#move $t1, $v0
	#add $s1, [$v0]
	
	#NOME
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, prompt3		#essa string é o prompt3
	syscall			#imprime a string
        li $v0, 8 
        la $a0, buffer 
        li $a1, 20 
        #move $t0,$a0
        syscall
	#sw $s0, ($v0)
	
	#move $t2, $v0
	#add $s2, [$v0]
	
	#SENHA
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, prompt4		#a string é prompt4
	syscall			#imprime a string
	li $v0, 5		#especifica que vai ler um inteiro
	syscall			#chamado para fazer a leitura
	move $s1,$v0
	#sw $s1, ($v0)
	
	#move $t3, $v0
	#add $s3, [$v0]
	
	#SALDO
	ori $t6, $t6,0
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, saldo		#a string é prompt5
	syscall			#imprime a string
	li $v0, 1
	or $a0,$t7,$zero
	andi $a0,$a0,0
	syscall
	#sw $s2, ($v0)
	
	#move $t4, $v0
	#add $s4, [$v0]
	j main
	nop

login:	
	#LOGIN
	li $v0, 4		#imprimir string
	la $a0, login1		#a string é login1
	syscall			#chamado para printar na tela
	li $v0, 5		#ler um inteiro
	syscall			#chamado para a leitura
	beq $v0, $s1, log	#se for igual pula para log
	nop
	bne $v0, $s1, main	#se for diferente pula para main
	nop
	
log:
	#PRINTANDO O MENU
	li $v0, 4		#imprimir a string
	la $a0, prompt6		#string prompt6
	syscall			#printa a string
	
	li $v0, 4		#imprimir string
	la $a0, prompt7		#string prompt7
	syscall			#printa a string
	
	li $v0, 4		#imprimir string
	la $a0, prompt8		#string prompt8
	syscall			#printa a string
	
	li $v0, 4		#imprimir string
	la $a0, prompt9		#string prompt9
	syscall			#printa a string

	li $v0, 4		#imprimir string
	la $a0, prompt10		#string prompt9
	syscall			#printa a string
			
	#LEITURA DO MENU
	li $v0, 5		#leitura de inteiro
	syscall			#chamado para a leitura
	move $t3, $v0		#move a opçao para o reg
	
	#COMPARANDO
	beq $t3, $t1, depositar	#se for igual pula para depositar
	nop
	beq $t3, $t2, retirar	#se for igual pula para retirar
	nop
	beq $t3, $t4, transferir#se for igual pula para transferir
	nop
	beq $t3, $t5, main	#se for igual pula para main
	nop
	beq $t3, $zero, fim	#se for igual pula para main
	nop
	
	
depositar:
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, saldo		#essa string é o saldo
	syscall			#imprime a string
	li $v0, 1
	add $a0,$t7,$zero
	syscall
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, depost1		#essa string é o saldo
	syscall			#imprime a string
	li $v0, 5
	syscall
	move $s0,$v0
	add $t7,$t7,$s0
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, saldo		#essa string é o saldo
	syscall			#imprime a string
	li $v0, 1
	or $a0,$t7,$zero
	syscall
	j log
	nop
	
retirar:
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, saldo		#essa string é o saldo
	syscall			#imprime a string
	li $v0, 1
	add $a0,$t7,$zero
	syscall
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, retira1		#essa string é o saldo
	syscall			#imprime a string
	li $v0, 5
	syscall
	move $s0,$v0
	sub $t7,$t7,$s0
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, saldo		#essa string é o saldo
	syscall			#imprime a string
	li $v0, 1
	or $a0,$t7,$zero
	syscall
	j log
	nop
	
transferir:
	
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, saldo		#essa string é o saldo
	syscall			#imprime a string
	li $v0, 1
	add $a0,$t7,$zero
	syscall
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, ncont		#essa string é o numero da conta na qual será realizado o depósito
	syscall			#imprime a string
	li $v0, 5
	syscall
	move $s5,$v0
	beq $s5,$s4,transferir2
	nop
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, erro		#essa string é para o usuário informar quanto deseja transferir
	syscall			#imprime a string
	j main
	nop

transferir2:
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, transf		#essa string é para o usuário informar quanto deseja transferir
	syscall			#imprime a string
	li $v0, 5
	syscall
	move $s0,$v0
	sub $t7,$t7,$s0
	add $s6,$s6,$s0
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, saldo		#essa string é para mostrar o saldo atual
	syscall			#imprime a string
	li $v0, 1
	or $a0,$t7,$zero
	syscall
	li $v0, 4		#especifica que vai imprimir uma string
	la $a0, saldo2		#essa string é para mostrar o saldo atual
	syscall			#imprime a string
	li $v0, 1
	or $a0,$s6,$zero
	syscall
	j log
	nop

fim:
	break