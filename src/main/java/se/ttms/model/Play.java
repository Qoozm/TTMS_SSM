package se.ttms.model;


public class Play {
	private int id;
	private int typeId;
	private int langId;
	
	private String name;
	private String introduction;
	private String image;
	private int length;
	private float ticketPrice;
	private int status;  // 0：待安排演出    1：已安排演出    -1：下线
	
	public static int WAITFOR = 0;
	public static int ALREADY = 1;
	public static int OFFLINE = -1;

	public Play(){}
	
	public Play(int id, int typeId, int langId, String name,
			String introduction, String image, int length, float ticketPrice,
			int status) {
		super();
		this.id = id;
		this.typeId = typeId;
		this.langId = langId;
		this.name = name;
		this.introduction = introduction;
		this.image = image;
		this.length = length;
		this.ticketPrice = ticketPrice;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTypeId() {
		return typeId;
	}

	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}

	public int getLangId() {
		return langId;
	}

	public void setLangId(int langId) {
		this.langId = langId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image_path) {
		this.image = image_path;
	}

	public int getLength() {
		return length;
	}

	public void setLength(int length) {
		this.length = length;
	}

	public float getTicketPrice() {
		return ticketPrice;
	}

	public void setTicketPrice(float ticketPrice) {
		this.ticketPrice = ticketPrice;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Play{" +
				"id=" + id +
				", typeId=" + typeId +
				", langId=" + langId +
				", name='" + name + '\'' +
				", introduction='" + introduction + '\'' +
				", image='" + image + '\'' +
				", length=" + length +
				", ticketPrice=" + ticketPrice +
				", status=" + status +
				'}';
	}
}
