%{
#include <stdio.h>                                                             
#include "y.tab.h"                                                             
void yyerror(const char *s);                                                   
%}                                  

Knostar [^*]*                                                                  
Nostarfwd [^*/]
Pstar [\*]+
alpha [A-Za-z]                                                                
digit [0-9]


%%
"/*"{Knostar}{Pstar}({Nostarfwd}{Knostar}{Pstar})*"/"   ;
"//".*                                                  ;
public  						return PUBLIC;
interface						return INTERFACE;                            
void							return VOID;
extends                         return EXTENDS;
int|float|char|String			return TYPE;
{alpha}({alpha}|{digit})*		return IDENTIFIER;
"{"								return CURLY_OPEN;
"}"								return CURLY_CLOSE;
"("								return ROUND_OPEN;
")"								return ROUND_CLOSE;
";"								return SEMICOLON;
[ \t\n]+						;
.								return *yytext;
%%


int yywrap(){                                                             //function is called by lex when input is exhausted
	return 1;                                                             //return 1 if we are done
}

