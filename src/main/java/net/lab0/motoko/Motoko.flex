
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
// TODO: doc comments
LINE_COMMENT="//"[^\r\n]*
// TODO: comments nesting
BLOCK_COMMENT="/*" [^"*/"]* "*/"

// Hacky
// TODO: Implement the actual definition from https://sdk.dfinity.org/docs/language-guide/language-manual.html#syntax-chars
CHAR="'" [:letter:] "'" | "'" \\ "'" "'"

TEXT=\"([^\\\"\r\n]|\\[^\r\n])*\"?

// <id>   ::= Letter (Letter | Digit | _)*
// Letter ::= A..Z | a..z
// Digit  ::= 0..9
LETTER=[a-zA-Z]
DIGIT=[0-9]
ID={LETTER} ({LETTER}|{DIGIT}|{UNDERSCORE})*

//hexdigit ::= ['0'-'9''a'-'f''A'-'F']
HEXDIGIT=[[0-9]||[a-f]||[A-F]]
//num ::= digit ('_'? digit)*
NUM={DIGIT} ({UNDERSCORE}* {DIGIT})*
//hexnum ::= hexdigit ('_'? hexdigit)*
HEXNUM={HEXDIGIT} ({UNDERSCORE}? {HEXDIGIT})*
//nat ::= num | "0x" hexnum
NAT={NUM} | "0x" {HEXNUM}

//let float =
//    num '.' frac?
//  | num ('.' frac?)? ('e' | 'E') sign? num
//  | "0x" hexnum '.' hexfrac?
//  | "0x" hexnum ('.' hexfrac?)? ('p' | 'P') sign? num

FLOAT= ({NUM} {POINT} {NUM}?)
    | {NUM} ({POINT} {NUM}?)? ["e" "E"] {SIGN}? {NUM}
    | "0x" {HEXNUM} {POINT} {HEXNUM}?
    | "0x" {HEXNUM} ({POINT} {HEXNUM}?)? ["p" "P"] {SIGN}? {NUM}

SIGN=({PLUS} | {MINUS})

ACTOR="actor"
AMPERSAND="&"
AND="and"
ASSERT="assert"
AWAIT="await"
BANG="!"
BREAK="break"
CARRET="^"
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
HASH="#"
IF="if"
IGNORE="ignore"
IN="in"
IN_PLACE_UPDATE=":="
IN_PLACE_ADD="+="
IN_PLACE_SUBTRACT="-="
IN_PLACE_MULTIPLY="*="
IN_PLACE_DIVIDE="/="
IN_PLACE_MODULO="%="
IN_PLACE_EXPONENTIATION="**="
IN_PLACE_LOGICAL_AND="&="
IN_PLACE_LOGICAL_OR="|="
IN_PLACE_EXCLUSIVE_OR="^="
IN_PLACE_SHIFT_LEFT="<<="
IN_PLACE_SHIFT_RIGHT=">>="
IN_PLACE_ROTATE_LEFT="<<>="
IN_PLACE_ROTATE_RIGHT="<>>="
IN_PLACE_ADD_WRAP_ON_OVERFLOW="+%="
IN_PLACE_SUBTRACT_WRAP_ON_OVERFLOW="-%="
IN_PLACE_MULTIPLY_WRAP_ON_OVERFLOW="*%="
IN_PLACE_EXPONENTIATION_WRAP_ON_OVERFLOW="**%="
IN_PLACE_CONCATENATION="#="
IMPORT="import"
L_ANGLE="<"
L_CURL="{"
L_PAREN="("
L_ROTATE="<<>"
L_SHIFT="<<"
L_SQUARE="["
LABEL="label"
LET="let"
LOOP="loop"
LTE="<="
MINUS="-"
MODULE="module"
NEQ="!="
NOT="not"
NULL="null"
OBJECT="object"
OR="or"
PERCENT="%"
PIPE="|"
PLUS="+"
POINT="."
POW="**"
PRIVATE="private"
PUBLIC="public"
QUERY="query"
R_ANGLE=">"
R_CURL="}"
R_PAREN=")"
R_ROTATE="<>>"
R_SHIFT=">>"
R_SQUARE="]"
RETURN="return"
SEMI=";"
SHARED="shared"
SLASH="/"
STABLE="stable"
STAR="*"
SWITCH="switch"
SYSTEM="system"
TRUE="true"
TRY="try"
TYPE="type"
TYPE_CONSTRAINT="<:"
UNDERSCORE="_"
VAR="var"
WHILE="while"
WRAPPING_ADD="+%"
WRAPPING_SUB="-%"
WRAPPING_MUL="*%"
WRAPPING_POW="**%"

%state WAITING_VALUE

%%

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<YYINITIAL> {
    // comments
    {LINE_COMMENT}            { yybegin(YYINITIAL); return MotokoTypes.LINE_COMMENT; }
    {BLOCK_COMMENT}           { yybegin(YYINITIAL); return MotokoTypes.BLOCK_COMMENT; }

    // literals
    {CHAR}                    { yybegin(YYINITIAL); return MotokoTypes.CHAR; }
    {TEXT}                    { yybegin(YYINITIAL); return MotokoTypes.TEXT; }
    {FLOAT}                   { yybegin(YYINITIAL); return MotokoTypes.FLOAT; }
    {NAT}                     { yybegin(YYINITIAL); return MotokoTypes.NAT; }

    // keywords
    {ACTOR}                   { yybegin(YYINITIAL); return MotokoTypes.ACTOR; }
    {BANG}                    { yybegin(YYINITIAL); return MotokoTypes.BANG; }
    {CLASS}                   { yybegin(YYINITIAL); return MotokoTypes.CLASS; }
    {ELSE}                    { yybegin(YYINITIAL); return MotokoTypes.ELSE; }
    {FALSE}                   { yybegin(YYINITIAL); return MotokoTypes.FALSE; }
    {FOR}                     { yybegin(YYINITIAL); return MotokoTypes.FOR; }
    {FUNC}                    { yybegin(YYINITIAL); return MotokoTypes.FUNC; }
    {HASH}                    { yybegin(YYINITIAL); return MotokoTypes.HASH; }
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
    {IN_PLACE_UPDATE}                               { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_UPDATE; }
    {IN_PLACE_ADD}                                  { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_ADD; }
    {IN_PLACE_SUBTRACT}                             { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_SUBTRACT; }
    {IN_PLACE_MULTIPLY}                             { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_MULTIPLY; }
    {IN_PLACE_DIVIDE}                               { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_DIVIDE; }
    {IN_PLACE_MODULO}                               { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_MODULO; }
    {IN_PLACE_EXPONENTIATION}                       { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_EXPONENTIATION; }
    {IN_PLACE_LOGICAL_AND}                          { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_LOGICAL_AND; }
    {IN_PLACE_LOGICAL_OR}                           { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_LOGICAL_OR; }
    {IN_PLACE_EXCLUSIVE_OR}                         { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_EXCLUSIVE_OR; }
    {IN_PLACE_SHIFT_LEFT}                           { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_SHIFT_LEFT; }
    {IN_PLACE_SHIFT_RIGHT}                          { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_SHIFT_RIGHT; }
    {IN_PLACE_ROTATE_LEFT}                          { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_ROTATE_LEFT; }
    {IN_PLACE_ROTATE_RIGHT}                         { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_ROTATE_RIGHT; }
    {IN_PLACE_ADD_WRAP_ON_OVERFLOW}                 { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_ADD_WRAP_ON_OVERFLOW; }
    {IN_PLACE_SUBTRACT_WRAP_ON_OVERFLOW}            { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_SUBTRACT_WRAP_ON_OVERFLOW; }
    {IN_PLACE_MULTIPLY_WRAP_ON_OVERFLOW}            { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_MULTIPLY_WRAP_ON_OVERFLOW; }
    {IN_PLACE_EXPONENTIATION_WRAP_ON_OVERFLOW}      { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_EXPONENTIATION_WRAP_ON_OVERFLOW; }
    {IN_PLACE_CONCATENATION}                        { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_CONCATENATION; }

    {WRAPPING_ADD}             { yybegin(YYINITIAL); return MotokoTypes.WRAPPING_ADD; }
    {WRAPPING_MUL}             { yybegin(YYINITIAL); return MotokoTypes.WRAPPING_MUL; }
    {WRAPPING_POW}             { yybegin(YYINITIAL); return MotokoTypes.WRAPPING_POW; }
    {WRAPPING_SUB}             { yybegin(YYINITIAL); return MotokoTypes.WRAPPING_SUB; }

    {L_ROTATE}                { yybegin(YYINITIAL); return MotokoTypes.L_ROTATE; }
    {R_ROTATE}                { yybegin(YYINITIAL); return MotokoTypes.R_ROTATE; }

    {L_SHIFT}                 { yybegin(YYINITIAL); return MotokoTypes.L_SHIFT; }
    {R_SHIFT}                 { yybegin(YYINITIAL); return MotokoTypes.R_SHIFT; }

    {POW}                     { yybegin(YYINITIAL); return MotokoTypes.POW; }

    {TYPE_CONSTRAINT}         { yybegin(YYINITIAL); return MotokoTypes.TYPE_CONSTRAINT; }

    {AMPERSAND}               { yybegin(YYINITIAL); return MotokoTypes.AMPERSAND; }
    {AND}                     { yybegin(YYINITIAL); return MotokoTypes.AND; }
    {CARRET}                  { yybegin(YYINITIAL); return MotokoTypes.CARRET; }
    {COLUMN}                  { yybegin(YYINITIAL); return MotokoTypes.COLUMN; }
    {COMA}                    { yybegin(YYINITIAL); return MotokoTypes.COMA; }
    {EQEQ}                    { yybegin(YYINITIAL); return MotokoTypes.EQEQ; }
    {L_ANGLE}                 { yybegin(YYINITIAL); return MotokoTypes.L_ANGLE; }
    {L_CURL}                  { yybegin(YYINITIAL); return MotokoTypes.L_CURL; }
    {L_PAREN}                 { yybegin(YYINITIAL); return MotokoTypes.L_PAREN; }
    {L_SQUARE}                { yybegin(YYINITIAL); return MotokoTypes.L_SQUARE; }
    {MINUS}                   { yybegin(YYINITIAL); return MotokoTypes.MINUS; }
    {OR}                      { yybegin(YYINITIAL); return MotokoTypes.OR; }
    {PERCENT}                 { yybegin(YYINITIAL); return MotokoTypes.PERCENT; }
    {PIPE}                    { yybegin(YYINITIAL); return MotokoTypes.PIPE; }
    {PLUS}                    { yybegin(YYINITIAL); return MotokoTypes.PLUS; }
    {POINT}                   { yybegin(YYINITIAL); return MotokoTypes.POINT; }
    {QUERY}                   { yybegin(YYINITIAL); return MotokoTypes.QUERY; }
    {R_ANGLE}                 { yybegin(YYINITIAL); return MotokoTypes.R_ANGLE; }
    {R_CURL}                  { yybegin(YYINITIAL); return MotokoTypes.R_CURL; }
    {R_PAREN}                 { yybegin(YYINITIAL); return MotokoTypes.R_PAREN; }
    {R_SQUARE}                { yybegin(YYINITIAL); return MotokoTypes.R_SQUARE; }
    {SEMI}                    { yybegin(YYINITIAL); return MotokoTypes.SEMI; }
    {SLASH}                   { yybegin(YYINITIAL); return MotokoTypes.SLASH; }
    {STAR}                    { yybegin(YYINITIAL); return MotokoTypes.STAR; }


    // identifiers
    {ID}                      { yybegin(YYINITIAL); return MotokoTypes.ID; }
}

({CRLF}|{WHITE_SPACE})+       { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                           { return TokenType.BAD_CHARACTER; }
