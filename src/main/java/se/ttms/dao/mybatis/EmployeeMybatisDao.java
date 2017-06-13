package se.ttms.dao.mybatis;

import se.ttms.model.Employee;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */

public interface EmployeeMybatisDao {

    int addEmployee(Employee employee);

    int delEmployee(int ID);

    int updateEmployeeInfo(Employee employee);

    int updateEmployeePass(Employee employee);

    List<Employee> getEmployee(String condi);
}
