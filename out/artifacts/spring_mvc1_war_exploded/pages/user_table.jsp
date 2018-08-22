<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  Student: Admin
  Date: 2018/8/21
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>user</title>
</head>
<body>
<h2>所有学生</h2>
<table id="items"  >
    <tr>
        <td>学号</td>
        <td>姓名</td>
        <td>地址</td>
        <td>年龄</td>
        <td>操作</td>
    </tr>

    <c:forEach items="${students}" var="student" >
        <tr>
            <td id="id${student.id }">${student.id }</td>
            <td id="name${student.id }">${student.username}</td>
            <td id="java${student.id}">${student.addr }</td>
            <td id="html${student.id }">${student.age }</td>
            <td ><a onclick="delete_stu(${student.id})">删除</a>|<a onclick="edit_stu(${student.id})">编辑</a></td>
        </tr>
    </c:forEach>

</table>
</body>
</html>
