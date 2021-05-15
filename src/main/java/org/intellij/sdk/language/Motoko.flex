
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

DOUBLE_QUOTED_STRING=\"([^\\\"\r\n]|\\[^\r\n])*\"?
EQUAL="="
SEMI=";"
COLUMN=":"
IMPORT="import"
NULL="null"
VAR="var"
ID=[:jletter:] [:jletterdigit:]*

END_OF_LINE_COMMENT=("#"|"!")[^\r\n]*

%state WAITING_VALUE

%%

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<YYINITIAL> {
    {DOUBLE_QUOTED_STRING}    { yybegin(YYINITIAL); return MotokoTypes.STRING; }
    {EQUAL}                   { yybegin(YYINITIAL); return MotokoTypes.EQUAL; }
    {IMPORT}                  { yybegin(YYINITIAL); return MotokoTypes.IMPORT; }
    {NULL}                    { yybegin(YYINITIAL); return MotokoTypes.NULL; }
    {SEMI}                    { yybegin(YYINITIAL); return MotokoTypes.SEMI; }
    {VAR}                     { yybegin(YYINITIAL); return MotokoTypes.VAR; }

    {ID}                      { yybegin(YYINITIAL); return MotokoTypes.ID; }
}

({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }
