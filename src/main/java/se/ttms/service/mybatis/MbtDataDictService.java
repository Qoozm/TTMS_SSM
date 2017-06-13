package se.ttms.service.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.ttms.dao.mybatis.DataDictMybatisDao;
import se.ttms.model.DataDict;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */

@Service
public class MbtDataDictService {

    @Autowired
    private DataDictMybatisDao dataDictMybatisDao;

    public int add(DataDict ddict){
        return dataDictMybatisDao.addDataDict(ddict);
    }

    public int modify(DataDict ddict){
        return dataDictMybatisDao.updateDataDict(ddict);
    }

    public int delete(int ID){
        return dataDictMybatisDao.delDataDict(ID);
    }

    public List<DataDict> Fetch(String condt){
        return dataDictMybatisDao.getDataDict(condt);
    }

    public List<DataDict> FetchAll(){
        return dataDictMybatisDao.getDataDict("");
    }
    public List<DataDict> findByID(int id) {

        return dataDictMybatisDao.getDataDict(" dict_parent_id =" +id);
    }

    public void findAllSonByID(List<DataDict> list, int id){

        List<DataDict> childList = findByID(id);
        for(int i=0;i<childList.size();i++){
            if(!hasChildren(childList.get(i).getId()))
                list.add(childList.get(i));
            else
            {
                findAllSonByID(list, childList.get(i).getId());
            }
        }
    }

    public boolean hasChildren(int id){
        List<DataDict> list = dataDictMybatisDao.getDataDict(" dict_parent_id =" +id);
        return list.size()>0 ? true : false;
    }
}
