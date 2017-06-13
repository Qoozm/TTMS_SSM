package se.ttms.dao.mybatis;

import se.ttms.model.Seat;

import java.util.List;

/**
 * Created by Charley on 2017/6/9.
 */


public interface SeatMybatisDao {

    int addSeat(Seat seat);

    int delSeat(int seatId);

    int updateSeat(Seat seat);

    int delAllSeat(int studioId);

    List<Seat> getSeat(String condi);

}
