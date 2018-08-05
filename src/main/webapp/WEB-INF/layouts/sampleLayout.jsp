<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Spring Boot Demo</title>
    <tiles:insertAttribute name="style" />
    <style type="text/css">
      body {
        padding-top: 75px;
      }
      pre {
          padding: 0px;
          margin: 0px 0px 20px 0px;
          background-color: transparent;
      }
      p {
        line-height: 1.8;
      }
      blockquote {
        font-size: 16px;
        line-height: 1.5;
      }
      dt {
        font-size: 16px;
      }

      /* 향후 퍼블리셔에게 전달.. */
      .dataTables_length {
        float: left;
      }
      .dataTables_filter {
        display: none;
      }
    </style>
    <tiles:insertAttribute name="script" />
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/sample">Sample</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="/sample/client">ClientSide</a></li>
            <li><a href="/sample/server">ServerSide</a></li>
            <li><a href="/sample/env">Development Env</a></li>
            <li><a href="/sample/guide">Naming Rule</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container">
      <tiles:insertAttribute name="body" />
    </div>
    <footer class="footer">
      <div class="container">
        <p class="text-muted">© 2016 CHOTIRE.</p>
      </div>
    </footer>
    <script type="text/javascript">
      $(function () {
        $('pre code').each(function(i, block) {
          hljs.highlightBlock(block);
        });

        var parser = document.createElement('a');
        parser.href = location.href;
        $('.navbar-nav a').each(function() {
          var $a = $(this);
          if ($a.attr('href') == parser.pathname) {
            $a.parent().addClass('active');
            return false;
          }
        });

        if ($('.navbar-nav li.active').length == 0) {
          $('.navbar-nav li:first').addClass('active');
        }
      });
    </script>
    <tiles:insertAttribute name="alert" />
    <tiles:insertAttribute name="confirm" />
  </body>
</html>