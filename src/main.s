.data
LAST_TILE:	.word 0

.text
.include "MACROSv21.s"
# REGISTRADORES
# s0 = front buffer
# s1 = back buffer
# s3 = current frame address
# s4 = music address
# s5 = numero de movimentos/turnos
# s6 = last input time
# s7 = render permission (1 or 0)
# s8 = thorn in last move (1 or 0)
# s9 = side to render
# s11 = key or no key

# a5 = tmp

#Configurações iniciais
INIT:
	jal INIT_VIDEO
	li s7,1
	# Music initialization
	la t0, D_BG_MUSIC
	la t1, M_BG	
	sw t1, 0(t0)	
	jal a0, ST_MUS

#Desenhando Primeira Animação
jal a6, PRIMEIRAS_ANIMACOES

#Inicialização menu Principal
INIT_I:
	la t0, CUR_MAP
	sw zero, (t0)

	la a1, MENU01
	la a0, MENU02
	call SET_IMAGES

	la t0, OPCAO
	li t1, 1
	sw t1, (t0)

	la a0, D_IMAGE1
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES

#Menu Principal Loop
I_LOOP: 
	jal a6,KEY3		# le o teclado	blocking
	#jal P_MUS	
	j I_LOOP

#Desenhando História
HISTORIA:
	jal a6, D_HISTORIA

#Criando mapa 01
call MAPA01

#Inicialização Game Loop
INIT_G:
	# Movement initialization
	la s5 N_MOV
	lb s5 0(s5)
	li s6, 0

#Inicialização Hud
INIT_HUD:
	#Hud inicialization
	la a0, hud
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	la a0, hud
	li a1, 0
	li a2, 0
	call RENDER
	#DOOR INITIALIZATION
	li s11, 0

	lw a4, (s3)
	xori a4, a4, 1		
	mv a0, s5
	call PRINT_INT
	li s8, 0

# Game loop
G_LOOP:
	jal a6,KEY1	
	jal P_MUS
	jal a6, GLOBAL_DRAW
	j G_LOOP
	
# Inicialização Menu de diálogo
INIT_O:
	la t0, OPCAO
	li t1, 1
	sw t1, (t0)

	la a0, D_IMAGE1
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	
#Menu de dialogo loop
O_LOOP: 
	jal a6,KEY2		# le o teclado	blocking
	j O_LOOP

#Inicialização Menu pause
INIT_M:
	la a0, pause0
	la a1, pause1
	la a2, pause2
	call SET_IMAGES

	la t0, OPCAO
	li t1, 1
	sw t1, (t0)

	la a0, D_IMAGE1
	lw a0, (a0)
	li a1, 0
	li a2, 0
	call RENDER
	call SWAP_FRAMES
	
#Loop menu pause
M_LOOP: 
	jal a6,KEY4		# le o teclado	blocking
	j M_LOOP


	
#Includes	
.include "buffer.s"
.include "render.s"
.include "sound.s"
.include "poling01.s"
.include "movimentacao.s"
.include "menu-blocking.s"
.include "tiles.s"
.include "correlate.s"
.include "animation.s"
.include "map_manager.s"
.include "historyAnimation.s"
.include "print_int.s"
.include "board.s"
.include "mapas.s"
.include "SYSTEMv21.s"

.data
#MISC
.include "../sprites/misc/floor.data"
.include "../sprites/misc/key.data"
.include "../sprites/misc/door.data"
.include "../sprites/misc/stone.data"
.include "../sprites/misc/spike.data"
.include "../sprites/misc/ColunaBaixo.data"
.include "../sprites/misc/ColunaCima.data"
.include "../sprites/misc/parede.data"
.include "../sprites/misc/black.data"
.include "../sprites/misc/hud.data"

#MORTE E RESET
.include "../sprites/menu/MORTE.data"
.include "../sprites/menu/reset_and_sucess_pass.data"

#Dialogos MAP1
.include "../sprites/menu/dialog10.data"
.include "../sprites/menu/dialog11.data"
.include "../sprites/menu/dialog12.data"

#Dialogos MAP2
.include "../sprites/menu/dialog20.data"
.include "../sprites/menu/dialog21.data"
.include "../sprites/menu/dialog22.data"

#Dialogos MAP3
.include "../sprites/menu/dialog30.data"
.include "../sprites/menu/dialog31.data"
.include "../sprites/menu/dialog32.data"

#Dialogos MAP4
.include "../sprites/menu/dialog40.data"
.include "../sprites/menu/dialog41.data"
.include "../sprites/menu/dialog42.data"

#Dialogos MAP5
.include "../sprites/menu/dialog60.data"
.include "../sprites/menu/dialog61.data"
.include "../sprites/menu/dialog63.data"

#Dialogos MAP6
.include "../sprites/menu/dialog50.data"
.include "../sprites/menu/dialog51.data"

#MENUS
.include "../sprites/menu/creditosfinais.data"
.include "../sprites/menu/alertainicial.data"
.include "../sprites/menu/MENU01.data"
.include "../sprites/menu/MENU02.data"

#HISTORIA
.include "../sprites/menu/history0.data"
.include "../sprites/menu/history1.data"
.include "../sprites/menu/history2.data"
.include "../sprites/menu/history3.data"

#PAUSE
.include "../sprites/menu/pause0.data"
.include "../sprites/menu/pause1.data"
.include "../sprites/menu/pause2.data"

#ANIMACAO E MUSICA
.include "animation.data"
.include "songs.data"
