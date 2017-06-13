package se.ttms.webcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import se.ttms.common.Md5;
import se.ttms.model.Employee;
import se.ttms.service.mybatis.MbtEmployeeService;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by colin on 2017/6/5.
 */

@Controller
public class IndexController {

    @Autowired
    MbtEmployeeService employeeSrv;

    @Autowired
    Md5 md5;

    @RequestMapping(value = "/index", method = RequestMethod.POST)
    public String verify(Employee employee,
                         @RequestParam("verificationCode") String verificationCode,
                         RedirectAttributes model,
                         HttpSession session) {

        String empNo = employee.getNo();
        String empPasswd = employee.getPassword();

        if (null == session.getAttribute("code") || !session.getAttribute("code").toString().equalsIgnoreCase(verificationCode)) {
            model.addFlashAttribute("info", "验证码错误！");
            session.setAttribute("employee", employee);
            return "redirect:/login";
        }

        if (!empNo.equals("") && !empPasswd.equals("")) {
            empPasswd = md5.getMD5Str(empPasswd + empPasswd);

            String condt = "emp_no = '" + empNo + "'";
            List<Employee> employees = employeeSrv.Fetch(condt);

            if (employees.size() == 0) {
                model.addFlashAttribute("info", "输入的账号不存在！");
                return "redirect:/login";
            } else if (employees.get(0).getPassword().equals(empPasswd)) {

                session.removeAttribute("code");
                employee = employees.get(0);
                Employee.nowId = employee.getId();
                session.setAttribute("employee", employee);

                return "redirect:/views/common/index.html";

            } else {
                model.addFlashAttribute("info", "密码错误，请重新输入！");
                return "redirect:/login";
            }
        } else {
            model.addFlashAttribute("info", "用户名或密码错误，请重新输入！");
            return "redirect:/login";
        }
    }
}
