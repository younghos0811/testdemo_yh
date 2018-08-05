<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<hr />
<blockquote>
  <p>
    위 예제의 문제점을 극복하고 사실상 가장 많이 사용하게 될 예제로 전체 프로젝트에
    기본 모델이 될 그리드 사용법을 설명한다.
  </p>
</blockquote>
<p>
  가장 많이 사용될 그리드 형태라고는 하지만 지금까지 보았던 것들과 크게 다를 것은 없다.
  옵션 중 <kbd>ajax</kbd> 섹션에 <kbd>data</kbd> 옵션이 추가 되었다. (columns의 data 옵션과 헷갈리지 말 것...)
  이전까지는 가져온 데이터에 대한 filtering(?)을 했다면 지금부터는 ajax에 직접 파라미터를 전달하여 검색을 할 것이다.
</p>
<pre><code class="javascript">ajax: {
  url: '/sample/employees',
  dataSrc: 'data',
  data: function(param) {
    $('#gridCustomForm input').each(function() {
      var $input = $(this);
      param[$input.attr('name')] = $input.val();
    });
  },
  headers: {identity: 'custom'},
}</code></pre>
<p>
  ajax 요청을 보낼 검색 폼의 input을 순회하여 input의 name을 key로하고 input의 값(value)을 넣어 요청을 보내고
  server에서는 이 파라미터를 받아 처리하게된다.
</p>
<pre><code class="java">public class EmployeeSearchCriteria extends DataTablesInput {
  private String name;

  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date startHireDate;

  @DateTimeFormat(pattern = "yyyy-MM-dd")
  private Date endHireDate;

  private String dept;
}</code></pre>
<p>
  검색 조건의 파라미터를 바인딩하기 위해 <kbd>EmployeeSearchCriteria</kbd>라는 클래스를 만들고
  위에서 설명했듯이 DataTables가 전달하는 다른 파라미터도 함께 바인딩하기 위해 DataTablesInput을 상속 받는다.
  이렇게 바인딩된 파라미터로 늘 해왔듯이 Dynamic Query를 작성하면 되겠다.
</p>
<pre><code class="xml">&lt;select id=&quot;findEmployeesByCustom&quot; resultType=&quot;Employee&quot;&gt;
   SELECT * FROM EMP
    WHERE 1 = 1
    &lt;if test=&quot;name != null&quot;&gt;
      AND name LIKE '%' || #[name] || '%'
    &lt;/if&gt;
    &lt;if test=&quot;startHireDate != null and endHireDate != null&quot;&gt;
      AND hire_date BETWEEN #[startHireDate] AND #[endHireDate]
    &lt;/if&gt;
    &lt;if test=&quot;dept != null&quot;&gt;
      AND dept LIKE '%' || #[dept] || '%'
    &lt;/if&gt;
&lt;/select&gt;</code></pre>
<form id="gridCustomForm" class="form-inline">
  <input type="text" name="name" class="form-control" placeholder="이름" data-column="1">
  <div class="form-group">
    <div class="input-group date" id="startPicker">
      <input type="text" name="startHireDate" class="form-control input-date" placeholder="입사일(form)" data-column="3">
      <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar"></span>
      </span>
    </div>
  </div>
  <div class="form-group">
    <div class="input-group date" id="endPicker" data-date-use-current="false">
      <input type="text" name="endHireDate" class="form-control input-date" placeholder="입사일(to)" data-column="3">
      <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar"></span>
      </span>
    </div>
  </div>
  <input type="text" name="dept" class="form-control" placeholder="소속" data-column="4">
  <button class="btn btn-primary">검색</button>
</form>
<table id="serverForCustom" class="table table-striped table-bordered">
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
    var $grid = $('#serverForCustom').DataTable({
      serverSide: true,
      ajax: {
        url: '/sample/employees',
        dataSrc: 'data',
        data: function(param) {
          $('#gridCustomForm input').each(function() {
            var $input = $(this);
            param[$input.attr('name')] = $input.val();
          });
        },
        headers: {identity: 'custom'},
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

    $('#gridCustomForm').submit(function(e) {
      e.preventDefault();
      $grid.draw();
    });

    $grid.on('click', 'a', function(e) {
      e.preventDefault();
      alert($(this).text());
    });

    $('#startPicker').on('dp.change', function(e) {
        $('#endPicker').data('DateTimePicker').minDate(e.date);
    });
    $('#endPicker').on('dp.change', function(e) {
        $('#startPicker').data('DateTimePicker').maxDate(e.date);
    });
  });
</script>