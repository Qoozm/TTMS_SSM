package se.ttms.service.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.ttms.dao.mybatis.SeatMybatisDao;
import se.ttms.dao.mybatis.StudioMybatisDao;
import se.ttms.model.Seat;
import se.ttms.model.Studio;

import java.util.List;

/**
 * Created by Charley on 2017/6/10.
 */

@Service
public class MbtStudioService {

    @Autowired
    private StudioMybatisDao stuDAO;

    @Autowired
    SeatMybatisDao seatMybatisDao;

    public int add(Studio stu){
        return stuDAO.addStudio(stu);
    }

    public int modify(Studio stu){
        return stuDAO.updateStudio(stu);
    }

    public int delete(int ID){
        return stuDAO.delStudio(ID);
    }

    public List<Studio> Fetch(String condt){
        return stuDAO.getStudio(condt);
    }

    public List<Studio> FetchAll(){
        return stuDAO.getStudio("");
    }

    public int createSeats(Studio stu){
        if(stu.getStudioFlag()==0){
            int rnt = 0;
            Seat seat = new Seat();
            try {
                for (int i = 1; i <= stu.getRowCount(); i++)
                    for (int j = 1; j <= stu.getColCount(); j++) {
                        seat.setRow(i);
                        seat.setColumn(j);
                        seat.setSeatStatus(1);
                        rnt += seatMybatisDao.addSeat(seat);
                    }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return rnt;
        }
        return -1;
    }
}
