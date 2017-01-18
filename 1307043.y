/* C Declarations */

%{
	#include<stdio.h>
	int sym[26];
	int t0=0;
	int t1=0;
	int t2=0;
	int t3=0;
	int t4=0;
	int cnt=0;
%}

/* bison declarations */

%token NUM VAR IF ELSE WHILE CASE SWITCH BREAK PRINT DEFAULT
%nonassoc IFX
%nonassoc ELSE
%left '<' '>'
%left '+' '-'
%left '*' '/'

/* Grammar rules and actions follow.  */

%%

program: /* NULL */

	| program statement
	;



statement  :  SWITCH '(' VAR ')' '{' BASE '}' 
                  
	                        

    | expression ';' 			{ printf("value of expression: %d\n", $1); }

    | VAR '=' expression ';'{ 
							    sym[$1] = $3; 
							    t4 = sym[$1];
							    printf("Value of the variable: %d\t\n",$3);
						    }


    | WHILE '(' VAR ')' {
                            printf("\n----- Loop Started Here ---- \n");
							while(t4--) {
								printf("Loop Here :  %d\n", t4);
							}
							printf("----- Loop Ended Here -----\n\n");				
						}


	| IF '(' expression ')' expression ';' %prec IFX {
								if($3)
								{
									printf("\nvalue of expression in IF: %d\n",$5);
								}
								else
								{
							     	printf("condition value zero in IF block\n");
								}
							}

	| IF '(' expression ')' expression ';' ELSE expression ';' {
								 	if($3)
									{
										printf("value of expression in IF: %d\n",$5);
									}
									else
									{
										printf("value of expression in ELSE: %d\n",$8);
									}
								}

	|IF '(' expression ')' '{' statement '}'  
	;


BASE : Bas
     | Bas Dflt
     ;

Bas   : /*NULL*/
     | Bas Cs
     ;

Cs    : CASE NUM ':' expression ';' BREAK ';' {
             if(t4==$2){
                  cnt=1;
                  printf("\nSwitch Case statement Started Here \nYour ID : %d  and You Got %d Marks!! \nSwitch case ended\n\n",$2,$4);
             }
        }
     ;

Dflt    : DEFAULT ':' expression ';' BREAK ';'{
            if(cnt==0){
                printf("\nSwitch Case statement Started Here\nYou Failed !!!\nSwitch case ended\n\n");
            }
        }
     ;     


expression: NUM				{ $$ = $1; 	}

	| VAR				{ $$ = sym[$1]; }

	| expression '+' expression	{ $$ = $1 + $3; }

	| expression '-' expression	{ $$ = $1 - $3; }

	| expression '*' expression	{ $$ = $1 * $3; }

	| expression '/' expression	{ 	
	                    if($3) 
				  		{
				     		$$ = $1 / $3;
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by zero\t");
				  		} 	
				    }

	| expression '<' expression	{ $$ = $1 < $3; }

	| expression '>' expression	{ $$ = $1 > $3; }

	| '(' expression ')'		{ $$ = $2;	}
	;
%%

int yywrap()
{
return 1;
}

yyerror(char *s){
	printf( "%s\n", s);
}

