package com.enuri.meeting;

import java.io.Serializable;

public class Room_User_Data implements Serializable {
	private String userid = "";
	private String pass = "";
	private String company = "";
	private String team = "";
	private String name = "";
	private String reg_date = "";

	public Room_User_Data() {
	}

	public String getUserid() {
		return this.userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPass() {
		return this.pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getCompany() {
		return this.company;
	}
	public void setCompany(String company) {
		this.company = company;
	}

	public String getTeam() {
		return this.team;
	}
	public void setTeam(String team) {
		this.team = team;
	}

	public String getName() {
		return this.name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getReg_date() {
		return this.reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}


}