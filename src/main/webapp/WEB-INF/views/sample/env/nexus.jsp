<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    Maven 프로젝트 시에 Maven central repository에서 제공하는 다양한 장점에도
    불구하고 사용성 측면에서 내부 repository manager의 사용을 권고하고 있다.
    실제 기업 또는 organization에서는 하나 이상의 central repository를 제공
    하고 있으며 Nexus는 이런 여러 개의 외부 리포지토리를 Proxy 개념으로 연결해서
    효율적으로 내부 개발자들에게 virtual한 하나의 repository 연결 포인트를 제공한다.
    실제 내부 개발자들은 Nexus 리포지토리만을 바라보고 필요한 artifact들을 요청한다.
  </p>
</blockquote>
<p>
  Maven central repository에는 우리가 알고있는 거의 대부분의 오픈소스 라이브러리들이 저장소에
  등록되어있다. 하지만 JDBC Driver, 기타 상용 자바 라이브러리들은 오픈소스가 아니므로
  Maven central repository에 등록되어있지 않다. 이런 경우 Maven에 해당 라이브러리를 저장소에
  저장하여 사용해야한다. Nexus에 3rd party library를 등록하는 방법은 다음과 같다.
</p>
<ul>
  <li>Nexus 웹콘솔 접속: http://203.245.65.140:8081/nexus</li>
  <li>관리자 계정으로 로그인: admin/admin123</li>
  <li>Repositories 메뉴 클릭</li>
  <li>Repositories 탭에서 3rd party 클릭</li>
  <li>하단의 Artifact Upload 탭 클릭</li>
  <li>GAV Definition GAV Parameters로 선택</li>
  <li>Group 입력(보통 라이브러리의 도메인주소)</li>
  <li>Artifact 입력(보통 라이브러리 이름)</li>
  <li>Version 입력(라이브러리 버전)</li>
  <li>Packaging jar 선택</li>
  <li>Select Artifact(s) to Upload...를 클릭하여 업로드할 라이브러리 선택</li>
  <li>Add Artifact 버튼 클릭</li>
  <li>Upload Artifact 버튼 클릭</li>
</ul>
<img src="/img/sample/env/nexus-3rd.gif" class="img-responsive center-block">
<p>
  위와 같은 과정으로 라이브러리를 업로드가 되면 업로드된 라이브러리를 Maven에 dependency로
  등록해줘야 하는데 업로드된 라이브러리의 artifact는 Browse Index 탭을 클릭하면 업로드된
  artifact의 트리가 나오는데 트리 중 업로드된 jar 파일을 선택하면 오른쪽에 Maven dependency
  문법이 출력되고 해당 문법을 복사하여 pom.xml에 붙여넣어 dependency를 정의하면 된다.
</p>
<img src="/img/sample/env/nexus-depen.gif" class="img-responsive center-block">