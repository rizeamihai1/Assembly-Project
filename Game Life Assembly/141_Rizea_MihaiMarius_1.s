.data

mlines: .space 4
ncols:   .space 4
p: .space 4
x: .space 4
y: .space 4
k: .space 4
o: .space 4
matrix: .zero 1600    
copie: .zero 1600 
lineIndex: .space 4
colIndex: .space 4
evolutia: .space 4
linie: .space 4
coloana: .space 4
m: .space 4
n: .space 4
sum: .space 4
i: .space 4
j: .space 4
pozInitiala: .space 4
elem: .space 4
vectoruu: .space 2000
initial: .long 0
lungime_cheie: .long 0
opt: .long 8
len: .long
len2: .long
poz: .long 0

vector: .space 2000
mesaj: .space 1000
formatscanf: .asciz "%d"
formatScanfs: .asciz "%s"
formatprintf: .asciz "%d "
formatPrintf: .asciz "%d"
formatPrintfx: .asciz "%X"
formatPrintfc: .asciz "%c"
ox: .asciz "0x"
endl: .asciz "\n"
temporal: .byte 0
.text

.global main

main:

citire_m:
    push $mlines
    push $formatscanf
    call scanf
    add $8, %esp

citire_n:
    push $ncols
    push $formatscanf
    call scanf
    add $8, %esp

movl mlines, %ebx
addl $2, %ebx
movl ncols, %eax
addl $2, %eax
    
movl $0, %edx
mull %ebx
    
mov %eax, lungime_cheie

movl mlines,%ebx
movl %ebx, m

movl ncols,%ebx
movl %ebx, n 

incl m
incl n
addl $2, mlines
addl $2, ncols


citire_p:
    push $p
    push $formatscanf
    call scanf
    add $8, %esp

mov $matrix, %edi
mov $0, %ecx

et_p:
    cmp p, %ecx
    je et_citeste_k
    push %ecx
    push $x
    push $formatscanf
    call scanf
    add $8, %esp

    incl x

    push $y
    push $formatscanf
    call scanf
    add $8, %esp

    incl y
    
    pop %ecx
    
    mov x, %eax
    mull ncols
    addl y, %eax  
    movl $1, (%edi, %eax, 4)

    inc %ecx
    jmp et_p

et_citeste_k:

    #Citim k

    push $k
    push $formatscanf
    call scanf
    add $8, %esp
    movl $0, evolutia
    et_evolutii:
        movl evolutia, %ecx
        cmp %ecx, k
        je et_citeste_o
        et_copiere1: #pune in copie continutul din matrix
            movl $0, linie
            movl $matrix, %edi
            et_linii1:
                mov linie, %ecx
                cmp mlines, %ecx
                je et_evolute_efectiva
                    
                movl $0, coloana
                et_coloane1:
                    mov coloana, %ecx
                    cmp ncols, %ecx
                    je sf_linie1

                    mov linie, %eax
                    mull ncols
                    add coloana, %eax

                    movl (%edi, %eax, 4), %esi
                    movl $copie, %edi
                    movl %esi, (%edi, %eax,4)
                    movl $matrix, %edi
                    incl coloana
                    jmp et_coloane1

                sf_linie1:
                    incl linie
                    jmp et_linii1   
        et_evolute_efectiva: #modifica copie (face o evolutie)
            movl $1, i
            movl $matrix, %edi
            et_linie3:
                movl i, %ecx
                cmp %ecx, m
                je et_copiere2
                movl $1, j
                et_coloane3:
                    movl j, %ecx
                    cmp %ecx,n
                    je sf_linie3
                    mov i, %eax
                    mov $0, %edx
                    mull ncols
                    add j, %eax
                    mov $0, %esi
                    mov %eax, pozInitiala

                    #ac linie, stanga dreapta elm curent
                    addl $1, %eax
                    addl (%edi,%eax,4), %esi
                    
                    movl pozInitiala, %eax
                    subl $1, %eax
                    addl (%edi,%eax,4), %esi
                    
                    #linia de mai sus, ac colana, stanga, dreapta

                    movl pozInitiala, %eax
                    subl ncols, %eax
                    addl (%edi,%eax,4), %esi

                    movl pozInitiala, %eax
                    subl ncols, %eax
                    subl $1, %eax
                    addl (%edi,%eax,4), %esi

                    movl pozInitiala, %eax
                    subl ncols, %eax
                    addl $1, %eax
                    addl (%edi,%eax,4), %esi

                    #linia de mai jos, ac colana, stanga, dreapta

                    movl pozInitiala, %eax
                    addl ncols, %eax
                    addl (%edi,%eax,4), %esi

                    movl pozInitiala, %eax
                    addl ncols, %eax
                    subl $1, %eax
                    addl (%edi,%eax,4), %esi

                    movl pozInitiala, %eax
                    addl ncols, %eax
                    addl $1, %eax
                    addl (%edi,%eax,4), %esi
                    
                    movl pozInitiala, %eax
                    #aici trb tratate cazurile!!!!
                    
                    cmpl $0,(%edi,%eax,4)
                    je cazul_0

                    movl $1, %ebx
                    cmpl $1,(%edi,%eax,4)
                    je cazul_1

                    cazul_0:
                        movl $copie, %edi
                        
                        movl $3, %ebx
                        cmp %ebx, %esi
                        je fa_1
                        
                        jmp sari
                    cazul_1:
                        movl $copie, %edi
                        
                        cmp $2, %esi # esi < 2
                        jl fa_0
                        
                        cmp $3, %esi # esi > 3
                        jg fa_0

                        jmp sari
                    fa_1:
                        movl $1,(%edi,%eax,4)
                        jmp sari

                    fa_0:
                        movl $0,(%edi,%eax,4)
                        jmp sari

                    sari:
                        movl $matrix, %edi
                        incl j
                        jmp et_coloane3
                sf_linie3:
                    incl i
                    jmp et_linie3


        
        et_copiere2: #pune in matrix continutul din copie(evolutia noua)
            movl $0, linie
            movl $copie, %edi
            et_linii2:
                mov linie, %ecx
                cmp mlines, %ecx
                je et_sari
                    
                movl $0, coloana
                et_coloane2:
                    mov coloana, %ecx
                    cmp ncols, %ecx
                    je sf_linie2

                    mov linie, %eax
                    mull ncols
                    add coloana, %eax

                    movl (%edi, %eax, 4), %esi
                    movl $matrix, %edi
                    movl %esi, (%edi, %eax,4)
                    movl $copie, %edi
                    incl coloana
                    jmp et_coloane2

                sf_linie2:
                    incl linie
                    jmp et_linii2 
        et_sari:
            incl evolutia
            jmp et_evolutii

et_citeste_o:
    citire_o:
    	push $o
    	push $formatscanf
    	call scanf
    	add $8, %esp
    mov o, %ecx
    cmp $1, %ecx
    je decriptare
    citire_mesaj:
    	push $mesaj
    	push $formatScanfs
    	call scanf
    	addl $8, %esp
    determina_lungime_mesaj:
    	push $mesaj
    	call strlen
    	addl $8, %esp
    	movl %eax, len
    movl $0, %eax
    movl $0, %edx
    movl $0, %ecx

    movl $mesaj, %esi
    movl $0, poz
    
loop:
    mov $0, %ebx
    movb (%esi, %ecx, 1), %bl
    cmp $0, %bl
    je ceva
    #in bl am 8 biti, vreau fiecare bit sa-l pun in "vector = mesaj"
    movl %ecx, poz
    mov $7, %ecx
    
    loop2:
    	cmp $-1, %ecx
    	je exit_loop
    	movb %bl, temporal
    	shr %ecx, %bl
    	and $1, %bl
    	
    	movl $vector, %esi
    	movl poz, %eax
    	mov $0, %edx
    	mull opt
    	addl $7, %eax
    	subl %ecx, %eax
    	movl %ebx, (%esi, %eax,4)

    	movl $mesaj, %esi
        movb temporal, %bl
        
        decl %ecx
        jmp loop2
    exit_loop:
    	movl poz, %ecx
    	incl %ecx 
    	jmp loop
    
ceva:
    movl len, %eax
    incl %eax
    movl $0, %edx
    mull opt
    movl %eax, len
    
    movl lungime_cheie, %ecx
    mov $matrix, %esi
loop_lungimi:
    cmp len, %ecx #len = lungime mesaj (8*nr litere), in %ecx lungimea cheii
    jge urm
    mov $0, %ecx
    loop_lungimi2:
    	cmp len, %ecx
    	je pas3
    	mov %ecx, %edx
    	addl lungime_cheie, %edx
    	movl (%esi, %ecx,4), %ebx
    	movl %ebx, (%esi, %edx,4)
    	incl %ecx
    	jmp loop_lungimi2
    pas3:
    addl lungime_cheie, %ecx
    movl %ecx, lungime_cheie
   jmp loop_lungimi
#xorare $matrix, cu $vector
urm:

    mov $0, %ecx
    movl $matrix, %esi
    
    loop_afisare:
    	cmp len, %ecx
    	je urm2
    	movl (%esi, %ecx, 4), %ebx
    	movl $vector, %esi
    	
    	movl (%esi, %ecx, 4), %edx
    	xor %ebx, %edx
    	movl %edx, (%esi, %ecx,4)
    	
    	movl $matrix, %esi
    	incl %ecx
    	jmp loop_afisare
urm2:
	
    push $ox
    call printf
    addl $4, %esp
    
    mov $0, %ecx
    movl $vector, %esi
    mov $0, %edx
    mov $0, %eax
   loop_afisare2:
    	cmp len, %ecx
    	je et_exit
    	mov %ecx, %edx
    	addl $4, %edx
    	mov $0, %eax
    	loop_3:
    	    cmp %edx, %ecx
    	    je aici
    	    movl (%esi, %ecx, 4), %ebx
    	    shl $1, %eax
    	    addl %ebx, %eax
    	    incl %ecx
    	    jmp loop_3
    	aici:
    	    
    	push %ecx
    	push %edx
    	
    	push %eax
    	push $formatPrintfx
    	call printf
    	addl $8, %esp
    	
    	pushl $0
    	call fflush
    	addl $4, %esp
    	
    	pop %edx
    	pop %ecx
    	
    	
    	jmp loop_afisare2
decriptare:
    push $mesaj
    push $formatScanfs
    call scanf
    addl $8, %esp
    
    push $mesaj
    call strlen
    addl $8, %esp
    subl $2, %eax
    movl %eax, len
    
    mov $2, %ecx
    mov $0, %ebx
    mov $mesaj, %esi
    
    loop_decriptare:
        movb (%esi, %ecx,1), %bl
        cmp $0, %bl
        je aici_decriptare
        cmp $57, %bl
        jle cifra_decript
        litera_decript:
            subb $55, %bl
            jmp add_decript
        cifra_decript:
            subb $48, %bl
            jmp add_decript
       	add_decript:
            mov $vector, %esi
            mov %ebx, -8(%esi, %ecx,4)
        incl %ecx
        mov $mesaj, %esi
        jmp loop_decriptare
    aici_decriptare:   
        
        mov $0, %ecx
        mov $vector, %esi
        baza_2_decriptare:
            cmp len, %ecx
            je concate_lungime_cheie
            mov %ecx, %edi

            mov %edi, %eax
            mov $4, %ebx
            mov $0, %edx
            mull %ebx
            
            mov %eax, initial
            mov %eax, %edi
            
            mov %edi, %edx
    	    addl $4, %edx
    	    mov $vector, %esi
    	    movl (%esi, %ecx, 4), %ebx
    	   
            cate_4_decriptare:
                cmp %edx, %edi
                je aicisia_decriptare
                #in %ebx am elemenetul in baza 10
                mov %ebx, %eax
    	    	and $1, %eax
    	    	
    	    	push %edi
    	    	push %edx
    	    	
    	    	subl %edi, %edx
    	    	decl %edx
    	    	addl initial, %edx
    	    	mov $vectoruu, %esi
    	    	mov %eax, (%esi, %edx,4)
    	    	
    	    	pop %edx
    	    	pop %edi
    	    	
    	    	
    	    	shr %ebx
    	    	
    	    	incl %edi
    	    	jmp cate_4_decriptare
    	     aicisia_decriptare:
    	     	
    	        incl %ecx
    	        jmp baza_2_decriptare
        
        #lungime_cheie
        concate_lungime_cheie:
            mov len, %eax
            mov $4, %ebx
            mov $0, %edx
            mull %ebx
            mov %eax, len
            
            movl lungime_cheie, %ecx
            mov $matrix, %esi
            
            concatenare_decript:
                cmp len, %ecx #len = lungime mesaj (8*nr litere), in %ecx lungimea cheii
                jge xorare_decriptare
                mov $0, %ecx
                loop_lungimi2_decript:
    	            cmp len, %ecx
        	        je pas3_decript
    	            mov %ecx, %edx
    	            addl lungime_cheie, %edx
    	            movl (%esi, %ecx,4), %ebx
    	            movl %ebx, (%esi, %edx,4)
    	            incl %ecx
    	            jmp loop_lungimi2_decript
                pas3_decript:
                addl lungime_cheie, %ecx
                movl %ecx, lungime_cheie
            jmp concatenare_decript


        xorare_decriptare:
                        
            mov $0, %ecx
            mov $matrix, %esi
            loop_xorare_decriptare:
                cmp len, %ecx
    	        je afisare_mesaj_decriptare
    		    movl (%esi, %ecx, 4), %ebx
    		    movl $vectoruu, %esi
    	
    		    movl (%esi, %ecx, 4), %edx
    		    xor %ebx, %edx
    		    movl %edx, (%esi, %ecx,4)
    	
    		    movl $matrix, %esi
    		    incl %ecx
    	        jmp loop_xorare_decriptare
    	    
    	    
        afisare_mesaj_decriptare:
            movl $vectoruu, %esi
            mov $0, %ecx
            loop_afisare2_decript:
    	    cmp len, %ecx
    	    je et_exit
    	    mov %ecx, %edx
    	    addl $8, %edx
    	    mov $0, %eax
    	    loop_3_decript:
    	        cmp %edx, %ecx
    	        je aici_decriptareee
    	        movl (%esi, %ecx, 4), %ebx
    	        shl $1, %eax
    	        addl %ebx, %eax
    	        incl %ecx
    	        jmp loop_3_decript
    	    aici_decriptareee:
    	    
    	    push %ecx
    	    push %edx
    	
    	    push %eax
    	    push $formatPrintfc
    	    call printf
    	    addl $8, %esp
    	
    	    pushl $0
    	    call fflush
    	    addl $4, %esp
    	
    	    pop %edx
    	    pop %ecx
    	
    	
    	    jmp loop_afisare2_decript
et_exit:  
    mov $1, %eax
    mov $0, %ebx
    int $0x80

