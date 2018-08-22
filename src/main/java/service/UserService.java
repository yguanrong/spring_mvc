package service;

import dao.UserDao;
import model.Student;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private UserDao userDao=new UserDao();

    public boolean loginCheck(Student user) {
        Student u = userDao.findUserByName(user.getUsername());
        if (u!=null){
            return true;
        }
        else {
            return false;
        }
    }
}
