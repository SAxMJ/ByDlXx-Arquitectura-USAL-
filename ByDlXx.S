

	.data
;Espacio de ddatos

; VARIABLES DE ENTRADA: NO MODIFICAR ORDEN (Se puedenmodificar los valores)
a1: 	.float 1.1
a2: 	.float 2.2  
a3: 	.float 3.3
a4: 	.float 4.4

;;;;; VARIABLES DE SALIDA: NO MODIFICAR ORDEN; m11, m12, m13, m14; m21, m22, m23, m24; m31, m32, m33, m34; m41, m42, m43, m44

M:  
.float 0.0, 0.0, 0.0, 0.0
.float 0.0, 0.0, 0.0, 0.0
.float 0.0, 0.0, 0.0, 0.0
.float 0.0, 0.0, 0.0, 0.0


; hm1, hm2, hm3, hm4
HM: 
.float 0.0, 0.0, 0.0, 0.0


; vm1, vm2, vm3, vm4
VM: 
.float 0.0, 0.0, 0.0, 0.0

check: 
.float 0.0

mf1:
.float 0.0, 0.0
.float 0.0, 0.0

mf2:
.float 0.0, 0.0
.float 0.0, 0.0

mf3:
.float 0.0, 0.0
.float 0.0, 0.0


kronecker:
.float 0.0,0.0,0.0,0.0
.float 0.0,0.0,0.0,0.0
.float 0.0,0.0,0.0,0.0
.float 0.0,0.0,0.0,0.0

cero:
.float	0.0

;;;;; FIN NO MODIFICAR ORDEN




.text
;Espacio de codigo
		.global main


main:

	;INICIALIZAMOS MF1
	addi	r1,r0,0	;Inicializamos iterador
	
	lf 		f2,a1
	lf 		f3,a2

	sf		mf1(r1),f2
	lf		f0,cero
	eqf		f0,f3
	bfpt	finish
	divf	f4,f2,f3
	sf		mf1+4(r1),f4

	sf		mf1+8(r1),f3

	multf	f5,f2,f3
	sf		mf1+12(r1),f5

	;INICIALIZAMOS MF2
	addi	r1,r0,0	;Inicializamos iterador
	
	lf 		f2,a3
	lf 		f3,a4

	sf		mf2(r1),f2

	eqf		f0,f3
	bfpt	finish
	divf	f4,f2,f3
	sf		mf2+4(r1),f4

	sf		mf2+8(r1),f3

	multf	f5,f2,f3
	sf		mf2+12(r1),f5


	;INICIALIZAMOS MF3
	addi	r1,r0,0	;Inicializamos iterador
	
	lf 		f2,a2
	lf 		f3,a3

	sf		mf3(r1),f2

	lf		f0,cero
	eqf		f0,f4
	bfpt	finish

	divf	f4,f2,f3
	sf		mf3+4(r1),f4

	sf		mf3+8(r1),f3

	multf	f5,f2,f3
	sf		mf3+12(r1),f5



		;|||||||||||||||||||||||||||||||||||||
		;		PRODUCTO DE KRONEKER
		;|||||||||||||||||||||||||||||||||||||


	addi r1,r0,#0 ;Inicializamos el iterador de memoria de v1 a 0 (i)
	addi r2,r0,#0 ;Inicializamos el iterador de memoria de v2 a 0 (j)
	addi r3,r0,#0 ;Inucializamos el iterador de memoria de matriz resultado (k)

	lf		f7,mf1(r1)
	lf		f8,mf2(r2)										
	multf	f9,f7,f8
	sf		kronecker(r3),f9			;0*0 | 2*0

								;k++
								;j++ 1

	lf		f8,mf2+4(r2)						
	multf   f9,f7,f8
	sf		kronecker+4(r3),f9			;0*1 | 2*1

								;k++
								;i++ 1
								;j-- 0

	lf		f7,mf1+4(r1)
	lf		f8,mf2(r2)										
	multf	f9,f7,f8							
	sf		kronecker+8(r3),f9			;1*0 | 3*0
												
								;k++
								;j++ 1
												
	lf		f8,mf2+4(r2)
	multf 	f9,f7,f8
	sf 		kronecker+12(r3),f9			;1*1 | 3*1

								;k++
								;i--0
								;j++ 2

	lf		f7,mf1(r1)
	lf		f8,mf2+8(r2)										
	multf	f9,f7,f8
	sf		kronecker+16(r3),f9			;0*2 | 2*2

								;k++	
								;j++ 3

	lf		f8,mf2+12(r2)
	multf 	f9,f7,f8
	sf 		kronecker+20(r3),f9			;0*3 | 2*3

								;k++
								;i++
								;j-- 2

	lf		f7,mf1+4(r1)
	lf		f8,mf2+8(r2)										
	multf	f9,f7,f8
	sf		kronecker+24(r3),f9			;1*2 | 3*2

								;k++	
								;j++ 3

	lf		f8,mf2+12(r2)										
	multf	f9,f7,f8
	sf		kronecker+28(r3),f9			;1*3 | 3*3






		;|||||||||||||||||||||||||||||||||||||
		;		PRODUCTO DE KRONEKER 2
		;|||||||||||||||||||||||||||||||||||||
		
	addi r1,r0,#8
	addi r3,r3,#32
	addi r2,r0,0	


	lf		f7,mf1(r1)
	lf		f8,mf2(r2)										
	multf	f9,f7,f8
	sf		kronecker(r3),f9			;0*0 | 2*0

								;k++
								;j++ 1

	lf		f8,mf2+4(r2)						
	multf   f9,f7,f8
	sf		kronecker+4(r3),f9			;0*1 | 2*1

								;k++
								;i++ 1
								;j-- 0

	lf		f7,mf1+4(r1)
	lf		f8,mf2(r2)										
	multf	f9,f7,f8							
	sf		kronecker+8(r3),f9			;1*0 | 3*0
												
								;k++
								;j++ 1
												
	lf		f8,mf2+4(r2)
	multf 	f9,f7,f8
	sf 		kronecker+12(r3),f9			;1*1 | 3*1

								;k++
								;i--0
								;j++ 2

	lf		f7,mf1(r1)
	lf		f8,mf2+8(r2)										
	multf	f9,f7,f8
	sf		kronecker+16(r3),f9			;0*2 | 2*2

								;k++	
								;j++ 3

	lf		f8,mf2+12(r2)
	multf 	f9,f7,f8
	sf 		kronecker+20(r3),f9			;0*3 | 2*3

								;k++
								;i++
								;j-- 2

	lf		f7,mf1+4(r1)
	lf		f8,mf2+8(r2)										
	multf	f9,f7,f8
	sf		kronecker+24(r3),f9			;1*2 | 3*2

								;k++	
								;j++ 3

	lf		f8,mf2+12(r2)										
	multf	f9,f7,f8
	sf		kronecker+28(r3),f9			;1*3 | 3*3




	;HACEMOS EL DETERMINANTE
	addi	r1,r0,#0

	lf		f10,mf3(r1)
	lf		f11,mf3+12(r1)
	multf	f12,f10,f11	

	lf		f10,mf3+4(r1)
	lf		f11,mf3+8(r1)
	multf	f13,f10,f11

	subf	f12,f12,f13	;Almacenamos el resultado del determinante en f12

	lf		f0,cero
	eqf		f0,f12 		;Si el valor de f12 (determinante) es 0 saltamos al final
	bfpt	finish


	;HAMCEMOS DIVISION (a1+a4) CON EL DETERMINANTE

	lf 		f2,a1
	lf		f3,a4

	addf	f3,f3,f2

	divf	f6,f3,f12





	;PRIMERAS DOS FILAS MATRIZ RESULTADO
	addi	r1,r0,#0
	lf		f14,kronecker(r1)
	multf	f14,f14,f6
	sf		M(r1),f14
	lf		f14,kronecker+4(r1)
	multf	f14,f14,f6
	sf		M+4(r1),f14
	lf		f14,kronecker+8(r1)
	multf	f14,f14,f6
	sf		M+8(r1),f14
	lf		f14,kronecker+12(r1)
	multf	f14,f14,f6
	sf		M+12(r1),f14
	lf		f14,kronecker+16(r1)
	multf	f14,f14,f6
	sf		M+16(r1),f14
	lf		f14,kronecker+20(r1)
	multf	f14,f14,f6
	sf		M+20(r1),f14
	lf		f14,kronecker+24(r1)
	multf	f14,f14,f6
	sf		M+24(r1),f14
	lf		f14,kronecker+28(r1)
	multf	f14,f14,f6
	sf		M+28(r1),f14





	;SEGUNDAS DOS FILAS DE LA MATRIZ M

	addi	r1,r0,#32
	lf		f14,kronecker(r1)
	multf	f14,f14,f6
	sf		M(r1),f14
	lf		f14,kronecker+4(r1)
	multf	f14,f14,f6
	sf		M+4(r1),f14
	lf		f14,kronecker+8(r1)
	multf	f14,f14,f6
	sf		M+8(r1),f14
	lf		f14,kronecker+12(r1)
	multf	f14,f14,f6
	sf		M+12(r1),f14
	lf		f14,kronecker+16(r1)
	multf	f14,f14,f6
	sf		M+16(r1),f14
	lf		f14,kronecker+20(r1)
	multf	f14,f14,f6
	sf		M+20(r1),f14
	lf		f14,kronecker+24(r1)
	multf	f14,f14,f6
	sf		M+24(r1),f14
	lf		f14,kronecker+28(r1)
	multf	f14,f14,f6
	sf		M+28(r1),f14





	;HACEMOS LA VM

	addi	r1,r0,#0	;Inicializamos dos iteradores, ya que vamos a usar uno para cada fila de la matriz vector
	addi 	r2,r0,#16
	addi	r3,r0,#0	
	lf		f15, M(r1)
	lf		f16, M(r2)
	multf 	f15,f15,f16		
	sf		VM(r3),f15		
	lf		f15, M+4(r1)
	lf		f16, M+4(r2)
	multf 	f15,f15,f16		
	sf		VM+4(r3),f15		
	lf		f15, M+8(r1)
	lf		f16, M+8(r2)
	multf 	f15,f15,f16		
	sf		VM+8(r3),f15		
	lf		f15, M+12(r1)
	lf		f16, M+12(r2)
	multf 	f15,f15,f16		
	sf		VM+12(r3),f15		


	;HACEMOS LA HM

	addi	r1,r0,#32	;Inicializamos los inidices donde se tendrán que colocar ahora en la matriz que sería r1 en la posición 8 y r2 en la 12
	addi	r2,r0,#48
	addi	r3,r0,#0
	lf		f15, M(r1)
	lf		f16, M(r2)
	multf 	f15,f15,f16		
	sf		HM(r3),f15		
	lf		f15, M+4(r1)
	lf		f16, M+4(r2)
	multf 	f15,f15,f16		
	sf		HM+4(r3),f15		
	lf		f15, M+8(r1)
	lf		f16, M+8(r2)
	multf 	f15,f15,f16		
	sf		HM+8(r3),f15	
	lf		f15, M+12(r1)
	lf		f16, M+12(r2)
	multf 	f15,f15,f16		
	sf		HM+12(r3),f15	



	;OBTENEMOS EL VALOR check

	addi r1,r0,#0

	lf	f17,VM(r1)
	lf	f18, VM+4(r1)
	lf	f19,VM+8(r1)
	lf	f20, VM+12(r1)

	lf	f21,HM(r1)
	lf	f22, HM+4(r1)
	lf	f23,HM+8(r1)
	lf	f24, HM+12(r1)

	addf f25,f17,f18	
	addf f26,f17,f18 ;Para comprobar
	addf f25,f25,f19	
	addf f25,f25,f20


	addf f25,f25,f21
	addf f25,f25,f22	
	addf f25,f25,f23	
	addf f27,f23,f24 ;Para comprobar
	addf f25,f25,f24	

	sf	check,f25

	trap 0



finish:
	trap 0