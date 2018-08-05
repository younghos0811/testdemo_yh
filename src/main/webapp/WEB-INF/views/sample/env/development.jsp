<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    개발환경 구성 및 구성 요소에 대해 알아본다.
  </p>
</blockquote>
<p>
  <img src="/img/sample/env/env-tree.gif" class="img-responsive center-block">
</p>
<p>
  m-doumi 개발환경은 jvm, sts 등 통합적으로 제공이 되며, 별도의 설치가 필요없이
  윈도우 OS의 C드라이브 루트에 복사하면 된다.
</p>
<dl>
  <dt>디렉토리 설명</dt>
  <dd>
    <ul>
      <li>
        <strong>bin</strong>
        <p>
          jdk, sts(eclipse) 등 실행 도구들이 위치한다.
        </p>
      </li>
      <li>
        <strong>maven</strong>
        <p>
          Maven 설정파일(settings.xml)이 위치하고 및 라이브러리 레포지토리 경로
        </p>
      </li>
      <li>
        <strong>resources</strong>
        <p>
          폰트, 롬복(Lombok) 등 개발지원 도구들이 위치한다.
        </p>
      </li>
      <li>
        <strong>workspaces</strong>
        <p>
          m-doumi 개발소스가 위치하며 sts 프로젝트 워크스페이스이다.
        </p>
      </li>
    </ul>
  </dd>
  <dt>도구 설치</dt>
  <dd>
    <ul>
      <li>
        <strong>폰트 설치</strong>
        <p>
          폰트 설치는 강제 사항은 아니지만 sts의 기본 폰트 설정으로는 영문자(1바이트 문자)와 한글(2바이트 문자)이
          조화롭지 못하고 개발 시에 헷갈릴 수 있는 I(대문자 아이), l(소문자 엘), 1(숫자 일), 0(숫자 영), O(대문자 오) 등의
          문자 식별이 어렵다. 이러한 개발자들의 에로사항을 해결해주는 폰트들이 다양하게 있는데 본 프로젝트에서는
          네이버에서 개발자들의 위해 공개한 나눔고딕코딩 폰트를 설치할 것을 권장한다.
        </p>
        <p>
          m-doumi/resources/NanumGothicCoding_Setup-2.0.exe 파일을 클릭하여 설치
        </p>
      </li>
      <li>
        <strong>롬복(Lombok) 설치</strong>
        <p>
          Java 개발은 POJO(Plain Old Java Object) 형태로 많이 개발이되는데 이 때
          클래스내의 멤버변수들에 대한 getter/setter를 생성하게된다. getter/setter에
          특별한 전처리 또는 후처리가 있는 경우가 아니고서는 단순히 private 멤버 변수들을
          캡슐화하기 위한 getter/setter만 존재하게 된다. 이런 getter/setter는 개발되는 비즈니스 로직에
          크게 영향이 없으면서 코드 라인은 매우 많이 잡아먹게 된다. 게다가 변수명이 변경된다거나 또는
          추가, 삭제 될 경우에 해당하는 getter/setter도 수정해야 하는데 매우 번거로울 수 밖에 없다.
        </p>
        <p>
          롬복은 이런 귀찮은 일들을 자동화해주는 도구이다. 롬복은 @Data Annotation을 통해 자동으로 getter/setter를
          컴파일 시점에 생성해준다. 하지만 sts와 같은 개발도구는 롬복이 기본지원 사항이 아니므로 sts에 롬복을
          추가해줘야 한다.
        </p>
        <p>
          m-doumi/resources/lombok.bat 를 클릭하면 아래와 같은 화면을 볼 수 있고 [Specify location...] 버튼을 클릭하여
          Dialog를 오픈한 후 <i>C:\m-doumi\bin\sts-bundle\sts-3.8.0.RELEASE</i> 위치로 찾아가 [Select] 버튼을 클릭한다.
          다음으로 [Install / Update] 버튼을 클릭하여 설치한다. 만약 sts가 구동된 상태로 설치를 했다면 sts를 재구동하면
          설치가 완료된다.
        </p>
        <p>
          <img src="/img/sample/env/lombok.gif" class="img-responsive center-block">
        </p>
      </li>
    </ul>
  </dd>
  <dt>서버 실행</dt>
  <dd>
    <p>
      sts 실행 후 정상적으로 서버가 기동되면 개발 환경은 80%이상 구축된 것이다.
      서버는 embed tomcat으로 기본설정상 80포트로 구동된다. Boot Dashboard 뷰에서 start 버튼을 클릭을하여
      톰켓을 구동시킨다.
    </p>
    <p>
      <img src="/img/sample/env/boot-dashboard.gif" class="img-responsive center-block">
    </p>
    <p>
      Console 뷰에 다음과 같은 로그가 출력되면 정상적으로 구동이 된 것이다.
    </p>
    <p>
      <img src="/img/sample/env/tomcat-boot.gif" class="img-responsive center-block">
    </p>
    <p>
      만약 로컬 PC에 다른 웹서버가 구동되어있어
      80포트를 사용할 수 없는 경우라면 설정을 변경하여 구동한다.
      Boot Dashboard에서 m-doumi에서 오른쪽 마우스 클릭 > Open Config 클릭 > Arguments 탭 클릭 > Program arguments 에
      --server.port=8080 (본인이 사용 가능한 포트 입력) > Apply 클릭
    </p>
    <p>
      설정이 완료 되었다면 서버를 재실행하여 설정한 포트로 접근하면된다.
    </p>
    <p>
      <img src="/img/sample/env/tomcat-config.gif" class="img-responsive center-block">
    </p>
    <p>
      M-Doumi 시스템은 기안/여신 두 개의 시스템으로 논리적으로 분리가된다.
      시스템 구분 값은 프로레임워크에서 필수로 요구하는 값으로 JVM 옵션을 설정해야만
      서버가 구동되었다 하더라도 서비스가 정상적으로 실행될 수 있다.
      ServerSide 메뉴의 'System Types' 섹션을 확인하여 설정을 진행하도록 한다.
    </p>
  </dd>
  <dt>SVN 연결</dt>
  <dd>
    <p>
      형상관리 시스템인 SVN에 연결하기 위해서는 먼저 SVN Repository Exploring 퍼스펙티브를 오픈해야한다.
      SVN Repository Exploring 퍼스펙티브가 오픈되어있지 않다면 Window > Perspective > Open Perspective >
      Other > SVN Repository Exploring 클릭 > OK 버튼을 클릭하면 SVN Repository Exploring 이 오픈된다.
    </p>
    <img src="/img/sample/env/svn-perspective.gif" class="img-responsive center-block">
    <p>
      SVN Repository Exploring 이 오픈되면 SVN Repositories 뷰에서 마우스 오른쪽 버튼을 클릭한 후
      Repository Location 메뉴를 클릭한다.
    </p>
    <p>
      New Repository Location Dialog가 오픈되면 아래 내용을 입력한다.
    </p>
    <ul>
      <li>URL: http://203.245.65.140/svn/M-doumi</li>
      <li>User: 발급받은 계정 아이디</li>
      <li>Password: 발급받은 계정 비밀번호</li>
      <li>Save authentication 체크박스 체크</li>
      <li>Finish 버튼 클릭</li>
    </ul>
    <img src="/img/sample/env/svn-location.gif" class="img-responsive center-block">
    <p>
      위 과정을 통해 SVN에 연결이 되었다면 SVN Repositories 뷰의 연결 트리를 확장하여
      trunk 하위의 m-doumi 소스를 체크아웃한다.
    </p>
    <img src="/img/sample/env/svn-checkout.gif" class="img-responsive center-block">
  </dd>
</dl>