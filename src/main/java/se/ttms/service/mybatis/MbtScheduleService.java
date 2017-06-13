package se.ttms.service.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.ttms.dao.mybatis.ScheduleMybatisDao;
import se.ttms.model.Schedule;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */

@Service
public class MbtScheduleService {

    @Autowired
    private ScheduleMybatisDao stuDAO;

    public int add(Schedule stu){
        return stuDAO.addSchedule(stu);
    }

    public int modify(Schedule stu){
        return stuDAO.updateSchedule(stu);
    }

    public int delete(int ID){
        return stuDAO.delSchedule(ID);
    }

    public List<Schedule> Fetch(String condt){
        return stuDAO.getSchedule(condt);
    }

    public List<Schedule> FetchAll(){
        return stuDAO.getSchedule("");
    }
}
