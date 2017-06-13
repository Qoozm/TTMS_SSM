package se.ttms.webcontroller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import se.ttms.model.Seat;
import se.ttms.model.Studio;
import se.ttms.service.mybatis.MbtSeatService;
import se.ttms.service.mybatis.MbtStudioService;

import java.util.List;


/**
 * Created by colin on 2017/6/7.
 */
@Controller
public class StudioController {

    @Autowired
    private MbtStudioService studioSrv;

    @Autowired
    private MbtSeatService seatSrv;

    @RequestMapping(value = "/findStudioByPage", method = RequestMethod.GET)
    public String findStudioByPage(int currentPage, Model model) {

        PageHelper.startPage(currentPage, 5);
        List<Studio> studios = studioSrv.FetchAll();
        PageInfo pageInfo = new PageInfo(studios);

        model.addAttribute("studios", studios);
        model.addAttribute("pageInfo", pageInfo);

        return "views/admin/studioList";
    }

    @RequestMapping(value = "/studioModify", method = RequestMethod.POST)
    public String studioModify(Studio studio, RedirectAttributes model) {

        String status;

        if (seatSrv.deleteAll(studio.getID()) != 0 && studioSrv.modify(studio) != 0) {
            status = "修改演出厅" + studio.getName() + "成功";
        } else {

            status = "修改演出厅" + studio.getName() + "失败";
            model.addFlashAttribute("tip", status);
            return "redirect:/findStudioByPage?currentPage=1";
        }

        seatSrv.deleteAll(studio.getID());

        Seat seat = new Seat();

        for (int i = 0; i < studio.getRowCount(); i++) {
            for (int j = 0; j < studio.getColCount(); j++) {
                seat.setStudioId(studio.getID());
                seat.setRow(i + 1);
                seat.setColumn(j + 1);
                seat.setSeatStatus(Seat.GOOD_SEAT);

                seatSrv.add(seat);
            }
        }

        model.addFlashAttribute("tip", status);

        return "redirect:/findStudioByPage?currentPage=1";
    }

    @RequestMapping(value = "/studioAdd", method = RequestMethod.POST)
    public String studioAdd(Studio studio, RedirectAttributes model) {

        String status;

        if (studioSrv.add(studio) != 0) {
            status = "添加演出厅" + studio.getName() + "成功";
        } else {

            status = "添加演出厅" + studio.getName() + "失败";
            model.addFlashAttribute("tip", status);
            return "redirect:/findStudioByPage?currentPage=1";
        }

        Seat seat = new Seat();

        for (int i = 0; i < studio.getRowCount(); i++) {
            for (int j = 0; j < studio.getColCount(); j++) {
                seat.setStudioId(studio.getID());
                seat.setRow(i + 1);
                seat.setColumn(j + 1);
                seat.setSeatStatus(Seat.GOOD_SEAT);

                seatSrv.add(seat);
            }
        }

        model.addFlashAttribute("tip", status);

        return "redirect:/findStudioByPage?currentPage=1";
    }

    @RequestMapping(value = "/studioDelete", method = RequestMethod.GET)
    public String studioDelete(int studioId, RedirectAttributes model) {
        String status;

        if (studioSrv.delete(studioId) != 0) {
            status = "删除演出厅成功";
        } else {
            status = "删除演出厅失败";
            model.addFlashAttribute("tip", status);
            return "redirect:/findStudioByPage?currentPage=1";
        }

        model.addFlashAttribute("tip", status);

        return "redirect:/findStudioByPage?currentPage=1";
    }

    @RequestMapping(value = "/searchByStudioName", method = RequestMethod.GET)
    public String searchByStudioName(String studioName, Model model) {

        List<Studio> studios = studioSrv.Fetch("studio_name = " + "'" + studioName.trim() + "'");

        PageInfo pageInfo = new PageInfo(studios);
        model.addAttribute("studios", studios);
        model.addAttribute("pageInfo", pageInfo);

        return "views/admin/studioList";
    }
}
