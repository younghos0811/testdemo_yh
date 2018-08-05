<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    HTML/Javascript Style Guide
  </p>
</blockquote>
<p>
  HTML 과 javascript는 통상적인 스타일 규약대로 코딩합니다.
</p>
<dl>
  <dt>일반 규칙</dt>
  <dd>
    <ul>
      <li>
        <strong>Indent (Tab-Width)</strong>
        <p>
          될수 있으면 jsp나 js파일은 m-doumi폴더에 있는 sublime_text를 사용하여 편집합니다.<br/>
          이때 Indent Using Space로 Tab-Width를 2를 기본으로 하여 편집합니다.
          <pre><code class="javascript">&lt;dl&gt;
  &lt;dt&gt;Indent (Tab띄워쓰기)&lt;/dt&gt;
  &lt;dd&gt;
    &lt;ul&gt;
      &lt;li&gt;
        &lt;strong&gt;Tab -&gt; Space&lt;/strong&gt;
        &lt;p&gt;
          될수 있으면 jsp나 js파일은 m-doumi폴더에 있는 sublime_text를 사용하여 편집합니다.&lt;br/&gt;
          이때 Indent Using Space로 Tab-Width를 2를 기본으로 하여 편집합니다.
          &lt;pre&gt;&lt;code class=&quot;javascript&quot;&gt;
          &lt;/code&gt;&lt;/pre&gt;
        &lt;/p&gt;
      &lt;/li&gt;
    &lt;/ul&gt;
  &lt;/dd&gt;
&lt;/dl&gt;</code></pre>
          <pre><code class="javascript">$(document).ready(function() {
  $.getJSON('domain/tablelist', function(data) {
    for(var i=0; i&lt;data.data.length; i++) {
      $('#tablename').append('&lt;option value=&quot'+data.data[i]['tableId']+'&quot&gt;'+data.data[i]['tableName']+'&lt;/option&gt;');
    }
  });
});</code></pre>
        </p>
      </li>
      <li>
        <strong>문자열 Quotation</strong>
        <p>
          HTML - 문자열은 더블 쿼테이션으로 감싼다
          <pre><code class="javascript">&lt;code class=&quot;javascript&quot;&gt;</code></pre>
          Javascript - 문자열은 싱글 쿼테이션으로 감싼다(가장 외부)
          <br/>내부에 포함된 또다른 문자열은 더블쿼테이션으로 감싼다
          <pre><code class="javascript">$('#tablename').append('&lt;option value=&quot'+data.data[i]['tableId']+'&quot&gt;'+data.data[i]['tableName']+'&lt;/option&gt;');</code></pre>
        </p>
      </li>
    </ul>
  </dd>
</dl>