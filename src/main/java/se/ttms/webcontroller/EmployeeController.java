package se.ttms.webcontroller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import se.ttms.common.Md5;
import se.ttms.model.Employee;
import se.ttms.service.mybatis.MbtEmployeeService;

import java.util.ArrayList;

/**
 * Created by Jung on 2017/6/7.
 */
@Controller
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class EmployeeController {

    @Autowired
    MbtEmployeeService employeeSrv;

    @RequestMapping("/findEmployeeByPage")
    public ModelAndView findEmployeePage(int currentPage) {

        int pageSize = 8;
        PageHelper.startPage(currentPage, pageSize);
        ArrayList<Employee> employees = (ArrayList<Employee>) employeeSrv.FetchAll();
        PageInfo pageInfo = new PageInfo(employees);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("views/admin/employeeList");
        modelAndView.addObject("employees", employees);
        modelAndView.addObject("pageInfo", pageInfo);

        return modelAndView;
    }

    @RequestMapping("/searchByEmployeeName")
    public ModelAndView searchByEmployeeName(String employeeName) {

        int pageSize = 10;
        PageHelper.startPage(1, pageSize);
        ArrayList<Employee> employees = (ArrayList<Employee>) employeeSrv.Fetch("emp_name = '" + employeeName + "'");
        PageInfo pageInfo = new PageInfo(employees);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("views/admin/employeeList");
        modelAndView.addObject("employees", employees);
        modelAndView.addObject("pageInfo", pageInfo);

        return modelAndView;
    }

    @RequestMapping("/employeeModify")
    public ModelAndView employeeModify(Employee employee) {

        if (employee.getPassword() != null) {
            Md5 md5 = new Md5();
            employee.setPassword(md5.getMD5Str(employee.getPassword() + employee.getPassword()));
            employeeSrv.modify(employee);
        } else {
            String old = employeeSrv.Fetch("emp_id = " + employee.getId()).get(0).getPassword();
            employee.setPassword(old);
        }

        return findEmployeePage(1);
    }

    @RequestMapping(value = "/employeeAdd", method = RequestMethod.POST)
    public ModelAndView employeeAdd(Employee employee) {

        Md5 md5 = new Md5();
        employee.setPassword(md5.getMD5Str(employee.getPassword() + employee.getPassword()));
        employeeSrv.add(employee);

        return findEmployeePage(1);
    }

    @RequestMapping(value = "/employeeDelete")
    public ModelAndView employeeDel(int employeeId) {

        employeeSrv.delete(employeeId);

        return findEmployeePage(1);
    }

}
