
package net.lab0.motoko;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import net.lab0.motoko.psi.MotokoTypes;
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
LINE_COMMENT="//"[^\r\n]*
BLOCK_COMMENT="/*" [^"*/"]* "*/"

TEXT=\"([^\\\"\r\n]|\\[^\r\n])*\"?
NAT=-[:digit:]+ | [:digit:]+

ACTOR="actor"
AND="and"
ASSERT="assert"
AWAIT="await"
BANG="!"
BREAK="break"
CASE="case"
CATCH="catch"
CLASS="class"
COLUMN=":"
COMA=","
CONTINUE="continue"
DEBUG="debug"
DEBUG_SHOW="debug_show"
EQEQ="=="
EQ="="
ELSE="else"
FALSE="false"
FLEXIBLE="flexible"
FOR="for"
FUNC="func"
GTE=">="
ID=[:jletter:] [:jletterdigit:]*
IF="if"
IGNORE="ignore"
IN="in"
IMPORT="import"
L_ANGLE="<"
L_CURL="{"
L_PAREN="("
L_SQUARE="["
LABEL="label"
LET="let"
LOOP="loop"
LTE="<="
MODULE="module"
NEQ="!="
NOT="not"
NULL="null"
OBJECT="object"
OR="or"
POINT="."
PRIVATE="private"
PUBLIC="public"
QUERY="query"
R_ANGLE=">"
R_CURL="}"
R_PAREN=")"
R_SQUARE="]"
RETURN="return"
SEMI=";"
SHARED="shared"
STABLE="stable"
SWITCH="switch"
SYSTEM="system"
TRUE="true"
TRY="try"
TYPE="type"
UNDERSCORE="_"
VAR="var"
WHILE="while"

%state WAITING_VALUE

%%

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<YYINITIAL> {
    // comments
    {LINE_COMMENT}            { yybegin(YYINITIAL); return MotokoTypes.LINE_COMMENT; }
    {BLOCK_COMMENT}      { yybegin(YYINITIAL); return MotokoTypes.BLOCK_COMMENT; }

    // literals
    {TEXT}                    { yybegin(YYINITIAL); return MotokoTypes.TEXT; }
    {NAT}                     { yybegin(YYINITIAL); return MotokoTypes.NAT; }

    // keywords
    {ACTOR}                   { yybegin(YYINITIAL); return MotokoTypes.ACTOR; }
    {BANG}                    { yybegin(YYINITIAL); return MotokoTypes.BANG; }
    {CLASS}                   { yybegin(YYINITIAL); return MotokoTypes.CLASS; }
    {ELSE}                    { yybegin(YYINITIAL); return MotokoTypes.ELSE; }
    {FALSE}                   { yybegin(YYINITIAL); return MotokoTypes.FALSE; }
    {FOR}                     { yybegin(YYINITIAL); return MotokoTypes.FOR; }
    {FUNC}                    { yybegin(YYINITIAL); return MotokoTypes.FUNC; }
    {IF}                      { yybegin(YYINITIAL); return MotokoTypes.IF; }
    {IN}                      { yybegin(YYINITIAL); return MotokoTypes.IN; }
    {IMPORT}                  { yybegin(YYINITIAL); return MotokoTypes.IMPORT; }
    {LET}                     { yybegin(YYINITIAL); return MotokoTypes.LET; }
    {NULL}                    { yybegin(YYINITIAL); return MotokoTypes.NULL; }
    {MODULE}                  { yybegin(YYINITIAL); return MotokoTypes.MODULE; }
    {OBJECT}                  { yybegin(YYINITIAL); return MotokoTypes.OBJECT; }
    {PUBLIC}                  { yybegin(YYINITIAL); return MotokoTypes.PUBLIC; }
    {SHARED}                  { yybegin(YYINITIAL); return MotokoTypes.SHARED; }
    {SYSTEM}                  { yybegin(YYINITIAL); return MotokoTypes.SYSTEM; }
    {TRUE}                    { yybegin(YYINITIAL); return MotokoTypes.TRUE; }
    {TYPE}                    { yybegin(YYINITIAL); return MotokoTypes.TYPE; }
    {VAR}                     { yybegin(YYINITIAL); return MotokoTypes.VAR; }

    // comparators
    {GTE}                     { yybegin(YYINITIAL); return MotokoTypes.GTE; }
    {LTE}                     { yybegin(YYINITIAL); return MotokoTypes.LTE; }
    {NEQ}                     { yybegin(YYINITIAL); return MotokoTypes.NEQ; }
    {EQ}                      { yybegin(YYINITIAL); return MotokoTypes.EQ; }

    // symbols
    {COLUMN}                  { yybegin(YYINITIAL); return MotokoTypes.COLUMN; }
    {COMA}                    { yybegin(YYINITIAL); return MotokoTypes.COMA; }
    {EQEQ}                    { yybegin(YYINITIAL); return MotokoTypes.EQEQ; }
    {L_ANGLE}                 { yybegin(YYINITIAL); return MotokoTypes.L_ANGLE; }
    {L_CURL}                  { yybegin(YYINITIAL); return MotokoTypes.L_CURL; }
    {L_PAREN}                 { yybegin(YYINITIAL); return MotokoTypes.L_PAREN; }
    {L_SQUARE}                { yybegin(YYINITIAL); return MotokoTypes.L_SQUARE; }
    {POINT}                   { yybegin(YYINITIAL); return MotokoTypes.POINT; }
    {R_ANGLE}                 { yybegin(YYINITIAL); return MotokoTypes.R_ANGLE; }
    {R_CURL}                  { yybegin(YYINITIAL); return MotokoTypes.R_CURL; }
    {R_PAREN}                 { yybegin(YYINITIAL); return MotokoTypes.R_PAREN; }
    {R_SQUARE}                { yybegin(YYINITIAL); return MotokoTypes.R_SQUARE; }
    {SEMI}                    { yybegin(YYINITIAL); return MotokoTypes.SEMI; }


    // identifiers
    {ID}                      { yybegin(YYINITIAL); return MotokoTypes.ID; }
}

({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }
