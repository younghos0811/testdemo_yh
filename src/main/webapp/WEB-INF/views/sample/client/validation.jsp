<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote>
  <p>
    JavaScript의 Form Validation은 반복적으로 같은 코드가 사용되고 매우 귀찮고 번거로운 처리이다.
    Parsley는 이런 귀찮은 작업을 심플하게 작성 가능하도록 하는 Validation Libary이다.
    기본적으로 제공해주는 Field Validator로 왠만한 검증은 가능하고 프로젝트에 Specific한 내용은
    확장 기능을 통해 Custom Validator를 만들 수도 있다. 자세한 내용은
    Parsley <a href="http://parsleyjs.org/doc/index.html" target="_blank"><strong>문서</strong></a>를 참고한다.
  </p>
</blockquote>
<p>
  Parsley는 User Attribute로 Validation 속성을 지정하는 것을 기본으로 한다.
  즉, HTML 태그내에 제약을 하고자하는 Validator를 지정하게 된다.
</p>
<pre><code class="html">&lt;input type=&quot;text&quot; class=&quot;form-control&quot; id=&quot;name&quot; name=&quot;name&quot; placeholder=&quot;&#51060;&#47492;&quot; data-parsley-length=&quot;[2, 5]&quot; data-parsley-required&gt;
&lt;input type=&quot;text&quot; class=&quot;form-control input-date&quot; id=&quot;hireDate&quot; name=&quot;hireDate&quot; placeholder=&quot;&#51077;&#49324;&#51068;&quot; data-parsley-date data-parsley-required&gt;
&lt;input type=&quot;radio&quot; name=&quot;subscribe&quot; value=&quot;option2&quot; data-parsley-required&gt; &#45348;
&lt;input type=&quot;radio&quot; name=&quot;subscribe&quot; value=&quot;option2&quot;&gt; &#50500;&#45768;&#50724;
&lt;input type=&quot;text&quot; class=&quot;form-control input-numeral&quot; id=&quot;salary&quot; name=&quot;salary&quot; placeholder=&quot;&#50672;&#48393;&quot; data-parsley-currency data-parsley-required&gt;
&lt;input type=&quot;text&quot; class=&quot;form-control&quot; id=&quot;dept&quot; name=&quot;dept&quot; placeholder=&quot;&#48512;&#49436;&quot; data-parsley-required&gt;
&lt;select class=&quot;form-control&quot; id=&quot;hobby&quot; name=&quot;hobby&quot; data-parsley-required&gt;
  &lt;option value=&quot;&quot; selected disabled&gt;--- &#49440;&#53469; ---&lt;/option&gt;
  &lt;option&gt;&#50689;&#54868;&#44048;&#49345;&lt;/option&gt;
  &lt;option&gt;&#50868;&#46041;&lt;/option&gt;
  &lt;option&gt;&#44172;&#51076;&lt;/option&gt;
  &lt;option&gt;&#45909;&#54980;&#51656;&lt;/option&gt;
&lt;/select&gt;
&lt;input type=&quot;email&quot; class=&quot;form-control&quot; id=&quot;email&quot; name=&quot;email&quot; placeholder=&quot;abc@korea.com&quot;&gt;</code></pre>
<p>
  먼저 '이름' input을 보면 두 가지 속성이 사용되었다.
</p>
<ul>
  <li>data-parsley-required: 필수 입력 값을 나타내는 속성</li>
  <li>data-parsley-length: 입력 값은 반드시 n부터 n개까지 나타내는 속성</li>
</ul>
<p>
  위와 같이 input 다양한 옵션을 사용하여 입력 값에 제약을 줄 수 있다.
  다양한 Validator 옵션은 <a href="http://parsleyjs.org/doc/index.html#validators-overview" target="_blank"><strong>문서</strong></a>를 참고한다.
  예제에서 입사일, 연봉 input의 <kbd>data-parsley-date</kbd>, <kbd>data-parsley-currency</kbd> Validator는 Parsley가 제공해주는 Validator가 아닌
  Custom Validator이다. 날짜, 통화와 같은 제약은 국가마다 양식이 달라 기본으로 제공하는 게 의미없다고 생각하여 제공하지 않는 것 같다.
  <kbd>data-parsley-date</kbd>는 yyyy-mm-dd 형태의 날짜 포멧을 검증하는 Validator이고 <kbd>data-parsley-currency</kbd>는 123,456 형태의
  통화를 검증하는 Validator이다. 만약 <kbd>data-parsley-date</kbd>를 지정한 input에 '2016-08-1a' 같은 값을 입력 했다면
  Validator에 의해 유효한 값을 입력하라는 메시지가 나타날 것이다. 이것만으로도 충분하지만 좀 더 User Friendly한 시스템을
  만든다면 위 섹션 중 'Input Formatter'의 'input_date' 기능을 함께 제공해주게 되면 애초에 문자를 입력할 수 없을 것이고 또한 '-'(hyphen)도 자동으로 붙어
  좀 더 세련된 시스템을 만들 수 있을 것이다. <kbd>data-parsley-currency</kbd> 또한 마찬가지로 'input_numeral' 기능을 함께 제공해주면 좋을 것이다.
</p>
<p>
  이렇게 User Attribute로 지정된 Validator가 실행 실행되기 위해서 약간의 JavaScript 코드가 필요하다.
</p>
<pre><code class="javascript">$('#validationForm').parsley().on('form:submit', function(parsleyForm) {
  $.post('sample/employees', parsleyForm.$element.serialize(), function(data) {
    alert('submit complete');
  });
  return false;
});</code></pre>
<p>
  먼저 검증할 폼(<kbd>$('#validationForm')</kbd>)을 선택한 후 <kbd>parsley()</kbd>함수를 호출하면 끝이다.
  폼의 검증이 에러없이 정상적으로 종료가되면 submit이 일어나게 되는데 ajax를 사용하는 환경에서는
  실제 폼이 submit되면 안 되므로 submit 이벤트를 직접 처리하여 submit을 막고 원하는 작업을 수행한다.
</p>
<p>
  <kbd>on('form:submit'...</kbd> 코드 부분이 form submit 이벤트를 처리하는 코드로
  jQuery ajax로 폼의 입력 값을 서버로 보내고 submit 이벤트를 무효화 하기 위해서 <kbd>return false</kbd>를 하였다.
  사실 submit 이벤트를 무효화 하는 것은 콜백 함수의 파라미터로 전달해주는 <kbd>parsleyForm</kbd> 객체의
  submitEvent property의 preventDefault()를 호출하여 submit 이벤트를 무효화 하는 것이 맞지만
  무슨 이유인지는 모르겟지만 이 코드가 정상적으로 동작하지 않는다. 이와 관련하여 질문도 있지만
  아직 특별한 해결책은 없는 것 같다.
  <a href="http://stackoverflow.com/questions/38350850/formsubmit-unable-to-prevent-default-with-return-false" target="_blank">form:submit unable to prevent default with return false</a>
</p>

<p>
  html 구조가 잘못되어 있는 경우, (예:닫히지 않은 태그, 태그 누락) 특정 브라우저에서 동작하지 않는 현상이 있으므로,
  이 경우, html 문서의 구조를 먼저 확인하도록 한다.
</p>
<hr />
<form class="form-horizontal" id="validationForm">
  <div class="row">
    <div class="col-md-6">
      <div class="form-group">
        <label for="name" class="col-sm-2 control-label">이름</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="name" name="name" placeholder="이름" data-parsley-length="[2, 5]" data-parsley-required>
        </div>
      </div>
      <div class="form-group">
        <label for="hireDate" class="col-sm-2 control-label">입사일</label>
        <div class="col-sm-10 controls">
          <div class="input-group date">
            <input type="text" class="form-control input-date" id="hireDate" name="hireDate" placeholder="입사일" data-parsley-date data-parsley-required>
            <span class="input-group-addon">
              <span class="glyphicon glyphicon-calendar"></span>
            </span>
          </div>
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
          <div class="checkbox">
            <label>
              <input type="checkbox" name="married"> 결혼여부
            </label>
          </div>
        </div>
      </div>
      <div class="form-group">
        <label class="col-sm-2 control-label">Subscribe</label>
        <div class="col-sm-10">
          <div class="radio">
            <label>
              <input type="radio" name="subscribe" value="option2" data-parsley-required> 네
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="subscribe" value="option2"> 아니오
            </label>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="form-group">
        <label for="salary" class="col-sm-2 control-label">연봉</label>
        <div class="col-sm-10">
          <input type="text" class="form-control input-numeral" id="salary" name="salary" placeholder="연봉" data-parsley-currency data-parsley-required>
        </div>
      </div>
      <div class="form-group">
        <label for="dept" class="col-sm-2 control-label">부서</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="dept" name="dept" placeholder="부서" data-parsley-required>
        </div>
      </div>
      <div class="form-group">
        <label for="hobby" class="col-sm-2 control-label">취미</label>
        <div class="col-sm-10">
          <select class="form-control" id="hobby" name="hobby" data-parsley-required>
            <option value="" selected disabled>--- 선택 ---</option>
            <option>영화감상</option>
            <option>운동</option>
            <option>게임</option>
            <option>덕후질</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <label for="email" class="col-sm-2 control-label">이메일</label>
        <div class="col-sm-10">
          <input type="email" class="form-control" id="email" name="email" placeholder="abc@korea.com">
        </div>
      </div>
    </div>
  </div>
  <button class="btn btn-primary">저장</button>
</form>
<script type="text/javascript">
  $(document).ready(function() {
    // http://stackoverflow.com/questions/38350850/formsubmit-unable-to-prevent-default-with-return-false
    $('#validationForm').parsley().on('form:submit', function(parsleyForm) {
      $.post('sample/employees', parsleyForm.$element.serialize(), function(data) {
        alert('submit complete');
      });
      return false;
    });
  });
</script>