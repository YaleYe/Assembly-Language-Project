title move an object()
;this program indicate user to input certain arrow and count how many right answer when the game ends
include irvine32.inc

Displayshape Macro
	mov edx,offset shape
	call writestring
	endm
;add time counter
;speed, levels

.data
points dword 0
return db 'Enter K when you are ready!',0dh,0ah,0
instruction db 'This game requires you to press UP,DOWN,LEFT,RIGHT to receive certain points',0dh,0ah,0
guide db 'up= w,down=s,left=a,right=d',0dh,0ah,0
scoreSummary db 'You have scored ',0
restartInstruction db "Play again, 'Y' or 'N' ",0dh,0ah,0
mes1 db '**********POWERED BY GOOGLE.INC*********',0dh,0ah,0
mes2 db '*            *****************         *',0dh,0ah,0
mes3 db '*           *****************          *',0dh,0ah,0
mes4 db '*          ****                        *',0dh,0ah,0
mes5 db '*         ****                         *',0dh,0ah,0
mes6 db '*        ****                          *',0dh,0ah,0
mes7 db '*       ****                           *',0dh,0ah,0
mes8 db '*       ****            **********     *',0dh,0ah,0
mes9 db '*       ****            **********     *',0dh,0ah,0
mes10 db '*       ****                  ****     *',0dh,0ah,0
mes11 db '*         ****                ****     *',0dh,0ah,0
mes12 db '*          ****              ****      *',0dh,0ah,0
mes13 db '*           ****            ****       *',0dh,0ah,0
mes14 db '*             *****************        *',0dh,0ah,0          
mes15 db '*                ************          *',0dh,0ah,0
mes16 db '****************************************',0dh,0ah,0


left1 db "                        |\     ",0dh,0ah,0
left2 db "                        | \    ",0dh,0ah,0
left3 db "     |------------------   \   ",0dh,0ah,0
left4 db "     |------------------    \  ",0dh,0ah,0
left5 db "     |------------------     \ ",0dh,0ah,0
left6 db "     |------------------     / ",0dh,0ah,0
left7 db "     |------------------    /  ",0dh,0ah,0
left8 db "     |------------------   /   ",0dh,0ah,0
left9 db "                        | /    ",0dh,0ah,0
left0 db "                        |/     ",0dh,0ah,0

right1 db "     /|                        ",0dh,0ah,0
right2 db "    / |                        ",0dh,0ah,0
right3 db "   /   ------------------|     ",0dh,0ah,0
right4 db "  /    ------------------|     ",0dh,0ah,0
right5 db " /     ------------------|     ",0dh,0ah,0
right6 db " \     ------------------|     ",0dh,0ah,0
right7 db "  \    ------------------|     ",0dh,0ah,0
right8 db "   \   ------------------|     ",0dh,0ah,0
right9 db "    \ |                        ",0dh,0ah,0
right0 db "     \|                        ",0dh,0ah,0

up1 db "      /\         ",0dh,0ah,0
up2 db "     /  \        ",0dh,0ah,0
up3 db "    /    \       ",0dh,0ah,0
up4 db "   /      \      ",0dh,0ah,0
up5 db "  /--------\     ",0dh,0ah,0
up6 db "    ||||||       ",0dh,0ah,0
up7 db "    ||||||       ",0dh,0ah,0
up8 db "    ||||||       ",0dh,0ah,0
up9 db "    |----|       ",0dh,0ah,0


down1 db "   |----|      ",0dh,0ah,0
down2 db "   ||||||      ",0dh,0ah,0
down3 db "   ||||||      ",0dh,0ah,0
down4 db "   ||||||      ",0dh,0ah,0
down5 db " \--------/    ",0dh,0ah,0
down6 db "  \      /     ",0dh,0ah,0
down7 db "   \    /      ",0dh,0ah,0
down8 db "    \  /       ",0dh,0ah,0
down9 db "     \/        ",0dh,0ah,0




.code
main proc
	call clrscr
	mov dh,6
	mov dl,10

	;ask use to start the game
	loopback:
		lea edx,instruction
		call writestring
		call drawGoogle
		lea edx,return
		call writestring
		call readChar
		cmp al,'k'
		jne loopback
		je start

		start:			
			call generateDirectionNumber ;randomsize a number to represent a number
				cmp eax,1
				je upselection          ;up arrow 
				cmp eax,2
				je downselection        ;down arrow
				cmp eax,3
				je leftselection        ;left arrow
				cmp eax,4
				je rightselection       ;right arrow
				
					upselection:       ;up option
						call drawup
						call readchar
						cmp al,'w'
						je incPoints
						jne outputResult

					downselection:    ;down option
						call drawdown
						call readchar
						cmp al,'s'
						je incPoints
						jne outputResult

					
					leftselection:    ;left option
						call drawleft
						call readchar
						cmp al,'d'
						je incPoints
						jne outputResult

					
					rightselection:   ;right option
						call drawright
						call readchar
						cmp al,'a'
						je incPoints
						jne outputResult

					incPoints:       ;when the key is hited right, increase the points
						mov eax,points
						add eax,10
						mov points,eax
						jmp start    ;back to regenerate a direction

						outputResult:   ;when game is over, print out results and ask user to replay or not
							lea edx,scoreSummary
							call writestring
							mov eax, points
							call writedec
							call crlf
							lea edx,restartInstruction
							call writestring
							call readchar
							cmp al,'y'
							je restart
							cmp al,'n'
							je endThePain
							jne loopback
								
								restart:  ;init the points
									mov points,0
									jmp start
								endThePain:
									exit



			
main endp

;generate new direction to press
generateDirectionNumber proc
	mov eax,4
	call randomrange
generateDirectionNumber endp


;draw the google icon
drawGoogle proc
	call clrscr 
	push eax
	mov eax,white +(black*16)   ;forground/ the background color (*16)two words
	call settextcolor
	pop eax

	call gotoxy
	push edx   ;save the position
	mov edx,offset guide
	call writestring
	pop edx
	inc dh
	call gotoxy

	call gotoxy
	push edx   ;save the position
	mov edx,offset mes1
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes2
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes3
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes4
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes5
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes6
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes7
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes8
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes9
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes10
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes11
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes12
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes13
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes14
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes15
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset mes16
	call writestring
	pop edx
	inc dh
	call gotoxy

	ret
drawGoogle endp

;draw left arrow
drawleft proc

	push edx
	mov edx,offset left1
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset left2
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset left3
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset left4
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset left5
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset left6
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset left7
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset left8
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset left9
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset left0
	call writestring
	pop edx
	inc dh
	call gotoxy

	ret
drawleft endp



;draw the right icon
drawright proc


	push edx
	mov edx,offset right1
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset right2
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset right3
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset right4
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset right5
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset right6
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset right7
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset right8
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset right9
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset right0
	call writestring
	pop edx
	inc dh
	call gotoxy

	ret
drawright endp


;draw the up icon
drawup proc

	push edx
	mov edx,offset up1
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset up2
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset up3
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset up4
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset up5
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset up6
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset up7
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset up8
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset up9
	call writestring
	pop edx
	inc dh
	call gotoxy

	ret
drawup endp


;draw the down icon
drawdown proc

	push edx
	mov edx,offset down1
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset down2
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset down3
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset down4
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset down5
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset down6
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset down7
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset down8
	call writestring
	pop edx
	inc dh
	call gotoxy

	push edx
	mov edx,offset down9
	call writestring
	pop edx
	inc dh
	call gotoxy

	ret
drawdown endp

end main