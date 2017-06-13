package se.ttms.service.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.ttms.dao.mybatis.TicketMybatisDao;
import se.ttms.model.Ticket;

import java.util.List;

/**
 * Created by Charley on 2017/6/10.
 */

@Service
public class MbtTicketService {

    @Autowired
    private TicketMybatisDao stuDAO;

    public int add(Ticket stu){
        return stuDAO.addTicket(stu);
    }

    public int modify(int sched_id,double ticketprice){
        return stuDAO.updateTicketPrice(sched_id,ticketprice);
    }

    public int delete(int ID){
        return stuDAO.delTicket(ID);
    }

    public int modify(Ticket ticket){
        return stuDAO.updateTicketStatus(ticket);
    }

    public int deleteAll(int sched_id){
        return stuDAO.delTicketBySchedule(sched_id);
    }

    public List<Ticket> Fetch(String condt){
        return stuDAO.getTicket(condt);
    }

    public List<Ticket> FetchAll(){
        return stuDAO.getTicket("");
    }
}
