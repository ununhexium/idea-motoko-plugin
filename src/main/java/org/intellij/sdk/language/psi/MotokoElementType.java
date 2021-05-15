package org.intellij.sdk.language.psi;

import com.intellij.psi.tree.IElementType;
import org.intellij.sdk.language.MotokoLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class MotokoElementType extends IElementType {

  public MotokoElementType(@NotNull @NonNls String debugName) {
    super(debugName, MotokoLanguage.INSTANCE);
  }

}
