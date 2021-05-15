package org.intellij.sdk.language;

import com.intellij.openapi.fileTypes.LanguageFileType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;

public class MotokoFileType extends LanguageFileType {

  public static final MotokoFileType INSTANCE = new MotokoFileType();

  private MotokoFileType() {
    super(MotokoLanguage.INSTANCE);
  }

  @NotNull
  @Override
  public String getName() {
    return "Motoko File";
  }

  @NotNull
  @Override
  public String getDescription() {
    return "Motoko language file";
  }

  @NotNull
  @Override
  public String getDefaultExtension() {
    return "mo";
  }

  @Nullable
  @Override
  public Icon getIcon() {
    return MotokoIcons.FILE;
  }

}
