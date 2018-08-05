<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    SVN은 기본적으로 CLI 방식을 사용하는 형상관리 도구이다. SVN과 관련하여
    많은 명령어가 있고 이런 명령어를 찾아서 저장소를 관리하는 것은 많은 노력과
    경험이 필요한 부분인데 어렵고 복잡한 관리를 쉬운 UI로 관리할 수 있는
    VisualSVN Server를 사용하여 SW 형상을 관리한다.
  </p>
</blockquote>
<dl>
  <dt>저장소(Repository) 생성</dt>
  <dd>
    <ul>
      <li>VisualSVN의 Repositories에 마우스 오른쪽 버튼을 클릭하고 Create New Repository를 클릭</li>
      <li>Regualr FSFS repository 선택 후 다음 버튼 클릭</li>
      <li>Repository Name 입력</li>
      <li>Single-project repository 선택 후 다음 버튼 클릭</li>
      <li>All Subversion users have Read/Write access 선택 후 Create 버튼 클릭</li>
      <li>마지막으로 현재까지 입력한 내용과 생성된 저장소를 접속할 수 있는 URL이 제공된다</li>
    </ul>
    <img src="/img/sample/env/subversion-repo.gif" class="img-responsive center-block">
  </dd>
  <dt>계정 생성</dt>
  <dd>
    <p>
      저장소가 생성되었다면 생성된 저장소에 접근할 수 있는 계정을 생성해야한다.
    </p>
    <ul>
      <li>VisualSVN의 Users에 마우스 오른쪽 버튼을 클릭하고 Create User를 클릭</li>
      <li>User name, Password, Confirm password 입력 후 OK버튼 클릭</li>
    </ul>
    <img src="/img/sample/env/subversion-user.gif" class="img-responsive center-block">
  </dd>
</dl>
