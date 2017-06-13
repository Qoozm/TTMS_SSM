package se.ttms.model;


public class Studio {
	/* add field
	 * studio_flag   smallint comment    '取值含义：
           
           0：座位损坏不能用
           1：座位可用；
           -1: 未生成
	 */
	private int id;
	private String name="" ;
	private int rowCount=0;
	private int colCount=0;
	private String introduction="";
	private int studioFlag;
	
	public static final int NOTHING = 0;
	public static final int EXIST = 1;
	public static final int DAMAGE = -1;
	
	public int getStudioFlag() {
		return studioFlag;
	}

	public void setStudioFlag(int studioFlag) {
		this.studioFlag = studioFlag;
	}

	public void setID(int id){
		this.id=id;
	}
	
	public int getID(){
		return id;
	}
	
	public void setName(String name){
		this.name=name;
	}
	
	public String getName(){
		return name;
	}
	
	public void setRowCount(int count){
		this.rowCount=count;
	}
	
	public int getRowCount(){
		return rowCount;
	}
	public void setColCount(int count){
		this.colCount=count;
	}
	
	public int getColCount(){
		return colCount;
	}
	
	public void setIntroduction(String intro){
		this.introduction=intro;
	}
	
	public String getIntroduction(){
		return introduction;
	}

	@Override
	public String toString() {
		return "Studio{" +
				"id=" + id +
				", name='" + name + '\'' +
				", rowCount=" + rowCount +
				", colCount=" + colCount +
				", introduction='" + introduction + '\'' +
				", studioFlag=" + studioFlag +
				'}';
	}
}
