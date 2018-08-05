<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
  .twitter-typeahead {
    width: 100%;
  }
  .tt-query,
  .tt-hint {
    width: 396px;
    height: 30px;
    padding: 8px 12px;
    font-size: 24px;
    line-height: 30px;
    border: 2px solid #ccc;
    -webkit-border-radius: 8px;
       -moz-border-radius: 8px;
            border-radius: 8px;
    outline: none;
  }
  .tt-query {
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
       -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
  }
  .tt-hint {
    color: #999
  }
  .tt-menu {
    max-height: 200px;
    overflow-y: auto;
    width: 422px;
    margin: 12px 0;
    padding: 8px 0;
    background-color: #fff;
    border: 1px solid #ccc;
    border: 1px solid rgba(0, 0, 0, 0.2);
    -webkit-border-radius: 8px;
       -moz-border-radius: 8px;
            border-radius: 8px;
    -webkit-box-shadow: 0 5px 10px rgba(0,0,0,.2);
       -moz-box-shadow: 0 5px 10px rgba(0,0,0,.2);
            box-shadow: 0 5px 10px rgba(0,0,0,.2);
  }
  .tt-suggestion {
    padding: 3px 20px;
    font-size: 18px;
    line-height: 24px;
  }
  .tt-suggestion:hover {
    cursor: pointer;
    color: #fff;
    background-color: #0097cf;
  }
  .tt-suggestion.tt-cursor {
    color: #fff;
    background-color: #0097cf;

  }
  .tt-suggestion p {
    margin: 0;
  }
  .tt-dropdown-menu {
    max-height: 200px;
    overflow-y: auto;
  }
</style>
<blockquote>
  <p>
    조회, 등록과 같은 폼에서 단순하게 특정 코드를 찾기 위해 팝업을 띄워 검색하는 방법은 여러번의 오퍼레이션을
    필요로 하며 개발 또한 번거롭고 사용자에게 좋은 UX를 제공하지 못 한다.
    이런 경우 자동완성 기능을 사용하면 심플한 화면 구성이 가능하다.
    보통 자동완성 기능은 jQuery UI를 많이 사용하는데 typeahead는 jQuery UI의 그것보다
    진일보된 기능(캐시 등)을 제공하고 코드의 양도 더 적다.
    자세한 내용은 typeahead <a href="https://github.com/twitter/typeahead.js" target="_blank"><strong>문서</strong></a>를 참고한다.
  </p>
</blockquote>
<p>
  typeahead는 단독으로 사용할 수도 있지만 bloodboud와 함께 사용하면 더 좋다.
</p>
<ul>
  <li>bloodboud.js: standalone suggestion engine</li>
  <li>typeahead.js: standalone UI view</li>
</ul>
<p>
  bloodboud는 자동완성 엔진이고 typeahead는 자동완성 데이터를 화면에 표현하는 라이브러리이다.
  먼저 자동완성을 하기 위해서는 사용자가 입력한 키워드에 해당하는 데이터를 ajax를 통해
  서버로부터 가져와야한다.
</p>
<pre><code class="javascript">var employees = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.whitespace,
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    url: 'sample/employees?dummy=&amp;name=%QUERY',
    wildcard: '%QUERY',
    transform: function(response) {
      return response.data;
    }
  }
});</code></pre>
<p>
  <kbd>datumTokenizer</kbd>, <kbd>queryTokenizer</kbd> 은 신경쓰지말고 항상 이렇게 쓰자...
  <kbd>remote</kbd>가 ajax를 통해 자동완성을 할 데이터를 가져오는 부분이다.
  코드 중에 <kbd>%QUERY</kbd>는 input 에 입력한 키워드가 wildcard에 지정된 문자열로
  치환이 된다.
</p>
<p>
  예제는 사원명을 키워드로 특정 사원을 자동완성 하는 예제이다.
  사원목록은 이전 예제의 Grid에서 사용하는 Java Method를 그대로 사용을한다.
  Grid의 응답 메시지는 사원목록 뿐아니라 recordsTotal등 여러가지 메시지를 응답으로 받는데
  자동완성에서는 사원목록만 유의미할 뿐이고 나머니 응답 메시지들은 불필요하다.
  불필요한 메시지를 필터링해야 하는데 이 때 사용하는 옵션이 <kbd>transform</kbd> 옵션이다.
  <kbd>transform</kbd>은 ajax를 통신을 통해 받은 응답 메시지를 전달해주고 자동완성에
  필요한 데이터를 리턴해주면 된다.
</p>
<p>
  자동완성에 필요한 데이터를 Bloodhound를 통해 가져오는 방법은 완성 되었으니 이제 데이터를
  화면에 표시하는 일이 남았다.
</p>
<div class="alert alert-danger" role="alert">
  url에 dummy= 파라미터는 예제 페이지를 구성하는데 필요한 의미없는
  파라미터이므로 무시한다. 혹시라도 예제를 보고 실제 프로젝트 적용할 때
  넣지 않도록 주의한다.
</div>
<pre><code class="javascript">$('#autocomplete').typeahead(Typeahead.default, {
  display: 'name',
  limit: 100,
  source: employees
}).on('typeahead:select', function(event, suggestion) {
  console.log(suggestion);
});</code></pre>
<p>
  사원목록의 응답 메시지는 사원번호, 이름, 연봉 등 사원정보에 대한 여러가지 정보를 담고있다.
  이 여러가지 정보 중 자동완성 시에 사용자에게 어떤 정보를 보이게 할 것인지 정해야 한다.
  <kbd>display: 'name'</kbd> 옵션으로 사원목록 응답 메시지에서 'name' 항목이 자동완성 ui에 나타나게 될것이다.
</p>
<p>
  자동완성을 하는데 특정 키워드에 해당하는 데이터가 1000개 이상이라면 어떻게 될까?
  1000개 이상의 데이터가 화면에 출력될 것이고 그 중 사용자가 필요로하는 데이터를 찾기위해
  커서 또는 스크롤을 내리면서 찾아야 할 것이고 또 많은 데이터를 렌더링 해야 하므로
  성능적으로도 기대에 미치기 어려울 수도 있다.
  이런 경우는 자동완성을 사용하지 않는 것이 좋을 수도 있다.
  자동완성은 최소한의 정보가 출력되어 사용자가 필요로하는 데이터를 빠르게 찾아갈 수 있어야만
  의미가 있다. 만약 특정 키워드에 해당하는 데이터가 많은 경우에는 키워드를 좀 더 길게 입력하게 하거나
  또는 자동완성 목록의 갯수를 제한하여 다른 키워드를 입력하게 유도하는 것이 좋다.
  <kbd>limit: 100</kbd> 옵션은 자동완성 데이터가 1000개 이상이더라도 100개까지만 출력하는 옵션으로
  자동완성 기능을 사용하는 페이지의 데이터를 고려하여 적정한 옵션을주어 사용하도록한다.
</p>
<p>
  <kbd>source</kbd> 옵션은 Bloodhound의 인스턴스를 넣으면 된다.
</p>
<p>
  마지막으로 사용자가 자동완성 결과 중 특정한 항목을 선택했을 때 우리는 여러가지 일을 해야한다.
  단순하게는 사용자가 선택한 사원의 키 값(사원번호)를 hidden 필드에 넣는다거나 사원정보를
  업데이트 한다거나 등등 프로젝트 요건 상 다양한 일들이 수반되게 된다.
  typeahead는 다양한 이벤트를 제공해주는데 아마도 'typeahead:select' 이벤트가 가장 많이
  사용되는 이벤트일 것이다. 자동완성 항목 중 특정 항목을 선택하면 'event' 객체와 선택한
  항목의 데이터(suggestion)를 매개변수로 콜백함수를 호출해주므로 콜백함수에 요건에 맞는
  로직을 넣으면 된다.
</p>
<hr />
<div id="scrollable-dropdown-menu">
  <input type="text" class="form-control" id="autocomplete" name="name" placeholder="이름">
</div>
<script type="text/javascript">
  $(document).ready(function() {
    var employees = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: {
        url: '/sample/employees?dummy=&name=%QUERY',
        wildcard: '%QUERY',
        transform: function(response) {
          return response.data;
        }
      }
    });

    $('#autocomplete').typeahead(Typeahead.default, {
      display: 'name',
      limit: 100,
      source: employees
    }).on('typeahead:select', function(event, suggestion) {
      console.log(suggestion);
    });

    $(document).ajaxSend(function(event, xhr, options) {
      if (options.url.indexOf('dummy') > -1) {
        xhr.setRequestHeader('identity', 'custom');
      }
    });
  });
</script>