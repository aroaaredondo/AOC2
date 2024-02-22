MOV     #20000,  r1         @ Cargar 20000 en r1
MOV     #20000,  r2         @ Cargar 20000 en r2
MOV     #10000,  r3         @ Cargar 10000 en r3
MOV     #1000,   r4         @ Cargar 1000 en r4
MOV     #700,    r5         @ Cargar 700 en r5
MOV     #60,     r6         @ Cargar 60 en r6
MOV     #9,      r7         @ Cargar 9 en r7

ADD r1, r2, r0    @ Sumar r2 a r0
ADD r0, r3, r0    @ Sumar r3 a r0
ADD r0, r4, r0    @ Sumar r4 a r0
ADD r0, r5, r0    @ Sumar r5 a r0
ADD r0, r6, r0    @ Sumar r6 a r0
ADD r0, r7, r0    @ Sumar r7 a r0

HALT   