package net.lab0.motoko

import com.intellij.lexer.Lexer
import com.intellij.openapi.editor.DefaultLanguageHighlighterColors
import com.intellij.openapi.editor.colors.TextAttributesKey
import com.intellij.openapi.fileTypes.SyntaxHighlighterBase
import com.intellij.psi.tree.IElementType
import net.lab0.motoko.psi.MotokoTypes

class MotokoSyntaxHighlighter : SyntaxHighlighterBase() {
  override fun getHighlightingLexer(): Lexer {
    return MotokoLexerAdapter()
  }

  override fun getTokenHighlights(tokenType: IElementType): Array<TextAttributesKey> {
    return when (tokenType) {
      MotokoTypes.ID -> IDENTIFIER_KEYS
      MotokoTypes.TEXT -> TEXT_KEYS
      in LINE_COMMENT -> COMMENT_KEYS
      in KEYWORDS -> KEYWORD_KEYS
      in NUMBERS -> NUMBER_KEYS
      in OPERATION_SIGNS -> OPERATION_SIGN_KEYS
      else -> EMPTY_KEYS
    }
  }

  companion object {
    val LINE_COMMENT = listOf(
      MotokoTypes.LINE_COMMENT,
    )

    val KEYWORDS = listOf(
      MotokoTypes.ACTOR,
      MotokoTypes.CLASS,
      MotokoTypes.ELSE,
      MotokoTypes.FALSE,
      MotokoTypes.FLEXIBLE,
      MotokoTypes.FOR,
      MotokoTypes.FUNC,
      MotokoTypes.IF,
      MotokoTypes.IN,
      MotokoTypes.IMPORT,
      MotokoTypes.LET,
      MotokoTypes.MODULE,
      MotokoTypes.NULL,
      MotokoTypes.OBJECT,
      MotokoTypes.PRIVATE,
      MotokoTypes.PUBLIC,
      MotokoTypes.QUERY,
      MotokoTypes.SHARED,
      MotokoTypes.STABLE,
      MotokoTypes.SYSTEM,
      MotokoTypes.TRUE,
      MotokoTypes.TYPE,
      MotokoTypes.VAR,
    )

    val NUMBERS = listOf(
      MotokoTypes.NAT,
    )

    val OPERATION_SIGNS = listOf(
      MotokoTypes.COMA,
      MotokoTypes.EQ,
      MotokoTypes.EQEQ,
      MotokoTypes.GTE,
      MotokoTypes.LTE,
      MotokoTypes.L_ANGLE,
      MotokoTypes.L_CURL,
      MotokoTypes.L_PAREN,
      MotokoTypes.L_SQUARE,
      MotokoTypes.NAT,
      MotokoTypes.NEQ,
      MotokoTypes.R_ANGLE,
      MotokoTypes.R_CURL,
      MotokoTypes.R_PAREN,
      MotokoTypes.R_SQUARE,
      MotokoTypes.SEMI,
      MotokoTypes.UNDERSCORE,
    )

    val LINE_COMMENTS = TextAttributesKey.createTextAttributesKey(
      "LINE_COMMENT",
      DefaultLanguageHighlighterColors.LINE_COMMENT
    )

    val KEYWORD = TextAttributesKey.createTextAttributesKey(
      "KEYWORD",
      DefaultLanguageHighlighterColors.KEYWORD
    )

    val IDENTIFIER = TextAttributesKey.createTextAttributesKey(
      "IDENTIFIER",
      DefaultLanguageHighlighterColors.IDENTIFIER
    )

    val NUMBER = TextAttributesKey.createTextAttributesKey(
      "NUMBER",
      DefaultLanguageHighlighterColors.NUMBER
    )

    val OPERATION_SIGN = TextAttributesKey.createTextAttributesKey(
      "OPERATION_SIGN",
      DefaultLanguageHighlighterColors.OPERATION_SIGN
    )

    val TEXT = TextAttributesKey.createTextAttributesKey(
      "TEXT",
      DefaultLanguageHighlighterColors.STRING
    )

    private val COMMENT_KEYS = arrayOf(LINE_COMMENTS)
    private val KEYWORD_KEYS = arrayOf(KEYWORD)
    private val IDENTIFIER_KEYS = arrayOf(IDENTIFIER)
    private val NUMBER_KEYS = arrayOf(NUMBER)
    private val OPERATION_SIGN_KEYS = arrayOf(OPERATION_SIGN)
    private val TEXT_KEYS = arrayOf(TEXT)
    private val EMPTY_KEYS = arrayOf<TextAttributesKey>()
  }
}
