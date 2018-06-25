.data
	mensaje:    .asciiz     "Ingrese la palabra ( ingrese '.' para terminar) > "
	enter:		.asciiz		"\n"
	str1:       .space      80
	str2:       .space      80
	Cmayor:		.word		65	#Es el ascii de caracteres de menor peso (A)
	Cmenor:		.word		122	#Es el ascii de caracter de mayor peso (z)
	
.text
 main:
 	lw $t4, Cmayor($zero)	#Agregamos una variable t4 con valor Cmayor	
	jal obtenerMayorCaracter	#Llamo a la función de caracteres mayores
	
    li $v0, 10				#Esta función da por terminado el programa
	syscall					#Ejecuta terminar programa
 
 obtenerMayorCaracter:
 	la      $s4,str1 		#Seteamos la dirección de 80 bytes a s2
	move    $t2,$s4			#Movemos el registro de S4 a T2
	jal     getstr			#Llmamos a la función getStr
 	jal caracterMayor
 getstr:
   	la      $a0,mensaje	#Imprimimos el mensaje al usuario
    li      $v0,4		# :)
    syscall				#se imprime ''

    move    $a0,$t2		# Movemos el registro a un argumento a0
    li      $a1,79		# :)
    li      $v0,8		# indica que el sistema leerá un string
    syscall

    jr      $ra          # return
caracterMayor:
    lb      $t2,($s4)						#obtenemos el siguiente char de str1
    beq     $t2,$zero,finDeBusqueda 	
    addi	$a0, $t2, 0						#cast t2 a int en a0
    addi    $s4,$s4,1 						#Apuntamos al siguiente caracter
	blt 	$t4, $a0, guardarMayorValor		#if t4 < a0, then llama a guardarMayorValor
    j 		caracterMayor
guardarMayorValor:
	addi $t4, $a0, 0					#Cambiamos el valor de t4 por el de t0
	j   caracterMayor          			#Return
finDeBusqueda:
	li $v0, 1							#Realizaremos un cast del caracter a int
	addi $a0, $t4, 0					#Esta función realiza el cast. a0 tiene el entero de cada caracter de t2
	syscall								#Imprimimos
	
	li $v0, 10				#Esta función da por terminado el programa
	syscall					#Ejecuta terminar programa