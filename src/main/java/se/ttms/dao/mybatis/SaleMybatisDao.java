package se.ttms.dao.mybatis;

import se.ttms.model.Sale;
import se.ttms.model.SaleItem;

import java.util.List;
import java.util.Map;

/**
 * Created by Charley on 2017/6/9.
 */

public interface SaleMybatisDao {

    int doSale(Map<String, Object> map);

    int addItem(Map<String, Object> map);

    int updateTicketStatusForSaled(int ticketId);

    int delSale(int SaleId);

    List<Sale> getSale(String condi);

    List<SaleItem> getSaleItem(String condi);


}
