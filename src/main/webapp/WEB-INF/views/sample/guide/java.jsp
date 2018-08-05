<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    Java 코딩규약 (<a href="https://google.github.io/styleguide/javaguide.html" target="_blank">Google Java Style Guide</a> 참고) 
  </p>
</blockquote>
<p>
  규약대로 코딩하면 좋겠지만, 불가피하거나 필요한 경우에는 참고만 하시기를....
</p>
<dl>
  <dt>소스파일</dt>
  <dd>
    <ul>
      <li>
        <strong>파일이름</strong>
        <p>
          클래스 이름과 동일하게 대소문자 구별해서 작성한다. 확장자는 당연히 java이다.
        </p>
      </li>
      <li>
        <strong>인코딩</strong>
        <p>
          소스파일의 인코딩은 UTF-8로 통일한다.
        </p>
      </li>
      <li>
        <strong>특수 문자</strong>
        <p>
          코드 내에서 특수 문자를 표현할 때 ‘\b’, ‘\n’, ‘\\’을 사용한다. (8진법(\012), 유니코드 표현 등을 사용하지 않는다)
        </p>
      </li>
      <li>
        <strong>Package</strong>
        <p>
          Package 문의 경우 아무리 길어도 한 문장으로 써야 한다.
        </p>
      </li>
      <li>
        <strong>import</strong>
        <p>
          import 문에는 *을 쓰지 않는다. Package 문과 동일하게 한 문장에 작성한다.<br/>
          import 문은 그룹핑을 해서 순서에 맞춰 작성한다. 다른 그룹간에는 공백라인을 한 줄 추가한다.(예제 참조)
          
        <pre><code class="java">package com.gscaltex.mdoumi.sample.web;

import java.util.*;      // 이건 안되요 안돼.
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gscaltex.mdoumi.base.datatables.mapping.DataTablesOutput;
import com.gscaltex.mdoumi.sample.model.Tableinfo;
import com.gscaltex.mdoumi.sample.service.DomainAutoService;
</code></pre>
        </p>
      </li>
      <li>
        <strong>클래스 멤버의 순서</strong>
        <p>
          클래스 멤버의 순서는 절대적인 것이 없다. 다만 이들의 순서가 논리적이여야 한다.
          <br/>가령 새로운 메소드가 추가되었다고 해서 클래스의 가장 마지막에 구현되는 것은 논리적이지 않다.
          <br/>멤버 순서에 대해서 하나의 제약 사항이 있는데 동일한 메소드명 (생성자들, 오버라이딩된 메소드들) 은 한 곳에 모아두어야 한다는 것.
        </p>
      </li>
    </ul>
  </dd>
  <dt>Formatting</dt>
  <dd>
    <ul>
      <li>
        <strong>중괄호</strong>
        <p>
          K&R style을 따르며 제거가 가능해도 무조건 쓴다. 가령 아래는 틀린 방식이다.
          <pre><code class="java">if (total > MAX_SUM)
    return true;
else
    return false;
</code></pre>
          위의 틀린 예는 다음과 같이 바꿔 쓸 수 있다.
          <pre><code class="java">if (total > MAX_SUM) {
    return true;
}
else {
    return false;
}
</code></pre>
			여는 중괄호를 뒤에는 코드가 없어야 한다.<br/>
			닫는 중괄호 앞에는 다른 코드가 없어야 한다.<br/>
			문장에 닫는 중괄호만 있는 케이스는 함수가 끝나거나 제어문이 끝날 때이다.<br/><br/>
			그래서 조건문의 경우 마지막에만 닫는 중괄호 단독으로 쓰일 수 있다.
          <pre><code class="java">if (fragment instanceof DialpadFragment) {
    mDialpadFragment = (DialpadFragment) fragment;
} else if (fragment instanceof CallLogFragment) {
    mCallLogFragment = (CallLogFragment) fragment;
} else if (fragment instanceof PhoneFavoriteFragment) {
    mPhoneFavoriteFragment = (PhoneFavoriteFragment) fragment;
} else if (fragment instanceof PhoneNumberPickerFragment) {
    mSearchFragment = (PhoneNumberPickerFragment) fragment;
}
</code></pre>
하지만 코드가 없는 메소드의 경우는 그냥 닫아도 괜찮다.
          <pre><code class="java">void doNothing() {}
</code></pre>
        </p>
      </li>
      <li>
        <strong>Line-wrapping</strong>
        <p>
          문장을 대입 연산자가 아닌 곳에서 잘라야 할 경우 심볼 앞에서 내린다.
          <pre><code class="java">this.someString = new StringBuffer()
                .append("Humans ")
                .append("are ")
                .append("intelligent ")
                .append("apes.");
this.someString = "Humans "
                + "are "
                + "intelligent "
                + "Apes.";
</code></pre>
            함수호출의 경우 ‘(‘는 첫 문장에 두고 나머지를 다음 문장으로 내린다.
            <pre><code class="java">addContactOptionMenuItem.setIntent(
    new Intent(Intent.ACTION_INSERT, Contacts.CONTENT_URI));
</code></pre>
            콤마 (‘,’)의 경우, 앞의 식별자와 동일한 단어로 취급한다. 
            <pre><code class="java">public void onLayoutChange(View v, int left, int top, int right, int bottom,
               int oldTop, int oldRight, int oldBottom) {
</code></pre>
        </p>
      </li>
      <li>
        <strong>공백처리</strong>
        <p>
          공백라인<br/>
		아래와 같은 상황에서 공백라인이 들어간다. 여러 줄의 공백라인은 추천하지 않는다.<br/>
		 - 클래스 멤버들을 구별하는 데 사용 : 메소드, 생성자, 멤버변수<br/>
		    멤버변수의 경우, 사이에 코드가 없다면 굳이 공백라인을 넣지 않아도 된다.<br/>
		 - 메소드 내부에서 논리적으로 그룹핑 되는 부분<br/><br/>
          공백문자
<pre><code class="java">if (true) {
     // ...
}
float var = a + i * (4 / Math.pow(0.5, x)) - 45.0f;
if (someBoolean) {
     // ...
} else {
     // ...
}
 
for (int i = 0; i < 10; i++) {
    //
}
catch (FooException | BarException e)
</code></pre>
 - if, for, catch 와 그 다음에 오는 ‘(‘ 사이에 공백문자<br/>
 - else, catch와 그 이전에 오는 ‘}’ 사이에 공백문자<br/>
 - ‘,’, ‘:’, ‘;’ 다음 이나 타입 캐스트시의 ‘)’  다음에 공백문자<br/>
 - 연산자 앞 뒤로는 공백문자 삽입<br/>
 - 연산자와 비슷한 심볼에서도 앞 뒤로 공백문자 삽입<br/><br/>
 변수정렬<br/>
        변수명을 보기 좋게 하기 위해서 정렬을 이용할 때가 있는데 이는 추천하지 않는다고 한다. 
<pre><code class="java">private int x; // 이거 좋아요
private Color color; // 역시 조아
 
private int      x;      // 허용은 되지만..나중에 유지보수 어려워
private Color    color;  // 마찬가지
</code></pre>
이유를 살펴보니 정렬을 쓰지 않는 것이 좋을 것 같다.</br>
 변수정렬을 할 경우, 유지보수 문제를 일으킨다고 하는데 구구절절 옳은 이야기들 뿐이다.</br>
  - 한 문장만 수정하고 싶은데 정렬 때문에 여러 문장을 수정해야 하는 상황 발생</br>
  - 코드리뷰를 힘들게 하며 가독성을 위해 너무 많은 잠재적 시간을 투입해야 함</br>
  - 코드 수정 이력에 필요 없는 정보를 넣게 되고 잠재적으로 충돌 가능성이 높아짐
        </p>
      </li>
      <li>
        <strong>기타</strong>
        <p>
          Switch 문
<pre><code class="java">switch (input) {
  case 1:
  case 2:
    prepareOneOrTwo();
    // fall through - 이런식으로 주석을 달아달라고 한다.
  case 3:
    handleOneTwoOrThree();
    break;
  default:
    handleLargeNumber(input);
}
</code></pre>
  - switch 문 내에서도 들여쓰기는 적용해야 한다.</br>
  - 아무 처리가 없더라도 default는 무조건 있어야 한다.</br></br>
          주석 스타일
<pre><code class="java">/*
 * This is          
 * okay.            
 */
</code></pre>
  - switch 문 내에서도 들여쓰기는 적용해야 한다.</br>
  - 아무 처리가 없더라도 default는 무조건 있어야 한다.</br></br>
      </li>
    </ul>
  </dd>
  <dt>들여쓰기 외</dt>
  <dd>
    <ul>
      <li>
        <strong style="color:red;">스페이스키 4개로 정의한다.</strong> (TAB)</li>
      <li>
        <strong>한 문장에는 하나의 변수 만을 선언한다.</strong></li>
      <li>
        <strong>변수 선언은 함수 처음에 하지 않는다. 최대한 변수가 사용되는 위치 근처에서 선언하여 변수의 스코프를 최소화 시킨다.</strong></li>
      <li>
        <strong>한 라인의 문자는 80개 혹은 100개만 쓴다. 그 보다 길 경우 다음 라인으로 내린다</strong></li>
    </ul>
  </dd>
  <dt>네이밍</dt>
  <dd>
    <ul>
      <li>
        <strong>package 명</strong>
        <p>
        모두 소문자로 기술한다. 단어가 달라지더라도 무조건 소문자를 사용한다.
<pre><code class="java">com.example.deepspace (O)
com.example.deepSpace (X)
com.example.deep_space (X)</code></pre>
        </p>
      </li>
      <li>
        <strong>Class 명</strong>
        <p>
        UpperCarmelCase를 사용한다.<br/>
        - 간단히 설명해서 대문자로 시작하고 단어가 바뀔 때마다 다시 대문자로 표시하는 거다
<pre><code class="java">AccountManagerInfo</code></pre>
        </p>
      </li>
      <li>
        <strong>Method 명</strong>
        <p>
        lowerCarmelCase를 사용한다.<br/>
        - 간단히 소문자로 시작해서 단어가 바뀔 때마다 다시 대문자로 표시하는 방식이다
<pre><code class="java">findEmployees // 임직원리스트
getEmployee // 특정임직원 상세조회
addEmployee // 임직원추가
delEmployee // 임직원삭제
editEmployee // 임직원수정
</code></pre>
find + 복수형 : 리스트 조회<br/>
get + 단수형 : 상세 조회<br/>
add + 단수형 : 추가<br/>
del + 단수형 : 삭제<br/>
edit + 단수형 : 수정
        </p>
      </li>
      <li>
        <strong>상수명</strong>
        <p>
        CONTANT_CASE 방식을 사용한다.<br/>
        - 모두 대문자를 사용하며 단어 사이에 밑줄을 표시한다. 당연히 명사나 명사구여야 한
<pre><code class="java">static final int NUMBER = 5;
static final ImmutableList<string> NAMES = ImmutableList.of("Ed", "Ann");
static final Joiner COMMA_JOINER = Joiner.on(',');
static final SomeMutableType[] EMPTY_ARRAY = {};</code></pre>
        </p>
      </li>
      <li>
        <strong>멤버변수명 / 인자명 / 로컬변수명</strong>
        <p>
        lowerCarmelCase를 사용한다.<br/>
        - 메소드명과 다른 점은 동사가 아닌 명사라는 점. 한문자는 피하자.
        </p>
      </li>
    </ul>
  </dd>
  <dt>주석</dt>
  <dd>
    <ul>
      <li>
        <strong>javadoc</strong>
        <p>
        javadoc block의 기본 형태는 다음과 같다 
<pre><code class="java">/** 
 * JavaDoc 테스트 클래스입니다.
 *
 * @author 이득영
 */ 
public class JavaDoc {  
   
    /** 
     * 곱셈을 합니다. 
     * 
     * @param a 첫번째 숫자
     * @param b 두번째 숫자
     * @return int 곱셈 결과값
     */ 
    public int multiply(int a, int b) {  
        return a * b;  
    }  
} </code></pre>
        </p>
      </li>
    </ul>
  </dd>
</dl>