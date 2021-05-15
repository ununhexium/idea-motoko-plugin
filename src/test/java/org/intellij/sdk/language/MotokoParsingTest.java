package org.intellij.sdk.language;

import com.intellij.testFramework.ParsingTestCase;

public class MotokoParsingTest extends ParsingTestCase {

    public MotokoParsingTest() {
        super("", "mo", new MotokoParserDefinition());
    }

    public void testSingleImport() {
        doTest(true);
    }

    public void testMultipleImports() {
        doTest(true);
    }

    public void testDeclareSingleVariable() {
        doTest(true);
    }

    public void testDeclareMultipleVariables() {
        doTest(true);
    }
    
    /**
     * @return path to test data file directory relative to root of this module.
     */
    @Override
    protected String getTestDataPath() {
        return "src/test/testData";
    }

    @Override
    protected boolean skipSpaces() {
        return false;
    }

    @Override
    protected boolean includeRanges() {
        return true;
    }

}
