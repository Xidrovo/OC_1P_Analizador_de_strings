.data
	menu:		.asciiz "\n--------------\n\nAnalizador de strings\n\n>1. Comparar strings \n>2. Calcular tamaño (numero de caracteres) \n>3. Calcular numero de palabras \n>4. Fin \n-------------------------\nEscoja: "
    message: 	.asciiz	"Hello darkness my old friend" #Texto a leer
    
	mensaje:    .asciiz     "Ingrese la palabra ( ingrese '.' para terminar) > "
	dot:        .asciiz     "."
	eqmsg:      .asciiz     "Palabras son iguales!\n"
	nemsg:      .asciiz     "Palabras no son iguales!\n"

	str1:       .space      80
	str2:       .space      80
	
.text

main:

	li $v0, 4			#Imprimo por pantalla el mensaje del menú
	la $a0, menu		# :)
	syscall				# :3
	
	li $v0, 5			#Le indico al sistema que quiero usar el servicio de input de .word
	syscall				#Llamo al sistema
	move $t0, $v0		#Ingreso el valor del input y lo almaceno en t0
	
	beq $t0,1,compararStrings	#Opción 1
	beq $t0,2,contarLetras		#Opción 2
	beq $t0,3,contarPalabras	#Opción 3

	jal exit

compararStrings:
	la      $s2,str1 		#Seteamos la dirección de 80 bytes a s2
	move    $t2,$s2			#Movemos el registro de S2 a T2
	jal     getstr			#Llmamos a la función getStr

	la      $s3,str2		#Seteamos la dirección de 80 bytes a s3
	move    $t2,$s3			#Movemos el registro de S3 a T2
	jal     getstr			#Llamamos a la función getStr
	
	jal cmploop

contarLetras:
    addi $t5,$0,32 			#Guarda el caracter de espacio.
    li $t1,0				#Inicializamos nuestro contador que va a estar en $t1 con el valor de 0
    la $t2,message			#Guardamos el primer valor del texto en el registro
    jal contadorLetras
    
contarPalabras:
	addi $t5,$0,32 			#Guarda el caracter de espacio.
    li $t1,0				#Inicializamos nuestro contador que va a estar en $t1 con el valor de 0
    la $t2,message			#Guardamos el primer valor del texto en el registro
    jal contadorPalabras
    
contadorLetras:
    lb   $a0,0($t2)				#Cargamos un byte del registro $t0 (Nuestro texto), lo que sería la primera letra
    beqz $a0, letrasContadas 	#Si encuentra que es un valor nulo, se salta a la función de fin.
    addi $t2,$t2,1				#Añade uno al registro de nuestro texto (ir al caracter siguiente)
    addi $t1,$t1,1				#Añade uno a nuestro contador que va a ser guardado en $t1
    j    contadorLetras 		#Repite el loop

contadorPalabras:
    lb   $a0,0($t2)					#Cargamos un byte del registro $t0 (Nuestro texto), lo que sería la primera letra
    beqz $a0, palabrasContadas 		#Si encuentra que es un valor nulo, se salta a la función de fin.
    beq $a0, $t5, contarPalabra		# Si encuentra un espacio, cuenta la palabra
    addi $t2,$t2,1					#Añade uno al registro de nuestro texto (ir al caracter siguiente)
    j  contadorPalabras	 			#Repite el loop
        
contarPalabra:
    addi $t1,$t1,1		#Añade uno a nuestro contador que va a ser guardado en $t1
    addi $t2,$t2,1		#Añade uno al registro de nuestro texto (ir al caracter siguiente)
    j  contadorPalabras	#Repite el loop
                                                                         
letrasContadas:			#Cuando ya se termine se ejecuta esta funcion
    li   $v0,1			#Instruccion para imprimir un Integer (nuestro contador)
    add  $a0, $0,$t1	#Añadir el valor de nuestro contador al registro que se va a imprimir
    syscall				#Ejecuta imprimir el valor del contador
    jal main

palabrasContadas:			#Cuando ya se termine se ejecuta esta funcion
    li   $v0,1				#Instruccion para imprimir un Integer (nuestro contador)
    addi $t1, $t1, 1		#Añade uno al contador
    add  $a0, $0,$t1		#Añadir el valor de nuestro contador al registro que se va a imprimir
    syscall					#Ejecuta imprimir el valor del contador
	jal main
	
getstr:
   	la      $a0,mensaje	#Imprimimos el mensaje al usuario
    li      $v0,4		# :)
    syscall				#se imprime ''

    move    $a0,$t2		# Movemos el registro a un argumento a0
    li      $a1,79		# :)
    li      $v0,8		# indica que el sistema leerá un string
    syscall

    jr      $ra          # return

# funcionará como strcmp
cmploop:
    lb      $t2,($s2)		#obtenemos el siguiente char de str1
    lb      $t3,($s3)		# obtenemos el siguiente char de str2
    bne     $t2,$t3,cmpne   # Si son diferentes, llama al procedure cmpne (comparison not equal)

    beq     $t2,$zero,cmpeq # si son iguales, llama a cmpeq (Comparison equal)

    addi    $s2,$s2,1 		# apuntamos al siguiente caracter
    addi    $s3,$s3,1       # apuntamos al siguiente caracter
    j       cmploop

cmpne:						#Si los strings no son iguales
    la      $a0,nemsg
    li      $v0,4
    syscall
	jal main
	
cmpeq:						#Si los strings son iguales
    la      $a0,eqmsg
    li      $v0,4
    syscall
	jal main
	
exit:
    li $v0, 10			#Esta función da por terminado el programa
	syscall				#Ejecuta terminar programa
