<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<p>
  ClientSide의 그리드는 그리드에 표현할 데이터를 HTML 또는 JavaScript 코드 내에 static하게
  넣을 수도 있고 AJAX를 통해 데이터를 가져올 수도 있다. 실제 프로그램에서는 정적인 데이터를
  사용할 일이 없으므로 초기 데이터는 AJAX를 통해서 가져온다. DataTables는 기본적으로
  전역 검색(Search)를 포함한다. 전역 검색은 그리드에 표현되는 데이터(Column)에 대해 OR 조건으로
  검색할 수 있게하는 기능이지만 실제 프로젝트에서는 검색 조건을 따로 구성하고 DatePicker,
  체크박스, 자동완성 등 다양한 컴포넌트를 이용하여 검색 조건을 구성하므로 예제에서는 전역 검색
  기능을 제거 시켰다. 전역 검색 기능이 무엇인지는
  <a href="https://datatables.net/examples/basic_init/zero_configuration.html" target="_blank">링크</a>를 통해 참고한다.
  먼저 코드를 보고 각각의 옵션에 대해 설명을 보자.
</p>
<pre><code class="javascript">var $grid = $('#client').DataTable({
  ajax: {
    url: '/sample/employees',
    dataSrc: ''
  },
  columnDefs: [{
    targets: [4],
    visible: false
  }],
  columns: [
    {data: 'no'},
    {
      data: 'name',
      render: function(data, type, row, meta) {
        return $('&lt;a&gt;', {
          href: 'view?no=' + row.no, text: data
        })[0].outerHTML;
      }
    },
    {data: 'salary'},
    {data: 'hireDate'},
    {data: 'dept'}
  ]
});</code></pre>
<p>
  DataTables을 사용하기 위해서는 thead가 반드시 포함된(tfoot은 옵션) table을 만들고
  해당 table을 jQuery로 선택한 다음 DataTable() 함수를 호출한다. DataTable() 함수에는 DataTables가
  제공하는 많은 옵션이 있고 기본적으로 프로젝트를 진행하는데 있어서 필요한 옵션에 대해서만
  설명을 하고 상황에 따라 필요한 옵션들은 <a href="https://datatables.net/" target="_blank">홈페이지</a>를 참고한다.
</p>
<pre><code class="javascript">ajax: {
  url: '/sample/employees',
  dataSrc: ''
}</code></pre>
<p>
  위 옵션은 ajax를 통해 DataTables에 데이터를 전달하는 역할을한다. url은 서버상에 데이터를
  전달해줄 주소이고 dataSrc는 전달된 데이터들 중 어떤 데이터가 그리드에 표현할 데이터인지 지정하는 옵션이다.
  좀 더 자세히 설명하면 보통 ajax를 통해 데이터를 가져오는 경우 그리드에 표현 데이터만 가져오는 경우도 있지만
  그리드 데이터 뿐 아니라 다른 데이터를 가져오는 경우도 많다. 그리드 데이터만 가져오는 경우는 아마다 다음과 같은
  형태일 것이다.
</p>
<pre><code class="javascript">[{"no":4044,"name":"조용상","salary":"2,000","hireDate":"2010-07-19","dept":"QA팀"},{"no":4045,"name":"김솔로","salary":"2,100","hireDate":"2010-01-23","dept":"QA팀"}]</code></pre>
<p>
  그리고 그리드 데이터 뿐 아니라 다른 데이터도 함께 가져오는 경우는
</p>
<pre><code class="javascript">{"draw":1,"recordsTotal":26,"data":[{"no":4044,"name":"조용상","salary":"2,000","hireDate":"2010-07-19","dept":"QA팀"},{"no":4045,"name":"김솔로","salary":"2,100","hireDate":"2010-01-23","dept":"QA팀"}]</code></pre>
<p>
 만약 위와 같은 형태으 데이터를 가져왔을 경우 DataTables이 그리드에 데이터를 표현해야 하는데
 어떤 데이터가 실제 그리드에 표현해야 하는 데이터인지 알 수가 없다. 이런 경우에 바로 <kbd>dataSrc</kbd> 옵션을 사용한다.
 순수하게 그리드 데이터만 가져오는 경우는 <kbd>dataSrc: ''</kbd>가 될 것이고 위의 경우처럼 그리드 데이터 뿐아니라
 다른 데이터도 가져올 경우에는 <kbd>dataSrc: 'data'</kbd> 속성을 지정하여 DataTables로 하여금 어떤 데이터가
 그리드에 표시할 데이터인지를 알려준다.
</p>
<pre><code class="javascript">columnDefs: [{
  targets: [4],
  visible: false
}]</code></pre>
<p>
  많은 경우에 그리드에 표시할 데이터보다 더 많은 데이터를 가져온 후 사용자가 볼 필요없는 데이터는
  그리드에는 표시하지 않고 그리드의 특정한 행 또는 열을 클릭할 경우 숨겨진 데이터(키 값과 같은 것들...)를
  이용하여 사용자와 상호작용하는 프로그램을 작성할 때가 많다. <kbd>targets, visible</kbd> 옵션이 위에서 설명한 것을
  만족하는 옵션이다.
  <kbd>targets</kbd>은 컬럼 인덱스를 Array로 지정하고 <kbd>visible</kbd> 옵션으로 보이게 할 것인지 아닌지를 지정한다.
</p>
<pre><code class="javascript">  columns: [
  {data: 'no'},
  {
    data: 'name',
    render: function(data, type, row, meta) {
      return $('&lt;a&gt;', {
        href: 'view?no=' + row.no, text: data
      })[0].outerHTML;
    }
  },
  {data: 'salary'},
  {data: 'hireDate'},
  {data: 'dept'}
]</code></pre>
<p>
  DataTables 그리드의 데이터 소스는 Arrays, Objects 두 가지 유형으로 올 수 있다.
  가장 간편한 것은 Array다.
</p>
<pre><code class="javascript">["Tiger Nixon", "System Architect", "Edinburgh", "5421", "2011/04/25", "$3,120"]</code></pre>
<p>
  위와 같은 형태의 데이터가 온다면 columns와 같은 옵션은 불필요하다. 데이터가 Arrays이기 때문에
  데이터의 순서대로 그리드에 바로 표현이된다. 하지만 이렇게 Arrays를 사용하는 경우는 드물고
  대부분 Objects(JSON)을 사용하게 된다. Objets가 사용되는 경우에는 key:value 형태이므로
  DataTables이 어떤 데이터를 그리드에 어떤 column에 표현해야 하는지 모르기 때문에
  columns 옵션을 통해 순서와 데이터를 지정하게 되는 것이다.
</p>
<pre><code class="javascript">render: function(data, type, row, meta) {
  return $('&lt;a&gt;', {
    href: 'view?no=' + row.no, text: data
  })[0].outerHTML;
}</code></pre>
<p>
  중간에 위와 같은 코드가 있는데 DataTables가 데이터를 그리드에 표현할 때는 Objects있는 value 값을
  그대로 출력하는 것에 그친다. 값만 출력하는 것이 아니고 그 값에 Anchor 태그를 붙여야 한다면
  어떻게 해야 할까? DataTables은 render라는 옵션을 제공하고 개발자가 표현하는 방법에 개입하 수 있게
  하고있다. 원하는 형태대로 데이터를 가공한 다음 가공된 값을 리턴하면 된다. 예제에서는 Anchor 태그로 감싼 값을 리턴했다.
</p>
<blockquote>
  <p>
    여기까지 DataTables이 그리드에 데이터를 출력하는 방법에 대해 설명했다면 다음은 출력된 데이터를
    검색하는 기능에 대해 설명한다.
  </p>
</blockquote>
<p>
  DataTables은 그리드에 출력된 데이터를 검색할 수 있는 다양한 filtering 기능을 제공한다.
  위에서 설명했던 전역 검색 외에도 table의 footer 영역에 filter component를 두어 검색 기능을 제공하는 등
  다양한 기능을 제공하고 있으나 이런 형태의 기능은 실제 프로젝트 현실과는 거리가 좀 있다.
</p>
<ul>
  <li><a href="https://datatables.net/examples/api/multi_filter.html" target="_blank">Individual column searching (text inputs)</a></li>
  <li><a href="https://datatables.net/examples/api/multi_filter_select.html" target="_blank">Individual column searching (select inputs)</a></li>
</ul>
<p>
  때문에 예제에서는 현실과 가장 가까운 검색 폼을 제공하는 형태로 설명한다.
</p>
<pre><code class="html">&lt;div id=&quot;gridSearch&quot; class=&quot;form-inline&quot;&gt;
  &lt;input type=&quot;text&quot; class=&quot;form-control&quot; placeholder=&quot;&#51060;&#47492;&quot; data-column=&quot;1&quot;&gt;
  &lt;input type=&quot;text&quot; class=&quot;form-control&quot; placeholder=&quot;&#50672;&#48393;&quot; data-column=&quot;2&quot;&gt;
  &lt;div class=&quot;form-group&quot;&gt;
    &lt;div class=&quot;input-group date&quot;&gt;
      &lt;input type=&quot;text&quot; class=&quot;form-control date&quot; placeholder=&quot;&#51077;&#49324;&#51068;&quot; data-column=&quot;3&quot;&gt;
      &lt;span class=&quot;input-group-addon&quot;&gt;
        &lt;span class=&quot;glyphicon glyphicon-calendar&quot;&gt;&lt;/span&gt;
      &lt;/span&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  &lt;input type=&quot;text&quot; class=&quot;form-control&quot; placeholder=&quot;&#48512;&#49436;&quot; data-column=&quot;4&quot;&gt;
&lt;/div&gt;</code></pre>
<p>
  검색을 위해 간단한 폼을 하나 만든다.
</p>
<pre><code class="javascript">$('#gridSearch').on('keyup', 'input', function() {
  var $input = $(this);
  Grid.filterColumn($grid, $input.data('column'), $input.val());
});</code></pre>
<p>
  검색 폼에있는 input 태그들에 keyup 이벤트를 등록하고 keyup이 발생할 때 마다
  그리드의 데이터를 필터링 할 수 있도록 Grid.filterColumn() 함수를 호출한다.
  <kbd>Grid.filterColumn($grid, $input.data('column'), $input.val());</kbd> 코드에 대해
  설명하면 <kbd>$grid(table)</kbd>의 n번째에 해당하는 컬럼 인덱스(<kbd>$input.data('column')</kbd>)를
  입력한 값으로(<kbd>$input.val()</kbd>) 검색하겠다는 의미가 된다.
</p>
<div id="gridSearch" class="form-inline">
  <input type="text" class="form-control" placeholder="이름" data-column="1">
  <input type="text" class="form-control" placeholder="연봉" data-column="2">
  <div class="form-group">
    <div class="input-group date">
      <input type="text" class="form-control date" placeholder="입사일" data-column="3">
      <span class="input-group-addon">
        <span class="glyphicon glyphicon-calendar"></span>
      </span>
    </div>
  </div>
  <input type="text" class="form-control" placeholder="부서" data-column="4">
</div>
<table id="client" class="table table-striped table-bordered">
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
    var $grid = $('#client').DataTable({
      ajax: {
        url: '/sample/employees',
        dataSrc: ''
      },
      columnDefs: [{
        targets: [4],
        visible: false
      }],
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

    $('#gridSearch').on('keyup', 'input', function() {
      var $input = $(this);
      Grid.filterColumn($grid, $input.data('column'), $input.val());
    });

    $grid.on('click', 'a', function(e) {
      e.preventDefault();
      alert($(this).text());
    });
  });
</script>