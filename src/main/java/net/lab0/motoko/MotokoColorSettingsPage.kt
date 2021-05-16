package net.lab0.motoko

import com.intellij.openapi.editor.colors.TextAttributesKey
import com.intellij.openapi.fileTypes.SyntaxHighlighter
import com.intellij.openapi.options.colors.AttributesDescriptor
import com.intellij.openapi.options.colors.ColorDescriptor
import com.intellij.openapi.options.colors.ColorSettingsPage
import net.lab0.motoko.MotokoSyntaxHighlighter.Companion.IDENTIFIER
import net.lab0.motoko.MotokoSyntaxHighlighter.Companion.KEYWORD
import net.lab0.motoko.MotokoSyntaxHighlighter.Companion.LINE_COMMENTS
import net.lab0.motoko.MotokoSyntaxHighlighter.Companion.NUMBER
import net.lab0.motoko.MotokoSyntaxHighlighter.Companion.OPERATION_SIGN
import net.lab0.motoko.MotokoSyntaxHighlighter.Companion.TEXT
import javax.swing.Icon

class MotokoColorSettingsPage : ColorSettingsPage {
  override fun getIcon(): Icon? {
    return MotokoIcons.FILE
  }

  override fun getHighlighter(): SyntaxHighlighter {
    return MotokoSyntaxHighlighter()
  }

  override fun getDemoText(): String {
    return """
import Example "./example";

// single line comment
module {
  func f(x: UserId, y: UserId): Bool { false };
  
  public class Class {
  };
  
  type NewProfile = Types.NewProfile;
  var x0 = null;
  let x1 = 1 == 2;
}
""".trimIndent()
  }

  override fun getAdditionalHighlightingTagToDescriptorMap(): Map<String, TextAttributesKey>? {
    return null
  }

  override fun getAttributeDescriptors(): Array<AttributesDescriptor> {
    return DESCRIPTORS
  }

  override fun getColorDescriptors(): Array<ColorDescriptor> {
    return ColorDescriptor.EMPTY_ARRAY
  }

  override fun getDisplayName(): String {
    return "Motoko"
  }

  companion object {
    private val DESCRIPTORS = arrayOf(
      AttributesDescriptor("Line Comments", LINE_COMMENTS),
      AttributesDescriptor("Keyword", KEYWORD),
      AttributesDescriptor("Number", NUMBER),
      AttributesDescriptor("Identifier", IDENTIFIER),
      AttributesDescriptor("Operation Sign", OPERATION_SIGN),
      AttributesDescriptor("Text", TEXT)
    )
  }
}
