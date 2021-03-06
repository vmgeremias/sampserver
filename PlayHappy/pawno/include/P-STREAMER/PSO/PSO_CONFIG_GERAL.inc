/*
*
*	-= P-STREAMER =-
*	Protioso Streamer
*	Autor: Protioso ([VGS]Protioso_OC)
*   Obs.: os valores abaixo podem ser editados conforme sua necessidade!
*
*/

#if !defined PSO_ORDEM_TIMER
	#define PSO_ORDEM_TIMER 1
/* Se estiver em 1 o que vir� primeiro na checagem
ser� os jogadores. Se estiver em 0 o que vir� primeiro ser� os objetos. */
#endif

#if !defined PSO_MULTI_SCRIPTS
	#define PSO_MULTI_SCRIPTS 0
/* Para compartilhar informa��es com outros scripts.
Deixe em 1 para habilitar (se realmente usar) e 0 para desabilitar. */
#endif

#if !defined MAX_PSO
	#define MAX_PSO 1000
/* Limite de objetos (altere como preferir). */
#endif

#if !defined PSO_TEMPO_CHECAGEM
	#define PSO_TEMPO_CHECAGEM 500
/* Tempo em milisegundos. */
#endif

#if !defined MAX_OBJETOS_JOGADOR
	#define MAX_OBJETOS_JOGADOR 180
/* M�ximo que o jogador pode ver. N�o pode
ultrapassar passar o limite do SA-MP!
Obs.: o limite de 180 foi definido a partir de testes. */
#endif

#if !defined PSO_CONSERVAR_OBJETOS
	#define PSO_CONSERVAR_OBJETOS 0
/* 0 desativado e 1 ativado... Isto define se
voc� quer manter os objetos depois que o jogador sair da �rea e n�o tiver
excedido o lime de objetos por jogador. */
#endif

#if !defined PSO_COMPARTILHAR_FUNC
	#define PSO_COMPARTILHAR_FUNC 0
/* 0 desativado e 1 ativado... Pouco recomendado
use apenas se realmente houver necessidade. Leia as �ltimas linhas do arquivo
PSO Manual.txt para saber mais! */
#endif

#if !defined PSO_RAIO_STREAM_PADRAO
	#define PSO_RAIO_STREAM_PADRAO 135.0
/* Se voc� n�o identificar um valor para o
raio que o objeto aparecer� nas fun��es para criar objeto, este valor ir� ser
usado para o novo objeto criado. */
#endif
