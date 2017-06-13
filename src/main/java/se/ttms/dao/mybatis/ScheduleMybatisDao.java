package se.ttms.dao.mybatis;

import se.ttms.model.Schedule;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */

public interface ScheduleMybatisDao {

    int addSchedule(Schedule schedule);

    int delSchedule(int ScheduleID);

    int updateSchedule(Schedule schedule);

    List<Schedule> getSchedule(String condi);

}
