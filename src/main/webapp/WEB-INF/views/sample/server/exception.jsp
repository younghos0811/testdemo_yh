<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<p>
  Exception 처리는 웹 어플리케이션 개발에 있어서 흔히 간과되는 중요한 사항중의 하나로,
  일반적으로 개발자는 method내에서 Exception이 발생하면 try, catch 구문을 사용하여 Stack Trace를 출력하거나,
  발생한 Exception을 throw하는 method를 호출한다. 일반적으로 운영시스템에서 Exception은 사용자의 요청을
  시스템이 처리할 수 없을 때 발생하며, 이러한 Exception이 발생했을 때 사용자가 기대하는 바는 다음과 같다.
</p>
<ul>
  <li>에러가 발생했음을 표시하는 메시지</li>
  <li>고객 지원 요청시 사용할 수 있는 고유한 에러 식별자</li>
  <li>문제에 대한 빠른 해결책</li>
</ul>
<p>
  이를 위해, 다음과 같이 간략한 구조의 Exception 처리 방법을 가이드 한다.
</p>
<img src="/img/sample/server/exception.gif" class="img-responsive center-block">
<p>
  위의 그림에서와 같이, Client의 요청을 처리하기 위해 해당 서비스의 비즈니스 오퍼레이션을
  호출하는 Controller, 비즈니스 오퍼레이션을 구현하고 있는 서비스, 데이터 액세스 로직을 구현하고
  있는 Repository에 대한 Exception 처리가 필요하다.
  Exception 처리시에는 불필요한 try ~ catch 절이 반복되지 않도록 주의해야 한다.
  따라서, 발생된 예외에 대한 처리는 서비스 레이어에서만 처리하며,
  발생한 예외에 대한 사용자 메시지를 보여주기 위한 코드 변환 작업을 수행한다.
  Presentation Layer에서는 별도의 예외 처리 작업 없이 선언적으로 예외 상황을 처리하고
  공통팀에서 제공하는 DefaultHandlerExceptionController를 활용하여 오류에 대한 메시지를 화면에 보여준다.
</p>
<div class="alert alert-danger" role="alert">
  무엇보다 중요한 것은 예외를 처리하기 위해 아래와 같은 형태로 코드를 작성하면 안되며
  발생된 예외를 극복할 수 있는 코드가 없는 경우 예외를 throw해야 한다.
</div>
<pre><code class="java">public int sum(int x, int y) {
    try {
        int sum = x + y;
    } catch (Exception e) {
      e.printStackTrace();
    }
}</code></pre>
<p>
  대부분의 Exception은 예외 발생으로 인해 해당 예외를 극복할 수 있는 경우가 드물다.
  Exception 모델링이 형편없기로 유명한 JDBC의 경우 모든 예외가 SQLException으로 발생
  (데이터베이스 Connection 접속 실패, SQL 문법 오류 등 전부다 SQLException이다.) 하므로
  더더욱 예외 상황에 따른 Failover 코드를 작성하기에 어렵다. 더군다나 SQLException은
  Checked Exception으로 개발자가 반드시 예외처리를 하게 되어있다.
  이 때문에 많은 개발자들이 <kbd>e.printStackTrace()</kbd>으로 예외를 마무리하곤 하는데
  이런 방식은 예외 처리를 안 하니느 못한 방법이다.
</p>
<p>
  아래 코드는 가장 기본적으면서도 적절한 예외 처리 방법이다. 예외는 예외가 발생한 클래스의
  이름만으로도 어떤 예외가 발생했는지 어느정도 가늠이 가능한 예외 클래스를 던저야한다.
  만약 Exception 또는 RuntimeExcetion이 throw 되었다고 가정한다면 예외가 밸상한 것은
  알겠는데 무슨 예외가 발생했는지는 정확하지 않다. 이런 경우에는 디버깅과
  운영 시에 빠른 장애처리를 어렵게한다.
</p>
<pre><code class="java">public void addEmployee(Employee employee) {
  List&lt;Employee&gt; employees = employeeMapper.findEmployeesByName(employee.getName());
  if (employees.size() &gt; 0) {
      throw new NameDuplicateException("[" + employee.getName() + "] 이미 존재하는 이름입니다.");
  }

  try {
      int result = employeeMapper.addEmployee(employee);
      if (result &lt; 1) {
          throw new NoAffectedException("사원정보가 저장되지 않았습니다. 입력 값을 확인하세요.");
      }
  } catch (Exception e) {
      throw new ServiceException(e.getMessage(), e);
  }
}</code></pre>
<p>
  예제 코드는 새롭게 추가되는 사원 중 이름이 중복된 경우 사용자 정의 예외 클래스인
  NameDuplicateException에 정확한 예외 메시지를 담아 throw한다.
  이름이 중복되지 않은 경우 데이터베이스에 사원을 인서트하는데 데이터베이스에 인서트 도중
  여러가지 이유로(컬럼의 길이, 잘 못된 데이터타입 등) 예외가 발생할 수 있는데
  실제 어떤 예외가 발생할지 알 수 없으므로 발생된 예외를 ServiceException으로 랩핑하여 던진다.
</p>
<p>
  아래 폼에 이름을 '조용상'으로 입력하면 이름이 중복었다는 메시지가 아래 코드에 의해 발생하게 되고
</p>
<pre><code class="java">if (employees.size() &gt; 0) {
    throw new NameDuplicateException("[" + employee.getName() + "] 이미 존재하는 이름입니다.");
}</code></pre>
<p>
  인서트가 되지 않았다면
</p>
<pre><code class="java">int result = employeeMapper.addEmployee(employee);
if (result &lt; 1) {
   throw new NoAffectedException("사원정보가 저장되지 않았습니다. 입력 값을 확인하세요.");
}</code></pre>
<p>
  코드에 의해 예외가 발생될 것이고 그 외 예상하지 못 한 예외의 경우 catch 절에 의해 예외가 throw되어
  에외 메시지가 클라이언트에 출력될 것이다.
</p>
<hr />
<form class="form-horizontal" id="exForm">
  <input type="hidden" name="no" value="9">
  <div class="row">
    <div class="col-md-6">
      <div class="form-group">
        <label for="name" class="col-sm-2 control-label">이름</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="name" name="name" placeholder="이름" value="조용상">
        </div>
      </div>
      <div class="form-group">
        <label for="hireDate" class="col-sm-2 control-label">입사일</label>
        <div class="col-sm-10 controls">
          <div class="input-group">
            <input type="text" class="form-control" id="hireDate" name="hireDate" placeholder="입사일" value="2016-08-22">
            <span class="input-group-addon">
              <span class="glyphicon glyphicon-calendar"></span>
            </span>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="form-group">
        <label for="salary" class="col-sm-2 control-label">연봉</label>
        <div class="col-sm-10">
          <input type="text" class="form-control input-numeral" id="salary" name="salary" placeholder="연봉" value="3500">
        </div>
      </div>
      <div class="form-group">
        <label for="dept" class="col-sm-2 control-label">부서</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="dept" name="dept" placeholder="부서" value="QA팀">
        </div>
      </div>
    </div>
  </div>
  <button class="btn btn-primary" type="button" id="exButton">저장</button>
</form>

<script type="text/javascript">
  $("#exButton").click(function() {
    $.post('/sample/employees', $('#exForm').serialize(), function(data) {
      console.log(data);
    });
  });
</script>