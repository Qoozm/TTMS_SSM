package se.ttms.model;

import se.ttms.common.Md5;

import java.io.Serializable;

public class Employee implements Serializable {

    private int access;  //员工权限标志,管理员为1,售票员为0
    private int id;    //员工工号
    private String no;   //工号
    private String name;   //员工姓名
    private String password;    //员工密码
    private String addr;       //员工地址
    private String tel;         //员工电话
    private String email;       //电子邮件

    public static int nowId = 0;
    public static int nowAccess = 0;

    public static final int MANAGE = 1;
    public static final int CONDUCTOR = 0;

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Employee(){

    }

    public Employee(int access, int id, String name, String password) {
        this.access = access;
        this.id = id;
        this.name = name;

        //密码双倍后进行MD5加密
        password = password + password;
        Md5 en = new Md5();
        try {
            this.password = en.getMD5Str(password);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public Employee(int access, String no, String name, String password, String addr, String tel, String email) {
        this.access = access;
        this.no = no;
        this.name = name;
        this.password = password;
        this.addr = addr;
        this.tel = tel;
        this.email = email;
    }

    public int getAccess() {
        return access;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }

    public void setAccess(int access) {
        this.access = access;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "access=" + access +
                ", id=" + id +
                ", no='" + no + '\'' +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", addr='" + addr + '\'' +
                ", tel='" + tel + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
