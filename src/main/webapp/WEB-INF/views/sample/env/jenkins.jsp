<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    Jenkins의 기능들
  </p>
  <ul>
    <li>저정소와 통합 (Integrate with repository)</li>
    <li>소스 코드 체크아웃 (Checkout the codes)</li>
    <li>분산 빌디 (Distributed Builds)</li>
    <li>빌드 및 테스트 (Build and test)</li>
    <li>테스트 보고서 생성 (Generate test report)</li>
    <li>실행 결과 통보 (Notification)</li>
    <li>산출물 저장소에 산출결과를 저장 (Archive and store in artifact repository</li>
    <li>배포 (Deploy)</li>
  </ul>
</blockquote>
<p>
  젠킨스를 통해 개발한 어플리케이션을 빌드하는 방법은 다음과 같다.
</p>
<div class="alert alert-danger" role="alert">
  Windows Server 특성상 SSH가 없어 자동 배포 시스템은 구현되지 않았으므로 배포는
  개발자가 직접 수행해야 한다.
</div>
<ul>
  <li>Jenkins 접속: http://203.245.65.140:8082</li>
  <li>빌드하고자 하는 Job을 클릭(dev-mdoumi: 개발, prod-modumi: 운영)</li>
  <li>
    Build Now를 클릭하여 빌드를 실행
    <ul>
      <li>빌드가 성공적으로 실행이 되면 파랑색 아이콘으로 표시가 되고</li>
      <li>
        실패하면 빨강색 아이콘으로 표시된다.
        실패한 빌드는 Console Output 메뉴를 통해 실패원인을 확인한 후 원인 조치 후
        재빌드를 수행한다(실패 원인의 90% 이상은 컴파일 에러..)
      </li>
      <li>
        노랑색 아이콘은 빌드는 성공했지만 Warning이 있는 경우로 보통
        테스트(JUnit 등) 실패 또는 정적 분석 시 결함이 있다는 의미인데
        본 프로젝트에서는 테스트코드 및 정적 분석을 사용하지 않으므로
        노랑색 아이콘을 볼 일은 없을 것이다.
      </li>
    </ul>
  </li>
  <li>
    빌드가 정상적으로 수행되면 목적 파일인 war 파일이 FTP를 통해 대상 서버의
    C:\Deploy 디렉토리에 자동으로 업로드가 된다.
  </li>
  <li>
    업로드가 된 파일은 수동으로 JEUS에 디플로이한다.
    <ul>
      <li>빌드가 수행되면 개발/운영 서버의 C:\Deploy\m-doumi-1.0.war.original 경로에 파일이 업로드된다.</li>
      <li>m-doumi-1.0.war.original 압축을 해제한다</li>
      <li>
        JEUS Container(draft 또는 loan)를 shutdown한다.
        <ul>
          <li>http://203.245.65.140:9736/webadmin 제우스 웹어드민 접속(운영의 경우 운영 아이피로 변경)</li>
          <li>administrator/jeusadmin 계정으로 로그인</li>
          <li>Servers 메뉴를 클릭한 후 draft 또는 loan 컨테이너 stop</li>
        </ul>
      </li>
      <li>D:\app\draft 또는 D:\app\loan 디렉토리 내의 모든 파일을 삭제</li>
      <li>압축해제한 파일을 복사</li>
      <li>제우스 웹어드민에서 shutdown한 컨테이너 start</li>
    </ul>
  </li>
  <li>
    소스가 배포되고 제우스가 기동되었다면 어플리케이션에 접근을 한다.
    <ul>
      <li>draft: http://203.245.65.140:9090</li>
      <li>loan: http://203.245.65.140:9091</li>
    </ul>
  </li>
</ul>
<img src="/img/sample/env/jenkins.png" class="img-responsive center-block">