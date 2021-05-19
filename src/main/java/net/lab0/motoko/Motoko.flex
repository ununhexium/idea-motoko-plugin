
package net.lab0.motoko;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import net.lab0.motoko.psi.MotokoTypes;
import com.intellij.psi.TokenType;

import java.util.LinkedList;

%%

%class MotokoLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%{

private final LinkedList<Integer> states = new LinkedList<>();

private void yypushstate(int state) {
    states.addFirst(yystate());
    yybegin(state);
}

private void yypopstate() {
    final int state = states.removeFirst();
    yybegin(state);
}

%}

%eof{  return;
%eof}

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
// TODO: doc comments
LINE_COMMENT="//"[^\r\n]*
DOC_COMMENT="/// "[^\r\n]*
BLOCK_COMMENT_START="/*"
BLOCK_COMMENT_END="*/"

//ascii ::= ['\x00'-'\x7f']
ASCII=[\x00-\x7f]

//ascii_no_nl ::= ['\x00'-'\x09''\x0b'-'\x7f']
ASCII_NO_NL=[[\x00-\x7f] -- \n ]

//utf8cont ::= ['\x80'-'\xbf']
UTF8CONT=[\x80-\xbf]

//utf8enc ::=
//    ['\xc2'-'\xdf'] utf8cont
//  | ['\xe0'] ['\xa0'-'\xbf'] utf8cont
//  | ['\xed'] ['\x80'-'\x9f'] utf8cont
//  | ['\xe1'-'\xec''\xee'-'\xef'] utf8cont utf8cont
//  | ['\xf0'] ['\x90'-'\xbf'] utf8cont utf8cont
//  | ['\xf4'] ['\x80'-'\x8f'] utf8cont utf8cont
//  | ['\xf1'-'\xf3'] utf8cont utf8cont utf8cont
UTF8ENC=  [\xc2-\xdf] {UTF8CONT}
    | [\xe0] [\xa0-\xbf] {UTF8CONT}
    | [\xed] [\x80-\x9f] {UTF8CONT}
    | [\xe1-\xec\xee-\xef] {UTF8CONT} {UTF8CONT}
    | [\xf0] [\x90-\xbf] {UTF8CONT} {UTF8CONT}
    | [\xf4] [\x80-\x8f] {UTF8CONT} {UTF8CONT}
    | [\xf1-\xf3] {UTF8CONT} {UTF8CONT} {UTF8CONT}

//utf8 ::= ascii | utf8enc
UTF8={ASCII} | {UTF8ENC}

//escape ::= ['n''r''t''\\''\'''\"']
ESCAPE=["n" "r" "t" "'" \" \\]

//character ::=
//  | [^'"''\\''\x00'-'\x1f''\x7f'-'\xff']
//  | utf8enc
//  | '\\'escape
//  | '\\'hexdigit hexdigit
//  | "\\u{" hexnum '}'

CHARACTER=
    [\x20 \x21 \x23-\x5b \x5d-\x7e]
  | {UTF8ENC}
  | \\{ESCAPE}
  | \\{HEXDIGIT} {HEXDIGIT}
  | \\"u{" {HEXNUM} "}"

//char := '\'' character '\''
CHAR="'" {CHARACTER} "'"

TEXT=\" ({CHARACTER})* \"

// <id>   ::= Letter (Letter | Digit | _)*
// Letter ::= A..Z | a..z
// Digit  ::= 0..9
LETTER=[a-zA-Z]
DIGIT=[0-9]
ID={LETTER} ({LETTER}|{DIGIT}|{UNDERSCORE})*

//hexdigit ::= ['0'-'9''a'-'f''A'-'F']
HEXDIGIT=[[0-9]||[a-f]||[A-F]]
//num ::= digit ('_'? digit)*
NUM={DIGIT} ({UNDERSCORE}? {DIGIT})*
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
ARROW="->"
ASSERT="assert"
ASYNC="async"      // TODO: not in the keywords list?
AWAIT="await"
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
DO="do"             // TODO: not in keywords?
ELSE="else"
EQ="="
EQEQ="=="
EXCLAMATION="!"
FALSE="false"
FLEXIBLE="flexible"
FOR="for"
FUNC="func"
GT=" > "
GTE=">="
HASH="#"
IF="if"
IGNORE="ignore"
IMPORT="import"
IN="in"
IN_PLACE_ADD="+="
IN_PLACE_ADD_WRAP_ON_OVERFLOW="+%="
IN_PLACE_CONCATENATION="#="
IN_PLACE_DIVIDE="/="
IN_PLACE_EXCLUSIVE_OR="^="
IN_PLACE_EXPONENTIATION="**="
IN_PLACE_EXPONENTIATION_WRAP_ON_OVERFLOW="**%="
IN_PLACE_LOGICAL_AND="&="
IN_PLACE_LOGICAL_OR="|="
IN_PLACE_MODULO="%="
IN_PLACE_MULTIPLY="*="
IN_PLACE_MULTIPLY_WRAP_ON_OVERFLOW="*%="
IN_PLACE_ROTATE_LEFT="<<>="
IN_PLACE_ROTATE_RIGHT="<>>="
IN_PLACE_SHIFT_LEFT="<<="
IN_PLACE_SHIFT_RIGHT=">>="
IN_PLACE_SUBTRACT="-="
IN_PLACE_SUBTRACT_WRAP_ON_OVERFLOW="-%="
IN_PLACE_UPDATE=":="
LABEL="label"
LET="let"
LOOP="loop"
LT=" < "
LTE="<="
L_ANGLE="<"
L_CURL="{"
L_PAREN="("
L_ROTATE="<<>"
L_SHIFT="<<"
L_SQUARE="["
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
QUESTION="?"
RETURN="return"
R_ANGLE=">"
R_CURL="}"
R_PAREN=")"
R_ROTATE="<>>"
R_SHIFT=" >>"
R_SQUARE="]"
SEMI=";"
SHARED="shared"
SLASH="/"
STABLE="stable"
STAR="*"
SWITCH="switch"
SYSTEM="system"
THROW="throw"              // TODO: not in the keywords?
TRUE="true"
TRY="try"
TYPE="type"
TYPE_CONSTRAINT="<:"
UNDERSCORE="_"
VAR="var"
WHILE="while"
WRAPPING_ADD="+%"
WRAPPING_MUL="*%"
WRAPPING_POW="**%"
WRAPPING_SUB="-%"

%state WAITING_VALUE
%xstate IN_BLOCK_COMMENT
%state IN_DOC_COMMENT

%%

// https://stackoverflow.com/questions/24666688/jflex-match-nested-comments-as-one-token
"/*"                           { yypushstate(IN_BLOCK_COMMENT); return MotokoTypes.BLOCK_COMMENT; }

<IN_BLOCK_COMMENT> {
  {BLOCK_COMMENT_START}        { yypushstate(IN_BLOCK_COMMENT); return MotokoTypes.BLOCK_COMMENT; }
  [^\*\\/]*                    { return MotokoTypes.BLOCK_COMMENT; }
  {BLOCK_COMMENT_END}          { yypopstate(); return MotokoTypes.BLOCK_COMMENT; }
  [\*\\/]                      { return MotokoTypes.BLOCK_COMMENT; }
  .                            { return MotokoTypes.BAD_CHARACTER; }
}
//
//<IN_DOC_COMMENT> {
//  "@deprecated"                { yybegin(YYINITIAL); return MotokoTypes.DEPRECATED; }
//}

<WAITING_VALUE> {
    {CRLF}({CRLF}|{WHITE_SPACE})+                 { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }
    {WHITE_SPACE}+                                { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }
}

<YYINITIAL> {
    // comments
    {DOC_COMMENT}             { yybegin(YYINITIAL); return MotokoTypes.DOC_COMMENT; }
    {LINE_COMMENT}            { yybegin(YYINITIAL); return MotokoTypes.LINE_COMMENT; }

    // literals
    {TEXT}                    { yybegin(YYINITIAL); return MotokoTypes.TEXT; }
    {CHAR}                    { yybegin(YYINITIAL); return MotokoTypes.CHAR; }
    {FLOAT}                   { yybegin(YYINITIAL); return MotokoTypes.FLOAT; }
    {NAT}                     { yybegin(YYINITIAL); return MotokoTypes.NAT; }

    // keywords
    {ACTOR}                   { yybegin(YYINITIAL); return MotokoTypes.ACTOR; }
    {ASSERT}                  { yybegin(YYINITIAL); return MotokoTypes.ASSERT; }
    {ASYNC}                   { yybegin(YYINITIAL); return MotokoTypes.ASYNC; }
    {AWAIT}                   { yybegin(YYINITIAL); return MotokoTypes.AWAIT; }
    {BREAK}                   { yybegin(YYINITIAL); return MotokoTypes.BREAK; }
    {CASE}                    { yybegin(YYINITIAL); return MotokoTypes.CASE; }
    {CATCH}                   { yybegin(YYINITIAL); return MotokoTypes.CATCH; }
    {CLASS}                   { yybegin(YYINITIAL); return MotokoTypes.CLASS; }
    {DO}                      { yybegin(YYINITIAL); return MotokoTypes.DO; }
    {ELSE}                    { yybegin(YYINITIAL); return MotokoTypes.ELSE; }
    {FALSE}                   { yybegin(YYINITIAL); return MotokoTypes.FALSE; }
    {FOR}                     { yybegin(YYINITIAL); return MotokoTypes.FOR; }
    {FUNC}                    { yybegin(YYINITIAL); return MotokoTypes.FUNC; }
    {HASH}                    { yybegin(YYINITIAL); return MotokoTypes.HASH; }
    {IF}                      { yybegin(YYINITIAL); return MotokoTypes.IF; }
    {IGNORE}                  { yybegin(YYINITIAL); return MotokoTypes.IGNORE; }
    {IN}                      { yybegin(YYINITIAL); return MotokoTypes.IN; }
    {IMPORT}                  { yybegin(YYINITIAL); return MotokoTypes.IMPORT; }
    {LABEL}                   { yybegin(YYINITIAL); return MotokoTypes.LABEL; }
    {LET}                     { yybegin(YYINITIAL); return MotokoTypes.LET; }
    {LOOP}                    { yybegin(YYINITIAL); return MotokoTypes.LOOP; }
    {MODULE}                  { yybegin(YYINITIAL); return MotokoTypes.MODULE; }
    {NULL}                    { yybegin(YYINITIAL); return MotokoTypes.NULL; }
    {NOT}                     { yybegin(YYINITIAL); return MotokoTypes.NOT; }
    {OBJECT}                  { yybegin(YYINITIAL); return MotokoTypes.OBJECT; }
    {PRIVATE}                 { yybegin(YYINITIAL); return MotokoTypes.PRIVATE; }
    {PUBLIC}                  { yybegin(YYINITIAL); return MotokoTypes.PUBLIC; }
    {SHARED}                  { yybegin(YYINITIAL); return MotokoTypes.SHARED; }
    {SWITCH}                  { yybegin(YYINITIAL); return MotokoTypes.SWITCH; }
    {SYSTEM}                  { yybegin(YYINITIAL); return MotokoTypes.SYSTEM; }
    {THROW}                   { yybegin(YYINITIAL); return MotokoTypes.THROW; }
    {TRUE}                    { yybegin(YYINITIAL); return MotokoTypes.TRUE; }
    {TRY}                     { yybegin(YYINITIAL); return MotokoTypes.TRY; }
    {TYPE}                    { yybegin(YYINITIAL); return MotokoTypes.TYPE; }
    {VAR}                     { yybegin(YYINITIAL); return MotokoTypes.VAR; }
    {WHILE}                   { yybegin(YYINITIAL); return MotokoTypes.WHILE; }

    // symbols
    // TODO: could be simplified by using binop + '=' in the parser
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

     // Hacks, see GT / LT
    " "*{IN_PLACE_SHIFT_LEFT}                       { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_SHIFT_LEFT; }
    " "*{IN_PLACE_SHIFT_RIGHT}                      { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_SHIFT_RIGHT; }
    " "*{IN_PLACE_ROTATE_LEFT}                      { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_ROTATE_LEFT; }
    " "*{IN_PLACE_ROTATE_RIGHT}                     { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_ROTATE_RIGHT; }
    {IN_PLACE_ADD_WRAP_ON_OVERFLOW}                 { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_ADD_WRAP_ON_OVERFLOW; }
    {IN_PLACE_SUBTRACT_WRAP_ON_OVERFLOW}            { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_SUBTRACT_WRAP_ON_OVERFLOW; }
    {IN_PLACE_MULTIPLY_WRAP_ON_OVERFLOW}            { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_MULTIPLY_WRAP_ON_OVERFLOW; }
    {IN_PLACE_EXPONENTIATION_WRAP_ON_OVERFLOW}      { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_EXPONENTIATION_WRAP_ON_OVERFLOW; }
    {IN_PLACE_CONCATENATION}                        { yybegin(YYINITIAL); return MotokoTypes.IN_PLACE_CONCATENATION; }

    {WRAPPING_ADD}             { yybegin(YYINITIAL); return MotokoTypes.WRAPPING_ADD; }
    {WRAPPING_MUL}             { yybegin(YYINITIAL); return MotokoTypes.WRAPPING_MUL; }
    {WRAPPING_POW}             { yybegin(YYINITIAL); return MotokoTypes.WRAPPING_POW; }
    {WRAPPING_SUB}             { yybegin(YYINITIAL); return MotokoTypes.WRAPPING_SUB; }

    " "*{L_ROTATE}                { yybegin(YYINITIAL); return MotokoTypes.L_ROTATE; }
    {R_ROTATE}                { yybegin(YYINITIAL); return MotokoTypes.R_ROTATE; }

    // Hack, see GT / LT
    " "*{L_SHIFT}                 { yybegin(YYINITIAL); return MotokoTypes.L_SHIFT; }
    {R_SHIFT}                 { yybegin(YYINITIAL); return MotokoTypes.R_SHIFT; }

    {POW}                     { yybegin(YYINITIAL); return MotokoTypes.POW; }

    {TYPE_CONSTRAINT}         { yybegin(YYINITIAL); return MotokoTypes.TYPE_CONSTRAINT; }

    // comparators
    {GTE}                     { yybegin(YYINITIAL); return MotokoTypes.GTE; }
    {LTE}                     { yybegin(YYINITIAL); return MotokoTypes.LTE; }
    /*
     /!\ Hack /!\

     JFlex will always use the longest match.
     Therefore we also take all the spaces arround the symbol to have a longer match than the whitespace macro.

     This is necessary to distinguish between an angle bracket that means less/more and
     an angle bracket that means generic typing.

     TODO: also grab tabs?
     */
    " "*{GT}" "*              { yybegin(YYINITIAL); return MotokoTypes.GT; }
    " "*{LT}" "*              { yybegin(YYINITIAL); return MotokoTypes.LT; }
    {NEQ}                     { yybegin(YYINITIAL); return MotokoTypes.NEQ; }
    {EQ}                      { yybegin(YYINITIAL); return MotokoTypes.EQ; }

    {ARROW}                   { yybegin(YYINITIAL); return MotokoTypes.ARROW; }

    {AMPERSAND}               { yybegin(YYINITIAL); return MotokoTypes.AMPERSAND; }
    {AND}                     { yybegin(YYINITIAL); return MotokoTypes.AND; }
    {EXCLAMATION}             { yybegin(YYINITIAL); return MotokoTypes.EXCLAMATION; }
    {CARRET}                  { yybegin(YYINITIAL); return MotokoTypes.CARRET; }
    {COLUMN}                  { yybegin(YYINITIAL); return MotokoTypes.COLUMN; }
    {COMA}                    { yybegin(YYINITIAL); return MotokoTypes.COMA; }
    {CONTINUE}                { yybegin(YYINITIAL); return MotokoTypes.CONTINUE; }
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
    {QUESTION}                { yybegin(YYINITIAL); return MotokoTypes.QUESTION; }
    {R_ANGLE}                 { yybegin(YYINITIAL); return MotokoTypes.R_ANGLE; }
    {R_CURL}                  { yybegin(YYINITIAL); return MotokoTypes.R_CURL; }
    {R_PAREN}                 { yybegin(YYINITIAL); return MotokoTypes.R_PAREN; }
    {R_SQUARE}                { yybegin(YYINITIAL); return MotokoTypes.R_SQUARE; }
    {RETURN}                  { yybegin(YYINITIAL); return MotokoTypes.RETURN; }
    {SEMI}                    { yybegin(YYINITIAL); return MotokoTypes.SEMI; }
    {SLASH}                   { yybegin(YYINITIAL); return MotokoTypes.SLASH; }
    {STABLE}                  { yybegin(YYINITIAL); return MotokoTypes.STABLE; }
    {STAR}                    { yybegin(YYINITIAL); return MotokoTypes.STAR; }
    {UNDERSCORE}              { yybegin(YYINITIAL); return MotokoTypes.UNDERSCORE; }


    // identifiers
    {ID}                      { yybegin(YYINITIAL); return MotokoTypes.ID; }
}

({CRLF}|{WHITE_SPACE})+       { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                           { return TokenType.BAD_CHARACTER; }
