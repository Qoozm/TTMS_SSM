package se.ttms.dao.mybatis;

import se.ttms.model.Play;

import java.util.List;

/**
 * Created by Charley on 2017/6/8.
 */

public interface PlayMybatisDao {

    int addPlay(Play play);

    int delPlay(int playID);

    int updatePlay(Play play);

    List<Play> getPlay(String condi);
}
