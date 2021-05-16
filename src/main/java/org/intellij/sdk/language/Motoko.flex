
package org.intellij.sdk.language;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import org.intellij.sdk.language.psi.MotokoTypes;
import com.intellij.psi.TokenType;

%%

%class MotokoLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}


CRLF=\R
WHITE_SPACE=[\ \n\t\f]


TEXT=\"([^\\\"\r\n]|\\[^\r\n])*\"?
NAT=-[:digit:]+ | [:digit:]+

ACTOR="actor"
COLUMN=":"
COMA=","
EQEQ="=="
EQ="="
FALSE="false"
FLEXIBLE="flexible"
FUNC="func"
GTE=">="
ID=[:jletter:] [:jletterdigit:]*
IMPORT="import"
L_ANGLE="<"
L_CURL="{"
L_PAREN="("
LET="let"
LTE="<="
MODULE="module"
NEQ="!="
NULL="null"
OR="or"
OBJECT="object"
PRIVATE="private"
PUBLIC="public"
QUERY="query"
R_ANGLE=">"
R_CURL="}"
R_PAREN=")"
SEMI=";"
SHARED="shared"
STABLE="stable"
SYSTEM="system"
TRUE="true"
TYPE="type"
UNDERSCORE="_"
VAR="var"


END_OF_LINE_COMMENT=("#"|"!")[^\r\n]*

%state WAITING_VALUE

%%

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<YYINITIAL> {
    // literals
    {TEXT}                    { yybegin(YYINITIAL); return MotokoTypes.TEXT; }
    {NAT}                     { yybegin(YYINITIAL); return MotokoTypes.NAT; }

    // keywords
    {ACTOR}                   { yybegin(YYINITIAL); return MotokoTypes.ACTOR; }
    {FALSE}                   { yybegin(YYINITIAL); return MotokoTypes.FALSE; }
    {FUNC}                    { yybegin(YYINITIAL); return MotokoTypes.FUNC; }
    {IMPORT}                  { yybegin(YYINITIAL); return MotokoTypes.IMPORT; }
    {LET}                     { yybegin(YYINITIAL); return MotokoTypes.LET; }
    {NULL}                    { yybegin(YYINITIAL); return MotokoTypes.NULL; }
    {MODULE}                  { yybegin(YYINITIAL); return MotokoTypes.MODULE; }
    {OBJECT}                  { yybegin(YYINITIAL); return MotokoTypes.OBJECT; }
    {TRUE}                    { yybegin(YYINITIAL); return MotokoTypes.TRUE; }
    {TYPE}                    { yybegin(YYINITIAL); return MotokoTypes.TYPE; }
    {VAR}                     { yybegin(YYINITIAL); return MotokoTypes.VAR; }

    // comparators
    {GTE}                     { yybegin(YYINITIAL); return MotokoTypes.GTE; }
    {LTE}                     { yybegin(YYINITIAL); return MotokoTypes.LTE; }
    {NEQ}                     { yybegin(YYINITIAL); return MotokoTypes.NEQ; }
    {EQ}                      { yybegin(YYINITIAL); return MotokoTypes.EQ; }

    // symbols
    {COMA}                    { yybegin(YYINITIAL); return MotokoTypes.COMA; }
    {EQEQ}                    { yybegin(YYINITIAL); return MotokoTypes.EQEQ; }
    {L_ANGLE}                  { yybegin(YYINITIAL); return MotokoTypes.L_ANGLE; }
    {L_CURL}                  { yybegin(YYINITIAL); return MotokoTypes.L_CURL; }
    {L_PAREN}                  { yybegin(YYINITIAL); return MotokoTypes.L_PAREN; }
    {R_ANGLE}                  { yybegin(YYINITIAL); return MotokoTypes.R_ANGLE; }
    {R_CURL}                  { yybegin(YYINITIAL); return MotokoTypes.R_CURL; }
    {R_PAREN}                  { yybegin(YYINITIAL); return MotokoTypes.R_PAREN; }
    {SEMI}                    { yybegin(YYINITIAL); return MotokoTypes.SEMI; }


    // identifiers
    {ID}                      { yybegin(YYINITIAL); return MotokoTypes.ID; }
}

({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }
