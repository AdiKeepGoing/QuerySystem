<%@ page import="com.example.echartsdemo.Policy" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>河北省科技政策查询系统</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .header {
            background-color: #ffffff;
            height: 90px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 999;
        }

        .logo {
            width: 70px;
            height: 70px;
            background: url(<%= request.getContextPath() %>/LOGO.png) center/cover;
            margin-right: 20px;
        }

        .title {
            font-size: 24px;
            font-weight: bold;
            color: #333333;
        }

        .content {
            max-width: 1200px;
            margin: 120px auto 20px auto; /* Top margin increased to accommodate header */
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            overflow: auto; /* Allow content to scroll */
            height: calc(100vh - 130px); /* Calculate height to fit remaining viewport */
        }

        .form-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .form-container input[type="text"] {
            padding: 10px;
            margin-right: 10px;
            border-radius: 4px;
            border: 1px solid #cccccc;
        }

        .form-container button[type="submit"] {
            padding: 10px 20px;
            background-color: #2e2ee5;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #dddddd;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
            text-transform: uppercase;
            color: #555555;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .total-records {
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
            color: #777777;
        }
    </style>
</head>
<body>

<div class="header">
    <div class="logo"></div>
    <div class="title">科技政策查询系统</div>
</div>

<div class="content">
    <div class="form-container">
        <form action="/EchartsDemo_war_exploded/PolicySearchServlet" method="post">
            <input type="text" id="policyName" name="policyName" placeholder="政策名称">
            <input type="text" id="policyCode" name="policyCode" placeholder="政策编号">
            <input type="text" id="agency" name="agency" placeholder="发文机构">
            <input type="text" id="fullTextSearch" name="fullTextSearch" placeholder="全文检索">
            <button type="submit">查询</button>
        </form>
    </div>

    <div style="width: 80%; margin: auto; margin-top: 20px; height: 600px; overflow-y: auto;">
        <table id="policyTable" style="width: 100%; text-align: center; border-collapse: collapse;">
            <tr>
                <th style="border: 1px solid black; width: 30%;">政策名称</th>
                <th style="border: 1px solid black; width: 30%;">发文机构</th>
                <th style="border: 1px solid black; width: 15%;">颁布日期</th>
                <th style="border: 1px solid black; width: 15%;">政策分类</th>
                <th style="border: 1px solid black;">操作</th>
            </tr>
            <!-- 这里放置动态生成的表格内容 -->
            <% List<Policy> policies = (List<Policy>)request.getAttribute("policies");
                if (policies != null) {
                    for (Policy policy : policies) { %>
            <tr style="border: 1px solid black;">
                <td style="padding: 10px;"><%= policy.getName() %></td>
                <td style="padding: 10px;"><%= policy.getOrgan() %></td>
                <td style="padding: 10px;"><%= policy.getPubdata() %></td>
                <td style="padding: 10px;"><%= policy.getType() %></td>
                <td style="padding: 8px;"><a href="policyDetails.jsp?policyId=<%= policy.getId() %>">查看</a></td>
            </tr>
            <%          }
            }
            %>
        </table>
    </div>

    <!-- 添加分页链接 -->

    <div class="total-records">共有 <%= (policies != null) ? policies.size() : 0 %> 条数据</div>
</div>



</body>
</html>

