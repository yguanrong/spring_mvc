<%@ page import="org.springframework.web.servlet.ModelAndView" %><%--
  Created by IntelliJ IDEA.
  Student: Admin
  Date: 2018/7/19
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"  %>
<html>
<head>
    <title>登录</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="../res/js/bootstrap.min.css">
    <link rel="stylesheet" href="../res/js/css1.css">
    <script src="../res/js/jquery.js"></script>
    <script src="../res/js/bootstrap.min.js"></script>

</head>
<body class="body">
<div class="prent">
    <div class="form" >
        <form autocomplete="off" action="/doLogin" method="post">
            <div class="ipt">
                <input type="text" name="id" id="name" value="1401150217" placeholder="请输入账号"/><br>
                <input type="password" name="password" value="123456" id="password" required="required" placeholder="请输入密码">
                <input style="background:#5cb85c; color: #ffffff" type="submit"  value="登录"/>
                <br>
                <b style="margin-left: 10%; color: #ac2925;" id="msg">${msg}</b>
            </div>

                <%--<div class="login  cont_join row">--%>
                    <%--<h2 style="color:#003333;font-size:22px;">四方考试系统</h2>--%>
                    <%--<h4 style="color:#a86515;font-size:22px;">用户登录 </h4>--%>
                    <%--<div class="input-group form-group">--%>
                        <%--<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>--%>
                        <%--<input type="text" class="form-control" placeholder="请输入用户名" required="required" maxlength="20">--%>
                        <%--<span class="glyphicon glyphicon-remove-circle form-control-feedback" style="display:inline-block;"></span>--%>
                    <%--</div>--%>
                    <%--<div class="input-group form-group">--%>
                        <%--<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>--%>
                        <%--<input type="text" class="form-control" placeholder="请输入密码" required="required" maxlength="16">--%>
                        <%--<span class="glyphicon glyphicon-eye-close form-control-feedback"></span> <!--小图标元素-->--%>
                    <%--</div>--%>
                    <%--<button type="submit" class="btn btn-primary btn-block">登    录</button><br>--%>
                    <%--<small class="text-muted">没有账户？<a href="regist.html">点此注册</a><div style="display: inline-block;width: 20%;"></div>--%>
                        <%--<a href="temporary.html">临时账户</a></small><a href="temporary.html">找回密码</a>--%>
                    <%--</small>--%>
                <%--</div>--%>
        </form>
    </div>
</div>

</body>
</html>