<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    Input element에 대한 Date, Phone number, Numeral 등 포멧을 지정하는 방법은
    class 속성에 input-date, input-numeral 처럼 속성을 지정한다.
    <kbd>class="input-date"</kbd>
    공통적으로 지원하기 어려운 포멧은
    <strong><a href="https://github.com/nosir/cleave.js" target="_blank">홈페이지</a></strong>
    API를 참고하여 구현하도록 한다.
  </p>
</blockquote>
<p>
  날짜 포멧 지정하는 방법으로 기본적으로 YYYY-MM-DD 형태로 지정되어 있다. 기본 포멧을 사용하지
  않는 경우에는 API를 통해 직접 포멧을 지정하도록 한다.
  날짜 뿐 아니라 시간까지 표현해야 한다거나
  <strong>프로젝트 전체적으로 공통 포멧이 지정되어야 하는 경우에는 공통팀에 의뢰한다.</strong>
</p>
<p><input type="text" class="form-control input-date" /></p>
<pre><code class="html">&lt;input type="text" class="form-control input-date" /&gt;</code></pre>
<p>
  위 input-date와 같은 내용 같고 소수점은 2자리까지 표현된다. 마찬가지로 다른 표현에 대해서는
  공통팀과 협의 또는 공통으로 지원하기 어려운 경우에는 API를 통해 직접 구현하도록 한다.
</p>
<p><input type="text" class="form-control input-numeral" /></p>
<pre><code class="html">&lt;input type="text" class="form-control input-numeral" /&gt;</code></pre>