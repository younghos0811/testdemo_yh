<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<hr />
<blockquote>
  <p>
    다음은 위의 ClientSide와 동일한 형태지만 페이징을 클라이언트에서 하지 않고
    화면에 출력할 필요한 데이터만큼 ServerSide에 요청을 하여 렌더링하는 ServerSide 예제이다.
    ServerSide processing은 아래와 같은 작업을 server와의 통신을 통해 한다.
  </p>
  <ul>
    <li>page 가 변경될 때마다 server 에서 data 를 불러오고</li>
    <li>searching 을 할 때 server 에 요청</li>
    <li>sorting 을 할 때 server 에 요청</li>
  </ul>
  <p>
    DataTables에서는 <a href="https://datatables.net/manual/data" target="_blank"><strong>데이터</strong></a>가
    10,000 이하라면 ClientSide로 그 이상이라면 ServerSide로하는 것이 권장한다. 물론 10,000건 이하의 데이터라도
    복잡한 쿼리가 실행되어 속도가 안 나온다면 ServerSide로 해야 할 것이다.
  </p>
</blockquote>
<p>
  ServerSide라고 해서 FrontEnd 코드가 특별히 달라지는 것은 크게없다. 다만 ServerSide에서 해야 할 것이
  더 많은데 이런 부분도 공통 모듈로 잘 추상화 되어있어 사용하는데에는 크게 어려움이 없다.
</p>
<pre><code class="javascript">var $grid = $('#serverForColumn').DataTable({
  serverSide: true,
  ajax: {
    url: '/sample/employees',
    dataSrc: 'data',
  }
  ....
  ...
  .
</code></pre>
<p>
  ClientSide와 비교해서 추가된 옵션은 <kbd>serverSide: true</kbd> 하나이다.
  다음으로 검색 폼에 검색어를 입력했을 경우 ClientSide와 같이 keyup 이벤트를
  사용하게 되면 서버로의 요청이 많아져 성능에 악영향을 줄 수 있으므로 검색 버튼을
  따로 두어 버튼을 크릭했을 경우에만 검색이 되도록한다.
</p>
<pre><code class="javascript">$('#gridColumnForm').submit(function(e) {
  e.preventDefault();
  $('input', this).each(function() {
    var $input = $(this);
    $grid.columns($input.data('column')).search($input.val());
  });
  $grid.draw();
});</code></pre>
<p>
  검색 버튼을 클릭할 때 실행되는 코드이다. submit이 될 때 form submit이 안 되도록
  <kbd>e.preventDefault();</kbd>를 호출하고 폼 하위에 있는 input의 값들을 각각의 cloumn들에
  assign 한 후 그리드를 다시 그려준다(<kbd>$grid.draw()</kbd>) <kbd>draw()</kbd> 함수가
  호출되면 <kbd>.DataTable()</kbd> 함수가 다시 호출된다.
</p>
<p>
  위 코드에서 <kbd>$grid.columns($input.data('column')).search($input.val());</kbd>를 한 이유는
  ServerSide로 구성한 경우에 ajax 호출 시 DataTables은 ajax에 지정된 url에 GET
  방식으로 여러가지 파라미터를 붙여서 서버를 호출한다. 만약 검색 폼에 이름 항목에 '조용상'이라는
  키워드를 넣었을 경우에 다음과 같은 형태의 파라미터가 서버로 날아간다.
</p>
<pre><code class="javascript">
draw:2
columns[0].data:no
columns[0].name:
columns[0].searchable:true
columns[0].orderable:true
columns[0].search.value:
columns[0].search.regex:false
columns[1].data:name
columns[1].name:
columns[1].searchable:true
columns[1].orderable:true
columns[1].search.value:조용상
columns[1].search.regex:false
.....
....
..
order[0].column:0
order[0].dir:asc
start:0
length:10
search.value:
search.regex:false
</code></pre>
<p>
  각 컬럼들의 속성들이 파라마터로 전달된다. 그렇기 때문에 특정 컬럼의 검색어를 전달하기 위해서
  <kbd>$grid.columns($input.data('column')).search($input.val());</kbd> 와 같은 코드를 사용하게 된 것이다.
</p>
<p>
  여기까지는 ClientSide와 비교해서 크게 차이는 없지만 Server 코드는 ClientSide보다 조금 더 신경써야 한다.
  먼저 DataTables의 파라미터를 받고 또 응답을 적절히 줄 수 있도록 <kbd>DataTablesInput</kbd>와 <kbd>DataTablesOutput&lt;T&gt;</kbd>
  객체를 사용한다.
</p>
<pre><code class="java">@RequestMapping(value=&quot;/employees&quot;, method=RequestMethod.GET, headers=&quot;identity=column&quot;)
public DataTablesOutput&lt;Employee&gt; findEmployees(DataTablesInput input) {
  List&lt;Employee&gt; employees = employeeService.findEmployeesByColumn(input, input.toPageBounds());
  DataTablesOutput&lt;Employee&gt; output = new DataTablesOutput&lt;Employee&gt;(employees);
  return output;
}</code></pre>
<p>
  <kbd>DataTablesInput</kbd>은 위에 기술한 파라마터가 바인딩되는 객체이고 <kbd>DataTablesOutput&lt;T&gt;</kbd>는
  DataTables이 응답으로 요구하는 몇 가지 항목과 그리드 데이터를 담을 수 있도록 한 객체이다.
</p>
<pre><code class="xml">SELECT * FROM EMP
 WHERE 1 = 1
   &lt;foreach item=&quot;column&quot; collection=&quot;input.columns&quot;&gt;
     &lt;if test=&quot;column.search.value != null&quot;&gt;
       AND $[@com.gscaltex.mdoumi.base.datatables.mapping.CaseFormat@convertPropertyNameToUnderscoreName(column.data)] LIKE '%' || #[column.search.value] || '%'
     &lt;/if&gt;
   &lt;/foreach&gt;</code></pre>
<p>
  파라미터로 전달된 데이터를 데이터베이스를 간단하게 조회하는 쿼리이다.
  MyBatis의 <kbd>foreach</kbd>문을 사용하여 파라미터의 columns 만큼 루프를 돌면서
  And 조건으로 Where 절을 만드는 과정이다. 검색어가 name=조용상 이므로 만들어진 최종으로 만들어진 쿼리문은 다음과 같다.
</p>
<pre><code class="xml">SELECT * FROM EMP
 WHERE 1 = 1
   AND name LIKE '%' || '조용상' || '%'</code></pre>
<p>
  만약 name=조용상&amp;hireDate=2010-01-01와 같다면 쿼리문은 다음과 같이 만들어 질 것이다.
</p>
<pre><code class="xml">SELECT * FROM EMP
 WHERE 1 = 1
   AND name LIKE '%' || '조용상' || '%'
   AND hireDate LIKE '%' || '2010-01-01' || '%'</code></pre>
<p>
<p>
  위 쿼리는 정상적으로 만들어졌지만 실행되지는 않고 에러가 발생한다. 에러가 발생하는 이유는 hireDate 컬럼명이
  잘 못 되었기 때문이다. 전통적으로 Java는 Camel Case(UserInput)를 사용하고 Database는 Snake Case(User_Input)를 사용한다.
  즉, hireDate의 데이터베이스 컬럼명은 실제로는 HIRE_DATE 이므로 위 쿼리는 에러가 발생된다.
  이 문제를 해결하기 위해 Camel Case를 Snake Case로 변환해야 한다. MyBatis 쿼리문을 보면
  <kbd>@com.gscaltex.mdoumi.base.datatables.mapping.CaseFormat@convertPropertyNameToUnderscoreName(column.data)</kbd>이
  변화하는 메소드이므로 참고한다.
</p>
<p>
  해당 섹션의 예제는 매우 간편한 방법으로 데이터를 조회할 수 있는 방법이지만 몇 가지 문제가 있다.
</p>
<ul>
  <li>같은 조건의 검색만 가능하다. 예제에서는 LIKE 사용</li>
  <li>현실 세계에서는 LIKE 뿐 아니라 Equal(=), Between 등 다양한 조건이 필요</li>
  <li>입사일(hireDate)을 from~to 형태의 조회조건으로 할 경우 사실 방법이 없다</li>
</ul>
<p>
  위와 같은 문제가 있지만 예제에 포함한 이유는 검색 조건이 간단한 그리드의 경우에는 꽤 쓸만할 수도 있지 않을까?
</p>
<form id="gridColumnForm" class="form-inline">
  <input type="text" class="form-control" placeholder="이름" data-column="1">
  <input type="text" class="form-control" placeholder="연봉" data-column="2">
  <div class="form-group">
    <div class="input-group date">
      <input type="text" class="form-control" placeholder="입사일" data-column="3">
      <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar"></span>
      </span>
    </div>
  </div>
  <input type="text" class="form-control" placeholder="소속" data-column="4">
  <button class="btn btn-primary">검색</button>
</form>
<table id="serverForColumn" class="table table-striped table-bordered">
  <thead>
    <tr>
      <th>사번</th>
      <th>이름</th>
      <th>연봉</th>
      <th>입사일</th>
      <th>소속</th>
    </tr>
  </thead>
</table>
<script type="text/javascript">
  $(document).ready(function() {
    var $grid = $('#serverForColumn').DataTable({
      processing: true,
      serverSide: true,
      ajax: {
        url: '/sample/employees',
        dataSrc: 'data',
        headers: {identity: 'column'}
      },
      columns: [
        {data: 'no'},
        {
          data: 'name',
          render: function(data, type, row, meta) {
            return $('<a>', {
              href: 'view?no=' + row.no, text: data
            })[0].outerHTML;
          }
        },
        {data: 'salary'},
        {data: 'hireDate'},
        {data: 'dept'}
      ]
    });

    $('#gridColumnForm').submit(function(e) {
      e.preventDefault();
      $('input', this).each(function() {
        var $input = $(this);
        $grid.columns($input.data('column')).search($input.val());
      });
      $grid.draw();
    });

    $grid.on('click', 'a', function(e) {
      e.preventDefault();
      alert($(this).text());
    });
  });
</script>