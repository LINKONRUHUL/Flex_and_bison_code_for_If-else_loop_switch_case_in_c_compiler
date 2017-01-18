/* C Declarations */

%{
	#include<stdio.h>
	#include "IF.tab.h"
	#include<stdlib.h>
	extern int yylval;
%}

/* RE and Actions */

%%

[0-9]+	{ 
		yylval = atoi(yytext);
		return NUM;
	}

[a-z]	{
		yylval = *yytext - 'a';
		return	VAR;
	}

"loop"    return WHILE;
"jodi"	  return IF;
"nahole"  return ELSE;
"case"    return CASE;
"switch"  return SWITCH;
"break"   return BREAK;
"print"   return PRINT;
"default" return DEFAULT;

[-+/*<>=,():;{}] 	{
		   
			yylval = yytext[0];
			return *yytext;
		}

[ \t\n]*	;

.	{
		yyerror("Unknown Character.\n");
	}
%%

main(){
	yyin = freopen("in.txt","r",stdin);
	yyout = freopen("output.txt","w",stdout);
	yyparse();
}

