<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    본 프로젝트에서는 널리 알려진 Java Logging Framework인 Log4j를 대체하기 위해 개발된
    Logging Framework인 Logback을 사용한다. Logback은 log4j에 비해서 속도나 메모리 사용면에서 개선되었고,
    slf4j 인터페이스를 직접 구현함으로써 로깅을 수행하는 어플리케이션에서는 slf4j api만을 사용하여
    로깅을 수행할 수 있기때문에 다른 Logging framework 와의 변경을 손쉽게 할 수 있다.
  </p>
</blockquote>
<table class="table table-bordered">
  <caption>Logback log level</caption>
  <colgroup>
    <col style="width: 16.6%">
    <col style="width: 16.6%">
    <col style="width: 16.6%">
    <col style="width: 16.6%">
    <col style="width: 16.6%">
    <col style="width: 16.6%">
  </colgroup>
  <tbody>
    <tr>
      <td>ERROR</td>
      <td style="background: #cfd8dc" />
      <td />
      <td />
      <td />
      <td />
    </tr>
    <tr>
      <td>WARN</td>
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
      <td />
      <td />
      <td />
    </tr>
    <tr>
      <td>INFO</td>
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
      <td />
      <td />
    </tr>
    <tr>
      <td>DEBUG</td>
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
      <td />
    </tr>
    <tr>
      <td>TRACE</td>
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
      <td style="background: #cfd8dc" />
    </tr>
  </tbody>
</table>
<p>
  Logback의 로그 레벨은 TRACE > DEBUG > INFO > WARN > ERROR 순서로
  개발 또는 운영 시에 상세한 정보로 디버깅 목적으로 사용할 정보는 DEBUG로
  특정한 상태나 중요한 값(아무나 봐도 상관없는 값)을 출력해야 할 경우에는 INFO 레벨을 사용하여
  로깅하는 것이 좋다.
  로깅은 비용이 많이드는 작업으로 적절한 로깅으로 어플리케이션을 최적화해야 한다.
</p>
<dl>
  <dt>기본적인 사용 방법</dt>
  <dd>
<pre><code class="java">public class LoggingTest {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    public void test() {
        logger.debug("This is a debug message");
        logger.info("This is an info message");
        logger.warn("This is a warn message");
        logger.error("This is an error message");
    }
}</code></pre>
  </dd>
  <dt>파라미터를 활용한 로깅</dt>
  <dd>
    로그메시지를 동적으로 생성할 때 가장 간단한 방법은 문자열의 + 으로 문자열을 생성해서 전달하는 방법이다.
    하지만 이 방법의 경우 해당 로그의 출력 여부와 관계없이 로그 이벤트 호출시 마다 매번 문자열 연산이
    발생하므로 성능적인 면에서 비효율적이다. Logback을 포함한 Slf4j를 구현체들은 파라미터를 이용한
    로깅 방식을 지원하여 불필요한 문자열 연산이 발생하지 않도록 한다.
    <p>
      다음은 하나의 파라미터를 이용하여 로그를 수행하는 예제이다. {} 문자를 이용하여 파라미터가 치환될 부분임을 명시할 수 있다.
    </p>
<pre><code class="java">logger.error("Movie Information: movieId={}", movie.getMovieId());</code></pre>
    <p>
      다음은 두 개의 파라미터를 전달하는 예제이다.
    </p>
<pre><code class="java">logger.debug("Movie Information: movieId={}, title={}" , movie.getMovieId(), movie.getTitle());</code></pre>
    <p>
      세 개 이상의 파라미터를 전달하는 경우는 Object 배열을 활용해야 한다. 다음은 Object 배열을 이용하여 파라미터를 전달하는 예제이다.
    </p>
<pre><code class="java">Object[] params =  new Object[]{movie.getMovieId(), movie.getTitle(), movie.getReleaseDate()};
logger.info("Movie Information: movieId={}, title={}, releaseDate={}", params);</code></pre>
  </dd>
</dl>
