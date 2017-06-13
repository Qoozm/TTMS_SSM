package se.ttms.model;

public class Sale {
	private int id;
	private int empId;
	private String time ; 
	private float payment;
	private float change;
	private int type;  // 1：销售单  -1：退款单
	private int status;  // 0：待付款   1：已付款
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public float getPayment() {
		return payment;
	}
	public void setPayment(float payment) {
		this.payment = payment;
	}
	public float getChange() {
		return change;
	}
	public void setChange(float change) {
		this.change = change;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Sale{" +
				"id=" + id +
				", empId=" + empId +
				", time='" + time + '\'' +
				", payment=" + payment +
				", change=" + change +
				", type=" + type +
				", status=" + status +
				'}';
	}
}
