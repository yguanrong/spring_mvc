package controller;

import dao.UserDao;
import model.Student;
import model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import service.UserService;

import java.io.PrintWriter;


@Controller
public class FirstController {

    private String msg="";//错误提示信息
    private ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    //从ioc容器中获取dao
    private UserDao dao = (UserDao) context.getBean("dao");


//    @RequestMapping("/login")
//    public String login(Model model){
//        model.addAttribute("msg",msg);
//
//        return "login";
//    }

//    @RequestMapping("/main")
//    public String main(){
//
//        return "main";
//    }

    @RequestMapping("/doLogin")
    public ModelAndView doLogin(User user){
        System.out.println("user.getId()+\"+++\"+user.getPassword() = " + user.getId()+"+++"+user.getPassword());
        ModelAndView mav = new ModelAndView();

        int re = dao.login(user);
        System.out.println("re = " + re);
        if(re==1) {
            //登录成功
            mav.addObject("name",dao.queryName(user.getId()));
            mav.addObject("id",user.getId());
            mav.setViewName("main");

        } else if (re==0){
            //密码不正确
            msg = "密码不正确";
            mav.addObject("msg",msg);
            mav.setViewName("login");
        }
        else
        {
            msg = "账号不存在";
            mav.addObject("msg",msg);
            mav.setViewName("login");

        }
        return mav;
    }

    /**
     *
     * 从数据库中获取全部学生信息，将数据返回给主页index,jsp
     *
     * @return 返回值类型： String
     * @author janinus
     */
    @RequestMapping(value = "/all",produces="text/html;charset=UTF-8")
    public @ResponseBody String queryAll() {
        return dao.queryAll();
    }

    /**
     * 通过姓名查找学生，使用模糊查找，将结果返回给index.jsp
     *
     * @param name
     * @param model
     * @return 返回值类型： String
     * @author janinus
     */
    @RequestMapping("/queryByName")
    public String queryByName(String name, Model model) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        //从ioc容器中获取dao
        UserDao dao = (UserDao) context.getBean("dao");
        model.addAttribute("students", dao.queryByName(name));
        return "main";
    }

    /**
     * 添加新学生，并将结果返回给all页面，由all转发到主页
     * @return 返回值类型： String
     * @author janinus
     */
    @RequestMapping( value="/add",produces = "text/html;charset=UTF-8")
    public @ResponseBody String addStu(Student student) {

        boolean result = dao.add(student);
        if (result)
            return "添加成功";
        else
            return "添加失败";
    }

    /**
     * 通过id删除学生
     * @return 返回值类型： String
     * @author janinus
     */
    @RequestMapping(value="/deleteById",produces = "text/html;charset=UTF-8")
    public @ResponseBody String deleteById(String id) {

        boolean result = dao.delete(id);
        if (result)
            return "删除成功";
        else
            return "删除失败";
    }

    /**
     *

     * @return 返回值类型： String
     * @author janinus
     */
    @RequestMapping(value = "/update",produces = "text/html;charset=UTF-8")
    public @ResponseBody String updateStu(Student student) {

        boolean result = dao.update(student);
        if (result)
            return "修改成功";
        else
            return "修改失败";
    }


    /**
     *
     * @return 返回值类型： String
     * @author janinus
     */
    @RequestMapping(value="/modifyPassWord",produces="text/html;charset=UTF-8")
    public @ResponseBody String modifyPassWord(User user) {

        boolean result = dao.modifyPassword(user);
        if (result)
            return "修改成功";
        else
            return "修改失败";
    }


    /**
     * 要弹出的页面消息
     * @param msg
     * @return 返回值类型： String
     * @author janinus
     */
    public String msg(String msg) {
        return "<script>alert('" + msg + "')</script>";
    }


    public void setDao(UserDao dao) {
        this.dao = dao;
    }

    public UserDao getDao() {
        return dao;
    }
}

