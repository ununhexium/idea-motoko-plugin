package net.lab0.motoko.psi;

import com.intellij.psi.tree.IElementType;
import net.lab0.motoko.MotokoLanguage;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

public class MotokoElementType extends IElementType {

  public MotokoElementType(@NotNull @NonNls String debugName) {
    super(debugName, MotokoLanguage.INSTANCE);
  }

}
