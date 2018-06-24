.data
    message: 	.asciiz	"Hello darkness my old friend" #Texto a leer
    
	mensaje:    .asciiz     "Ingrese la palabra ( ingrese '.' para terminar) > "
	dot:        .asciiz     "."
	eqmsg:      .asciiz     "Palabras son iguales!\n"
	nemsg:      .asciiz     "Palabras no son iguales!\n"

	str1:       .space      80
	str2:       .space      80
	
.text

main:
    li $t1,0			#Inicializamos nuestro contador que va a estar en $t1 con el valor de 0
    la $t0,message		#Guardamos el primer valor del texto en el registro

#	jal contadorLetras	#Llamo a la función

    la      $s2,str1 	#Seteamos la dirección de 80 bytes a s2
    move    $t2,$s2		#Movemos el registro de S2 a T2
    jal     getstr		#Llmamos a la función getStr

    la      $s3,str2	#Seteamos la dirección de 80 bytes a s3
    move    $t2,$s3		#Movemos el registro de S3 a T2
    jal     getstr		#Llamamos a la función getStr
    
    jal cmploop
	jal exit
	
contadorLetras:
    lb   $a0,0($t0)		#Cargamos un byte del registro $t0 (Nuestro texto), lo que sería la primera letra
    beqz $a0, fin 		#Si encuentra que es un valor nulo, se salta a la función de fin.
    addi $t0,$t0,1		#Añade uno al registro de nuestro texto (ir al caracter siguiente)
    addi $t1,$t1,1		#Añade uno a nuestro contador que va a ser guardado en $t1
    j    contadorLetras #Repite el loop
        
fin:					#Cuando ya se termine se ejecuta esta funcion
    li   $v0,1			#Instruccion para imprimir un Integer (nuestro contador)
    add  $a0, $0,$t1	#Añadir el valor de nuestro contador al registro que se va a imprimir
    syscall				#Ejecuta imprimir el valor del contador

getstr:
   	la      $a0,mensaje	#Imprimimos el mensaje al usuario
    li      $v0,4		# :)
    syscall				#se imprime ''

    move    $a0,$t2		# Movemos el registro a un argumento a0
    li      $a1,79		# :)
    li      $v0,8		# indica que el sistema leerá un string
    syscall

    # Esto podríamos usar para dar por terminado el programa. Cuandoe exista un menú
#    la      $a0,dot     #Obtenemos la dirección del '.'
#    lb      $a0,($a0)   #Obtenemos su valor
#    lb      $t2,($t2)   #Obtenemos el primer caracter del string
#    beq     $t2,$a0,exit#si es igual se termina el programa

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
	jal exit
	
cmpeq:						#Si los strings son iguales
    la      $a0,eqmsg
    li      $v0,4
    syscall
	jal exit
	
exit:
    li $v0, 10			#Esta función da por terminado el programa
	syscall				#Ejecuta terminar programa