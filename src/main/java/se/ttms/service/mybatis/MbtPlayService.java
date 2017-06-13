package se.ttms.service.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.ttms.dao.mybatis.PlayMybatisDao;
import se.ttms.model.Play;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */
@Service
public class MbtPlayService {

    @Autowired
    private PlayMybatisDao playMybatisDao;

    public int add(Play stu){
        return playMybatisDao.addPlay(stu);
    }

    public int modify(Play stu){
        return playMybatisDao.updatePlay(stu);
    }

    public int delete(int ID){
        return playMybatisDao.delPlay(ID);
    }

    public List<Play> Fetch(String condt){
        return playMybatisDao.getPlay(condt);
    }

    public List<Play> FetchAll(){
        return playMybatisDao.getPlay("");
    }
}
