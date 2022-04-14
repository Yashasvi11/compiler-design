%{ 
	#include<stdio.h>
	#include<stdlib.h>                                             //header file for general purpose standard library
	extern FILE *yyout;                                            //yyin and yyout as pointer of file type
	extern FILE *yyin;
	int yylex();
	void yyerror(const char *s);                                  //function either aborts the parsing job or just return
%}


%token PUBLIC INTERFACE IDENTIFIER VOID TYPE SEMICOLON CURLY_OPEN CURLY_CLOSE ROUND_OPEN ROUND_CLOSE EXTENDS;

%%

S			: E {printf("Interface Successfully Declared\n"); exit(0);}          //print message if sucessfully runs

E			: PUBLIC INTERFACE IDENTIFIER A CURLY_OPEN BODY CURLY_CLOSE                 //checks "{interface name A{BODY}}"
			;

A			: EXTENDS IDENTIFIER                                                       // checks if it extends interface or not or either it should be empty
			|                                                                    
			;

BODY		: BODY PUBLIC RETURNTYPE IDENTIFIER ROUND_OPEN MULPARAM ROUND_CLOSE SEMICOLON       //checks either contains some functions or not
			|                                                                                //empty
			;
	
RETURNTYPE	: TYPE                                                                      //checks return type of function in body
			| VOID
			;
	
PARAM		: TYPE IDENTIFIER 
			| TYPE IDENTIFIER ',' PARAM                                 //checks parameter in function either it had one or more or nothing
			;

MULPARAM	:PARAM
			|
			;
%%

void yyerror(char const *s)                                                            //returns error if interface is not defined properly
{
    printf("\nSyntax Invalid   %s\n",s);
    exit(1) ;
}

int main(int argc,char **argv) {                                                       

	yyin = fopen(argv[argc-1],"r");                                                     //it reads input file
	//yyout = fopen("Result.txt", "w"); 
    yyparse();
     
    return 1;
}
