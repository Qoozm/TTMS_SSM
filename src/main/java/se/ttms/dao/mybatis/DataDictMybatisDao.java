package se.ttms.dao.mybatis;

import se.ttms.model.DataDict;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */


public interface DataDictMybatisDao {

    int addDataDict(DataDict dataDict);

    int delDataDict(int ID);

    int updateDataDict(DataDict dataDict);

    List<DataDict> getDataDict(String condi);


}
