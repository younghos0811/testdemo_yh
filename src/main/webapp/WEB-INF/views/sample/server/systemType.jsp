<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    M-Doumi 프로젝트는 동일한 소스를 기반으로 여신(Loan), 기안(Draft) 두 개의 시스템으로
    개발 및 운영이 되어진다. 현재 소스가 실행되는 서버가 여신 또는 기안 시스템인지 식별하는
    방법을 설명한다.
  </p>
</blockquote>
<p>
  여신, 기안의 구분은 WAS가 구동될 때 JVM옵션으로 전달이된다. 개발 환경에서 JVM옵션을 주는 방법은
</p>
<ul>
  <li>Boot Dashboard</li>
  <li>마우스 오른쪽 버튼 Open Config 클릭</li>
  <li>Arguments 탭 클릭</li>
  <li>VM arguments 에 -Dmdoumi.system.type=D 입력 (기안=D, 여신=L)</li>
  <li>Apply 클릭</li>
</ul>
<img src="/img/sample/server/system-types.gif" class="img-responsive center-block">
<p>
  -Dmdoumi.system.type 의 값을 D(기안), L(여신) 으로 변경하면서 개발을 진행하면 된다.
</p>
<p>
  프레임워크에서는 비즈니스 개발 코드서 시스템타입을 쉽게 접근할 수 있는 방법을 제공한다.
  시스템타입을 사용하기 위해서는
</p>
<ul>
  <li>모든 모델 클래스는 <kbd>Domain</kbd> 클래스를 상속받는다.</li>
  <li>모든 검색 조건(SearchCriteria) 클래스는 <kbd>DataTablesInput</kbd> 클래스를 상속받는다.</li>
</ul>
<pre><code class="java">public class Employee extends Domain {
.....
....
...
}</code></pre>
<pre><code class="java">public class EmployeeSearchCriteria extends DataTablesInput {
.....
....
...
}</code></pre>
<p>
  위 클래스들을 상속받으면 <kbd>getSystemType()</kbd> 메서드를 통해 시스템타입을 리턴 받을 수 있다.
  만약 <kbd>Domain</kbd> 또는 <kbd>DataTablesInput</kbd> 클래스를 상속받지 못하는 곳에서는
  <kbd>SystemType.get()</kbd> static 메서드를 호출하여 시스템타입을 리턴 받을 수 있으므로
  상황에 맞게 사용하면 된다.
</p>
<pre><code class="java">public class EmployeeService {
    public void addEmployee(Employee employee) {
        String systemType = SystemType.get();
    }
}</code></pre>