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
TENAPP   DB '               *********Mini Calculator********$'                           

.CODE   

;   --------Main function-------------

MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX 
    
    MOV AH,9
    LEA DX,TENAPP
    INT 21H
    
    CALL nextLine
    CALL nextLine
    
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
    
    CALL nextLine; Xuong dong
    
    JMP Input; Tro lai buoc nhap input


    
;   ---------Cong 2 so----------    
  ADD:
    MOV BH, 0; Vi o ham main su dung thanh ghi BH, nen o day ta gan no lai bang 0
        
    LEA DX,MSG6  ;tbao ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec     ; goi ham nhap so thu nhat he 10
    PUSH AX           ; luu ax da nhap lai
    CALL nextLine
    
    LEA DX,MSG7    ;tbao ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec   ; goi ham nhap so thu hai
    MOV BL, AL
    CALL nextLine  ;Xuong dong
    
    POP AX            ; goi ax tu Stack ra
    CALL tong         ; goi ham tinh tong 2 so (trong ax va bx)
    PUSH AX
    
    LEA DX,MSG8    ;in tbao ket qua
    MOV AH,9
    INT 21H
    
    POP AX
    CALL outputDec   ; goi ham in ket qua
    
    JMP EXIT_P       ;nhay xuong buoc in ket thuc chuong trinh



    
;  ----------------------Tru 2 so---------------------    
   SUB: 
   
    MOV BH, 0; Vi o ham main su dung thanh ghi BH, nen o day ta gan no lai bang 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec     ; goi ham nhap so thu nhat he 10
    PUSH AX           ; luu ax da nhap lai
    CALL nextLine     ; Xuong dong
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H  
    
    CALL inputDec     ; goi ham nhap so thu 2
    MOV BL, AL
    CALL nextLine
    
    POP AX           ; goi ax tu Stack ra
    CALL hieu          ; goi ham tinh hieu 2 so (trong ax va bx)
    PUSH AX
    
    LEA DX,MSG8       ; in tbao ket qua
    MOV AH,9
    INT 21H
    
    POP AX
    CALL outputDec    ; goi ham in ket qua
    
    JMP EXIT_P 
    
    
    
    
   MUL:
 
    MOV bh, 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec     ; goi CTC nhap so thu nhat he 10
    PUSH AX           ; luu ax da nhap lai
    CALL nextLine
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec
    MOV BL, AL
    CALL nextLine
    
    POP AX            ; goi ax tu Stack ra
    CALL tich          ; goi ham tinh tich 2 so (trong ax va bx)
    PUSH AX
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    POP AX
    CALL outputDec
    
    JMP EXIT_P  
    
   
   
   
   
   
   DIV:
    
    MOV BH, 0
        
    LEA DX,MSG6  ;ENTER 1ST NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec     ; goi CTC nhap so thu nhat he 10
    PUSH AX           ; luu ax da nhap lai
    CALL nextLine
    
    LEA DX,MSG7    ;ENTER 2ND NUMBER
    MOV AH,9
    INT 21H 
    
    CALL inputDec
    MOV BL, AL
    CALL nextLine
    
    POP AX            ; goi ax tu Stack ra
    CALL thuong          ; goi ham tinh thuong 2 so (trong ax va bx)
    PUSH AX
    
    LEA DX,MSG8
    MOV AH,9
    INT 21H
    
    POP AX
    CALL outputDec
    
    JMP EXIT_P
    
    EXIT_P:
    
        LEA DX,MSG
        MOV AH,9
        INT 21H    
        
    MOV AH,4CH
    INT 21H
MAIN ENDP 


;    ---------Chuong trinh con-------------  
  
    tong PROC          ; CTC con tinh tong 2 so
        ADD AX, BX
        RET
    tong ENDP


;   Chuong trinh con tinh hieu
    hieu PROC
        SUB AX, BX
        RET
    hieu ENDP  


; Chuong trinh con tinh tich     
    tich PROC 
         MUL BX
         RET
    tich ENDP 


; Chuong trinh con tinh thuong    
    thuong PROC 
         DIV BL
         RET
    thuong ENDP 


; Chuong trinh con xuong dong                                                            
    nextLine PROC    
        MOV AH, 9
        LEA DX, CLRF
        INT 21H
        RET
    nextLine ENDP

; Chuong trinh con nhap dau vao he 10     
    inputDec PROC
         
        batDau:
            MOV BX, 0 ; bien tinh tong
            MOV CX, 0
            MOV AH, 1
            INT 21H
            CMP AL, '-'
            JE dauTru
            CMP AL, '+'
            JE dauCong
            JMP tiepTuc
             
            dauTru:
                MOV CX, 1
             
            dauCong:
                INT 21H
             
            tiepTuc:
                CMP AL, '0'
                JNGE khongPhaiSo    ; khong lop hon hoac bang
                CMP AL, '9'
                JNLE khongPhaiSo    ; Khong nho hon hoac bang
                AND AX, 000fh      ; doi thanh chu so, giai thich f sang nhi phan 1111, vd ki tu '1' trong 
                                   ; thanh ghi al co ma hex la 0x31 co ma o cuoi(1) chuyen sang nhi phan la 0001, sau cau lenh and thanh ghi al chua ma 0001 nen ki tu '1' duoc chuyen thanh so
                PUSH AX             ; luu gia tri vua nhap vao ngan xep
                MOV AX, 10           ; gan ax = 10
                 
                MUL BX              ; ax = tong*10 hay ax = bx * 10
                MOV BX, AX          
                POP AX              ; lay gia tri vua nhap ra gan vao ax chinh la cai bien 'so' o duoi
                ADD BX, AX          ; tong = tong*10 + so
                
                MOV AH, 1
                INT 21H
                CMP AL, 13          ; da enter chua?
                JNE tiepTuc         ; nhap tiep
                 
                MOV AX, BX          ; chuyen KQ ra ax
                CMP CX,1           ; co phai so am khong
                JNE ra
                NEG ax              ; neu la so am thi doi ax ra so am
                 
            ra: 
                RET
                 
            khongPhaiSo:
                MOV AH, 2
                MOV DL, 0dh
                INT 21H
                MOV DL, 0ah
                INT 21H
                JMP batDau
                 
                 
    inputDec ENDP 
     
    outputDec PROC 
         
        CMP AX, 0   ;   neu ax >= 0 tuc la khong phai so am ta doi ra day
        JGE doiRaDay
        PUSH AX
        MOV DL, '-'
        MOV AH, 2
        INT 21H
        POP AX
        NEG AX  ; ax = -ax
         
        doiRaDay:
            MOV CX, 0  ; gan cx = 0
            MOV BX, 10  ; so chia la 10
            chia:
                MOV DX, 0  ; gan dx = 0
                DIV BX      ; ax = ax / bx; dx = ax % bx
                PUSH DX      
                INC CX
                CMP AX, 0   ; kiem tra xem thuong bang khong chua?
                JNE chia    ; neu khong bang thi lai chia
                MOV AH, 2
            hien:
                POP DX
                OR DL, 30H  ; chuyen tu ki tu sang so hay cong them 48 trong bang ma asci ('0' + 48 = 0)
                            ;vd 5 nhi phan 0000 0101
                            ;30 sang nhi phan 0011 0000
                            ;sau cau lenh or ta dc 0011 0101 hay noi cach khac la cong them 48
                            ;do dx la thanh ghi 16 bit va dl la thanh ghi 8 bit nen ta su dung cach nay
                INT 21H
                LOOP hien
                
                ; vi gia tri cac thanh ghi ban dau duoc dua vao stack 
                ;nen khi thuc hien xong co the lay tu stack va tra lai gia tri ban dau cua cac thanh ghi 
        RET
         
    outputDec ENDP

; su khac biet giua 2 cau lenh and ax, 000fh va or dl,30h mac du chung deu co muc dich la chuyen ki tu thanh so
; la and ax, 000fh se xoa tat ca cac bit dau chi giu lai 4 bit cuoi trong he nhi phan, con cau lenh kia chuyen doi gia tri thanh
;ki tu so trong  bang ma ascii de in ra
