<%@ page import="com.example.echartsdemo.Policy" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.example.echartsdemo.DatabaseConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>政策详情</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            margin-top: 20px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .policy-info {
            margin-top: 20px;
        }
        .policy-info p {
            margin: 10px 0;
            font-size: 18px;
        }
        .policy-info p span {
            font-weight: bold;
        }
        .error-message {
            color: #ff0000;
            text-align: center;
            font-size: 18px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>政策详情</h1>
    <%!
        // 方法：安全输出
        public String safeOutput(String input) {
            return input != null ? input : "";
        }
    %>
    <%-- 获取传递过来的政策ID --%>
    <% String policyId = request.getParameter("policyId"); %>
    <%-- 初始化政策对象 --%>
    <% Policy policy = null; %>
    <%-- 数据库连接 --%>
    <% Connection connection = null; %>
    <% PreparedStatement statement = null; %>
    <% ResultSet resultSet = null; %>
    <% try {
        // 获取数据库连接
        connection = DatabaseConnection.getConnection();
        // 准备查询语句
        String sql = "SELECT * FROM policy WHERE id=?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, policyId);
        // 执行查询
        resultSet = statement.executeQuery();
        // 处理结果集
        if (resultSet.next()) {
            String name = resultSet.getString("name");
            String organ = resultSet.getString("organ");
            String pubdata = resultSet.getString("pubdata");
            String type = resultSet.getString("type");
            String document = resultSet.getString("document");
            String text = resultSet.getString("text");
            // 创建政策对象
            policy = new Policy(name, organ, pubdata, type, document, text);
            policy.setId(policyId);
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // 关闭数据库连接
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } %>
    <%-- 显示政策详情 --%>
    <% if (policy != null) { %>
    <div class="policy-info">
        <p><span>政策名称：</span><%= safeOutput(policy.getName()) %></p>
        <p><span>发文机构：</span><%= safeOutput(policy.getOrgan()) %></p>
        <p><span>颁布日期：</span><%= safeOutput(policy.getPubdata()) %></p>
        <p><span>政策分类：</span><%= safeOutput(policy.getType()) %></p>
        <p><span>文档：</span><%= safeOutput(policy.getDocument()) %></p>
        <p><span>文本：</span><%= safeOutput(policy.getText()) %></p>
    </div>
    <% } else { %>
    <p class="error-message">未找到该政策的详情。</p>
    <% } %>
</div>
</body>
</html>
