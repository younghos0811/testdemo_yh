<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
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
    <div class="container" style="overflow: scroll; height: 630px; ">
      <tiles:insertAttribute name="body" />
    </div>
    <p class="text-right">
      <button class="btn btn-primary" style="margin: 10px 20px 0px 0px" type="button" onclick="window.close()">Close</button>
    </p>
    <script type="text/javascript">
      $(function () {
        $('pre code').each(function(i, block) {
          hljs.highlightBlock(block);
        });
      });
    </script>
  </body>
</html>