package com.example.echartsdemo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/PolicyDetailsServlet")
public class PolicyDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String policyId = request.getParameter("policyId");
        Policy policy = null;

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM policy WHERE id=?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, policyId);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("name");
                String organ = resultSet.getString("organ");
                String pubdata = resultSet.getString("pubdata");
                String type = resultSet.getString("type");
                String document = resultSet.getString("document");
                String text = resultSet.getString("text");

                policy = new Policy(name, organ, pubdata, type);
                policy.setId(policyId);
                policy.setDocument(document);
                policy.setText(text);
            } else {
                // 如果未找到对应政策，则返回错误信息或者跳转到错误页面
                // 可以使用 response.sendError() 或者 response.sendRedirect() 方法
                // 这里仅作为示例，您可以根据需求进行修改
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "未找到对应政策");
                return;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
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
        }

        // 将政策对象存储在请求属性中，以便在 JSP 页面中使用
        request.setAttribute("policy", policy);
        // 转发到政策详情页面
        request.getRequestDispatcher("/policyDetails.jsp").forward(request, response);
    }

}
