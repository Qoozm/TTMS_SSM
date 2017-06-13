package se.ttms.model;

public class Seat {

	
	 /*
	  * seat_status   smallint comment    '取值含义：
            0：此处是空位，没有安排座椅
            1：完好的座位，可以使用
            -1：座位损坏，不能安排座位',

	  */
	private int id;
	private int studioId;
	private int row;
	private int column;
	private int seatStatus;

	public static final int BAD_SEAT = -1;
	public static final int EMPTY_SEAT = 0;
	public static final int GOOD_SEAT = 1;
	
	
	public Seat(){	}

	@Override
	public String toString() {
		return "Seat{" +
				"id=" + id +
				", studioId=" + studioId +
				", row=" + row +
				", column=" + column +
				", seatStatus=" + seatStatus +
				'}';
	}

	public Seat(int id, int studioId, int row, int column, int seatStatus) {
		super();
		this.id = id;
		this.studioId = studioId;
		this.row = row;
		this.column = column;
		this.seatStatus = seatStatus;
	}

	public int getSeatStatus() {
		return seatStatus;
	}

	public void setSeatStatus(int seatStatus) {
		this.seatStatus = seatStatus;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getStudioId() {
		return studioId;
	}

	public void setStudioId(int studioId) {
		this.studioId = studioId;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public int getColumn() {
		return column;
	}

	public void setColumn(int column) {
		this.column = column;
	}
}
