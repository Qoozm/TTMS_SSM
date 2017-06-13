package se.ttms.webcontroller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import se.ttms.model.*;
import se.ttms.service.mybatis.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Jung on 2017/6/8.
 */

@Controller
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class ScheduleController {

    @Autowired
    private MbtScheduleService scheduleSrv;
    @Autowired
    private MbtPlayService playSrv;
    @Autowired
    private MbtStudioService studioSrv;

    @Autowired
    private MbtSeatService seatSrv;

    @Autowired
    private MbtTicketService ticketSrv;

    @RequestMapping("/findScheduleByPage")
    public ModelAndView findScheduleByPage(int currentPage) {

        int pageSize = 8;
        ModelAndView modelAndView = new ModelAndView();
        PageHelper.startPage(currentPage, pageSize);
        ArrayList<Schedule> schedules = (ArrayList<Schedule>) scheduleSrv.FetchAll();
        PageInfo pageInfo = new PageInfo(schedules);
        HashMap<Integer, String> idToPlayName = new HashMap<Integer, String>();
        HashMap<Integer, String> idToStudioName = new HashMap<Integer, String>();

        for (Schedule schedule : schedules) {
            System.out.println(schedule.getPlay_id());
            Play play = playSrv.Fetch("play_id = " + schedule.getPlay_id()).get(0);
            idToPlayName.put(schedule.getPlay_id(), play.getName());
            Studio studio = studioSrv.Fetch("studio_id = " + schedule.getStudio_id()).get(0);
            idToStudioName.put(schedule.getStudio_id(), studio.getName());
        }

        modelAndView.setViewName("views/admin/scheduleList");
        modelAndView.addObject("schedules", schedules);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("playsName", idToPlayName);
        modelAndView.addObject("studioNames", idToStudioName);

        return modelAndView;
    }

    @RequestMapping("/searchScheduleByPlayName")
    public ModelAndView searchScheduleByPlayName(String playName) {

        int pageSize = 10;
        List<Play> plays = playSrv.Fetch("play_name = '" + playName + "'");
        ArrayList<Schedule> schedules = new ArrayList<Schedule>();
        HashMap<Integer, String> idToStudioName = new HashMap<Integer, String>();
        HashMap<Integer, String> idToPlayName = new HashMap<Integer, String>();
        if ((plays == null) || (plays.size() == 0)) {
            plays = new ArrayList<Play>();
            plays.add(new Play());
        }
        PageInfo pageInfo = new PageInfo(schedules);
        for (Play play : plays) {
            PageHelper.startPage(1, pageSize);
            ArrayList<Schedule> tmp = (ArrayList<Schedule>) scheduleSrv.Fetch("play_id = " + play.getId());
            pageInfo = new PageInfo(tmp);
            idToPlayName.put(play.getId(), play.getName());
            for (Schedule schedule : tmp) {
                Studio studio = studioSrv.Fetch("studio_id = " + schedule.getStudio_id()).get(0);
                idToStudioName.put(schedule.getStudio_id(), studio.getName());
            }
            schedules.addAll(tmp);
        }

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("views/admin/scheduleList");
        modelAndView.addObject("schedules", schedules);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("studioNames",idToStudioName);
        modelAndView.addObject("playsName", idToPlayName);

        return modelAndView;
    }

    @RequestMapping(value = "/scheduleModify", method = RequestMethod.POST)
    public ModelAndView scheduleModify(Schedule schedule) {

        System.out.println(schedule);
        scheduleSrv.modify(schedule);

        return findScheduleByPage(1);
    }

    @RequestMapping(value = "/scheduleAdd", method = RequestMethod.POST)
    public ModelAndView scheduleAdd(Schedule schedule) {

        Ticket ticket = new Ticket();

        Play play = playSrv.Fetch("play_id = " + schedule.getPlay_id()).get(0);
        play.setStatus(1);
        playSrv.modify(play);

        scheduleSrv.add(schedule);
        ArrayList<Seat> seats = (ArrayList<Seat>) seatSrv.FetchAll();
        for (Seat seat : seats) {
            ticket.setSeatId(seat.getId());
            ticket.setScheduleId(schedule.getSched_id());
            ticket.setPrice((float) schedule.getSched_ticket_price());
            if (seat.getSeatStatus() == 1) {
                ticket.setStatus(0);
            } else {
                ticket.setStatus(9);
            }
            ticketSrv.add(ticket);
        }

        return findScheduleByPage(1);
    }

    @RequestMapping(value = "/scheduleDelete")
    public ModelAndView scheduleDel(int scheduleId) {

        scheduleSrv.delete(scheduleId);

        return findScheduleByPage(1);
    }

    @RequestMapping("/getStudioList")
    public void studioList (HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        ArrayList<Studio> studios = (ArrayList<Studio>) studioSrv.FetchAll();
        JsonArray langArray = new JsonArray();
        JsonObject langJson;

        for (int i = 0; i < studios.size(); ++i) {
            langJson = new JsonObject();
            langJson.addProperty("studioId", studios.get(i).getID());
            langJson.addProperty("studioName", studios.get(i).getName());
            langArray.add(langJson);
        }

        PrintWriter writer = response.getWriter();
        writer.write(langArray.toString());
        writer.close();
    }

    @RequestMapping("/getPlayList")
    public void playList (HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        ArrayList<Play> plays = (ArrayList<Play>) playSrv.FetchAll();
        JsonArray langArray = new JsonArray();
        JsonObject langJson;

        for (int i = 0; i < plays.size(); ++i) {
            langJson = new JsonObject();
            langJson.addProperty("playId", plays.get(i).getId());
            langJson.addProperty("playName", plays.get(i).getName());
            langArray.add(langJson);
        }

        PrintWriter writer = response.getWriter();
        writer.write(langArray.toString());
        writer.close();
    }





    @RequestMapping("/findTicketScheduleByPage")
    public ModelAndView findTicketScheduleByPage(int currentPage) {

        int pageSize = 8;
        ModelAndView modelAndView = new ModelAndView();
        PageHelper.startPage(currentPage, pageSize);
        ArrayList<Schedule> schedules = (ArrayList<Schedule>) scheduleSrv.FetchAll();
        PageInfo pageInfo = new PageInfo(schedules);
        HashMap<Integer, String> idToPlayName = new HashMap<Integer, String>();
        HashMap<Integer, String> idToStudioName = new HashMap<Integer, String>();

        for (Schedule schedule : schedules) {
            Play play = playSrv.Fetch("play_id = " + schedule.getPlay_id()).get(0);
            idToPlayName.put(schedule.getPlay_id(), play.getName());
            Studio studio = studioSrv.Fetch("studio_id = " + schedule.getStudio_id()).get(0);
            idToStudioName.put(schedule.getStudio_id(), studio.getName());
        }

        modelAndView.setViewName("views/common/saleTicket");
        modelAndView.addObject("schedules", schedules);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("playsName", idToPlayName);
        modelAndView.addObject("studioNames", idToStudioName);

        return modelAndView;
    }


    @RequestMapping("/searchTicketScheduleByPlayName")
    public ModelAndView searchTicketScheduleByPlayName(String playName) {

        int pageSize = 10;
        List<Play> plays = playSrv.Fetch("play_name = '" + playName + "'");
        ArrayList<Schedule> schedules = new ArrayList<Schedule>();
        HashMap<Integer, String> idToStudioName = new HashMap<Integer, String>();
        HashMap<Integer, String> idToPlayName = new HashMap<Integer, String>();
        if ((plays == null) || (plays.size() == 0)) {
            plays = new ArrayList<Play>();
            plays.add(new Play());
        }
        PageInfo pageInfo = new PageInfo(schedules);
        for (Play play : plays) {
            PageHelper.startPage(1, pageSize);
            ArrayList<Schedule> tmp = (ArrayList<Schedule>) scheduleSrv.Fetch("play_id = " + play.getId());
            pageInfo = new PageInfo(tmp);
            idToPlayName.put(play.getId(), play.getName());
            for (Schedule schedule : tmp) {
                Studio studio = studioSrv.Fetch("studio_id = " + schedule.getStudio_id()).get(0);
                idToStudioName.put(schedule.getStudio_id(), studio.getName());
            }
            schedules.addAll(tmp);
        }

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("views/common/saleTicket");
        modelAndView.addObject("schedules", schedules);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("studioNames",idToStudioName);
        modelAndView.addObject("playsName", idToPlayName);

        return modelAndView;
    }
}
