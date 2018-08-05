'use strict';

var Formatter = {
  date: function() {
    $('.input-date').each(function() {
      new Cleave(this, {
          date: true,
          datePattern: ['Y', 'm', 'd'],
          delimiter: '-'
      });
    });
  },
  numeral: function() {
    $('.input-numeral').each(function() {
      new Cleave(this, {
          numeral: true,
          numeralThousandsGroupStyle: 'thousand'
      });
    });
  },
  format: function() {
    Formatter.date();
    Formatter.numeral();
  }
};

var Widget = {
  datepicker: function() {
    $('.date').each(function() {
      $(this).datetimepicker({
        format: 'YYYY-MM-DD'
      });
    });
  }
};

var Grid = {
  init: function() {
    $.extend($.fn.dataTable.defaults, {
      processing: true,
      searching: true,
      ordering: true,
      info: false,
      dom: '<f<t><ilp>>',
      language: {
        lengthMenu: '페이지당 줄수 _MENU_',
        zeroRecords: '검색 결과가 없습니다',
        info: '현재페이지 _PAGE_ of _PAGES_',
        infoEmpty: '조회된 데이터가 없습니다.',
        infoFiltered: '(총 _MAX_ 개)',
        emptyTable: '조회된 데이터가 없습니다.'
      },
    });
  },
  filterColumn: function(grid, index, value) {
    grid.column(index).search(value, false, true, false).draw();
  }
};

var Validator = {
  regexes: {
    currency: /(?=.)(([1-9][0-9]{0,2}(,[0-9]{3})*)|0)?(\.[0-9]{1,2})?$/,
    date: /^\d{4}-\d{1,2}-\d{1,2}$/
  },
  init: function() {
    $.extend(window.Parsley.options, {
      errorsWrapper: false
    });

    Parsley.on('field:error', function (fieldInstance) {
      var $element = fieldInstance.$element;
      if ($element.data('error-message') != fieldInstance.getErrorsMessages().toString()) {
        $element.tooltip({
          trigger: 'hover',
          container: 'body',
          placement: 'bottom',
          title: function () {
            return fieldInstance.getErrorsMessages();
          }
        }).tooltip($element.is(':focus') ? 'show' : null);

        $element.parents('div.form-group').addClass('has-error');
        $element.data('error-message', fieldInstance.getErrorsMessages().toString());
      }
    });

    Parsley.on('field:success', function (fieldInstance) {
      fieldInstance.$element.parents('div.form-group').removeClass('has-error');
      fieldInstance.$element.removeData('error-message');
      fieldInstance.$element.tooltip('destroy');
    });

    Validator.register();
    Validator.addMessage();
  },
  register: function() {
    Parsley.addValidator('currency', {
      requirementType: 'string',
      validateString: function(value, requirement) {
        return Validator.regexes.currency.test(value);
      },
      messages: {
        ko: '유효한 금액을 입력하세요.'
      }
    });
    Parsley.addValidator('date', {
      requirementType: 'string',
      validateString: function(value, requirement) {
        return Validator.regexes.date.test(value);
      },
      messages: {
        ko: '유효한 날짜를 입력하세요.'
      }
    });
    Parsley.addValidator('count', {
        requirementType: 'string',
        validateString: function(value, requirement) {
          if(requirement == "5"){ //.equals가 적용안됨
            return value.length==5;
          }else if(requirement == "6"){
            return value.length==6;
          }
          return false;
        },
        messages: {
          ko: '%s글자를 입력하세요.'
        }
    });
  },
  addMessage: function() {
    Parsley.addMessages('ko', {
      defaultMessage: '입력한 내용이 올바르지 않습니다.',
      type: {
        email:        '유효한 이메일을 입력하세요.',
        url:          '유효한 URL을 입력하세요.',
        number:       '숫자를 입력하세요.',
        integer:      '정수를 입력하세요.',
        digits:       '숫자를 입력하세요.',
        alphanum:     '알파벳과 숫자만 입력하세요.'
      },
      notblank:       '공백은 입력할 수 없습니다.',
      required:       '필수 입력사항입니다.',
      pattern:        '입력한 내용이 올바르지 않습니다.',
      min:            '입력 값은 %s보다 크거나 같아야 합니다. ',
      max:            '입력 값은 %s보다 작거나 같아야 합니다.',
      range:          '입력 값은 %s보다 크고 %s 보다 작아야 합니다.',
      minlength:      '%s 이상의 글자수를 입력하세요. ',
      maxlength:      '%s 이하의 글자수를 입력하세. ',
      length:         '입력 값은 글자수가 %s보다 크고 %s보다 작아야 합니다.',
      mincheck:       '최소한 %s개를 선택하세요. ',
      maxcheck:       '%s개 또는 그보다 적게 선택하세요.',
      check:          '선택한 값이 %s보다 크거나 %s보다 작아야 합니다.',
      equalto:        '같은 값을 입력하세요.'
    });
    Parsley.setLocale('ko');
  }
};

var Typeahead = {
  default: {
    highlight: true
  }
};

var JQuery = {
  extends: function() {
    $.rest = function(url, data, callback, type, method) {
      if ($.isFunction(data)) {
        type = type || callback,
        callback = data,
        data = {}
      }

      return $.ajax({
        url: url,
        type: method,
        success: callback,
        data: data,
        contentType: type
      });
    }

    $.put = function(url, data, callback, type) {
      return $.rest(url, data, callback, type, 'PUT');
    }

    $.delete = function(url, data, callback, type) {
      return $.rest(url, data, callback, type, 'DELETE');
    }

    $.alert = function(message, callback) {
      var $alert = showModal('#_alert_', message);
      var $footer = $alert.find('.modal-footer');
      $footer.off();

      if (callback) {
        $footer.on('click', '> button', callback);
      }
    }

    $.confirm = function(message, okCallback, cancelCallback) {
      var $confirm = showModal('#_confirm_', message);
      var $footer = $confirm.find('.modal-footer');
      $footer.off();

      if (okCallback) {
        $footer.on('click', '> button:first', okCallback);
      }

      if (cancelCallback) {
        $footer.on('click', '> button:last', cancelCallback);
      }
    }

    $.fn.serializeObject = function() {
      var object = {};
      var array = this.serializeArray();

      $.each(array, function() {
        if (object[this.name] !== undefined) {
          if (!object[this.name].push) {
            object[this.name] = [object[this.name]];
          }
          object[this.name].push(this.value || '');
        } else {
          object[this.name] = this.value || '';
        }
      });
      return object;
    };

    function showModal(selector, message) {
      var $modal = $(selector);
      $modal.find('.modal-body p').empty().text(message);
      $modal.modal('show');
      return $modal;
    }
  }
};

var Modal = {
  defaults: {
    update: false,
    'class': 'modal-dialog'
  },
  init: function() {
    $('[data-toggle=modal]').each(function() {
      var $trigger = $(this);
      var options = $.extend({}, Modal.defaults, $trigger.data('options'));

      var $modalContainer = $('<div>', {
        id: $trigger.data('target').substring(1),
        'class': 'modal fade modal-wrap',
        'data-update': options.update
      });
      var $modalDialog = $('<div>', options);
      var $modalContent = $('<div>', {'class': 'modal-content'});
      $modalContainer.append($modalDialog.append($modalContent)).appendTo('body');
    });

    $('body').on('hidden.bs.modal', function(e) {
      var $modal = $(e.target);
      if ($modal.data('update')) {
        $modal.removeData('bs.modal').find('.modal-content').empty();
      }
    });
  }
};

var Ajax = {
  defaults: {
    enabledProgressBar: false,
    progressBarText: ''//'please wait...'
  },
  setProgressBarText: function(text) {
    Ajax.defaults.progressBarText = text;
  },
  enableProgressBar: function() {
    $(document).ajaxStart(function() {
      Ajax.defaults.enabledProgressBar = true;

      if(!$('#loading').length){
        var $container = $('<div>', {id: 'loading', style: 'display: none'});
        var $wrapper = $('<div>')
        var $image = $('<img>', {src: '/img/ajax-loader.gif'});
        var $text = $('<div>', {text: Ajax.defaults.progressBarText});
        var $background = $('<div>', {'class': 'bg'});

        $wrapper.append($image).append($text);
        $container.append($wrapper).append($background).appendTo('body');

        $('#loading').css({
          width: '100%',
          height: '100%',
          position: 'fixed',
          zIndex: 10000000,
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          margin: 'auto'
        });

        $('#loading .bg').css({
          background: '#000000',
          opacity: 0,
          width: '100%',
          height: '100%',
          position: 'absolute',
          top: 0
        });

        $('#loading > div:first').css({
          width: '250px',
          height: '75px',
          textAlign: 'center',
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          margin: 'auto',
          fontSize: '16px',
          zIndex: 10,
          color: '#000000'
        });
      }
      $('#loading .bg').height('100%');
      $('#loading').fadeIn(300);
      $('body').css('cursor', 'wait');
    });

    $(document).ajaxStop(function() {
       $('#loading').fadeOut(300);
       $('body').css('cursor', 'default');
    });
  },
  enableErrorHandler: function() {
    $(document).ajaxError(function(evnet, xhr, settings, thrownError) {
      var response = JSON.parse(xhr.responseText);
      $.alert(response.message);
    });
  }
};

var Utils = {
  openWindow: function(url, options) {
    if (!options) {
      options = {};
    }

    if (!options.width) {
        options.width = 1024;
    }
    if (!options.height) {
        options.height = 768;
    }
    if (!options.layout) {
        options.layout = 'resizable=no, toolbar=no, menubar=no, location=no, status=no, scrollbars=yes';
    }

    var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
    var screenWidth = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
    var screenHeight = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
    var left = (screenWidth / 2) - (options.width / 2) + dualScreenLeft;
    var top = (screenHeight / 2) - (options.height / 2) + dualScreenTop;
    var name = '__window__' + Math.floor((Math.random() * 1000000) + 1);

    if (!options.params) {
        var params = '';
        $.each(options.params, function(name, value) {
            params += name + '=' + value + '&';
        });
        url += params ? '?' + params : '';
    }
    return window.open(url, name, 'top=' + top + ', left=' + left + ', width=' + options.width + ', height=' + options.height + ', ' + options.layout);
  }
};

$(document).ready(function() {
  JQuery.extends();
  Grid.init();
  Widget.datepicker();
  Formatter.format();
  Validator.init();
  Modal.init();
  Ajax.enableErrorHandler();
  Ajax.enableProgressBar();
});