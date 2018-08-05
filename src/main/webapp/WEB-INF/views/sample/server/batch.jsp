<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    배치 프로그램 정의는 일반적으로 배치(Batch) 프로그램이라 하면,
    일련의 작업들을 하나의 작업 단위로 묶어 연속적으로 일괄 처리하는 것을 말한다.
    온라인 프로그램에서도 여러 작업을 묶어 처리하는 경우가 있으므로 이와 구분하려면
    한 가지 특징을 더 추가해야 하는데, 사용자와의 상호작용(Interaction) 여부다.
    즉, 사용자와의 상호작용 없이 대량의 데이터를 처리하는 일련의 작업들을 묶어
    정기적으로 반복 수행하거나 정해진 규칙에 따라 자동으로 수행한다.
  </p>
</blockquote>
<dl>
  <dt>종류</dt>
  <dd>
    <ul>
      <li>정기 배치 : 정해진 시점(주로 야간)에 실행</li>
      <li>이벤트성 배치 : 사전에 정의해 둔 조건이 충족되면 자동으로 실행</li>
      <li>On-Demand 배치 : 사용자의 명시적인 요구가 있을 때마다 실행</li>
    </ul>
  </dd>
</dl>
<h3>Spring Batch</h3>
<dl>
  <dt>스프링 배치 기능</dt>
  <dd>
    <ul>
      <li>Job Repository 를 통한 배치 모니터링</li>
      <li>배치에 적합한 트랜잭션 처리를 위해 주기적인 commit방식 지원</li>
      <li>배치작업의 재시도, 재시작, 건너뛰기 등의 정책을 설정</li>
      <li>Commit 개수, Rollback 개수, 재시도 횟수 등 배치실행 통계 정보를 제공</li>
      <li>다양한 실행 방법 지원 - Quartz, CommandLine, JMX콘솔, OSGi, 동기/비동기-병렬 실행 ...</li>
    </ul>
  </dd>
</dl>
<dl>
  <dt>스프링 배치 구성요소</dt>
  <dd>
    <img src="/img/sample/server/spring-batch-reference-model.png" class="img-responsive center-block">
  </dd>
</dl>
<dl>
  <dt>용어 정의</dt>
  <dd>
    <p>
      <p><strong>JobLauncher</strong></p>
      JobLauncher는 배치 Job을 실행시키는 역할을 한다. Job과 Parameter를 받아서 실행. JobExecution를 반환 함.
    </p>
    <p>
      <p><strong>Job</strong></p>
      Job은 배치작업 전체의 중심 개념으로 배치작업 자체를 의미한다.
      Job은 실제 프로세스가 진행되는 Step들을 최상단에서 포함하고 있으며,
      Job의 실행은 배치작업 전체의 실행을 의미한다.
    </p>
    <p>
      <p><strong>JobInstance</strong></p>
      JobInstance는 논리적 Job 실행의 개념으로 JobInstance = Job + JobParameters로 표현할 수 있다.
      다시 말해, JobInstance는 동일한 Job이 각기 다른 JobParameter를 통해 실행 된 Job의 실행 단위이다.
      (Job과 JobParameters가 같으면 동일한 JobInstance이다.)
    </p>
    <p>
      <p><strong>JobParameter</strong></p>
      JobParameters는 하나의 Job에 존재할 수 있는 여러개의 JobInstance를 구별하기 위한 Parameter 집합이며,
      Job을 시작하는데 사용하는 Parameter 집합이다. 또한 Job이 실행되는 동안에 Job을 식별하거나
      Job에서 참조하는 데이터로 사용된다. 위의 그림(JobInstance 부분)으로
      예를들면 'EndOfDay' Job으로 2개의 JobInstance가 생성됐다.
      이 2개의 JobInstance는 각기 다른 JobParameters('2012/10/01', '2012/10/02')를 통해 생성된 것이다.
    </p>
    <p>
      <p><strong>JobExecution</strong></p>
      단 한 번 시도되는 Job 실행을 의미하는 기술적인 개념. 시작시간, 종료시간 ,상태(시작됨,완료,실패),종료상태의 속성을 가짐
    </p>
    <p>
      <p><strong>JobRepository</strong></p>
      수행되는 Job에 대한 정보를 담고 있는 저장소. 어떠한 Job이 언제 수행되었고,
      언제 끝났으며, 몇 번이 실행되었고 실행에 대한 결과가 어떤지 등의 Batch수행과
      관련된 모든 meta data가 저장되어 있다
    </p>
    <p>
      <p><strong>Step</strong></p>
      Batch job을 구성하는 독립적인 하나의 단계 Job은 하나이상의 step으로 구성
      실제 배치 처리 과정을 정의하고, 제어하는데 필요한 모든 정보를 포함
      Step의 내용은 전적으로 개발자의 선택에 따라 구성됨.
    </p>
    <p>
      <p><strong>Step Execution</strong></p>
      하나의 step을 실행하는 한번의 시도.
      시작시간, 종료시간,상태, 종료상태, commitCount, itemCount 의 속성을 가진다.
    </p>
    <p>
      <p><strong>Item</strong></p>
      처리할 데이터의 가장 작은 구성 요소.
      e.g. 파일의 한 줄, DB의 한 Row, Xml의 특정 element
    </p>
    <p>
      <p><strong>ItemReader</strong></p>
      Step안에서 File 또는 DB등에서 Item을 읽어 들인다
      더 이상 읽어올 Item이 없을 때에는 read()메소드에서 null값을 반환. 그 전까지는 순차적인 값을 리턴
    </p>
    <p>
      <p><strong>ItemWriter</strong></p>
      Step안에서 File 또는 DB등으로 Item을 저장한다.
    </p>
    <p>
      <p><strong>Item Processor</strong></p>
      Item reader에서 읽어 들인 Item에 대하여 필요한 로직처리 작업을 수행한다.
    </p>
    <p>
      <p><strong>Chunk</strong></p>
      하나의 Transaction안에서 처리할 Item의 덩어리.
      chunk size가 10이라면 하나의 transaction안에서 10개의 item에 대한 처리를 하고 commit을 하게 되는 것이다.
    </p>
  </dd>
</dl>
<dl>
  <dt>Chunk 기반 처리(Chunk-Oriented Processing)</dt>
  <dd>
    <p>
      Chunk 기반 처리는 스프링 배치에서 가장 일반적으로 사용하는 Step 유형이다.
      Chunk 기반 처리는 data를 한번에 하나씩 읽고, 트랜잭션 범위 내에서 'Chunk'를
      만든 후 한번에 쓰는 방식이다. 즉, 하나의 item이 ItemReader를 통해 읽히고,
      Chunk 단위로 묶인 item들이 한번에 ItemWriter로 전달 되어 쓰이게 된다.
      Chunk 단위로 Item 읽기 → 처리/변환 → 쓰기의 단계를 거치는 Chunk 기반 처리 매커니즘은 다음과 같다
    </p>
    <img src="/img/sample/server/chunk-oriented-processing.png" class="img-responsive center-block">
  </dd>
</dl>
<dl>
  <dt>TaskletStep</dt>
  <dd>
    <p>
      배치작업을 적용한 업무 환경에 따라 ItemReader와 ItemWriter를 활용한 구조가 맞지 않는 경우도 있을 것이다.
      예를들어 단순히 DB의 프로시저 호출만으로 끝나는 배치처리가 있다면 단순히 메소드 하나로 기능을
      구현하고 싶어질 것이다. 이런 경우를 위해 스프링 배치에서는 TaskletStep을 제공한다.
      Tasklet은 RepeatStatus.FINISHED를 반환하거나 에러가 발생하기 전까지 계속 실행하는
      execute() 하나의 메소드를 갖는 간단한 인터페이스로 저장 프로시저, 스크립트,
      또는 간단한 SQL 업데이트 문을 호출 할 수 있다.
      TaskletStep을 구성하기 위해서는 <tasklet> 태그의 'ref'속성을 통해 Tasklet 객체를 참조해야한다.
      <chunk> 태그는 <tasklet> 내에서 사용되지 않는다.(<Chunk> 태그는 Chunk-Oriented Processing에서 사용된다.)
    </p>
  </dd>
</dl>
<dl>
  <dt>스프링 배치 장점</dt>
  <dd>
    <p>
      Batch 를 작성한 Step 및 Job 관련된 Table을 제공해주고 각 배치 프로그램이
      어떻게 작동해서 어떤 결과가 있었는지 확인 가능하다.
    </p>
    <img src="/img/sample/server/spring-batch-schema.png" class="img-responsive center-block">
    <p>
      배치작업 처리 중의 정보는 JobRepository의 JobInstance, JobParams, JobExecution,
      StepExecution, key-value 쌍으로 값을 보관할 수 있는 공간인 ExecutionContext에
      저장 및 갱신되어 history를 관리한다.
    </p>
    <ul class="list-unstyled">
      <li>
        <table class="table table-bordered">
          <caption>BATCH_JOB_INSTANCE</caption>
          <colgroup>
            <col style="width: 20%">
            <col style="width: 80%">
          </colgroup>
          <thead>
            <tr>
              <th>JobInstance 속성</th>
              <th>설명</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>jobInstanceId</td>
              <td>JobInstance를 식별하는 ID</td>
            </tr>
            <tr>
              <td>version</td>
              <td>JobInstance 의 수정 횟수</td>
            </tr>
            <tr>
              <td>jobName</td>
              <td>Job의 이름</td>
            </tr>
            <tr>
              <td>jobKey</td>
              <td>JobInstance를 구분 짓는 JobParameters의 serialization</td>
            </tr>
          </tbody>
        </table>
      </li>
      <li>
        <table class="table table-bordered">
          <caption>BATCH_JOB_EXECUTION</caption>
          <colgroup>
            <col style="width: 20%">
            <col style="width: 80%">
          </colgroup>
          <thead>
            <tr>
              <th>JobExecution 속성</th>
              <th>설명</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>status</td>
              <td>
                BatchStatus는 실행 상태를 나타내는 객체이다, 실행하는 동안에는 BatchStatus,
                STARTED, 실행이 실패한 경우 BatchStatus.FAILED, 실행이 성공적으로 종료됐을
                경우 BatchStatus.COMPLETED가 된다.
              </td>
            </tr>
            <tr>
              <td>startTime</td>
              <td>Execution이 시작되는 현재 시스템 시간을 java.Util.Data로 저장</td>
            </tr>
            <tr>
              <td>endTime</td>
              <td>Execution의 성공/실패 여부와 관계없이 종료되는 현재 시스템 시간을 java.Util.Data로 저장</td>
            </tr>
            <tr>
              <td>exitStatus</td>
              <td>ExitStatus는 실행의 결과를 나타낸다. 호출자에게 반환될 exit code를 포함한다.</td>
            </tr>
            <tr>
              <td>createTime</td>
              <td>JobExecution이 최초 생성 된 현재 시스템 시간을 java.Util.Data로 저장</td>
            </tr>
            <tr>
              <td>lastUpdated</td>
              <td>JobExecution이 마지막으로 생성 된 현재 시스템 시간을 java.Util.Data로 저장</td>
            </tr>
            <tr>
              <td>executionContext</td>
              <td>execution간 지속돼야 할 모든 데이터를 포함하는 '프로퍼티 백'</td>
            </tr>
            <tr>
              <td>failureExceptions</td>
              <td>Job이 실행되는 동안 발생한 익셉션 리스트</td>
            </tr>
          </tbody>
        </table>
      </li>
      <li>
        <table class="table table-bordered">
          <caption>BATCH_JOB_PARAMS</caption>
          <colgroup>
            <col style="width: 20%">
            <col style="width: 80%">
          </colgroup>
          <thead>
            <tr>
              <th>JobParams 속성</th>
              <th>설명</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>jobInstanceId</td>
              <td>BATCH_JOB_INSTANCE 테이블의 jobInstanceId를 외래키로 지정</td>
            </tr>
            <tr>
              <td>typeCd</td>
              <td>파라마터의 형식을 String으로 저장,null일 될 수 없음</td>
            </tr>
            <tr>
              <td>keyName</td>
              <td>파라미터의 키</td>
            </tr>
            <tr>
              <td>stringVal</td>
              <td>String타입의 파마미터 값</td>
            </tr>
            <tr>
              <td>dateVal</td>
              <td>Date타입의 파마미터 값</td>
            </tr>
            <tr>
              <td>longVal</td>
              <td>Long타입의 파마미터 값</td>
            </tr>
            <tr>
              <td>doubleVal</td>
              <td>Double타입의 파마미터의 값</td>
            </tr>
          </tbody>
        </table>
      </li>
      <li>
        <table class="table table-bordered">
          <caption>BATCH_STEP_EXECUTION</caption>
          <colgroup>
            <col style="width: 20%">
            <col style="width: 80%">
          </colgroup>
          <thead>
            <tr>
              <th>StepExecution 속성</th>
              <th>설명</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>status</td>
              <td>
                BatchStatus는 실행 상태를 나타내는 객체이다, 실행하는 동안에는
                BatchStatus,STARTED, 실행이 실패한 경우 BatchStatus.FAILED,
                실행이 성공적으로 종료됐을 경우 BatchStatus.COMPLETED가 된다.
              </td>
            </tr>
            <tr>
              <td>startTime</td>
              <td>Execution이 시작되는 현재 시스템 시간을 java.Util.Data로 저장</td>
            </tr>
            <tr>
              <td>endTime</td>
              <td>Execution의 성공/실패 여부와 관계없이 종료되는 현재 시스템 시간을 java.Util.Data로 저장</td>
            </tr>
            <tr>
              <td>exitStatus</td>
              <td>ExitStatus는 실행의 결과를 나타낸다. 호출자에게 반환될 exit code를 포함한다.</td>
            </tr>
            <tr>
              <td>executionContext</td>
              <td>execution간 지속돼야 할 모든 데이터를 포함하는 '프로퍼티 백'</td>
            </tr>
            <tr>
              <td>readCount</td>
              <td>성공적으로 읽은 item 갯수</td>
            </tr>
            <tr>
              <td>writeCount</td>
              <td>성공적으로 쓰인 item 갯수</td>
            </tr>
            <tr>
              <td>commitCount</td>
              <td>해당 execution에서 커밋된 트랜젝션 횟수</td>
            </tr>
            <tr>
              <td>rollbackCount</td>
              <td>롤백된 Step에 의해서 제어된 비즈니스 트랜젝션의 갯수</td>
            </tr>
            <tr>
              <td>readSkipCount</td>
              <td>읽기 과정에서 실패 후, 스킵된 item 갯수</td>
            </tr>
            <tr>
              <td>processSkipCount</td>
              <td>프로세스 과정에서 실패 후, 스킵된 item 갯수</td>
            </tr>
            <tr>
              <td>filterCount</td>
              <td>ItemProcessor에 의해 필터링 된 item 갯수</td>
            </tr>
            <tr>
              <td>writeSkipCount</td>
              <td>쓰기 과정에서 실패 후, 스킵된 item 갯수</td>
            </tr>
          </tbody>
        </table>
      </li>
      <li>
        <table class="table table-bordered">
          <caption>BATCH_JOB_EXECUTION_CONTEXT</caption>
          <colgroup>
            <col style="width: 20%">
            <col style="width: 80%">
          </colgroup>
          <thead>
            <tr>
              <th>JobExecutionContext 속성</th>
              <th>설명</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>jobExecutionId</td>
              <td>BATCH_JOB_EXECUTION 테이블의 jobExecutionId를 외래키로 지정</td>
            </tr>
            <tr>
              <td>shortContext</td>
              <td>SERIALIZED_CONTEXT의 문자열 버전</td>
            </tr>
            <tr>
              <td>serializedContext</td>
              <td>전체 Context</td>
            </tr>
          </tbody>
        </table>
      </li>
      <li>
        <table class="table table-bordered">
          <caption>BATCH_STEP_EXECUTION_CONTEXT</caption>
          <colgroup>
            <col style="width: 20%">
            <col style="width: 80%">
          </colgroup>
          <thead>
            <tr>
              <th>StepExecutionContext 속성</th>
              <th>설명</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>stepExecutionId</td>
              <td>BATCH_STEP_EXECUTION 테이블의 stepExecutionId를 외래키로 지정</td>
            </tr>
            <tr>
              <td>shortContext</td>
              <td>SERIALIZED_CONTEXT의 문자열 버전</td>
            </tr>
            <tr>
              <td>serializedContext</td>
              <td>전체 Context</td>
            </tr>
          </tbody>
        </table>
      </li>
    </ul>
    <div class="alert alert-danger" role="alert">
      Spring Batch가 데이터베이스에 배치처리 정보를 인서트하기 위해서는
      Spring Batch Schema가 생성되어 있어야한다. schema는 spring-batch-core-[version].jar 파일의
      org.springframework.batch.core 패키지에 데이터베이스 벤더별로 스키마 파일이 있으므로
      사용하는 데이터베이스 맞는 스키마를 실행하여 테이블을 생성한다.
    </div>
  </dd>
</dl>
<dl>
  <dt>예제</dt>
  <dd>
    <p>
      Spring Batch를 Java Config로 구성하려고 했으나 여러가지 이유로 구성에 실패했다.
      프로젝트 기간을 고려할 때 원인 파악 및 연구할 시간이 부족해 xml 방식으로 선회를 했다.
      본 프로젝트에서는 xml 방식의 구성을 기본으로 한다. Java Config가 xml에 비해
      가지는 장점이 분명히 있지만 xml 방식이라고 해서 나쁜 것은 아니다.(이렇게라도 위안을... ㅠㅠ)
    </p>
    <p>
      예제는 3가지 형태로 구성되어 있다.
    </p>
    <ul>
      <li>특정 테이블에서 데이터를 읽은 후 타켓 테이블로 인서트</li>
      <li>프로시저에서 데이터를 읽은 후 file write</li>
      <li>단순히 프로시저를 호출</li>
    </ul>
    <p>
      Spring Batch xml을 구성하기 위해서는 반드시 batch/context.xml 파일을 임포트해야 한다.
      context.xml에는 <kbd>JobLauncher</kbd>와 <kbd>JobRepository</kbd>가 정의되어 있으며
      모든 Batch Job들은 이 두개의 Bean이 없이는 구동될 수 없기 때문에 context.xml을 임포트한다.
    </p>
    <pre><code class="xml">&lt;import resource=&quot;classpath:batch/context.xml&quot; /&gt;</code></pre>
  </dd>
  <dt>특정 테이블에서 데이터를 읽은 후 타켓 테이블로 인서트</dt>
  <dd>
    <p>
      대부분의 배치 작업들이 그렇듯이 소스를 읽어(ItemReader) 타켓에 쓰는(ItemWriter) 것이 기본이다.
      먼저 테이블에서 소스를 읽는 설정을 보자
    </p>
<pre><code class="xml">&lt;bean id=&quot;sampleItemReader&quot; class=&quot;org.springframework.batch.item.database.JdbcCursorItemReader&quot; scope=&quot;step&quot;&gt;
  &lt;property name=&quot;dataSource&quot; ref=&quot;dataSource&quot; /&gt;
  &lt;property name=&quot;sql&quot;&gt;
    &lt;value&gt;
      &lt;![CDATA[
      SELECT *
        FROM emp
       WHERE hire_date &gt;= '#&#123;jobParameters[startDate]&#125;'
         AND hire_date &lt;= '#&#123;jobParameters[endDate]&#125;'
      ]]&gt;
    &lt;/value&gt;
  &lt;/property&gt;
  &lt;property name=&quot;rowMapper&quot;&gt;
    &lt;bean class=&quot;com.gscaltex.mdoumi.sample.batch.EmployeeRowMapper&quot; /&gt;
  &lt;/property&gt;
&lt;/bean&gt;</code></pre>
    <p>
      어떤 데이터베이스에 접속해서 쿼리를 실행할 것인지 <kbd>dataSource</kbd>를 지정하고
      실행할 쿼리를 작성한다. 쿼리의 where 절에 <kbd>'#&#123;jobParameters[startDate]&#125;'</kbd>는
      파라미터로 전달된 값을 바인딩하는 표현언어이다. 이 파라미터를 어디서 어떻게 전달했는지는 이후
      코드에서 본다.
    </p>
    <p>
      실행된 쿼리의 로우(Row)들을 특정한 자바 객체에 매핑해줘야 하는데 그 때 사용되는 부분이
      <kbd>rowMapper</kbd>로 JDBC ResultSet에서 어떤 컬럼을 어떻게 매핑할지 정의한다.
    </p>
<pre><code class="java">public class EmployeeRowMapper implements RowMapper<Employee> {
  @Override
  public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
    Employee employee = new Employee();
    employee.setNo(rs.getLong("no"));
    employee.setName(rs.getString("name"));
    employee.setHireDate(rs.getDate("hire_date"));
    employee.setSalary(rs.getInt("salary"));
    employee.setDept(rs.getString("dept"));

    return employee;
  }
}</code></pre>
    <p>
      이렇게 읽어온 데이터를 타겟 테이블에 인서트하기 위해 ItemWriter를 정의한다.
    </p>
<pre><code class="xml">&lt;bean id=&quot;sampleItemWriter&quot; class=&quot;org.springframework.batch.item.database.JdbcBatchItemWriter&quot;&gt;
  &lt;property name=&quot;dataSource&quot; ref=&quot;dataSource&quot; /&gt;
  &lt;property name=&quot;sql&quot;&gt;
    &lt;value&gt;
      &lt;![CDATA[
      INSERT INTO emp (
          name
         ,salary
         ,hire_date
         ,dept)
      VALUES (
          :name
         ,:salary
         ,:hireDate
         ,:dept)
      ]]&gt;
    &lt;/value&gt;
  &lt;/property&gt;
  &lt;property name=&quot;itemSqlParameterSourceProvider&quot;&gt;
    &lt;bean class=&quot;org.springframework.batch.item.database.BeanPropertyItemSqlParameterSourceProvider&quot; /&gt;
  &lt;/property&gt;
&lt;/bean&gt;</code></pre>
    <p>
      ItemReader와 마찬가지로 어떤 데이터베이스에 연결하여 사용할지 <kbd>dataSource</kbd>를 지정하고
      인서트 쿼리문을 작성한다. 인서트 문의 바인딩 표현 문법이 MyBatis의 그것과는 조금 다를 뿐 크게 다를 것이 없다.
      MyBatis가 <kbd>$&#123;name&#125;</kbd> 처럼 했다면 Spring Batch에서는 <kbd>:name</kbd>처럼 표현한다.
      인서트에 바인딩되는 데이터는 ItemReader에서 전달해준 <kbd>Employee</kbd> 객체가 된다.
      바인딩할 객체를 어떻게 제공할 것인지는 <kbd>itemSqlParameterSourceProvider</kbd>로 정의되는데
      <kbd>BeanPropertyItemSqlParameterSourceProvider</kbd>를 사용했다. <kbd>BeanPropertyItemSqlParameterSourceProvider</kbd>는
      Bean을 Reflection하여 변수명과 변수 값을 활용할 수 있게 해주는데 복잡하게 생각할 것 없이
      이런 형태의 예제에서는 무조건 Copy & Paste하여 사용하면된다.
    </p>
    <p>
      ItemReader와 ItemWriter가 구성되었다면 이 두개의 작업을 사용하여 드디어 Job을 구성할 수 있게된다.
    </p>
<pre><code class="xml">&lt;job id=&quot;sampleJob&quot; xmlns=&quot;http://www.springframework.org/schema/batch&quot;&gt;
  &lt;step id=&quot;sampleStep&quot;&gt;
    &lt;tasklet&gt;
      &lt;chunk reader=&quot;sampleItemReader&quot; writer=&quot;sampleItemWriter&quot; commit-interval=&quot;100&quot; /&gt;
    &lt;/tasklet&gt;
  &lt;/step&gt;
&lt;/job&gt;</code></pre>
    <p>
      Job의 reader와 writer에 미리 정의한 Bean을 chunk 기반으로 설정하면 된다. 이렇게 Job이 구성되면
      이것만으로도 Job을 실행할 수 있는 준비가 된 것이지만 앞서 내용처럼 Batch Job은 사용자와 상호작용 없이
      스스로 구동되어야 하므로 Scheduler를 통해서 Job을 실행한다.
    </p>
<pre><code class="xml">&lt;bean id=&quot;sampleJobScheduler&quot; class=&quot;com.gscaltex.mdoumi.sample.batch.EmployeeJobScheduler&quot;&gt;
  &lt;property name=&quot;jobLauncher&quot; ref=&quot;jobLauncher&quot; /&gt;
  &lt;property name=&quot;job&quot; ref=&quot;sampleJob&quot; /&gt;
&lt;/bean&gt;

&lt;task:scheduled-tasks&gt;
  &lt;task:scheduled ref=&quot;sampleJobScheduler&quot; method=&quot;run&quot; cron=&quot;0 29 16 * * *&quot; /&gt;
&lt;/task:scheduled-tasks&gt;</code></pre>
    <p>
      Job을 실행하기 위해 특정한 Job 클래스 빈을 소유하는 클래스를 만들고(<kbd>EmployeeJobScheduler</kbd>)
      해당 클래스를 Scheduler에 등록하여 특정한 시간에 Job이 실행될 수 있도록 한다.
    </p>
<pre><code class="java">public class EmployeeJobScheduler {
  private final Logger logger = LoggerFactory.getLogger(this.getClass());
  private final Format dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

  private JobLauncher jobLauncher;

  private Job job;

  public void setJobLauncher(JobLauncher jobLauncher) {
    this.jobLauncher = jobLauncher;
  }

  public void setJob(Job job) {
    this.job = job;
  }

  public void run() throws Exception {
    JobParametersBuilder paramBuilder = new JobParametersBuilder();
    paramBuilder.addString("startDate", "1990-3-14");
    paramBuilder.addString("endDate", "2017-3-16");
    JobExecution execution = jobLauncher.run(job, paramBuilder.toJobParameters());

    logger.info("Executed: &#123;&#125;", job.getName());
    logger.info("Exit Status: &#123;&#125;", execution.getStatus());
    logger.info("Exit Status: &#123;&#125;", execution.getAllFailureExceptions());
    logger.info("End: &#123;&#125;", dateFormatter.format(new Date()));
    logger.info("Done");
  }
}</code></pre>
    <p>
      <kbd> &lt;task:scheduled ref=&quot;sampleJobScheduler&quot; method=&quot;run&quot; cron=&quot;0 29 16 * * *&quot; /&gt;</kbd>
      의미는 EmployeeJobScheduler 클래스의 run 메서드를 매일 오후 4시 29분 0초에 실행하라는 의미가 된다.
      cron expression은 <a href="http://chanlee.github.io/2014/01/18/cron-expression-with-quartz-cron-trigger/" target="_blank">여기</a>를 참고한다.
    </p>
    <p>
      위 내용 중 ItemReader의 jobParameters가 어디서 온 것인지 나중에 보겠다고 했는데..
      <kbd>WHERE hire_date &gt;= '#&#123;jobParameters[startDate]&#125;</kbd> 바인딩 파라미터는
      EmployeeJobScheduler 클래스에서 전달해준 것이다.
    </p>
  </dd>
  <dt>프로시저에서 데이터를 읽은 후 file write</dt>
  <dd>
    <p>
      프로시저의 경우 일반적의 경우와 크게 다를 것은 없다. 다만,
      JdbcCursorItemReader가 StoredProcedureItemReader로 변경되고 프로시저
      바인딩 파라미터를 전달하는 부분이 조금 다를뿐이다.
    </p>
<pre><code class="xml">&lt;bean id=&quot;storedProcedureItemReader&quot; class=&quot;org.springframework.batch.item.database.StoredProcedureItemReader&quot; scope=&quot;step&quot;&gt;
  &lt;property name=&quot;dataSource&quot; ref=&quot;dataSource&quot; /&gt;
  &lt;property name=&quot;procedureName&quot; value=&quot;GET_PAPER_LIST4&quot; /&gt;
  &lt;property name=&quot;parameters&quot;&gt;
    &lt;list&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;list_type&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.VARCHAR&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;user_id&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.VARCHAR&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;code&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.VARCHAR&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;cust_nm&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.VARCHAR&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;user_nm&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.VARCHAR&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;subject&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.VARCHAR&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;order_by&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.VARCHAR&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;page_no&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.INTEGER&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;max_rec&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.INTEGER&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
      &lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
        &lt;constructor-arg index=&quot;0&quot; value=&quot;sys_type&quot; /&gt;
        &lt;constructor-arg index=&quot;1&quot;&gt;
          &lt;util:constant static-field=&quot;java.sql.Types.VARCHAR&quot; /&gt;
        &lt;/constructor-arg&gt;
      &lt;/bean&gt;
    &lt;/list&gt;
  &lt;/property&gt;
  &lt;property name=&quot;preparedStatementSetter&quot;&gt;
    &lt;bean id=&quot;preparedStatementSetter&quot; class=&quot;org.springframework.batch.core.resource.ListPreparedStatementSetter&quot;&gt;
      &lt;property name=&quot;parameters&quot;&gt;
        &lt;list&gt;
          &lt;value&gt;receive&lt;/value&gt;
          &lt;value&gt;CJ65&lt;/value&gt;
          &lt;value&gt;&lt;/value&gt;
          &lt;value&gt;&lt;/value&gt;
          &lt;value&gt;&lt;/value&gt;
          &lt;value&gt;&lt;/value&gt;
          &lt;value&gt;MAKEDATE&lt;/value&gt;
          &lt;value&gt;1&lt;/value&gt;
          &lt;value&gt;20&lt;/value&gt;
          &lt;value&gt;D&lt;/value&gt;
        &lt;/list&gt;
      &lt;/property&gt;
    &lt;/bean&gt;
  &lt;/property&gt;
  &lt;property name=&quot;rowMapper&quot;&gt;
    &lt;bean class=&quot;com.gscaltex.mdoumi.sample.batch.PaperRowMapper&quot; /&gt;
  &lt;/property&gt;
&lt;/bean&gt;</code></pre>
    <p>
      프로시저에 전달할 파라미터를 SqlParameter 객체를 통해 정의한다. SqlParameter의 생성자는
      프로시저의 input 파라마터명과 input 파라미터의 데이터유형을 값으로한다.
    </p>
<pre><code class="xml">&lt;bean class=&quot;org.springframework.jdbc.core.SqlParameter&quot;&gt;
  &lt;constructor-arg index=&quot;0&quot; value=&quot;list_type&quot; /&gt;
  &lt;constructor-arg index=&quot;1&quot;&gt;
    &lt;util:constant static-field=&quot;java.sql.Types.VARCHAR&quot; /&gt;
  &lt;/constructor-arg&gt;
&lt;/bean&gt;</code></pre>
    <p>
      다음으로 <kbd>procedureName</kbd> 속성을 통해 프로시저명을 지정하고
      프로시저 바인딩 값을 정의하면 된다. 예제에서 사용되는 프로시저는 파라머터의 갯수가 10개이므로
      10개의 값을 정의한다.
    </p>
<pre><code class="xml">&lt;property name=&quot;preparedStatementSetter&quot;&gt;
  &lt;bean id=&quot;preparedStatementSetter&quot; class=&quot;org.springframework.batch.core.resource.ListPreparedStatementSetter&quot;&gt;
    &lt;property name=&quot;parameters&quot;&gt;
      &lt;list&gt;
        &lt;value&gt;receive&lt;/value&gt;
        &lt;value&gt;CJ65&lt;/value&gt;
        &lt;value&gt;&lt;/value&gt;
        &lt;value&gt;&lt;/value&gt;
        &lt;value&gt;&lt;/value&gt;
        &lt;value&gt;&lt;/value&gt;
        &lt;value&gt;MAKEDATE&lt;/value&gt;
        &lt;value&gt;1&lt;/value&gt;
        &lt;value&gt;20&lt;/value&gt;
        &lt;value&gt;D&lt;/value&gt;
      &lt;/list&gt;
    &lt;/property&gt;
  &lt;/bean&gt;
&lt;/property&gt;</code></pre>
    <p>
      그 외 나머지 내용들은 위에서 설명한 내용들과 다를 것이 없으며 ItemWriter는
      예제 작성을 위해 적당한 타켓이 없어 파일로 write한 것 뿐이니 무시해도 좋다.
    </p>
  </dd>
  <dt>단순히 프로시저를 호출</dt>
  <dd>
    <p>
      위 에서도 설명 했듯이 어떤 Batch Job은 ItemReader와 ItemWriter를 활용한 구조가 맞지 않는 경우도 있다.
      단순히 프로시저 호출만으로 끝나는 배치처리라면 TaskletStep을 정의하여 사용하면 된다.
    </p>
<pre><code class="java">public class StoredProcedureTasklet implements Tasklet {
  private final Logger logger = LoggerFactory.getLogger(this.getClass());

  private DataSource dataSource;

  public void setDataSource(DataSource dataSource) {
    this.dataSource = dataSource;
  }

  @Override
  public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
    Map&lt;String, Object&gt; parameters = new HashMap&lt;String, Object&gt;();
    parameters.put(&quot;list_type&quot;, &quot;receive&quot;);
    parameters.put(&quot;user_id&quot;, &quot;CJ65&quot;);
    parameters.put(&quot;code&quot;, null);
    parameters.put(&quot;cust_nm&quot;, null);
    parameters.put(&quot;user_nm&quot;, null);
    parameters.put(&quot;subject&quot;, null);
    parameters.put(&quot;order_by&quot;, &quot;MAKEDATE&quot;);
    parameters.put(&quot;page_no&quot;, &quot;1&quot;);
    parameters.put(&quot;max_rec&quot;, &quot;20&quot;);
    parameters.put(&quot;sys_type&quot;, &quot;D&quot;);

    SimpleJdbcCall procedure = new SimpleJdbcCall(dataSource).withProcedureName(&quot;GET_PAPER_LIST4&quot;);
    SqlParameterSource parameterSource = new MapSqlParameterSource(parameters);
    Map&lt;String, Object&gt; result = procedure.execute(parameterSource);

    logger.debug(result.toString());

    return RepeatStatus.FINISHED;
  }
}</code></pre>
<pre><code class="xml">&lt;bean id=&quot;storedProcedureTasklet&quot; class=&quot;com.gscaltex.mdoumi.sample.batch.StoredProcedureTasklet&quot; scope=&quot;step&quot;&gt;
  &lt;property name=&quot;dataSource&quot; ref=&quot;dataSource&quot; /&gt;
&lt;/bean&gt;

&lt;job id=&quot;storedProcedureTaskletJob&quot; xmlns=&quot;http://www.springframework.org/schema/batch&quot;&gt;
  &lt;step id=&quot;storedProcedureTaskletStep&quot;&gt;
    &lt;tasklet ref=&quot;storedProcedureTasklet&quot; /&gt;
  &lt;/step&gt;
&lt;/job&gt;

&lt;bean id=&quot;storedProcedureTaskletJobScheduler&quot; class=&quot;com.gscaltex.mdoumi.sample.batch.StoredProcedureTaskletJobScheduler&quot;&gt;
  &lt;property name=&quot;jobLauncher&quot; ref=&quot;jobLauncher&quot; /&gt;
  &lt;property name=&quot;job&quot; ref=&quot;storedProcedureTaskletJob&quot; /&gt;
&lt;/bean&gt;

&lt;task:scheduled-tasks&gt;
  &lt;task:scheduled ref=&quot;paperJobScheduler&quot; method=&quot;run&quot; cron=&quot;0 29 16 * * *&quot; /&gt;
&lt;/task:scheduled-tasks&gt;</code></pre>
  </dd>
</dl>
<p>
  지금까지의 예제는 가장 간단하면서도 또 많이 사용할만한 내용의 예제이지만
  Spring Batch는 훨씬 더 많고 강력한 기능들을 지원한다.
  대용량 데이터의 배치 처리 시 Multi Thread에 의한 partitioning,
  Job Listener 등 많은 기능이 있는데 이런 기능에 대해 쉽게 참고할만한 사이트가 있다.
  아래 사이트를 참고.
  <br>
  <a href="https://www.mkyong.com/tutorials/spring-batch-tutorial/" target="_blank">Spring Batch Tutorial</a>
</p>