
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

COLUMN=":"
DOUBLE_QUOTED_STRING=\"([^\\\"\r\n]|\\[^\r\n])*\"?
EQUAL="="
FALSE="false"
ID=[:jletter:] [:jletterdigit:]*
IMPORT="import"
NULL="null"
SEMI=";"
TRUE="true"
VAR="var"

END_OF_LINE_COMMENT=("#"|"!")[^\r\n]*

%state WAITING_VALUE

%%

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<YYINITIAL> {
    // literals
    {DOUBLE_QUOTED_STRING}    { yybegin(YYINITIAL); return MotokoTypes.STRING; }

    // keywords
    {FALSE}                   { yybegin(YYINITIAL); return MotokoTypes.FALSE; }
    {IMPORT}                  { yybegin(YYINITIAL); return MotokoTypes.IMPORT; }
    {NULL}                    { yybegin(YYINITIAL); return MotokoTypes.NULL; }
    {TRUE}                    { yybegin(YYINITIAL); return MotokoTypes.TRUE; }
    {VAR}                     { yybegin(YYINITIAL); return MotokoTypes.VAR; }

    // symbols
    {EQUAL}                   { yybegin(YYINITIAL); return MotokoTypes.EQUAL; }
    {SEMI}                    { yybegin(YYINITIAL); return MotokoTypes.SEMI; }

    // identifiers
    {ID}                      { yybegin(YYINITIAL); return MotokoTypes.ID; }
}

({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }
