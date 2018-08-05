<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote>
  <p>
    Bootstrap의 Modal dialog에 대해 알아본다. 자세한 내용은 Bootstrap의
    <a href="http://getbootstrap.com/javascript/#modals" target="_blank">Modals</a> 문서를 참고한다.
  </p>
</blockquote>
<p>
  보통 Modal dialog의 사용법들을 보면 특정 페이지내에 Modal div을 만들어놓고 사용하는 예제들이 대부분이다.
  일반적인 예제 내용처럼 사용하게 되면 몇가지 문제가 있다.
</p>
<ul>
  <li>공통으로 사용되는 Modal의 경우에도 매 페이지마다 Modal div 구성을 해야한다.</li>
  <li>Modal Open/Close 스크립트가 Modal을 포함하는 페이지마다 존재해야한다.</li>
  <li>기타 등등</li>
</ul>
<p>
  물론 일반적인 프로젝트에서는 위와 같은 문제는 JSP include 등을 사용해서 해결하겠지만
  include는 왠지 세련된 방법처럼 보이지 않는다.
  본 프로젝트에서는 동적으로 Modal div를 구성하고 Modal 내의 Contents도 동적으로 가져와
  구성할 것이다. 또 Open/Close 스크립트 작성도 불필요하게 구성한다. 이 방법은 기본적으로
  Bootstrap에서 제공하는 기능이며 약간의 확장을 통해 좀 더 편하게 구성했다.
</p>
<pre><code class="html">&lt;a data-toggle=&quot;modal&quot; href=&quot;&quot; data-target=&quot;#modal1&quot; data-options='{&quot;update&quot;: true, &quot;class&quot;: &quot;modal-dialog modal-lg&quot;}'&gt;Click me&lt;/a&gt;
&lt;a data-toggle=&quot;modal&quot; href=&quot;sample/modals/2?value=Second%20modal&quot; data-target=&quot;#modal2&quot; class=&quot;btn btn-primary&quot;&gt;Click me&lt;/a&gt;</code></pre>
<p>
  Modal을 띄우기 위한 코드는 위 HTML이 전부이다. 두 개의 Anchor 태그가 있는데 동일한 기능을 하는 Anchor 태그이지만
  Anchor 태그를 일반적인 링크처럼 사용하는 방법과 버튼처럼(<kbd>class="btn btn-primary"</kbd>) 사용하는 방법을 보여주기 위한 예제이다.
  각 화면의 요구사항에 맞게 적절한 Anchor 태크를 사용하면 되겠다.
</p>
<p>
  먼저 Modal을 사용하기 위해서는 몇 가지 옵션을 주어야한다.
  Anchor가 모달을 띄우는 버튼인지 알려주는 <kbd>data-toggle="modal"</kbd> 속성,
  모달 div를 가르키는 <kbd>data-target="#modal1"</kbd> 속성 이 두가지 속성을 주면 기본적으로
  Modal을 띄울 수 있다. <kbd>data-target="#modal1"</kbd> 속성 값은 ID Seletor로 페이지내의
  유니크한 임의의 값을주면 런타임 시에 <kbd>data-target="#modal1"</kbd> 속성 값인 'modal1'을 id로 하는
  Modal div을 생성한다. 마지막으로 <kbd>href</kbd> 속성으로 모달의 컨텐츠 영역을 표현하는
  서버상의 리소스를 가르키면 된다.
</p>
<p>
  지금까지는 단순한 경우의 모달 사용 방법이였다. 하지만 다양한 상황에서는 위와 같이 정적인 모달로는
  한계가 있다. 모달은 Open 후 Close된면 모달 Element가 사라지는 것이 아니고 눈에만 안 보일 뿐이다.
  다시 또 모달을 오픈하면 Close 하기전 상태 그대로 다시 오픈이된다. 이 경우 문제가 되는상황을 보면
  사용자를 조회하는 모달이 있고 특정인을 조회한 후 모달을 닫았다가 다시 오픈하면 조금 전에 조회한 검색어
  그리고 검색어에 해당하는 목록이 그대로 출력된다. 프로젝트 요건상 이런 형태로 올바른 형태일 수도 있겠지만
  대부분의 상황에서는 검색어, 목록이 초기화 될 것을 기대하게된다.
  상태를 초기화 하는 방법은 여러가지 방법(form reset 등)이 있을 수 있겠지만 손이 안가고 가장 쉬운방법은
  모달 컨텐츠를 다시 재로딩하는 방법이다.
</p>
<p>
  재로딩 하는 옵션이 <kbd>data-options='{"update": true, "class": "modal-dialog modal-lg"}'</kbd>
  부분으로 <kbd>update: true</kbd> 부부이다. update 옵션을 주면 모달이 닫힐 때 모달 컨텐츠를 제거하고
  다시 오픈될 때 컨텐츠 부분을 재로딩한다. 다음으로 <kbd>class: modal-dialog modal-lg</kbd> 옵션은
  첫번째, 두번째 모달의 크기가 다른데 해당 옵션으로 크기를 지정할 수 있다. 크기는 대, 중, 소 크기를 제공하는데
  옵션이 없으면 중간 크기의 모달이 뜬다. 크기에 따른 css 클래스는 Bootstrap
  <a href="http://getbootstrap.com/javascript/#modals" target="_blank">Modals</a> 문서를 참고한다.
</p>
<div class="alert alert-danger" role="alert">
  <kbd>data-options='{"update": true, "class": "modal-dialog modal-lg"}'</kbd> 속성 지정 시
  주의해야 할 부분은 data-options은 JSON Object로 지정되어야 한다는 점이다.
  반드시 key: value를 더블 쿼테이션(double quotes)오 감싸주여야 JSON parse가 제대로 동작한다.
  (boolean, integer 값은 제외)
</div>
<p>
  현실 세계는 Tutorial들이 제공하는 예제보다 항상 더 복잡하다. 만약 모달의 컨텐츠를 지정하는 <kbd>href</kbd> 속성이
  특정한 로직에 의해 동적으로 변해야 한다면 어떻게 해야할까? 방법은 아래 코드처럼 스크립트와 같이
  <kbd>href</kbd>속성을 동적으로 변경하고자하는 Anchor에 click 이벤트를 등록하고 해당 이벤트에서
  href 속성을 변경하면 된다.
</p>
<pre><code class="javascript">$('[data-target="#modal1"]').click(function() {
  this.href = 'sample/modals/1?value=First%20modal%23' + Math.floor(Math.random() * 100);
});</code></pre>
<hr />
<a data-toggle="modal" href="" data-target="#modal1" data-options='{"update": true, "class": "modal-dialog modal-lg"}'>Click me</a>
<a data-toggle="modal" href="/sample/modals/2?value=Second%20modal" data-target="#modal2" class="btn btn-primary">Click me</a>
<script type="text/javascript">
  $(document).ready(function() {
    $('[data-target="#modal1"]').click(function() {
      this.href = '/sample/modals/1?value=First%20modal%23' + Math.floor(Math.random() * 100);
    });
  });
</script>