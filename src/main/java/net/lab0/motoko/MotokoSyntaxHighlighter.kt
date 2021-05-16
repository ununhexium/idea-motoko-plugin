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
      in KEYWORDS -> KEYWORD_KEYS
      in OPERATION_SIGNS -> OPERATION_SIGN_KEYS
      else -> EMPTY_KEYS
    }
  }

  companion object {
    val KEYWORDS = listOf(
      MotokoTypes.ACTOR,
      MotokoTypes.FALSE,
      MotokoTypes.FLEXIBLE,
      MotokoTypes.FUNC,
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

    val OPERATION_SIGNS = listOf(
      MotokoTypes.COMA,
      MotokoTypes.EQ,
      MotokoTypes.EQEQ,
      MotokoTypes.GTE,
      MotokoTypes.LTE,
      MotokoTypes.L_ANGLE,
      MotokoTypes.L_CURL,
      MotokoTypes.L_PAREN,
      MotokoTypes.NAT,
      MotokoTypes.NEQ,
      MotokoTypes.R_ANGLE,
      MotokoTypes.R_CURL,
      MotokoTypes.R_PAREN,
      MotokoTypes.SEMI,
      MotokoTypes.UNDERSCORE,
    )

    val KEYWORD = TextAttributesKey.createTextAttributesKey(
      "KEYWORD",
      DefaultLanguageHighlighterColors.KEYWORD
    )

    val IDENTIFIER = TextAttributesKey.createTextAttributesKey(
      "IDENTIFIER",
      DefaultLanguageHighlighterColors.IDENTIFIER
    )

    val OPERATION_SIGN = TextAttributesKey.createTextAttributesKey(
      "OPERATION_SIGN",
      DefaultLanguageHighlighterColors.OPERATION_SIGN
    )

    val TEXT = TextAttributesKey.createTextAttributesKey(
      "TEXT",
      DefaultLanguageHighlighterColors.STRING
    )

    private val KEYWORD_KEYS = arrayOf(KEYWORD)
    private val IDENTIFIER_KEYS = arrayOf(IDENTIFIER)
    private val OPERATION_SIGN_KEYS = arrayOf(OPERATION_SIGN)
    private val TEXT_KEYS = arrayOf(TEXT)
    private val EMPTY_KEYS = arrayOf<TextAttributesKey>()
  }
}
