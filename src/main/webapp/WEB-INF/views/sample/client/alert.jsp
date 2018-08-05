<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote>
  <p>
    Browser에서 지원하는 Alert 그리고 Confirm Dialog는 브라우저 종류마다 형태가 다르고
    메시지의 표현(html 사용 불가) 또한 제한적이며 그렇기 때문에 사용자 친화적이지 않다.
    브라우저 기본 Alert, Confirm 대신 Bootstrap Modal Dialog를 사용하도록 한다.
  </p>
</blockquote>
<p>
  Alert, Confirm API는 <kbd>$.alert(message, [callback])</kbd>,
  <kbd>$.confirm(message, [okCallback], [cancelCallback])</kbd>으로 기본 alert, confirm과 사용 방법은
  크게 다르지않고 다만 확인, 취소 버튼을 클릭할 때의 callback 함수를 전달하는 방법만
  조금 다르다.
</p>
<p>
  먼저 Alert 창을 띄우는 예제를 보면
</p>
<pre><code class="javascript">$('#alert').click(function() {
  $.alert('Alert!!', function() {
    alert('Alert 창을 닫습니다!!');
  });
});</code></pre>
<p>
  alert 버튼을 클릭하면 $.alert 함수를 호출하고 첫 번째 매개변수로
  사용자에게 보여줄 메시지를 전달하고 두 번재 매개변수로는 '확인' 버튼을
  클릭할 때 실행할 콜백함수를 전달했다. 콜백이 불 필요한 경우에는 전달하지 않아도된다.
  즉, <kbd>$.alert('Alert!!')</kbd> 형태로 사용해도 된다.
</p>
<p>
  다음으로 Confirm 예제로
</p>
<pre><code class="javascript">$('#confirm').click(function() {
  function ok() {
    alert('확인 버튼을 클릭했습니다!!')
  }
  function cancel() {
    alert('취소 버튼을 클릭했습니다!!')
  }
  $.confirm('Confirm!!', ok, cancel);
});</code></pre>
<p>
  $.alert 함수와 마찬가지로 불필요한 콜백은 제외할 수 있다.
</p>
<hr />
<button class="btn btn-primary" type="button" id="alert">alert</button>
<button class="btn btn-primary" type="button" id="confirm">confirm</button>
<script type="text/javascript">
  $(document).ready(function () {
    $('#alert').click(function() {
      $.alert('Alert!!', function() {
        alert('Alert 창을 닫습니다!!');
      });
    });

    $('#confirm').click(function() {
      function ok() {
        alert('확인 버튼을 클릭했습니다!!')
      }
      function cancel() {
        alert('취소 버튼을 클릭했습니다!!')
      }
      $.confirm('Confirm!!', ok, cancel);
    });
  });
</script>
