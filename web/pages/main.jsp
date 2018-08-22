<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  Student: Admin
  Date: 2018/7/19
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>主页home</title>
    <link rel="stylesheet" href="../res/js/bootstrap.css">
    <link rel="stylesheet" href="../res/js/css2.css">
    <script src="../res/js/jquery-3.3.1.js"></script>
    <script src="../res/js/bootstrap.min.js"></script>
    <script>
        /**正常的操作符号*/
        function setCaozuo(x){
            var index=x;
            var upd ='<span onclick="update('+index+')" class="glyphicon glyphicon-pencil" ></span>&nbsp;';
            var caozuo ='<div id="'+"old"+x+'">'+upd+'</div>'+
                '<div style="display: none" id="'+"new"+x+'"><input onclick="subm('+index+')" type="button" value="完成">' +
                '&nbsp;<input onclick="ret('+index+')" type="button" value="取消"></div>';
            return caozuo;
        }

        /**查找数据*/
        function search() {
            $("#result").empty();
            var str="<tr><th width='15%'>学号</th><th width='15%'>姓名</th><th width='15%'>地址</th><th width='15%'>年龄</th><th width='15%'>操作</th></tr>";
            $("#result").append(str);

            var val=document.getElementById("search_text");
            if(val.value.length===0) {
                searAll();
            }
        }

        /**修改数据*/
        function update(num) {

            var obj_old=document.getElementById("old"+num);
            var obj_new=document.getElementById("new"+num);
            var obj=document.getElementById(num);
            var input_obj=obj.getElementsByTagName("input");
            for(var i=0;i<input_obj.length;i++){
                input_obj[i].removeAttribute("readOnly");
            }
            obj_old.style.display="none";
            obj_new.style.display="block";
        }
        /**提交修改数据*/
        function subm(num) {
            var name=document.getElementById("name_"+num).value;
            var id=document.getElementById("id_"+num).value;
            var addr=document.getElementById("addr_"+num).value;
            var age=document.getElementById("age_"+num).value;
            var obj_old=document.getElementById("old"+num);
            var obj_new=document.getElementById("new"+num);
            var obj=document.getElementById(num);
            var input_obj=obj.getElementsByTagName("input");

            $.ajax({
                type:"POST",
                dataType: 'text',
                url:"/update",
                data:{id:id,username:name,addr:addr,age:age},
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success:function(data){
                    alert(data);
                    obj_old.style.display="block";
                    obj_new.style.display="none";

                    for(var i=0;i<input_obj.length;i++){
                        input_obj[i].setAttribute("readOnly","readonly");
                    }

                },
                error:function(data){
                    alert(data);
                }

            });
        }
        /**取消修改*/
        function ret(num) {
            var obj_old=document.getElementById("old"+num);
            var obj_new=document.getElementById("new"+num);
            obj_old.style.display="block";
            obj_new.style.display="none";

            var obj=document.getElementById(num);
            var input_obj=obj.getElementsByTagName("input");
            for(var i=0;i<input_obj.length;i++){
                input_obj[i].setAttribute("readOnly","readonly");
            }
        }

        function searAll() {
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: "/all",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var str = '<tr id="' + i + '"><th><input style="width: 90%" id="id_' + i + '" type="text" readOnly="readonly" value="' + data[i].id +
                            '"></th><th><input style="width: 90%" id="name_' + i + '" type="text" readOnly="readonly" value="' + data[i].username +
                            '"></th><th><input style="width: 90%" id="addr_' + i + '" type="text" readOnly="readonly" value="' + data[i].addr +
                            '"></th><th><input style="width: 90%" id="age_' + i + '" type="text" readOnly="readonly" value="' + data[i].age +
                            '"></th><th>' + setCaozuo(i) + '</th></tr>';
                        $("#result").append(str);
                    }

                },
                error: function () {
                    alert("fail");
                }

            });
        }

        function showOne(obj) {
            $("#student").hide();
            $("#modifyPassword").hide();
            $("#add_student").hide();
            $("#delete_student").hide();

            $("#"+obj).show()
        }
        function submit_new_password() {
            var val=document.getElementById("new_password").value;
            $.ajax({

                type:"POST",
                dataType: 'text',
                url:"/modifyPassWord",
                data:{id:${id},password:val},
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success:function(data){
                    alert(data);

                },
                error:function(data){
                    alert(data);
                }

            });
        }

        function submit_new_student() {

            var new_id=document.getElementById("new_id").value;
            var new_name=document.getElementById("new_name").value;
            var new_addr=document.getElementById("new_addr").value;
            var new_age=document.getElementById("new_age").value;
            $.ajax({
                type:"POST",
                dataType: 'text',
                url:"/add",
                data:{id:new_id,username:new_name,addr:new_addr,age:new_age},
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success:function(data){
                    alert(data);

                },
                error:function(data){
                    alert(data);
                }

            });
        }
        function submit_delete_student() {

            var delete_id=document.getElementById("delete_id").value;
            $.ajax({
                type:"POST",
                dataType: 'text',
                url:"/deleteById",
                data:{id:delete_id},
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                success:function(data){
                    alert(data);
                },
                error:function(data){
                    alert(data);
                }

            });
        }


    </script>
</head>
<body>
<div class="navbar navbar-duomi navbar-static-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <i class="navbar-brand" id="logo">学生信息管理系统 欢迎您：${name}
            </i>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2" style="margin-top: 20px">
            <ul id="main-nav" class="nav nav-tabs nav-stacked" style="">
                <li class="active">
                    <a href="javascript:showOne('student')">
                        <i class="glyphicon glyphicon-th-large"></i>
                        首页
                    </a>
                </li>
                <li>
                    <a href="#systemSetting" class="nav-header collapsed" data-toggle="collapse">
                        <i class="glyphicon glyphicon-cog"></i>
                        系统管理
                        <span class="pull-right glyphicon glyphicon-chevron-down"></span>
                    </a>
                    <ul id="systemSetting" class="nav nav-list collapse secondmenu" style="height: 0px;">
                        <li><a href="#">用户管理<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                        <li><a href="#">角色管理<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                        <li><a href="javascript:showOne('modifyPassword')">修改密码<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                    </ul>
                </li>
                <li>
                    <a href="#dySetting" class="nav-header collapsed" data-toggle="collapse">
                        <i class="glyphicon glyphicon-user"></i>
                        学生管理
                        <span class="pull-right glyphicon glyphicon-chevron-down"></span>
                    </a>
                    <ul id="dySetting" class="nav nav-list collapse secondmenu" style="height: 0px;">
                        <li><a href="javascript:showOne('student')">查看信息
                            <i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                        <li><a href="javascript:showOne('add_student')">添加学生
                            <i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                        <li><a href="javascript:showOne('delete_student')">删除学生
                            <i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                    </ul>
                </li>

                <%--<li>--%>
                    <%--<a href="#jjfzSetting" class="nav-header collapsed" data-toggle="collapse">--%>
                        <%--<i class="glyphicon glyphicon-user"></i>--%>
                        <%--积极分子管理--%>
                        <%--<span class="pull-right glyphicon glyphicon-chevron-down"></span>--%>
                    <%--</a>--%>
                    <%--<ul id="jjfzSetting" class="nav nav-list collapse secondmenu" style="height: 0px;">--%>
                        <%--<li><a href="#">查看信息<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>--%>
                        <%--<li><a href="#">添加积极分子<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>--%>
                        <%--<li><a href="#">删除积极分子<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>--%>
                    <%--</ul>--%>
                <%--</li>--%>

                <li>
                    <a href="#ggSetting" class="nav-header collapsed" data-toggle="collapse">
                        <i class="glyphicon glyphicon-credit-card"></i>
                        公告管理
                        <span class="pull-right glyphicon glyphicon-chevron-down"></span>
                    </a>
                    <ul id="ggSetting" class="nav nav-list collapse secondmenu" style="height: 0px;">
                        <li><a href="#">查看公告<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                        <li><a href="#">发布公告<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                        <li><a href="#">删除公告<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                    </ul>
                </li>
                <li>
                    <a href="#dadSetting" class="nav-header collapsed" data-toggle="collapse">
                        <i class="glyphicon glyphicon-folder-open"></i>
                        档案袋管理
                        <span class="pull-right glyphicon glyphicon-chevron-down"></span>
                    </a>
                    <ul id="dadSetting" class="nav nav-list collapse secondmenu" style="height: 0px;">
                        <li><a href="#">查看档案袋<i class="glyphicon glyphicon-circle-arrow-right"></i></a></li>
                    </ul>
                </li>

            </ul>
        </div>
        <%--学生信息--%>
        <div class="col-md-10" id="student" style="margin-top: 20px">
            <div class="panel panel-success">
                <div class="panel-heading" >
                    内容
                </div>
                <div class="panel-body">
                    <form id="form" autocomplete="off" style="width: 100%">
                    <%--查询--%>
                        <div class="div-add" style="width:90%">
                        <input id="search_text" type="text" placeholder="请输入十位数学号查询，若为空则查询全部数据" style="width: 85%; float: left">
                        <a href="javascript:search()" style="width: 10%; float: right" title="查询">
                            <span class="glyphicon glyphicon-search" ></span>
                        </a>
                        </div>
                        <div  style="width:90%">
                            <table class="table" style="width: 100%" id="result">

                            </table>

                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%--修改密码--%>
        <div class="col-md-10" id="modifyPassword" style="display: none; margin-top: 20px">
            <div class="panel panel-success">
                <div class="panel-heading" >
                    修改密码
                </div>
                <div class="panel-body">

                        <input type="password" id="new_password" placeholder="输入新密码" style="width: 70%; float: left">

                    <input type="button" style="margin-left: 20px" onclick="submit_new_password()" value="确定">
                </div>
            </div>
        </div>

        <%--添加学生--%>
        <div class="col-md-10" id="add_student" style="display: none; margin-top: 20px">
            <div class="panel panel-success">
                <div class="panel-heading" >
                    添加学生
                </div>
                <div class="panel-body">
                    <div  style="width:90%">
                        <table class="table" style="width: 100%; padding-top: 10px">

                            <tr>
                                <th width="10%">
                                    姓名
                                </th>
                                <th width="68%">
                                    <input type="text" style="width:90%;" id="new_name">
                                </th>
                            </tr>
                            <tr>
                                <th width="10%">
                                    学号
                                </th>
                                <th width="68%">
                                    <input type="text" style="width:90%;" id="new_id">
                                </th>
                            </tr>
                            <tr>
                                <th width="10%">
                                    住址
                                </th>
                                <th width="68%">
                                    <input type="text" style="width:90%;" id="new_addr">
                                </th>
                            </tr>
                            <tr>
                                <th width="10%">
                                    年龄
                                </th>
                                <th width="68%">
                                    <input type="text" style="width:90%;" id="new_age">
                                </th>
                            </tr>
                        </table>

                    </div>

                    <input type="button" style="margin-left: 20px" onclick="submit_new_student()" value="确定">
                </div>
            </div>
        </div>

        <%--删除学生--%>
        <div class="col-md-10" id="delete_student" style="display: none; margin-top: 20px">
            <div class="panel panel-success">
                <div class="panel-heading" >
                    删除学生
                </div>
                <div class="panel-body">
                    <input type="text" id="delete_id" placeholder="输入要删除学生的id" style="width: 70%; float: left">
                    <input type="button" style="margin-left: 20px" onclick="submit_delete_student()" value="确定">
                </div>
            </div>
        </div>

    </div>
</div>

</body>
</html>