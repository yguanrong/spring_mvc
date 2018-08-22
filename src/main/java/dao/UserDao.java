package dao;

import model.Student;
import model.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import com.alibaba.fastjson.JSON;

import javax.naming.spi.DirStateFactory;
import javax.xml.transform.Result;

/**
 * Repository用于标注数据访问组件，即DAO组件
 * Created by GuanRong on 2018/7/28.
 */

public class UserDao {

    //把对象转为json
    public static <T> String serialize(T object) {
        return JSON.toJSONString(object);
    }

    private JdbcTemplate jdbcTemplate;
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * 查询所有学生
     *
     * @return 返回值类型： List<Student>
     * @author janinus
     */
    public String queryAll() {
        String sql = "select id,name,addr,age from student";
        //将查询结果映射到Student类中，添加到list中，并返回
        List users= jdbcTemplate.query(sql, new StudentMapper());

        String string = serialize(users);
        System.out.println("string = " + string);

        return string;
    }
    /**
     * 通过姓名查询
     *
     * @param name
     * @return 返回值类型： List<Student>
     * @author janinus
     */
    public String queryByName(String name) {
        String sql = "select id,name,addr,age from student where name like '%" + name + "%'";
        List users= jdbcTemplate.query(sql, new StudentMapper());
        String string = serialize(users);

        return string;
    }

    /**
     * 通过姓名查询
     *
     * @param id
     * @return 返回值类型： List<Student>
     * @author janinus
     */
    public String queryName(String id) {
        String sql = "select * from student where id = '" + id + "'";
        List<Student> students= jdbcTemplate.query(sql, new StudentMapper());
        students.get(0).getUsername();

        return students.get(0).getUsername();
    }
    /**
     * 添加学生
     *
     * @param user
     * @return 返回值类型： boolean
     * @author janinus
     */
    public boolean add(Student user) {
        String sql = "insert into student(id,name,addr,age) values(?,?,?,?)";
        return jdbcTemplate.update(sql,
                new Object[] { user.getId(),user.getUsername(),  user.getAddr(), user.getAge()},
                new int[] { Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR }) == 1;
    }
    /**
     * 删除学生
     *
     * @param id
     * @return 返回值类型： boolean
     * @author janinus
     */
    public boolean delete(String id) {
        String sql = "delete from student where id = ?";
        return jdbcTemplate.update(sql, id) == 1;
    }
    /**
     * 更新学生信息
     *
     * @param student
     * @return 返回值类型： boolean
     * @author janinus
     */
    public boolean update(Student student) {
        String sql = "update student set id=? ,name=?,addr = ? ,age = ? where id = ?";
        Object stuObj[] = new Object[] { student.getId(), student.getUsername(), student.getAddr(),
                student.getAge(),student.getId()};
        return jdbcTemplate.update(sql, stuObj) == 1;
    }
    /**
     *
     * StudentMapper数据库映射
     *
     * @ClassName UserMapper
     * @author janinus
     * @date 2017年6月27日
     * @Version V1.0
     */
    class StudentMapper implements RowMapper<Student> {

        @Override
        public Student mapRow(ResultSet rs, int rowNum) throws SQLException {
            // TODO Auto-generated method stub
            Student user = new Student();
            user.setId(rs.getString("id"));
            user.setUsername(rs.getString("name"));
            user.setAddr(rs.getString("addr"));
            user.setAge(rs.getString("age"));


            return user;
        }

    }
    public Student findUserByName(String userName) {
        Student user = new Student();
        user.setId("1");
        user.setUsername("ygr");
        user.setAddr("广西");
        user.setAge("22");
        if (user.getUsername().equals(userName)) {
            return user;
        } else {

            return null;
        }
    }


    class UserMapper implements RowMapper<User>{

        @Override
        public User mapRow(ResultSet resultSet, int i) throws SQLException {
            User user=new User();
            user.setId(resultSet.getString("id"));
            user.setPassword(resultSet.getString("password"));
            return user;
        }
    }

    /**
     * 登录*/
    public int login(User user){
        //0:密码错误，1：登录成功，2：账号不存在
        String sql="select * from user where id='"+user.getId()+"'";
        List<User> u = jdbcTemplate.query(sql,new UserMapper());
        if(u.size()!=0 && u.size()==1){
            if (u.get(0).getPassword().equals(user.getPassword())){
                return 1;
            }else {
                return 0;
            }
        }
        else{
            return 2;
        }
    }

    /**
     * 修改密码*/
    public Boolean modifyPassword(User user){
        String sql = "update user set id=? ,password=? where id = ?";
        Object stuObj[] = new Object[] {   user.getId(), user.getPassword(), user.getId()};

        return jdbcTemplate.update(sql, stuObj) == 1;
    }

}
