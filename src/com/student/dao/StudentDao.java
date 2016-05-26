package com.student.dao;

import com.student.model.Student;
import util.SqlHelper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ow on 16/5/1.
 */
public class StudentDao {
    public ResultSet query() throws SQLException{
        String sqlStr = "SELECT * FROM student";
        ResultSet rs = SqlHelper.executeQuery(sqlStr, null);
        return rs;
    }

    public static void insert(Student student) {
        String sql = "INSERT INTO student (name, sex,age,memo) VALUES (?,?,?,?)";//增
//        String[] para =  {"韩梅梅","女","24","小韩"};
        String[] para = {student.getName(), student.getSex(), student.getAge(), student.getMemo()};
        SqlHelper.executeUpdate(sql, para);
    }

    public static void delete(String id) {
        String sql = "DELETE FROM student WHERE id=?";//删
        String[] para = {id};
        SqlHelper.executeUpdate(sql, para);
    }

    public static void update(Student student) {
        String sql = "UPDATE student SET name=?, age=?, sex=?, memo=? WHERE id="+student.getId();//改
        String[] para = {student.getName(), student.getAge(), student.getSex(), student.getMemo()};
        SqlHelper.executeUpdate(sql, para);
    }
}
