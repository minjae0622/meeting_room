package com.enuri.meeting;

import java.io.Serializable;

public class Room_Reservation_Data implements Serializable {
	private int idx = 0;
	private String userid = "";
	private int room_num = 0;
	private String s_date = "";
	private String e_date = "";
	private String info = "";
	private String reg_date = "";
	
	private String user_name = "";
	private String user_company = "";
	private String user_team = "";

	public Room_User_Data room_user_data = null;

	public Room_Reservation_Data() {
		room_user_data = new Room_User_Data();
	}

	public int getIdx() {
		return this.idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getUserid() {
		return this.userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getRoom_num() {
		return this.room_num;
	}
	public void setRoom_num(int room_num) {
		this.room_num = room_num;
	}

	public String getS_date() {
		return this.s_date;
	}
	public void setS_date(String s_date) {
		this.s_date = s_date;
	}

	public String getE_date() {
		return this.e_date;
	}
	public void setE_date(String e_date) {
		this.e_date = e_date;
	}

	public String getInfo() {
		return this.info;
	}
	public void setInfo(String info) {
		this.info = info;
	}

	public String getReg_date() {
		return this.reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	
	public String getUser_name() {
		return this.user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public String getUser_company() {
		return this.user_company;
	}
	public void setUser_company(String user_company) {
		this.user_company = user_company;
	}
	
	public String getUser_team() {
		return this.user_team;
	}
	public void setUser_team(String user_team) {
		this.user_team = user_team;
	}

}
