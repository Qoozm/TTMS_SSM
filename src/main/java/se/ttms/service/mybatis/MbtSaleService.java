package se.ttms.service.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.ttms.dao.mybatis.SaleMybatisDao;
import se.ttms.model.Employee;
import se.ttms.model.Sale;
import se.ttms.model.SaleItem;
import se.ttms.model.Ticket;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Charley on 2017/6/9.
 */
@Service
public class MbtSaleService {

    @Autowired
    private SaleMybatisDao stuDAO;

    public boolean doSale(List<Ticket> tickets){

        float price = tickets.get(0).getPrice() * tickets.size();
        Map<String, Object> par = new HashMap<String, Object>();
        par.put("employeeId", Employee.nowId);
        par.put("nowTime", new Timestamp(new Date().getTime()));
        par.put("price", price);
        par.put("id", 0);

        int rtn = stuDAO.doSale(par);   // 插入Sale
        if (rtn > 0) {
            int id = Integer.parseInt(par.get("id").toString());
            par = new HashMap<String, Object>();
            par.put("saleId", id);
            par.put("price", tickets.get(0).getPrice());
            for (Ticket ticket : tickets) {
                par.put("ticketId", ticket.getId());
                int tmp = stuDAO.addItem(par);    // 插入SaleItem
                if (tmp > 0) {
                    if (stuDAO.updateTicketStatusForSaled(ticket.getId()) <= 0) {  // 修改状态
                        return false;
                    }
                } else {
                    return false;
                }
            }
            return true;
        }
        return false;
    }

    public List<Sale> Fetch(String condt) {
        return stuDAO.getSale(condt);
    }

    public List<Sale> FetchAll() {
        return stuDAO.getSale("");

    }

    public int delete(int ID){
        return stuDAO.delSale(ID);
    }

    public List<SaleItem> Fetchdetail(String condt) {
        return stuDAO.getSaleItem(condt);
    }

    public List<SaleItem> FetchAlldetail() {
        return stuDAO.getSaleItem("");
    }


}
