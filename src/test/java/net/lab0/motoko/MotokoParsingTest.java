package net.lab0.motoko;

import com.intellij.testFramework.ParsingTestCase;
import org.junit.Ignore;

@Ignore("Need to write all the grammar first")
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

    public void testImportsMustBeAtTheBeginning() {
        doTest(false, false);

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
