;== Beginning codes ==

extern printf

extern scanf

global travel

segment .data 

;== message to user==

Ispeed db "Please enter the speed for the initial segment of the trip (mph): ", 10, 0

miles db "For how many miles will you maintain this average speed? ",10,0

Fspeed db "What will be your speed during the final segment of the trip (mph): ", 10, 0

average db "Your average speed will be %1.18lf mph", 10, 0

time db "The total travel time will be %1.18lf hours", 10, 0

stringformat db "%s", 0                                     ;general string format

eight_byte_format db "%lf", 0                               ;general 8-byte float format

segment .bss

align 64                                                    ;Insure that the inext data declaration starts on a 64-byte boundar.
backuparea resb 832 

;== Executable ==
segment.text

travel:
;== how the function will run ==
							
;== Starting travel code (first obtain) ==

; Show first message (no input)
push qword 0
mov qword rax, 0
mov rdi, stringformat		;I'm assuming we need to lay something in rdi for it to work
mov rsi, Ispeed		;print out the message for inital speed
call printf
pop rax 			;Assuming that we need to reverse a push before we can take an input

; Asking for speed (obtain inital speed input)
push qword 0
mov qword rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf 			;should be right after first message
movsd xmm0, [rsp] 		;Transfer and store input to xmm0
movsd xmm8, xmm0 		;safely store in xmm8
pop rax

; show second message (no input) 
push qword 0
mov qword rax, 0
mov rdi, stringformat	
mov rsi, miles		;print out the message for total miles
call printf
pop rax 	

; Asking for total miles ( obtain miles )
push qword 0
mov qword rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf 
movsd xmm0, [rsp]
movsd xmm10, xmm0
pop rax

; show third message (no input) 
push qword 0
mov qword rax, 0
mov rdi, stringformat	
mov rsi, Fspeed		;print out the message for Final speed
call printf
pop rax 	

; Asking for speed (obtain final speed input)
push qword 0
mov qword rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf 			;should be right after first message
movsd xmm0, [rsp] 		;Transfer and store input to xmm0
movsd xmm9, xmm0 		;safely store in xmm9
pop rax

;== math ==

; Getting average speed
addsd xmm8, xmm9		; xmm8 = xmm8 + xmm9
mov rbx, 2 			; rbx set to 2
push rbx 			; push to a stack
divsd xmm8, [rsp]		; divide input (xmm8) by 2
movsd xmm1, [rsp] 		; copy to xmm1... not really needed for a 2
pop rax

; store average speed
push qword 0
movsd [rsp], xmm8 		;store the average speed

mov rax, 1
mov rdi, average
call printf

; Getting total time

divsd xmm10, xmm8 		; xmm10 = xmm10 / xmm8
movsd [rsp], xmm10

mov rax,1
mov rdi, time
call printf

mov rax, 1
call printf

pop r14

;========== End of program fp-io.asm

