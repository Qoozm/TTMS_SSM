package se.ttms.webcontroller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import se.ttms.model.Employee;
import se.ttms.model.Sale;
import se.ttms.model.SaleItem;
import se.ttms.service.mybatis.MbtPlayService;
import se.ttms.service.mybatis.MbtSaleService;
import se.ttms.service.mybatis.MbtScheduleService;
import se.ttms.service.mybatis.MbtTicketService;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Charley on 2017/6/7.
 */

@Controller
public class SaleController {

    @Autowired
    private MbtSaleService saleSrv;

    @Autowired
    private MbtScheduleService scheduleSrv;

    @Autowired
    private MbtPlayService playSrv;

    @Autowired
    private MbtTicketService ticketSrv;


    @RequestMapping("/findSaleByPage")
    public ModelAndView findSaleByPage(int currentPage, HttpSession session) {

        Employee employee = (Employee) session.getAttribute("employee");
        PageHelper.startPage(currentPage, 5);
        ArrayList<Sale> sales;
        if (employee.getAccess() == 0) {
            sales = (ArrayList<Sale>) saleSrv.Fetch("emp_id = " + employee.getId());
        }
        else {
            sales = (ArrayList<Sale>) saleSrv.FetchAll();
        }
        PageInfo pageInfo = new PageInfo(sales);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("employee", employee);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("sales", sales);
        modelAndView.setViewName("views/common/saleList");

        return modelAndView;

    }

    @RequestMapping("/findSaleItem")
    public ModelAndView findSaleItem(int currentPage, int saleId, int backSalePage) {

        HashMap<Integer, String> itemMap = new HashMap<Integer, String>();
        PageHelper.startPage(currentPage, 5);
        ArrayList<SaleItem> saleItems = (ArrayList<SaleItem>) saleSrv.Fetchdetail("sale_ID = " + saleId);
        PageInfo pageInfo = new PageInfo(saleItems);

        for (SaleItem saleItem : saleItems) {

            itemMap.put(saleItem.getId(), playSrv.Fetch("play_id = " + scheduleSrv.Fetch("sched_id = " +
                    "" + ticketSrv.Fetch("ticket_id = " + saleItem.getTicketId()).get(0).getScheduleId()).get(0).getPlay_id()).get(0).getName());
        }

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("views/common/saleItem");
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("itemMap", itemMap);
        modelAndView.addObject("saleItems", saleItems);
        modelAndView.addObject("backSalePage", backSalePage);

        return modelAndView;
    }

}
