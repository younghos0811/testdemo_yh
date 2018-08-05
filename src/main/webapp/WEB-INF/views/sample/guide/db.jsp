<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    SQL Style Guide
  </p>
</blockquote>
<p>
  일반적인 규칙은 꼬옥 지켜주세요. (T-SQL 안쓰시리라 믿습니다. 무조건 Ansi-SQL입니다.)
</p>
<dl>
  <dt>일반규칙</dt>
  <dd>
    <ul>
      <li>
        <strong>대소문자</strong>
        <p>
          SQL 예약어 (참고:<a href="https://support.office.com/ko-kr/article/SQL-%EC%98%88%EC%95%BD%EC%96%B4-b899948b-0e1c-4b56-9622-a03f8f07cfc8" target="_blank">클릭</a>) : 대문자
          </br>
          TABLE 명 : 소문자</br>
          컬럼 명 : 소문자</br>
          사용자정의 Stored Procedure 명 : 대문자</br>
          사용자정의 Function 명 : 대문자</br>
          SQL 함수 명 : 대문자
        </p>
      </li>
    </ul>
  </dd>
  <dt>쿼리</dt>
  <dd>
    <ul>
      <li>
        <strong>공백 - Domain Generator 이용</strong>
        <p>
          SELECT
          <pre><code class="database">SELECT file_hash
      ,file_id
      ,file_path
  FROM file_system
 WHERE file_name = '.vimrc';
 
SELECT first_name
  FROM staff;
  
SELECT a.title
      ,a.release_date
      ,a.recording_date
      ,a.production_date -- 주석
  FROM albums AS a
 WHERE a.title = 'Charcoal Lane'
    OR a.title = 'The New Danger';
    
-- 조인 (반드시 ANSI로)
SELECT r.last_name
  FROM riders AS r
       INNER JOIN bikes AS b
       ON r.bike_vin_num = b.vin_num
          AND b.engines > 2

       INNER JOIN crew AS c
       ON r.crew_chief_last_name = c.last_name
          AND c.chief = 'Y'
          
       LEFT OUTER JOIN team AS t
       ON c.team_cd = t.team_cd
          AND t.team_loc = 'Z';

-- 서브쿼리 1
SELECT r.last_name,
       (SELECT MAX(YEAR(championship_date))
          FROM champions AS c
         WHERE c.last_name = r.last_name
           AND c.confirmed = 'Y') AS last_championship_year
  FROM riders AS r
 WHERE r.last_name IN
       (SELECT c.last_name
          FROM champions AS c
         WHERE YEAR(championship_date) > '2008'
           AND c.confirmed = 'Y');
-- 서브쿼리 2
SELECT r.last_name,
       (SELECT MAX(YEAR(championship_date))
          FROM champions AS c
         WHERE c.last_name = r.last_name
           AND c.confirmed = 'Y') AS last_championship_year
  FROM riders AS r
       INNER JOIN (SELECT cols1
                         ,cols2
                     FROM tables
                    WHERE cols3 = 'TEST') AS x
       ON r.cols1 = x.cols1
          AND r.cols3 = 'T';
           
-- CASE문, BETWEEN, IN
SELECT CASE postcode
       WHEN 'BN1' THEN 'Brighton'
       WHEN 'EH1' THEN 'Edinburgh'
       END AS city
  FROM office_locations
 WHERE country = 'United Kingdom'
   AND opening_time BETWEEN 8 AND 9
   AND postcode IN ('EH1', 'BN1', 'NN1', 'KW1')</code></pre>
          INSERT
          <pre><code class="database">INSERT INTO albums (
    title
   ,release_date
   ,recording_date
)
VALUES (
    'Charcoal Lane'
   ,'1990-01-01 01:01:01.00000'
   ,'1990-01-01 01:01:01.00000'
);</code></pre>
          UPDATE
          <pre><code class="database">UPDATE albums
   SET release_date = '1990-01-01 01:01:01.00000'
      ,release_flag = 'Y'
 WHERE title = 'The New Danger'
   AND code = 'AS21';</code></pre>
          DELETE
          <pre><code class="database">DELETE FROM albums
 WHERE title = 'The New Danger'
   AND code = 'AS21';</code></pre>
        </p>
      </li>
    </ul>
  </dd>
  <dt>Aliasing - 별칭이용</dt>
  <dd>
    <ul>
      <li>
        <strong>TABLE 이나 Column에 별칭을 줄 경우 반드시 AS를 사용할 것.</strong>
        <p>
        <pre><code class="database">SELECT r.last_name AS name
  FROM riders AS r
       INNER JOIN bikes AS b
       ON r.bike_vin_num = b.vin_num
          AND b.engines > 2;</code></pre>
        </p>
      </li>
    </ul>
  </dd>
  <dt>사용자 정의 프로그래밍</dt>
  <dd>
    <ul>
      <li>
        <strong>사용자 정의 Function (대문자)</strong>
        <p>
        Function 명은 항상 FN_GET_COMMCDNAME 처럼<br/> 
        FN_ 로 시작하고 <br/>
        SCALAR Return 타입은 GET_<br/>
        TABLE Return 타입은 LIST_<br/>
        마지막에 약어를 준다.<br/>
        <strong style="color:red;">꼭 필요한 경우에만 사용자정의 Function을 생성..(생성 후 프로젝트팀 공유 필요 - 중복 방지)</strong>
        </p>
      </li>
      <li>
        <strong>사용자 정의 Stored Procedure (대문자)</strong>
        <p>
        Procedure 명은 항상 USP_MEMBER_GET 처럼<br/> 
        USP_ 로 시작하고 <br/>
        업무 약어(MEMBER / PAPER .. 등)를 주고 <br/>
        단일Row데이터 조회는 _GET<br/>
        멀티Row데이터 조회는 _LIST<br/>
        데이터 INSERT는 _ADD<br/>
        데이터 UPDATE는 _UPD_<br/>
        데이터 DELETE는 _DEL<br/>
        로 마무리 한다.<br/>
        <strong style="color:red;">꼭 필요한 경우에만 Stored Procedure를 생성..(원칙적으로 사용금지 - I/F를 위한 기존 프로시저는 이름 그대로 사용예정)</strong>
        </p>
      </li>
    </ul>
  </dd>
</dl>