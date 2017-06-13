package se.ttms.dao.mybatis;

import se.ttms.model.Ticket;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */
public interface TicketMybatisDao {

    int addTicket(Ticket ticket);

    int delTicket(int ticketID);

    int delTicketBySchedule(int scheduleID);

    int updateTicketStatus(Ticket ticket);

    int updateTicketPrice(int scheduleId, double price);

    List<Ticket> getTicket(String condi);
}
