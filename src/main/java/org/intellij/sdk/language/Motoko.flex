
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
EQUAL="="
FALSE="false"
FLEXIBLE="flexible"
ID=[:jletter:] [:jletterdigit:]*
IMPORT="import"
L_CURL="{"
L_TRIANGLE="<"
LET="let"
MODULE="module"
NULL="null"
OR="or"
OBJECT="object"
PRIVATE="private"
PUBLIC="public"
R_CURL="}"
R_TRIANGLE=">"
SEMI=";"
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
    {IMPORT}                  { yybegin(YYINITIAL); return MotokoTypes.IMPORT; }
    {LET}                     { yybegin(YYINITIAL); return MotokoTypes.LET; }
    {NULL}                    { yybegin(YYINITIAL); return MotokoTypes.NULL; }
    {MODULE}                  { yybegin(YYINITIAL); return MotokoTypes.MODULE; }
    {OBJECT}                  { yybegin(YYINITIAL); return MotokoTypes.OBJECT; }
    {TRUE}                    { yybegin(YYINITIAL); return MotokoTypes.TRUE; }
    {TYPE}                    { yybegin(YYINITIAL); return MotokoTypes.TYPE; }
    {VAR}                     { yybegin(YYINITIAL); return MotokoTypes.VAR; }

    // symbols
    {EQUAL}                   { yybegin(YYINITIAL); return MotokoTypes.EQUAL; }
    {SEMI}                    { yybegin(YYINITIAL); return MotokoTypes.SEMI; }
    {L_CURL}                  { yybegin(YYINITIAL); return MotokoTypes.L_CURL; }
    {R_CURL}                  { yybegin(YYINITIAL); return MotokoTypes.R_CURL; }

    // identifiers
    {ID}                      { yybegin(YYINITIAL); return MotokoTypes.ID; }
}

({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }
