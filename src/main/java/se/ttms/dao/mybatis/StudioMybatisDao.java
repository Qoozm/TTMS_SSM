package se.ttms.dao.mybatis;

import se.ttms.model.Studio;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */


public interface StudioMybatisDao {

    int addStudio(Studio studio);

    int updateStudio(Studio studio);

    int delStudio(int studioId);

    List<Studio> getStudio(String condi);
}
