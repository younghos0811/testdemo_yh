<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote>
  <p>
    DateTimePicker는 jQuery를 이용하여 직접 호출할 수도 있고 HTML의 User Attribtue
    에 속성을 지정하여 사용할 수도 있다. 기본적인 사용은 User Attribtue 방식을 사용하고
    User Attribtue로 표현하기 힘든(프로그래밍적 요소가 많은) DateTimePicker는 jQuery 방식을 사용한다.
    DateTimePicker의 다양한 API는
    <strong><a href="https://eonasdan.github.io/bootstrap-datetimepicker" target="_blank">홈페이지</a></strong>를 참고.
  </p>
</blockquote>
<p>
  다음은 jQuery 방식으로 옵션으로는 날짜 포멧을 YYYY/MM/DD 형태로, 오늘 이전 날짜는 선택하지 못하게하는 옵션을 준 예제.
</p>
<div class="form-group">
  <div class="input-group" id="datetimepicker">
    <input type="text" class="form-control" data-date-format="YYYY/MM/DD" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar"></span>
    </span>
  </div>
</div>
<pre><code class="javascript">$("#datetimepicker").datetimepicker({
  format: 'YYYY/MM/DD',
  minDate: moment()
});</code></pre>
<script type="text/javascript">
  $(document).ready(function () {
    $("#datetimepicker").datetimepicker({
      format: 'YYYY/MM/DD',
      minDate: moment()
    });
  });
</script>
<p>
  위 jQeury 방식의 옵션과 동일하지만 User Attribute를 활용한 예제로 이 방식이 전체 프로젝트에서 표준이다.
  User Attribtue방식을 사용할 경우 class 속성에 반드시 <kbd>calss="date"</kbd> 속성이 지정되어 있어야 한다.
</p>
<div class="form-group">
  <div class="input-group date">
    <input type="text" class="form-control input-date" data-date-min-date="2016-08-16" data-date-default-date="2016-08-16" />
    <span class="input-group-addon">
      <span class="glyphicon glyphicon-calendar"></span>
    </span>
  </div>
</div>
<pre><code class="html">&lt;div class=&quot;form-group&quot;&gt;
  &lt;div class=&quot;input-group date&quot;&gt;
    &lt;input type=&quot;text&quot; class=&quot;form-control&quot; data-date-min-date=&quot;2016-08-16&quot; data-date-default-date=&quot;2016-08-16&quot; /&gt;
    &lt;span class=&quot;input-group-addon&quot;&gt;
      &lt;span class=&quot;glyphicon glyphicon-calendar&quot;&gt;&lt;/span&gt;
    &lt;/span&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>
