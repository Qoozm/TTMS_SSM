package se.ttms.webcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import se.ttms.model.Seat;
import se.ttms.model.Studio;
import se.ttms.model.Ticket;
import se.ttms.service.mybatis.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by colin on 2017/6/9.
 */
@Controller
public class SaleTicketController {

    @Autowired
    private MbtStudioService studioSrv;

    @Autowired
    private MbtSeatService seatSrv;

    @Autowired
    private MbtScheduleService scheduleSrv;

    @Autowired
    private MbtTicketService ticketSrv;

    @Autowired
    private MbtSaleService saleSrv;

    @RequestMapping(value = "/doSale", method = RequestMethod.GET)
    public ModelAndView doSale(int scheduleId, int studioId) {
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("views/common/selectSeat");

        Studio studio = studioSrv.Fetch("studio_id = " + studioId).get(0);

        List<Seat> seats = seatSrv.Fetch("studio_id = " + studioId);

        List<Ticket> tickets = ticketSrv.Fetch("sched_id = " + scheduleId);

        HashMap<Integer, Ticket> seatTickets = new HashMap<Integer, Ticket>();

        for (Ticket ticket : tickets) {
            seatTickets.put(ticket.getSeatId(), ticket);
        }

        modelAndView.addObject("seatTickets", seatTickets);
        modelAndView.addObject("studio", studio);
        modelAndView.addObject("list", seats);

        return modelAndView;
    }

    @RequestMapping(value = "/pay", method = RequestMethod.GET)
    public void pay(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setCharacterEncoding("utf-8");

        PrintWriter out = response.getWriter();
        String result = "no";

        ArrayList<String> seatId = new ArrayList<String>();
        HashMap seatTickets = (HashMap) request.getSession().getAttribute("seatTickets");

        ArrayList<Ticket> tickets = new ArrayList<Ticket>();


        Studio studio = (Studio) request.getSession().getAttribute("studio");

        List<Seat> seats = seatSrv.Fetch("studio_id = " + "'" + studio.getID() +"'");
        Seat seatFirst = seats.get(0);
        int firstSeatId = seatFirst.getId();
        int studioRowCount = studio.getRowCount();

        for(int i = 1; request.getParameter("seat_id" + i) != null; i++){
            seatId.add(request.getParameter("seat_id" + i));
        }

        for(int i = 0;i < seatId.size();i++){

            String seatString = seatId.get(i);
            String[] seatSplit = seatString.split("_");
            int row = Integer.parseInt(seatSplit[0]);
            int col = Integer.parseInt(seatSplit[1]);
            int status = Integer.parseInt(seatSplit[2]);
            int seat_id = firstSeatId + (row - 1) * studioRowCount + col - 1;

            tickets.add((Ticket) seatTickets.get(seat_id));

        }

        float price = tickets.size() * tickets.get(0).getPrice();

        if (studio.getStudioFlag() == 1 && saleSrv.doSale(tickets)) {
            result = "购票成功，共 " + Float.toString(price) + " 元";
        }

        out.write(result);
        out.close();
    }
}
