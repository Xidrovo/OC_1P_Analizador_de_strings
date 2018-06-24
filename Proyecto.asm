.data
    message: .asciiz "Hello darkness my old friend" #Texto a leer
.text

main:
    li $t1,$zero		#Inicializamos nuestro contador que va a estar en $t1 con el valor de 0
    la $t0,message		#Guardamos el primer valor del texto en el registro

loop:
    lb   $a0,0($t0)		#Cargamos un byte del registro $t0 (Nuestro texto), lo que ser�a la primera letra
    beqz $a0, fin 		#Si encuentra que es un valor nulo, se salta a la funci�n de fin.
    addi $t0,$t0,1		#A�ade uno al registro de nuestro texto (ir al caracter siguiente)
    addi $t1,$t1,1		#A�ade uno a nuestro contador que va a ser guardado en $t1
    j     loop 			#Repite el loop
    
    
fin:					#Cuando ya se termine se ejecuta esta funcion
    li   $v0,1			#Instruccion para imprimir un Integer (nuestro contador)
    add  $a0, $0,$t1	#A�adir el valor de nuestro contador al registro que se va a imprimir
    syscall				#Ejecuta imprimir el valor del contador

    li   $v0,10			#Instrucci�n para terminar el programa
    syscall				#Ejecutar terminar programa.
