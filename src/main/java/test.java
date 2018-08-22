import dao.UserDao;
import model.Student;
import model.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class test {
    public static void main(String[] args){

        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        //从ioc容器中获取dao
        UserDao dao = (UserDao) context.getBean("dao");
        Student student = new Student();
        User user=new User();
        user.setId("1401150217");
        user.setPassword("123456");

        Boolean result = dao.modifyPassword(user);
        System.out.println("result = " + result);
    }

}
