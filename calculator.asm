.MODEL SMALL
.STACK 100H
.DATA      

CLRF  DB 13, 10,'$'
MSG1  DB 'For Add(+) type   :'1'$'
MSG2  DB 10,13,'For Sub(-) type   :'2'$'
MSG3  DB 10,13,'For Mul(*) type   :'3'$'
MSG4  DB 10,13,'For Div(/) type   :'4'$'
MSG5  DB 10,13,'Choose Any One:$'
MSG6  DB 10,13,10,13,'Enter 1st Number:$'
MSG7  DB 10,13,'Enter 2nd Number:$'
MSG8  DB 10,13,10,13,'The Result is: $' 
MSG9  DB 10,13, 'Wrong input. Choose again 1 -> 4$'
MSG   DB 10,13,10,13,'               ***THANK YOU FOR USING MY APP***$'
ten   DB '               *********Mini Calculator********$'                           

.CODE   

;   --------Main function-------------

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,9
    LEA DX,ten
    INT 21H
    
    call nextLine
    call nextLine
    
Input:
    
;   In thong bao chon phep tinh cong    
    LEA DX,MSG1
    MOV AH,9
    INT 21H

;   In thong bao chon phep tinh tru     
    LEA DX,MSG2
    MOV AH,9
    INT 21H

;   In thong bao chon phep tinh nhan    
    LEA DX,MSG3
    MOV AH,9
    INT 21H

;   In thong bao chon phep tinh chia    
    LEA DX,MSG4
    MOV AH,9
    INT 21H 
    
;   In thong bao nguoi dung lua chon phep tinh     
    LEA DX,MSG5
    MOV AH,9
    INT 21H
    
;   Nhap ki tu tu ban phim, chuyen tu ki tu sang so  
    MOV AH,1
    INT 21H
    MOV BH,AL
    SUB BH,48

;   Logic chon dau vao    
    CMP BH,1
    JE ADD
    
    CMP BH,2
    JE SUB
     
    CMP BH,3
    JE MUL
    
    CMP BH,4
    JE DIV

;   Neu nhap input khac 1 den 4 thi in ra tbao nhap lai input    
    LEA DX, MSG9
    MOV AH, 9
    INT 21H
    
    call nextLine; Xuong dong
    
    JMP Input; Tro lai buoc nhap input


    
;   ---------Cong 2 so----------    
  ADD:
    mov bh, 0; Vi o ham main su dung thanh ghi BH, nen o day ta gan no lai bang 0
        
    LEA DX,MSG6  ;tbao ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    call inputDec     ; goi ham nhap so thu nhat he 10
    push ax           ; luu ax da nhap lai
    call nextLine
    
    LEA DX,MSG7    ;tbao ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    call inputDec   ; goi ham nhap so thu hai
    mov bl, al
    call nextLine  ;Xuong dong
    
    pop ax            ; goi ax tu Stack ra
    call tong         ; goi ham tinh tong 2 so (trong ax va bx)
    push ax
    
    LEA DX,MSG8    ;in tbao ket qua
    MOV AH,9
    INT 21H
    
    pop ax
    call outputDec   ; goi ham in ket qua
    
    JMP EXIT_P       ;nhay xuong buoc in ket thuc chuong trinh



    
;  ----------------------Tru 2 so---------------------    
   SUB: 
   
    mov bh, 0; Vi o ham main su dung thanh ghi BH, nen o day ta gan no lai bang 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    call inputDec     ; goi ham nhap so thu nhat he 10
    push ax           ; luu ax da nhap lai
    call nextLine     ; Xuong dong
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    
    
    call inputDec     ; goi ham nhap so thu 2
    mov bl, al
    call nextLine
    
    pop ax            ; goi ax tu Stack ra
    call hieu          ; goi ham tinh hieu 2 so (trong ax va bx)
    push ax
    
    LEA DX,MSG8       ; in tbao ket qua
    MOV AH,9
    INT 21H
    
    pop ax
    call outputDec    ; goi ham in ket qua
    
    JMP EXIT_P 
    
    
    
    
   MUL:
 
    mov bh, 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    call inputDec     ; goi CTC nhap so thu nhat he 10
    push ax           ; luu ax da nhap lai
    call nextLine
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    
    
    call inputDec
    mov bl, al
    call nextLine
    
    pop ax            ; goi ax tu Stack ra
    call tich          ; goi ham tinh tich 2 so (trong ax va bx)
    push ax
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    pop ax
    call outputDec
    
    JMP EXIT_P  
    
   
   
   
   
   
   DIV:
    
    mov bh, 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    call inputDec     ; goi CTC nhap so thu nhat he 10
    push ax           ; luu ax da nhap lai
    call nextLine
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    
    call inputDec
    mov bl, al
    call nextLine
    
    pop ax            ; goi ax tu Stack ra
    call thuong          ; goi ham tinh thuong 2 so (trong ax va bx)
    push ax
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    pop ax
    call outputDec
    
    JMP EXIT_P
    
    EXIT_P:
    
        LEA DX,MSG
        MOV AH,9
        INT 21H    
        
    EXIT:
    
    MOV AH,4CH
    INT 21H
MAIN ENDP 


;    ---------Chuong trinh con-------------  
  
    tong proc          ; CTC con tinh tong 2 so
        add ax, bx
        ret
    tong endp


;   Chuong trinh con tinh hieu
    hieu proc
        sub ax, bx
        ret
    hieu endp  


; Chuong trinh con tinh tich     
    tich proc 
         mul bx
         ret
    tich endp 


; Chuong trinh con tinh thuong    
    thuong proc 
         div bl
         ret
    thuong endp 


; Chuong trinh con xuong dong                                                            
    nextLine proc    
        mov ah, 9
        lea dx, CLRF
        int 21h
        ret
    nextLine endp

; Chuong trinh con nhap dau vao he 10     
    inputDec proc
        ; luu cac gia tri ban dau trong cac thanh ghi vao stack
        push bx
        push cx
        push dx 
         
        batDau:
            mov bx, 0 ; bien tinh tong
            mov cx, 0
            mov ah, 1
            int 21h
            cmp al, '-'
            je dauTru
            cmp al, '+'
            je dauCong
            jmp tiepTuc
             
            dauTru:
                mov cx, 1
             
            dauCong:
                int 21h
             
            tiepTuc:
                cmp al, '0'
                jnge khongPhaiSo    ; khong lop hon hoac bang
                cmp al, '9'
                jnle khongPhaiSo    ; Khong nho hon hoac bang
                and ax, 000fh      ; doi thanh chu so, giai thich f sang nhi phan 1111, vd ki tu '1' trong 
                                   ; thanh ghi al co ma hex la 0x31 co ma o cuoi(1) chuyen sang nhi phan la 0001, sau cau lenh and thanh ghi al chua ma 0001 nen ki tu '1' duoc chuyen thanh so
                push ax             ; luu gia tri vua nhap vao ngan xep
                mov ax, 10           ; gan ax = 10
                 
                mul bx              ; ax = tong*10 hay ax = bx * 10
                mov bx, ax          
                pop ax              ; lay gia tri vua nhap ra gan vao ax chinh la cai bien 'so' o duoi
                add bx, ax          ; tong = tong*10 + so
                
                mov ah, 1
                int 21h
                cmp al, 13          ; da enter chua?
                jne tiepTuc         ; nhap tiep
                 
                mov ax, bx          ; chuyen KQ ra ax
                cmp cx,1           ; co phai so am khong
                jne ra
                neg ax              ; neu la so am thi doi ax ra so am
                 
            ra: 
            ;tra lai gia tri ban dau cho cac thanh ghi
                pop dx
                pop cx
                pop bx  
                 
                ret
                 
            khongPhaiSo:
                mov ah, 2
                mov dl, 0dh
                int 21h
                mov dl, 0ah
                int 21
                jmp batDau
                 
                 
    inputDec endp 
     
    outputDec proc 
       ; dua vao stack de khong lam thay doi gia tri cua thanh ghi
        push bx
        push cx
        push dx
         
        cmp ax, 0   ;   neu ax > 0 tuc la khong phai so am ta doi ra day
        jge doiRaDay
        push ax
        mov dl, '-'
        mov ah, 2
        int 21h
        pop ax
        neg ax  ; ax = -ax
         
        doiRaDay:
            mov cx, 0  ; gan cx = 0
            mov bx, 10  ; so chia la 10
            chia:
                mov dx, 0  ; gan dx = 0
                div bx      ; ax = ax / bx; dx = ax % bx
                push dx      
                inc cx
                cmp ax, 0   ; kiem tra xem thuong bang khong chua?
                jne chia    ; neu khong bang thi lai chia
                mov ah, 2
            hien:
                pop dx
                or dl, 30h  ; chuyen tu ki tu sang so hay cong them 48 trong bang ma asci ('0' + 48 = 0)
                            ;vd 5 nhi phan 0000 0101
                            ;30 sang nhi phan 0011 0000
                            ;sau cau lenh or ta dc 0011 0101 hay noi cach khac la cong them 48
                            ;do dx la thanh ghi 16 bit va dl la thanh ghi 8 bit nen ta su dung cach nay
                int 21h
                loop hien
                
                ; vi gia tri cac thanh ghi ban dau duoc dua vao stack 
                ;nen khi thuc hien xong co the lay tu stack va tra lai gia tri ban dau cua cac thanh ghi 
                pop dx
                pop cx
                pop bx
                ;pop ax
        ret
         
    outputDec endp
END MAIN

; su khac biet giua 2 cau lenh and ax, 000fh va or dl,30h mac du chung deu co muc dich la chuyen ki tu thanh so
; la and ax, 000fh se xoa tat ca cac bit dau chi giu lai 4 bit cuoi trong he nhi phan, con cau lenh kia chuyen doi gia tri thanh
;ki tu so trong  bang ma ascii de in ra
