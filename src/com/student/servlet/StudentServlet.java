package com.student.servlet;

import com.student.dao.StudentDao;
import com.student.model.Student;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ow on 16/5/1.
 */
public class StudentServlet extends HttpServlet {
    private StudentDao dao = new StudentDao();

    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String method = req.getParameter("method");
        try {
            switch (method) {
                case "insert":
                    insert(req, resp);
                    break;

                case "delete":
                    delete(req, resp);
                    break;

                case "query":
                    query(req, resp);
                    break;

                case "update":
                    update(req, resp);
                    break;

                default:
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void query(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        ResultSet rs = dao.query();
        req.setAttribute("rs", rs);
        req.getRequestDispatcher("student.jsp").forward(req, resp);
    }

    public void insert(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
/*        String name = new String(req.getParameter("name").getBytes("ISO-8859-1"), "utf-8");
        String sex = new String(req.getParameter("sex").getBytes("ISO-8859-1"), "utf-8");
        String age = new String(req.getParameter("age").getBytes("ISO-8859-1"), "utf-8");
        String memo = new String(req.getParameter("memo").getBytes("ISO-8859-1"), "utf-8");*/

        String name = req.getParameter("name");
        String sex = req.getParameter("sex");
        String age = req.getParameter("age");
        String memo = req.getParameter("memo");
//        String id = req.getParameter("id");

        java.net.URLDecoder.decode(name, "utf-8");
        java.net.URLDecoder.decode(sex, "utf-8");
        java.net.URLDecoder.decode(age, "utf-8");
        java.net.URLDecoder.decode(memo, "utf-8");
//        java.net.URLDecoder.decode(id, "utf-8");


        Student student = new Student();
        student.setName(name);
        student.setAge(age);
        student.setSex(sex);
        student.setMemo(memo);

        dao.insert(student);
        //query(req, resp);
    }

    public void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        dao.delete(req.getParameter("id"));
//        resp.getWriter().print("ok!");
       // query(req, resp);
    }

    public void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        /*
        String name = new String(req.getParameter("name").getBytes("ISO-8859-1"), "UTF-8");
        String sex = new String(req.getParameter("sex").getBytes("ISO-8859-1"), "UTF-8");
        String age = new String(req.getParameter("age").getBytes("ISO-8859-1"), "UTF-8");
        String memo = new String(req.getParameter("memo").getBytes("ISO-8859-1"), "UTF-8");
        String id = new String(req.getParameter("id").getBytes("ISO-8859-1"), "UTF-8");
        */

        String name = req.getParameter("name");
        String sex = req.getParameter("sex");
        String age = req.getParameter("age");
        String memo = req.getParameter("memo");
        String id = req.getParameter("id");

        java.net.URLDecoder.decode(name, "utf-8");
        java.net.URLDecoder.decode(sex, "utf-8");
        java.net.URLDecoder.decode(age, "utf-8");
        java.net.URLDecoder.decode(memo, "utf-8");
        java.net.URLDecoder.decode(id, "utf-8");

        Student student = new Student();
        student.setName(name);
        student.setAge(age);
        student.setSex(sex);
        student.setMemo(memo);
        student.setId(Integer.parseInt(id));

        dao.update(student);
        //query(req, resp);
    }
}