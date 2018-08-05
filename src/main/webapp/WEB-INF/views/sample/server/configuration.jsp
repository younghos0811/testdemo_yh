<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp" %>
<blockquote cite="http://example.com/facts">
  <p>
    환경변수란? 환경변수는 프로세스가 컴퓨터에서 동작하는 방식에 영향을 미치는, <strong>동적인 값</strong>들의 모임이다 - WIKI
  </p>
</blockquote>
<p>
  환경 변수가 중요한 이유는 시스템의 유연성에 있다.
</p>
<ul>
  <li>자주 변경되거나 확정되지 않은 데이터</li>
  <li>같은 용도이지만 개발, 테스트, 운영 등 다양한 조건마다 다른 데이터</li>
  <li>다양한 곳에서 사용하는 공통 데이터 존재</li>
</ul>
<p>
  기존 환경변수 방법
</p>
<dl>
  <dt>Java 환경변수 방법</dt>
  <dd>
<pre><code class="java">public class DatabaseProperty {
    public static final String DATABASE_DRIVER = "oracle.jdbc.driver.OracleDriver";
    public static final String DATABASE_URL = "jdbc:oracle:thin:@//192.168.1.1:1521:dev";
    public static final String DATABASE_USER = "devtest";
    public static final String DATABASE_PASSWORD = "test";
}</code></pre>
    <ul>
      <li>Java의 static final 키워드를 사용하여 클래스 변하지 않는 변수로 사용</li>
      <li>상수를 가지는 특정 클래스 의존적</li>
      <li>변수 변경 때 마다 참조하는 있는 클래스를 재컴파일</li>
      <li>현재도 많이 사용</li>
    </ul>
  </dd>
  <dt>Properties 파일</dt>
  <dd>
<pre><code class="java">db.driver=oracle.jdbc.driver.OracleDriver
db.url=jdbc:oracle:thin:@//192.168.1.1:1521:dev
db.user=devtest
db.password=test
</code></pre>
    <ul>
      <li>Key=Value 형태의 데이터</li>
      <li>Java에서 기본 지원 (java.util.Properties)</li>
      <li>한글 미지원</li>
    </ul>
  </dd>
  <dt>YAML 특징</dt>
  <dd>
    <ul>
      <li>심플! (JSON 비슷)</li>
      <li>한글지원</li>
      <li>들여쓰기 강제화(공백 문자를 이용한 들여쓰기, 탭문자 X)</li>
      <li>하나의 파일에서 문서를 나눌 수 있는 문법(---) 지원</li>
      <li>주석은 #으로 표시하며, 한 줄이 끝날 때까지 유효</li>

    </ul>
<pre><code class="javascript">server:
  port: 80
  error:
    whitelabel:
      enabled: false

---
spring.profiles: dev

spring:
  datasource:
    url: jdbc:h2:~/mdoumi
    username: sa
    password:

---
spring.profiles: prod

spring:
  datasource:
    initialize: false
    url: jdbc:h2:~/mdoumi
    driver-class-name:
    username: sa
    password:</code></pre>
  </dd>
</dl>
<p>
  Confinguration을 가져다 쓰는 방법은 여느 Spring 빈들과 다르지 않다.
</p>
<pre><code class="java">@Autowired
private SampleProperties sampleProperties;</code></pre>
<p>
  Yaml 파일의 내용을 Java 클래스에 매핑되는데 Yaml 파일 표현 내용대로
  Java 클래스를 구성하면 된다.
</p>
<pre><code class="javascript">sample:
  author: chotire
  mail:
    host: mail.gsitm.com
    port: 25
    from: chotire@gsitm.com
  mime:
    mime-mappings:
      -
        extension: xls
        mime-type: application/vnd.ms-excel
      -
        extension: ppt
        mime-type: application/vnd.ms-powerpoint
      -
        extension: doc
        mime-type: application/vnd.ms-word</code></pre>
<pre><code class="java">@Data
@Component
@ConfigurationProperties(prefix="sample", locations="classpath:sample.yml")
public class SampleProperties {
    private String author;
    private Mail mail;
    private Mime mime;

  @Data
  public static class Mail {
      private String host;
      private int port;
      private String from;
  }

  @Data
  public static class Mime {
      private List&lt;MimeMapping&gt; mimeMappings = new ArrayList&lt;MimeMapping&gt;();

      @Data
      public static class MimeMapping {
          private String extension;
          private String mimeType;
      }
  }

  @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}</code></pre>
<p>
  Confinguration을 사용할 때 주의해야 할 점은 Confinguration 의 내용이 Client쪽으로
  데이터가 전달되지 않도록 해야한다. Confinguration에는 보통 시스템내의 경로, 아이피, 기타 설정 등등의
  민감한 정보를 담고 있기 때문에 이런 데이터가 Client로 전달이되면 악의적인 사용자에 의해
  공격을 받을 수 있다. 예제는 Confinguration의 내용을 보여주기 위해 내용을 출력했지만 실제 프로젝트에서는
  조심해서 사용하도록 한다.
</p>
<hr />
<ul>
  <li>author: ${sampleProperties.author}</li>
  <li>
    mail
    <ul>
      <li>host: ${sampleProperties.mail.host}</li>
      <li>port: ${sampleProperties.mail.port}</li>
    </ul>
  </li>
  <li>
    mime
    <ul>
      <c:forEach var="mimeMapping" items="${sampleProperties.mime.mimeMappings}">
        <li>${mimeMapping.extension} / ${mimeMapping.mimeType}</li>
      </c:forEach>
    </ul>
  </li>
</ul>
