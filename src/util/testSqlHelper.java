package util;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by ow on 16/4/29.
 */
public class testSqlHelper {
    public static void main(String[] args) throws SQLException {
        testQuery();
//        testInsert();
//        testDelete();
//        testUpdate();

    }

    public static void testQuery() throws SQLException {
        System.out.print("testQuery......");


        String sqlStr = "SELECT * FROM student";
        ResultSet rs = SqlHelper.executeQuery(sqlStr, null);
        while(rs.next()){
            int id = rs.getInt("id");
            String name = rs.getString("name");
            String sex = rs.getString("sex");
            int age = rs.getInt("age");

            System.out.println("ID: "+id+", name: "+name+", sex: "+sex+", age: "+age);
        }

    }

    public static void testInsert() {
        String sql = "INSERT INTO student (name, sex,age,memo) VALUES (?,?,?,?)";//增
//        String[] para =  {"韩梅梅","女","24","小韩"};
        String[] para = {"李雷", "男", "29", "小李"};
        SqlHelper.executeUpdate(sql, para);
    }

    public static void testDelete() {
        String sql = "DELETE FROM student WHERE name=?";//删
        String[] para = {"韩梅梅"};
        SqlHelper.executeUpdate(sql, para);
    }

    public static void testUpdate() {
        String sql = "UPDATE student SET age=?, sex=? WHERE name='李雷'";//改
        String[] para = {"26", "男"};
        SqlHelper.executeUpdate(sql, para);
    }
}
