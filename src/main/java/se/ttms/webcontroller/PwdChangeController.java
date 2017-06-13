package se.ttms.webcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import se.ttms.common.Md5;
import se.ttms.model.Employee;
import se.ttms.service.mybatis.MbtEmployeeService;

import javax.servlet.http.HttpSession;

/**
 * Created by Charley on 2017/6/8.
 */

@Controller
public class PwdChangeController {

    @Autowired
    private MbtEmployeeService employeeSrv;

    @Autowired
    private Md5 md5;

    @RequestMapping("/pwdChange")
    public ModelAndView pwdChange(String old_pwd, String new_pwd, HttpSession session) {

        Employee employee = (Employee) session.getAttribute("employee");
        String status = null;
        old_pwd.trim();
        new_pwd.trim();
        old_pwd = md5.getMD5Str(old_pwd + old_pwd);
        new_pwd = md5.getMD5Str(new_pwd + new_pwd);

        if (old_pwd.equals(employee.getPassword())) {

            employee.setPassword(new_pwd);
            if (employeeSrv.modifyPasswd(employee) == 1) {
                status = "密码修改成功";
                session.setAttribute("employee", employee);
            } else {
                status = "密码修改失败";
            }
        } else {
            status = "原密码不正确";
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("views/common/change_pwd");
        modelAndView.addObject("status", status);

        return modelAndView;
    }
}
