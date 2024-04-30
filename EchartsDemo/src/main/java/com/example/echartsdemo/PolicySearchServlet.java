package com.example.echartsdemo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PolicySearchServlet")
public class PolicySearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String policyName = request.getParameter("policyName");
        String policyCode = request.getParameter("policyCode");
        String agency = request.getParameter("agency");
        String fullTextSearch = request.getParameter("fullTextSearch");

        List<Policy> policies = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = DatabaseConnection.getConnection();
            // Modified SQL query to include full text search
            String sql = "SELECT * FROM policy WHERE name LIKE ? AND id LIKE ? AND organ LIKE ? AND text LIKE ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + policyName + "%");
            statement.setString(2, "%" + policyCode + "%");
            statement.setString(3, "%" + agency + "%");
            statement.setString(4, "%" + fullTextSearch + "%");

            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String organ = resultSet.getString("organ");
                String pubdata = resultSet.getString("pubdata");
                String type = resultSet.getString("type");
                String id = resultSet.getString("id"); // Assuming "id" is the unique identifier
                Policy policy = new Policy(name, organ, pubdata, type);
                policy.setId(id); // Set the policy ID
                policies.add(policy);
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

        request.setAttribute("policies", policies);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
