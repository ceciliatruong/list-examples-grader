import static org.junit.Assert.*;

import java.util.Arrays;
import java.util.List;

import org.junit.*;

public class TestListExamples {
  // Write your grading tests here!
  @Test
  public void testMerge() {
      List<String> list1 = Arrays.asList("ab", "donut", "orange");
      List<String> list2 = Arrays.asList("a", "donut", "ornge");
      assertEquals(Arrays.asList("a", "ab", "donut", "donut", "orange", "ornge"), ListExamples.merge(list1, list2));
  }
  @Test
  public void testFilter() {
      StringChecker newChecker = new StringChecker() {
          @Override
          public boolean checkString(String s) {
              if(s.length() > 1) {
                  return true;
              }
              else {
                  return false;
              }
          }
      };
      List<String> list1 = Arrays.asList("donut", "orange");
      List<String> list2 = Arrays.asList("a", "donut", "orange");
      list2 = ListExamples.filter(list2, newChecker);
      assertEquals(list1, list2);
  }
}
