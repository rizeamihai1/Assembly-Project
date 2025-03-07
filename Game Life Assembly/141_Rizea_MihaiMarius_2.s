.data

mlines: .space 4
ncols:   .space 4
p: .space 4
x: .space 4
y: .space 4
k: .space 4
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
formatscanf: .asciz "%d"
formatprintf: .asciz "%d "
endl: .asciz "\n"

fisier: .space 4
citire: .asciz "r"
afisare: .asciz "w"
fin: .asciz "in.txt"
fout: .asciz "out.txt"
.text

.global main

main:

#Sa deschid fisierul de citire
    pushl $citire #cum il deschid
    pushl $fin #fisierul
    call fopen #sa deschid fisierul
    addl $8, %esp
    movl %eax, fisier

citire_m:
    push $mlines
    push $formatscanf
    push fisier
    call fscanf 
    add $12, %esp

citire_n:
    push $ncols
    push $formatscanf
    push fisier
    call fscanf 
    add $12, %esp

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
    push fisier
    call fscanf 
    add $12, %esp

mov $matrix, %edi
mov $0, %ecx

et_p:
    cmp p, %ecx
    je et_citeste_k
    push %ecx
    push $x
    push $formatscanf
    push fisier
    call fscanf 
    add $12, %esp

    incl x

    push $y
    push $formatscanf
    push fisier
    call fscanf 
    add $12, %esp

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
    push fisier
    call fscanf 
    add $12, %esp
    movl $0, evolutia
    et_evolutii:
        movl evolutia, %ecx
        cmp %ecx, k
        je et_afisare
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

et_afisare:
    pushl $afisare #cum il deschid
    pushl $fout #fisierul
    call fopen #sa deschid fisierul
    addl $8, %esp
    movl %eax, fisier
    
    movl $matrix, %edi
    movl $1, lineIndex

    et_lines:
        mov lineIndex, %ecx
        cmp m, %ecx
        je et_exit

    movl $1, colIndex

    et_cols:
        mov colIndex, %ecx
        cmp n, %ecx
        je et_cout_lines

        mov lineIndex, %eax
        mull ncols
        add colIndex, %eax
        
        movl (%edi, %eax, 4), %esi
        push %esi
        push $formatprintf
        push fisier
        call fprintf
        addl $12, %esp

        incl colIndex
        jmp et_cols

    et_cout_lines:
        push $endl
        push fisier
        call fprintf
        addl $8, %esp

        incl lineIndex
        jmp et_lines


et_exit:
    push $0 
    call fflush 
    addl $4, %esp
    
    mov $1, %eax
    mov $0, %ebx
    int $0x80
