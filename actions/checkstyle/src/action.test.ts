import { parseData } from "./action";
import { describe, expect, test } from "@jest/globals";
import { expectProblem } from "./problem.test";

const JOSM_SINGLE_EXAMPLE = `<?xml version="1.0" encoding="UTF-8"?>
<checkstyle version="9.3">
<file name="/Users/user/workspace/josm/core/test/unit/org/openstreetmap/josm/tools/bugreport/BugReportSenderTest.java">
</file>
<file name="/Users/user/workspace/josm/core/test/unit/org/openstreetmap/josm/tools/bugreport/BugReportTest.java">
<error line="141" column="101" severity="warning" message="&apos;}&apos; is not preceded with whitespace." source="com.puppycrawl.tools.checkstyle.checks.whitespace.WhitespaceAroundCheck"/>
</file>
</checkstyle>
`;

describe("Test action/parseData", () => {
  test("JOSM Sample XML, single file", () => {
    const problems = parseData(6, JOSM_SINGLE_EXAMPLE);
    expect(problems.length).toBe(1);
    expectProblem(
      {
        file: "test/unit/org/openstreetmap/josm/tools/bugreport/BugReportTest.java",
        column: 101,
        endColumn: 101,
        line: 141,
        endLine: 141,
        title:
          "com.puppycrawl.tools.checkstyle.checks.whitespace.WhitespaceAroundCheck",
        info: "'}'; is not preceded with whitespace.",
      },
      problems[0]
    );
  });
});
