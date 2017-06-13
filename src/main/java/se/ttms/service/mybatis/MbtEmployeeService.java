package se.ttms.service.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.ttms.dao.mybatis.EmployeeMybatisDao;
import se.ttms.model.Employee;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */
@Service
public class MbtEmployeeService {

    @Autowired
    private EmployeeMybatisDao employeeDAO;

    public int add(Employee employee) {
        return employeeDAO.addEmployee(employee);
    }

    public int modifyPasswd(Employee employee) {
        return employeeDAO.updateEmployeePass(employee);
    }

    public int modify(Employee employee) {
        return employeeDAO.updateEmployeeInfo(employee);
    }

    public int delete(int id) {
        return employeeDAO.delEmployee(id);
    }

    public List<Employee> Fetch(String condt) {
        return employeeDAO.getEmployee(condt);
    }

    public List<Employee> FetchAll() {
        return employeeDAO.getEmployee("");
    }
}
