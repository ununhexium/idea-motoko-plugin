package org.intellij.sdk.language.psi.impl;

import com.intellij.extapi.psi.ASTWrapperPsiElement;
import com.intellij.lang.ASTNode;
import org.intellij.sdk.language.psi.MotokoNamedElement;
import org.jetbrains.annotations.NotNull;

public abstract class MotokoNamedElementImpl extends ASTWrapperPsiElement implements MotokoNamedElement {

  public MotokoNamedElementImpl(@NotNull ASTNode node) {
    super(node);
  }

}
