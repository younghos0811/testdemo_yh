<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote>
  <p>
    jQuery의 Tree 플러그인 중 Bootstrap에 최적화된 트리 플러그인으로
    다양한 옵션을 제공한다.
    M-Doumi에서 품의서를 선택하는 화면에도 트리가 사용되는데 M-Doumi의 품의서 선택하는
    정도의 요구사항에서는 사실 트리 플러그인을 사용하지 않는 게 더 쉬울 수 있다.
    (트리 플러그인을 사용하려면 제공되는 API를 습득 및 학습 시간이 걸릴 수 있으므로...)
    M-Doumi의 트리는 트리처럼 보일 뿐 트리의 여러가지 기능이 필요하지 않은 형태의 트리 요건이다.
    단순히 레벨에 따라 margin 또는 padding 만 주어도 현재 M-Doumi형태의 트리 화면을 쉽게 구현이
    가능하다. 본 트리 플러그인은 품의서 선택 화면처럼 단순하지 않은 트리를 구현할 때 사용하는 게 좋겠다.
    자세한 내용은 Bootstrap Tree View <a href="https://github.com/jonmiles/bootstrap-treeview" target="_blank"><strong>문서</strong></a>를 참고한다.
  </p>
</blockquote>
<p>
  잘 만들어진 jQuery 트리 플러그인들은 비동기 요청 그리고 트리 노드의 DnD 등
  많은 기능을 지원하는 반면 Bootstrap Tree View 플러그인은 이런 기능을 지원하지 않는다. 대신
  기능이 단순한 반면 구현이 좀 더 쉽고 코드양도 상대적으로 적은 잇점이 있다.
  본 트리 예제는 품의서 선택 화면을 본 플러그인으로 구현할 경우를 예상하여 예제를 작성했다.
  먼저 ajax를 지원하지 않으므로 트리 데이터를 ajax로 가져와야 할 경우 구현 예이다.
</p>
<pre><code class="javascript">$.getJSON('/sample/organizations', function(response) {
  $('#tree').treeview({
    data: response,
    showBorder: false,
    showCheckbox: true,
    onNodeChecked: function(event, node) {
      if (!node.checkable) {
        $(this).treeview('uncheckNode', [node.nodeId]);
      }
    }
  }).treeview('expandAll');
});</code></pre>
<p>
  만약 Bootstrap Tree View 플러그인이 ajax를 지원했다면 <kbd>data</kbd>옵션에
  ajax 코드가 들어가 있었겠지만 지원하지 않으므로 ajax를 먼저 호출한 다음
  success 콜백 함수에서 Bootstrap Tree View 플러그인을 호출한다.
</p>
<p>
  품의서 선택 화면은 각 노드마다 보더를 표시하지 않으므로 <kbd>showBorder</kbd> 옵션을 false 값으로 주고
  품의서를 선택해야 하므로 <kbd>showCheckbox</kbd> 옵션을 true로 주었다.
</p>
<p>
  다음으로 Leaf 노드만 체크박스 선택이 되어야 하므로 Leaf 노드가 아닌 노드는
  <kbd>onNodeChecked</kbd> 이벤트에서 해당 노드가 체크 가능한 노드인지 아닌지를
  식별한 다음 체크 가능한 노드가 아니라면 <kbd>uncheckNode</kbd> 메소드를 사용하여
  체크가 되지 않도록 했다. <kbd>node.checkable</kbd>의 checkable은 사실 Bootstrap Tree View가
  지원하는 property가 아니고 임의로 만든 property이다. 필요하다면 checkable처럼 개발자 마음대로
  custom property를 추가할 수 있다. 여기서 custom property라는 의미는 Bootstrap Tree View 문서를 보면
  알겠지만 Bootstrap Tree View의 트리 노드의 데이터는 다음과 같은 스펙을 갖는다.
</p>
<pre><code class="javascript">{
  text: "Node 1",
  icon: "glyphicon glyphicon-stop",
  selectedIcon: "glyphicon glyphicon-stop",
  color: "#000000",
  backColor: "#FFFFFF",
  href: "#node-1",
  selectable: true,
  state: {
    checked: true,
    disabled: true,
    expanded: true,
    selected: true
  },
  tags: ['available'],
  nodes: [
    {},
    ...
  ]
}</code></pre>
<p>
  Bootstrap Tree View의 트리 노드 데이터에는 checkable이라는 속성이 없지만
  필요한 속성이 있다면 얼마든지 추가하여 사용할 수 있다.
  이렇게 만들어진 트리는 최초에는 펼쳐져있지 않고 접혀져있다.
  품의서 선택 화면은 모든 노드가 펼쳐있으므로 <kbd>.treeview('expandAll')</kbd> 메소드를
  통해 트리의 모든 노드를 펼쳐진 상태로 만든다.
</p>
<pre><code class="javascript">$("#checkbutton").click(function() {
  var checkedItems = $('#tree').treeview('getChecked');
  for (var i = 0; i &lt; checkedItems.length; i++) {
    console.log(checkedItems[i]);
  }
});</code></pre>
<p>
  품의서를 선택했다면 품의서 작성화면으로 가기전에 어떤 품의서가 선택되었는지
  또 선택된 품의서가 함께 작성 가능한 품의서인지 등을 판단해야 하므로
  <kbd>getChecked</kbd> 메소드를 통해 현재 체크된 품의서 목록을 가져온 후
  요구사항에 맞는 로직을 넣으면 된다.
</p>
<hr />
<div id="tree"></div>
<button type="button" id="checkbutton" class="btn btn-primary">체크된 아이템 확인</button>
<script type="text/javascript">
  $(document).ready(function() {
    $.getJSON('/sample/organizations', function(response) {
      $('#tree').treeview({
        data: response,
        showBorder: false,
        showCheckbox: true,
        onNodeChecked: function(event, node) {
          if (!node.checkable) {
            $(this).treeview('uncheckNode', [node.nodeId]);
          }
        }
      }).treeview('expandAll');
    });

    $("#checkbutton").click(function() {
      var checkedItems = $('#tree').treeview('getChecked');
      for (var i = 0; i < checkedItems.length; i++) {
        console.log(checkedItems[i]);
      }
    });
  });
</script>