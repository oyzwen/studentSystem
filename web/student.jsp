<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: ow
  Date: 16/5/2
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>学生系统</title>
    <% String path = request.getContextPath(); %>

    <style>
        body {
            margin: 0;
            padding: 0;
        }

        #top {
            background: #444;
            margin: 0px auto;
            padding: 20px;
        }

        #title {
            width: 340px;
            font-size: 36px;
            color: #ffffff;
            margin: 0px auto;
            padding: 0;
        }

        #formContainer {
            width: auto;
            height: 220px;
            background: #f2f2f2;
            /*border: #93bccc 1px solid;*/
            margin: 0px auto;
            padding: 30px;
        }

        form {
            width: 200px;
            height: auto;
            margin: 0px auto;
            padding: 0px;
            font-size: 14px;
            /*border: #6ca8cc 1px solid;*/

        }

        form b {
            color: #ff0000;
        }

        input {
            height: 30px;
            padding: 4px;
            vertical-align: middle;
        }

        .listInput {
            height: auto;
            width: 60px;
            padding: 0px;
            text-align: center;
            vertical-align: middle;
            /*background: #00ffff;*/
            border: none;
        }

        .btn {
            width: 80px;
            height: 36px;
            border-radius: 4px;
            background: #415066;
            color: #FFFFFF;
            /*text-shadow:none*/
            border: none;
            margin-right: 10px;
            font-size: 14px;
        }

        table {
            width: 600px;
            height: auto;
            margin: 20px auto;
            padding: 0;

            font-family: verdana, arial, sans-serif;
            font-size: 11px;
            color: #333333;
            border: #cccccc 1px solid;
            border-collapse: collapse;
        }

        table th {
            padding: 8px;
            border: #cccccc 1px solid;
            background-color: #f2f2f2;
        }

        table td {
            padding: 8px;
            border: #cccccc 1px solid;
            background-color: #ffffff;
            text-align: center;
        }
    </style>
    <script src="script/jquery-1.7.2.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function () {
            var lastID = 1;
            var temp = parseInt($("tr:last").attr("id"));
            if(temp)lastID = temp;

            $(".delete").click(function () {
                $.ajax({
                    url: "student",
                    data: $(this).attr("href"),
                    type: "GET",
                    datatype: "text",

                    success: function (msg) {
                        //alert("success!")
                    },
                    error: function (msg) {
                        alert("error!")
                        return false;
                    }
                })
                var cur = parseInt($(this).parents("tr").children("td").eq(0).html());
                var o = $("tr:gt(cur-1)").children("td").eq(0).html();
                $("tr").each(function () {
                    var n = $(this).children("td").eq(0).html();
                    if (n > cur)$(this).children("td").eq(0).html(n - 1);
                })


                $(this).parent().parent().remove();
                //event.preventDefault();
                return false;
            })


            $("#save").click(saveClick);
            function saveClick() {
                var name = $("form input[name='name']").val();
                var sex = $("form input[name='sex']").val();
                var age = $("form input[name='age']").val();
                var memo = $("form input[name='memo']").val();

                var orderNumer = parseInt($("tr:last").children("td").eq(0).html());//id  列表最后一位学生的序号 +1

                if(orderNumer)
                {
                    orderNumer++;
                }else{
                    orderNumer=1;
                }


                if (!name.length > 0) {
                    alert("姓名不能为空!");
                    $("form input[name='name']").focus();
                    //event.preventDefault();
                    return false;
                }
                if (!age > 0 || age > 100) {
                    alert("年龄输入不正确!");
                    $("form input[name='age']").focus();

                    //event.preventDefault();
                    return false;
                }

                $.ajax({
                    url: "student",
                    data: {name: name, sex: sex, age: age, memo: memo, method: "insert"},
                    type: "POST",
                    datatype: "text",
                    sucess: function () {
                        //alert("sucess!")
                    },
                    error: function () {
                        alert("error");
                        return false;
                    }
                })

                lastID++;
                var tr = "<tr>" +
                        "<td>" + orderNumer + "</td>" +
                        "<td><input class = 'listInput' type='text'  name='name' value='" + name + "'/></td>" +
                        "<td><input class='listInput' type='text' name='sex' value='" + sex + "'/></td>" +
                        "<td><input class='listInput' type='text' name='age' value='" + age + "'/></td>" +
                        "<td><input class='listInput' type='text' name='memo' value='" + memo + "'/></td>" +
                        "<td><a class='delete' href='method=delete&id=" + lastID + "'>删除</a></td>" +
                        "</tr>"

                $("table").append(tr);

                event.preventDefault();
                //$("form").submit();
            }


            $(".listInput").click(function () {
                $(this).attr("contenteditable", true);
                $(this).focus();
            });

            $(".listInput").focusout(function () {
                var sex = $(this).parent().parent().children("td").eq(2).children("input").attr("value");
                if (sex != "男" && sex != "女") {
                    alert("性别输入有误!");
                    $(this).parent().parent().children("td").eq(2).children("input").focus();
                }
            })

            $(".listInput").change(function () {
                var id = $(this).parents("tr").attr("id");
                var name = $(this).parent().parent().children("td").eq(1).children("input").attr("value");
                var sex = $(this).parent().parent().children("td").eq(2).children("input").attr("value");
                var age = $(this).parent().parent().children("td").eq(3).children("input").attr("value");
                var memo = $(this).parent().parent().children("td").eq(4).children("input").attr("value");

                if (sex != "男" && sex != "女") {
                    alert("性别输入有误!");
                    $(this).parent().parent().children("td").eq(2).children("input").focus();

                } else {
                    //alert(id + "----------" + name + "---" + sex + "---" + age + "--" + memo);
                    //location.href = "student?method=update&id=" + id + "&name=" + name + "&sex=" + sex + "&age=" + age + "&memo=" + memo;
                    $.ajax({
                        url: "student",
                        data: {name: name, sex: sex, age: age, memo: memo,id:id, method: "update"},
                        type: "POST",
                        datatype: "text",
                        sucess: function () {
                            //alert("sucess!")
                        },
                        error: function () {
                            alert("error");
                            return false;
                        }
                    })


                }
            })
        })

    </script>
</head>
<body>
<div id="top">
    <div id="title">旷课网学生管理系统</div>
</div>
<div id="formContainer">
    <form>
        <%--<form>--%>
        <b>*</b>姓名:&nbsp&nbsp&nbsp&nbsp<input type="text" name="name"/><br><br>
        <b>*</b>性别:&nbsp&nbsp&nbsp&nbsp男&nbsp<input type="radio" name="sex" checked="checked" value="男"/>
        &nbsp&nbsp&nbsp&nbsp女&nbsp<input type="radio" name="sex" value="女"/><br><br>
        <b>*</b>年龄:&nbsp&nbsp&nbsp&nbsp<input type="number" max="100" min="1" name="age"/><br><br>
        备注:&nbsp&nbsp&nbsp&nbsp<input type="text" name="memo"/><br><br>
        <button class="btn" id="save">保存</button>
        <button class="btn" id="reset" type="reset">重置</button>
    </form>
</div>
<div id="list">
    <table>
        <tr>
            <th width="10%"><b>序号</b></th>
            <th width="20%"><b>姓名</b></th>
            <th width="15%"><b>性别</b></th>
            <th width="15%"><b>年龄</b></th>
            <th width="20%"><b>备注</b></th>
            <th width="20%"><b>操作</b></th>
        </tr>
        <%
            ResultSet rs = (ResultSet) request.getAttribute("rs");
            int i = 1;
            while (rs.next()) {
                out.println("<tr id='" + rs.getString("id") + "'>");
                out.println("<td>" + i + "</td>");
                out.println("<td><input class='listInput' type='text' name='name' value='" + rs.getString("name") + "'/></td>");
                out.println("<td><input class='listInput' type='text' name='sex' value='" + rs.getString("sex") + "'/></td>");
                out.println("<td><input class='listInput' type='number' name='age' value='" + rs.getString("age") + "'/></td>");
                out.println("<td><input class='listInput' type='text' name='memo' value='" + rs.getString("memo") + "'/></td>");
                out.println("<td><a class='delete' href='method=delete&id=" + rs.getString("id") + "'>删除</a></td>");
                       /* + "&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp" + "<a class='edit' href='" + path + "/student?method=update&id=" + rs.getString("id")
                        + "&name="+rs.getString("name")
                        + "&sex="+rs.getString("sex")
                        + "&age="+rs.getString("age")
                        + "&memo="+rs.getString("memo")
                        +"'>修改</a></td>");*/
                out.println("</tr>");
                i++;
            }

            rs.close();
        %>
    </table>
</div>
</body>
</html>
