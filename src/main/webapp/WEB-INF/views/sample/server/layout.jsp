<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    JSP Page의 Layout을 구성하는 방법에는 몇 가지가 있다.
    대표적인 것이 include 지시어를 사용하여 중복되는 코드를 줄여주는 방법이다.
    그러나 여전히 한계가 존재하며 이를 해결하기 위한 더 나은 접근법은 템플릿 중심 아키텍처를 적용하는 것이다.
    Tiles 는 이를 지원하는 templating system으로 웹 어플리케이션의 유저 인터페이스를 단순화 하기위해 만들어졌다.
  </p>
</blockquote>
<dl>
  <dt>Page Layout 구성 방법</dt>
  <dd>
    <ul>
      <li><strong>JSP based approach</strong> : 페이지에 삽입할 기능이 많아질수록 복잡해짐. 소규모 어플리케이션에만 적합</li>
      <li><strong>include 지시어 사용</strong> : 중복되는 코딩 부분의 재사용. 여전히 페이지에서 컨텐츠와 레이아웃이 혼재됨.</li>
      <li><strong>Template based approach</strong> : 페이지의 물리적인 영역을 은닉화하는 방법 제공. 컨텐츠와 레이아웃의 분리</li>
    </ul>
    <img src="/img/sample/server/tiles.gif" class="img-responsive center-block">
  </dd>
  <dt>Layout 선택</dt>
  <dd>
    Tiles의 구성 및 레이아웃 선택하는 방법은 여러가지 방법이있다.
    보통 특정 URL을 기준으로 레이아웃을 선택하는데 이 방법은 수 많은 URL을
    레이아웃과 매핑 시켜야 하므로 매우 번거롭다.
    본 프로젝트에서는 레이아웃 키워드를 기반으로 레이아웃을 선택하는 방법을 취한다.
<pre><code class="java">@RequestMapping
public ModelAndView index() {
    return new ModelAndView("sample:sample/client/index");
}</code></pre>
    View를 리턴할 때 뷰이름에 특정한 prefix를 붙여 리턴한다. 예제에서는 <kbd>sample:</kbd>
    prefix를 붙였고 이는 sample 레이아웃을 선택하여 출력하겠다는 의미이다.
    현재 보고있는 화면이 sample 레이아웃을 기반으로한 화면이다.
    <p>
       레이아웃은 메뉴별, 기능별로 나뉘게 되는데 복잡한 UI를 요구하는 프로젝트 외에는
       기본 레이아웃과 팝업 레이아웃 구성만으로도 충분하다. 팝업(window.open) 레이아웃은
       보통 메뉴가 사라지고 상단에 팝업 창을 닫는 아이콘과 하단에 닫기 버튼을 두는데
       아래 예제를 통해서 확인해보자.
    </p>
    <p>
      <a class="btn btn-primary" href="/sample/popup/server" id="open">Opne Window</a>
    </p>
    예제와 같이 팝업 레이아웃을 선택하려면 <kbd>sample-popup:</kbd> prefix를 붙이면 된다.
    <p>
      사실 프로젝트에서 특별한 경우가 아니면 팝업을 쓸 일은 없을 수도 있다. 팝업대신
      Modal Dialog를 사용하게 될 것이다. 또 예제의 레이아웃 prefix는 예제만을 위한
      레이아웃이므로 실제 프로젝트에서는 <kbd>default:</kbd>, <kbd>default-popup:</kbd> prefix를
      적용하여 사용하면 되겠다.
    </p>
    <p>팝업을 띄우는 스크립트 예제</p>
<pre><code class="javascript">$('#open').click(function(e) {
  e.preventDefault();
  Utils.openWindow(this.href);
});</code></pre>
  </dd>
</dl>
<script type="text/javascript">
  $(document).ready(function() {
    $('#open').click(function(e) {
      e.preventDefault();
      Utils.openWindow(this.href);
    });
  });
</script>