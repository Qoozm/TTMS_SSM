package se.ttms.service.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.ttms.dao.mybatis.SeatMybatisDao;
import se.ttms.model.Seat;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */

@Service
public class MbtSeatService {

    @Autowired
    private SeatMybatisDao stuDAO;

    public int add(Seat stu){
        return stuDAO.addSeat(stu);
    }

    public int modify(Seat stu){
        return stuDAO.updateSeat(stu);
    }

    public int delete(int ID){
        return stuDAO.delSeat(ID);
    }

    public int deleteAll(int ID){
        return stuDAO.delAllSeat(ID);
    }

    public List<Seat> Fetch(String condt){
        return stuDAO.getSeat(condt);
    }

    public List<Seat> FetchAll(){
        return stuDAO.getSeat("");
    }
}
