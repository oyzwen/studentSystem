<%--
  Created by IntelliJ IDEA.
  User: ow
  Date: 16/5/1
  Time: 22:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <% String path = request.getContextPath(); %>
    <title>欢迎登陆学生系统</title>
  </head>
  <body>
  欢迎登陆学生系统
  <a href="<%=path%>/student?method=query">点击进入</a>
  </body>
</html>
