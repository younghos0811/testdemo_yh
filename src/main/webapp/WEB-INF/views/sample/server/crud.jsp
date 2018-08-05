<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<blockquote cite="http://example.com/facts">
  <p>
    본 프로젝트에서는 RESTful한 디자인을 지향한다. REST 아키텍처는
    HTTP 프로토콜의 Method(POST, GET, PUT, DELETE)를 적극적으로 활용하고
    URI는 명사 복수로 하는 것을 원칙으로 하는데 자세한 내용은
    <a href="/sample/download/restapi">restapi</a> 문서를 참고하도록한다.
  </p>
</blockquote>
<button class="btn btn-danger" type="button">삭제</button>
<table id="grid" class="table table-striped table-bordered">
  <thead>
    <tr>
      <th><input type="checkbox" name="example-select-all" value="1" id="example-select-all"></th>
      <th>사번</th>
      <th>이름</th>
      <th>연봉</th>
      <th>입사일</th>
      <th>소속</th>
    </tr>
  </thead>
</table>
<hr />
<form class="form-horizontal" id="employeeForm">
  <input type="hidden" name="no">
  <div class="row">
    <div class="col-md-6">
      <div class="form-group">
        <label for="name" class="col-sm-2 control-label">이름</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="name" name="name" placeholder="이름" data-parsley-length="[2, 5]" data-parsley-required>
        </div>
      </div>
      <div class="form-group">
        <label for="hireDate" class="col-sm-2 control-label">입사일</label>
        <div class="col-sm-10 controls">
          <div class="input-group date">
            <input type="text" class="form-control input-date" id="hireDate" name="hireDate" placeholder="입사일" data-parsley-date data-parsley-required>
            <span class="input-group-addon">
              <span class="glyphicon glyphicon-calendar"></span>
            </span>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="form-group">
        <label for="salary" class="col-sm-2 control-label">연봉</label>
        <div class="col-sm-10">
          <input type="text" class="form-control input-numeral" id="salary" name="salary" placeholder="연봉" data-parsley-currency data-parsley-required>
        </div>
      </div>
      <div class="form-group">
        <label for="dept" class="col-sm-2 control-label">부서</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="dept" name="dept" placeholder="부서" data-parsley-required>
        </div>
      </div>
    </div>
  </div>
  <button class="btn btn-primary" disabled="">저장</button>
  <button class="btn btn-info" type="button">신규</button>
</form>
<script type="text/javascript">
  $(document).ready(function() {
    var $grid = $('#grid').DataTable({
      serverSide: true,
      ajax: {
        url: '/sample/employees',
        dataSrc: 'data',
        headers: {identity: 'custom'},
      },
      columnDefs: [{
        targets: 0,
        searchable: false,
        orderable: false
      }],
      order: [1, 'asc'],
      columns: [
        {
          data: 'no',
          render: function(data, type, row, meta) {
            return $('<input>', {
              type: 'checkbox',
              name: 'no',
              value: data
            })[0].outerHTML;
          }
        },
        {data: 'no'},
        {data: 'name'},
        /*
        {data: 'name',
          render: function(data, type, row, meta) {
            return $('<a>', {
              href: '/sample/employees/' + row.no,
              text: data
            })[0].outerHTML;
          }
        },
        */
        {data: 'salary'},
        {data: 'hireDate'},
        {data: 'dept'}
      ]
    });
    
    // 페이지 클릭시 입력폼 리셋
    $('#grid').on( 'page.dt', function () {
      $('#example-select-all').prop('checked', false);
   	  $("form").each(function() {  
        if(this.id == "employeeForm") this.reset();  
	  });  
    });
    // 소팅시 입력폼 리셋
    $('#grid').on( 'order.dt', function () {
      $('#example-select-all').prop('checked', false);
      $("form").each(function() {  
        if(this.id == "employeeForm") this.reset();  
      });  
    });
    
    // Row 클릭시 데이터 상세 조회(첫번째 Cell 제외)
    $('#grid tbody').on('click', 'tr', function (evt) {
      if ($(evt.target).closest('td').index() > 0) {
        if ( !$(this).hasClass('selected') ) { // Row 선택 class 추가 및 제거
          $grid.$('tr.selected').removeClass('selected');
          $(this).addClass('selected');
        }
        $.get('/sample/employees/' + $grid.row(this).data()['no'], function(data) {
          var $form = $('#employeeForm');
          $form.find(':submit').prop('disabled', false);

          $.each(data, function(key, value) {
            $form.find(':input[name=' + key + ']').val(value);
          });
        }); 
      }
    });
    
    // 전체선택/해제 (체크박스)
    $('#example-select-all').on('click', function(){
      var rows = $grid.rows({ 'search': 'applied' }).nodes();
      $('input[type="checkbox"]', rows).prop('checked', this.checked);
    });

    $('#employeeForm').submit(function(e) {
      e.preventDefault();
      var $form = $('#employeeForm');
      var no = $form.find(':input[name=no]').val();

      if (no === '') {
        $.post('/sample/employees', $form.serialize(), function(data) {
          $grid.draw();
        });
      } else {
        $.put('/sample/employees/' + no, $form.serialize(), function(data) {
          $grid.draw();
        });
      }
    });

    // click, on('click')의 차이 설명?
    $('#employeeForm :button:last').click(function() {
      $(this).prev().prop('disabled', false).parents('form')[0].reset();
      $('#example-select-all').prop('checked', false);
      $grid.row('.selected').remove().draw( false );
      $('#employeeForm #name').focus();
    });

    $('button.btn-danger').click(function() {
      var $checkboxes = $('#grid').find(':checked');
      if ($checkboxes.length > 0) {
    	if (confirm('삭제하시겠습니까?')) {
          var values = $checkboxes.map(function() {
            return $(this).val();
          }).get();

          $.delete('/sample/employees/' + values, function() {
            $grid.draw();
          });
    	}
      }
    });

    $grid.on('click', 'a', function(e) {
      e.preventDefault();

      $.get(this.href, function(data) {
        var $form = $('#employeeForm');
        $form.find(':submit').prop('disabled', false);

        $.each(data, function(key, value) {
          $form.find(':input[name=' + key + ']').val(value);
        });
      });
    });
  });
</script>