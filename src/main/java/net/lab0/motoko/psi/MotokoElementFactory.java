package net.lab0.motoko.psi;

import com.intellij.openapi.project.Project;
import com.intellij.psi.PsiElement;
import com.intellij.psi.PsiFileFactory;
import net.lab0.motoko.MotokoFileType;

public class MotokoElementFactory {

  public static MotokoFile createFile(Project project, String text) {
    String name = "dummy.mo";
    return (MotokoFile) PsiFileFactory.getInstance(project).createFileFromText(name, MotokoFileType.INSTANCE, text);
  }

  public static PsiElement createCRLF(Project project) {
    final MotokoFile file = createFile(project, "\n");
    return file.getFirstChild();
  }

}
