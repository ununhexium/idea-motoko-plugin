package org.intellij.sdk.language.psi;

import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.psi.FileViewProvider;
import org.intellij.sdk.language.MotokoFileType;
import org.intellij.sdk.language.MotokoLanguage;
import org.jetbrains.annotations.NotNull;

public class MotokoFile extends PsiFileBase {

  public MotokoFile(@NotNull FileViewProvider viewProvider) {
    super(viewProvider, MotokoLanguage.INSTANCE);
  }

  @NotNull
  @Override
  public FileType getFileType() {
    return MotokoFileType.INSTANCE;
  }

  @Override
  public String toString() {
    return "Motoko File";
  }

}
