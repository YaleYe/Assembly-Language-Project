TITLE find prime
INCLUDE Irvine32.inc
;this program help to find if number's factorial number

.data

x dword ?
k dword ?
num dword ?
temp dword ?
Mess1 byte "Enter number: ",0dh,0ah,0          ;output message
Mess2 byte "Your number will be: ",0dh,0ah,0   ;output message
Mess3 byte " ",0
.code
main proc  
lea edx,Mess1
call writestring       ;tell user to input number

call readdec           ;input number
mov x,eax              ;save number into x


mov edx,0             ;init the division
mov ebx,2			  ;divided by two to find maximum looping cycle
div ebx				  ;division
mov k,eax			  ;save k for loop purpose

       
lea edx,Mess2
call writestring

mov eax,x
call writedec

lea edx,Mess3
call writestring

mov ecx,k
target:
	mov temp,ecx
	mov ebx,temp      ;division
	mov eax,x
	mov edx,0
	div ebx
	cmp edx,0
	je f1              ;if the leftover is 0, print the current number(factorial number)
	jne f2             ;if not, go back to the loop

	f1:
	lea edx,Mess3
	call writestring
	mov eax,ecx
	call writedec

	f2:
	mov eax,ecx

loop target        



	invoke exitprocess,0
main ENDP

END main