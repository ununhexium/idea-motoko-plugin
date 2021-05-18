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
      in TEXTS -> TEXT_KEYS
      in COMMENTS -> COMMENT_KEYS
      in KEYWORDS -> KEYWORD_KEYS
      in NUMBERS -> NUMBER_KEYS
      in OPERATION_SIGNS -> OPERATION_SIGN_KEYS
      else -> EMPTY_KEYS
    }
  }

  companion object {
    val COMMENTS = listOf(
      MotokoTypes.LINE_COMMENT,
      MotokoTypes.BLOCK_COMMENT,
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
      MotokoTypes.FLOAT,
    )

    val OPERATION_SIGNS = listOf(
      MotokoTypes.AMPERSAND,
      MotokoTypes.AND,
      MotokoTypes.CARRET,
      MotokoTypes.COMA,
      MotokoTypes.EQ,
      MotokoTypes.EQEQ,
      MotokoTypes.GTE,
      MotokoTypes.HASH,
      MotokoTypes.IN_PLACE_UPDATE,
      MotokoTypes.IN_PLACE_ADD,
      MotokoTypes.IN_PLACE_SUBTRACT,
      MotokoTypes.IN_PLACE_MULTIPLY,
      MotokoTypes.IN_PLACE_DIVIDE,
      MotokoTypes.IN_PLACE_MODULO,
      MotokoTypes.IN_PLACE_EXPONENTIATION,
      MotokoTypes.IN_PLACE_LOGICAL_AND,
      MotokoTypes.IN_PLACE_LOGICAL_OR,
      MotokoTypes.IN_PLACE_EXCLUSIVE_OR,
      MotokoTypes.IN_PLACE_SHIFT_LEFT,
      MotokoTypes.IN_PLACE_SHIFT_RIGHT,
      MotokoTypes.IN_PLACE_ROTATE_LEFT,
      MotokoTypes.IN_PLACE_ROTATE_RIGHT,
      MotokoTypes.IN_PLACE_ADD_WRAP_ON_OVERFLOW,
      MotokoTypes.IN_PLACE_SUBTRACT_WRAP_ON_OVERFLOW,
      MotokoTypes.IN_PLACE_MULTIPLY_WRAP_ON_OVERFLOW,
      MotokoTypes.IN_PLACE_EXPONENTIATION_WRAP_ON_OVERFLOW,
      MotokoTypes.IN_PLACE_CONCATENATION,
      MotokoTypes.LTE,
      MotokoTypes.L_ANGLE,
      MotokoTypes.L_CURL,
      MotokoTypes.L_PAREN,
      MotokoTypes.L_ROTATE,
      MotokoTypes.L_SHIFT,
      MotokoTypes.L_SQUARE,
      MotokoTypes.MINUS,
      MotokoTypes.NAT,
      MotokoTypes.NEQ,
      MotokoTypes.OR,
      MotokoTypes.PERCENT,
      MotokoTypes.PIPE,
      MotokoTypes.PLUS,
      MotokoTypes.POW,
      MotokoTypes.R_ANGLE,
      MotokoTypes.R_CURL,
      MotokoTypes.R_PAREN,
      MotokoTypes.R_ROTATE,
      MotokoTypes.R_SHIFT,
      MotokoTypes.R_SQUARE,
      MotokoTypes.SEMI,
      MotokoTypes.SLASH,
      MotokoTypes.STAR,
      MotokoTypes.UNDERSCORE,
      MotokoTypes.WRAPPING_ADD,
      MotokoTypes.WRAPPING_MUL,
      MotokoTypes.WRAPPING_SUB,
      MotokoTypes.WRAPPING_POW,
    )

    val TEXTS = listOf(
      MotokoTypes.CHAR,
      MotokoTypes.TEXT,
    )

    val BLOCK_COMMENTS = TextAttributesKey.createTextAttributesKey(
      "BLOCK_COMMENT",
      DefaultLanguageHighlighterColors.BLOCK_COMMENT
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
