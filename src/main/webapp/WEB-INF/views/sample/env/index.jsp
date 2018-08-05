<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="panel panel-primary">
  <div class="panel-heading">Development Environment</div>
  <div class="panel-body">
    <jsp:include page="development.jsp" />
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-heading">Subversion</div>
  <div class="panel-body">
    <jsp:include page="subversion.jsp" />
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-heading">Jenkins (Build)</div>
  <div class="panel-body">
    <jsp:include page="jenkins.jsp" />
  </div>
</div>

<div class="panel panel-primary">
  <div class="panel-heading">Nexus (Library Repository)</div>
  <div class="panel-body">
    <jsp:include page="nexus.jsp" />
  </div>
</div>