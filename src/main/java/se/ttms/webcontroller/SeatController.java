package se.ttms.webcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import se.ttms.model.Seat;
import se.ttms.model.Studio;
import se.ttms.service.mybatis.MbtSeatService;
import se.ttms.service.mybatis.MbtStudioService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by colin on 2017/6/8.
 */

@Controller
public class SeatController {

    @Autowired
    private MbtSeatService seatSrv;

    @Autowired
    private MbtStudioService studioSrv;

    @RequestMapping(value = "/searchSeatByStudioId", method = RequestMethod.GET)
    public String searchSeatByStudioId(int studioId, int currentPage, Model model) {

        ArrayList<Seat> seats = (ArrayList<Seat>) seatSrv.Fetch("studio_id = " + "'" + studioId +"'");
        List<Studio> studios = studioSrv.Fetch("studio_id = " + "'" + studioId +"'");
        Studio studio = studios.get(0);

        model.addAttribute("list", seats);
        model.addAttribute("studio", studio);
        model.addAttribute("currentPage", currentPage);

        return "views/admin/seat";
    }

    @RequestMapping(value = "/seatModify", method = RequestMethod.GET)
    public void seatModify(HttpServletRequest request, HttpServletResponse response) throws IOException {
        PrintWriter out = response.getWriter();
        String result = "no";

        ArrayList<String> seatId = new ArrayList<String>();
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

            Seat seat = new Seat();
            seat.setId(seat_id);
            seat.setStudioId(studio.getID());
            seat.setRow(row);
            seat.setColumn(col);
            seat.setSeatStatus(status);

            if(seatSrv.modify(seat) == 1){
                result = "yes";
            }
        }

        out.write(result);
        out.close();

    }

}
