package org.intellij.sdk.language;

import com.intellij.lang.Language;

public class MotokoLanguage extends Language {

    public static final MotokoLanguage INSTANCE = new MotokoLanguage();

    private MotokoLanguage() {
        super("Motoko");
    }

}
