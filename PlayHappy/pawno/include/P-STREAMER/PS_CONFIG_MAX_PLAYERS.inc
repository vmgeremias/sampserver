/*
*
*	-= P-STREAMER =-
*	Protioso Streamer
*	Autor: Protioso ([VGS]Protioso_OC)
*   Obs.: o valor abaixo pode ser editado conforme sua necessidade!
*
*/

#if defined MAX_PLAYERS
	#undef MAX_PLAYERS
#endif
#if defined PS_MAX_PLAYERS
	#define MAX_PLAYERS PS_MAX_PLAYERS
#else
	#define MAX_PLAYERS 500
/* Seu servidor est� mesmo com limite para 500
jogadores? Vamos racionalizar e aumentar a efici�ncia, caso voc� n�o use 500
abaixe este valor para a quantia m�xima definida em seu server.cfg!
 Por exemplo, se seu servidor est� limitado para apenas 50 jogadores n�o h�
motivos para deixar em 500. Uma quantia de 450 em um loop para v�rios
elementos (objetos, pickups...) faz uma enorme diferen�a! */
#endif
