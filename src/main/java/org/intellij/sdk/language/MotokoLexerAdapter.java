package org.intellij.sdk.language;

import com.intellij.lexer.FlexAdapter;

public class MotokoLexerAdapter extends FlexAdapter {

  public MotokoLexerAdapter() {
    super(new MotokoLexer(null));
  }

}
