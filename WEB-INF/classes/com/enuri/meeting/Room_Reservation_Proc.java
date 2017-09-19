package com.enuri.meeting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.enuri.db.DBConnection;
import com.enuri.meeting.Room_Reservation_Data;

public class Room_Reservation_Proc {
	private DBConnection dbConn = null;

	public Room_Reservation_Proc() {
		dbConn = new DBConnection();
	}

	// 입력
	public boolean insertRoom_Reservation(Room_Reservation_Data room_reservation_data) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean insert_check = false;
		StringBuffer strQuery = new StringBuffer();

		try {
			strQuery.append("INSERT INTO room_reservation (userid, room_num, s_date, e_date, info) ");
			strQuery.append("VALUES (?, ?, ?, ?, ?) ");

			conn = dbConn.createConnection("MEETING_ROOM");

			if(room_reservation_data.getUserid().length()>0) {
				pstmt = conn.prepareStatement(strQuery.toString());

				pstmt.clearParameters();

				int num = 1;
				pstmt.setString(num++, room_reservation_data.getUserid());
				pstmt.setInt(num++, room_reservation_data.getRoom_num());
				pstmt.setString(num++, room_reservation_data.getS_date());
				pstmt.setString(num++, room_reservation_data.getE_date());
				pstmt.setString(num++, room_reservation_data.getInfo());

				pstmt.executeUpdate();
				pstmt.close();

				insert_check = true;
			}

		} catch(SQLException e) {
			insert_check = false;
			throw new Exception(e);
		} catch(Exception e) {
			insert_check = false;
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt);
			} catch(Exception e) {
				throw new Exception(e);
			}
		}
		return insert_check;
	}

	// 수정
	public boolean updateRoom_Reservation(Room_Reservation_Data room_reservation_data) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean update_check = false;
		StringBuffer strQuery = new StringBuffer();

		try {

			strQuery.append("UPDATE room_reservation SET userid=?, room_num=?, s_date=?, e_date=?, info=? ");
			strQuery.append("WHERE idx=? ");

			conn = dbConn.createConnection("MEETING_ROOM");

			if(room_reservation_data.getIdx()>0) {
				pstmt = conn.prepareStatement(strQuery.toString());

				pstmt.clearParameters();

				int num = 1;
				pstmt.setString(num++, room_reservation_data.getUserid());
				pstmt.setInt(num++, room_reservation_data.getRoom_num());
				pstmt.setString(num++, room_reservation_data.getS_date());
				pstmt.setString(num++, room_reservation_data.getE_date());
				pstmt.setString(num++, room_reservation_data.getInfo());
				pstmt.setInt(num++, room_reservation_data.getIdx());

				pstmt.executeUpdate();
				pstmt.close();

				update_check = true;
			}

		} catch(SQLException e) {
			update_check = false;
			throw new Exception(e);
		} catch(Exception e) {
			update_check = false;
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt);
			} catch(Exception e) {
				throw new Exception(e);
			}
		}
		return update_check;
	}

	// 삭제
	public boolean deleteRoom_Reservation(int idx) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean delete_check = false;
		StringBuffer strQuery = new StringBuffer();

		try {
			strQuery.append("DELETE FROM room_reservation WHERE idx=? ");

			conn = dbConn.createConnection("MEETING_ROOM");

			if(idx>0) {
				pstmt = conn.prepareStatement(strQuery.toString());

				pstmt.clearParameters();
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
				pstmt.close();

				delete_check = true;
			}

		} catch(SQLException e) {
			delete_check = false;
			throw new Exception(e);
		} catch(Exception e) {
			delete_check = false;
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt);
			} catch(Exception e) {
				throw new Exception(e);
			}
		}
		return delete_check;
	}

	// 모든 정보 1개만 읽어오기
	public Room_Reservation_Data getRoom_Reservation(int idx) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		ResultSet rs = null;
		StringBuffer strQuery = new StringBuffer();
		Room_Reservation_Data rtnValue = new Room_Reservation_Data();

		try {
			conn = dbConn.createConnection("MEETING_ROOM");

			strQuery.append("SELECT idx, userid, room_num, s_date, e_date, info, reg_date ");
			strQuery.append("FROM room_reservation ");
			strQuery.append("WHERE idx=? ");

			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			pstmt.setInt(1, idx);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				rtnValue.setIdx(rs.getInt("idx"));
				rtnValue.setUserid(rs.getString("userid"));
				rtnValue.setRoom_num(rs.getInt("room_num"));
				rtnValue.setS_date(rs.getString("s_date"));
				rtnValue.setE_date(rs.getString("e_date"));
				rtnValue.setInfo(rs.getString("info"));
				rtnValue.setReg_date(rs.getString("reg_date"));

			}
		} catch(SQLException e) {
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt, rs);
			} catch(Exception ex) {
				throw new Exception(ex);
			}
		}

		return rtnValue;
	}

	public Room_Reservation_Data[] getRoom_DayReservationList(String Type, String dateStr) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		ResultSet rs = null;
		StringBuffer strQuery = new StringBuffer();
		ArrayList<Room_Reservation_Data> returnList = new ArrayList<Room_Reservation_Data>();

		try {
			conn = dbConn.createConnection("MEETING_ROOM");

			strQuery.append("select rr.idx, rr.userid, rr.room_num, rr.s_date, rr.e_date, rr.info, rr.reg_date, ru.company, ru.team, ru.name ");
			strQuery.append("from room_reservation rr, room_user ru ");
			strQuery.append("WHERE rr.userid=ru.userid ");
			strQuery.append("and LEFT(s_date, 8) = ? AND room_num = ? ");
			strQuery.append("ORDER BY s_date ASC ");

			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			pstmt.setString(1, dateStr);
			pstmt.setString(2, Type);

			rs = pstmt.executeQuery();

			while(rs.next()) {
				Room_Reservation_Data data = new Room_Reservation_Data();

				data.setIdx(rs.getInt("idx"));
				data.setUserid(rs.getString("userid"));
				data.setRoom_num(rs.getInt("room_num"));
				data.setS_date(rs.getString("s_date"));
				data.setE_date(rs.getString("e_date"));
				data.setInfo(rs.getString("info"));
				data.setReg_date(rs.getString("reg_date"));
				data.setUser_company(rs.getString("company"));
				data.setUser_team(rs.getString("team"));
				data.setUser_name(rs.getString("name"));

				returnList.add(data);
			}
		} catch(SQLException e) {
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt, rs);
			} catch(Exception ex) {
				throw new Exception(ex);
			}
		}

		return (Room_Reservation_Data[])returnList.toArray(new Room_Reservation_Data[0]);
	}

	public Room_Reservation_Data[] getRoom_ReservationList() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		ResultSet rs = null;
		StringBuffer strQuery = new StringBuffer();
		ArrayList<Room_Reservation_Data> returnList = new ArrayList<Room_Reservation_Data>();

		try {
			conn = dbConn.createConnection("MEETING_ROOM");

			strQuery.append("select rr.idx, rr.userid, rr.room_num, rr.s_date, rr.e_date, rr.info, rr.reg_date, ru.company, ru.team, ru.name ");
			strQuery.append("from room_reservation rr, room_user ru ");
			strQuery.append("WHERE rr.userid=ru.userid ");
			strQuery.append("and LEFT(s_date, 8) = replace(LEFT(now(), 10),'-','') ");
			strQuery.append("ORDER BY room_num DESC, s_date ASC ");

			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			rs = pstmt.executeQuery();

			while(rs.next()) {
				Room_Reservation_Data data = new Room_Reservation_Data();

				data.setIdx(rs.getInt("idx"));
				data.setUserid(rs.getString("userid"));
				data.setRoom_num(rs.getInt("room_num"));
				data.setS_date(rs.getString("s_date"));
				data.setE_date(rs.getString("e_date"));
				data.setInfo(rs.getString("info"));
				data.setReg_date(rs.getString("reg_date"));
				data.setUser_company(rs.getString("company"));
				data.setUser_team(rs.getString("team"));
				data.setUser_name(rs.getString("name"));

				returnList.add(data);
			}
		} catch(SQLException e) {
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt, rs);
			} catch(Exception ex) {
				throw new Exception(ex);
			}
		}

		return (Room_Reservation_Data[])returnList.toArray(new Room_Reservation_Data[0]);
	}

	// 시간 중복 체크.
	public int getRoom_ReservationExist(int idx, String s_date, String e_date, int room_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		ResultSet rs = null;
		StringBuffer strQuery = new StringBuffer();

		try {
			conn = dbConn.createConnection("MEETING_ROOM");

			strQuery.append("SELECT count(*) cnt ");
			strQuery.append("FROM room_reservation ");
			//strQuery.append("WHERE  ((? BETWEEN s_date AND e_date) OR  (? BETWEEN s_date AND e_date) OR  (s_date BETWEEN ? AND ?) OR  (e_date BETWEEN ? AND ?)) and idx <> ? and room_num = ?");
			// strQuery.append("WHERE  ((? > s_date and ? < e_date ) OR  (? > s_date and ? < e_date) OR  (s_date > ? and s_date < ? ) OR  (e_date > ? and e_date < ?)) and idx <> ? and room_num = ?");
			strQuery.append("WHERE s_date < ? and e_date > ?  and idx <> ? and room_num = ?");


			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			pstmt.setString(1, e_date);
			pstmt.setString(2, s_date);
			pstmt.setInt(3, idx);
			pstmt.setInt(4, room_num);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				return rs.getInt("cnt");

			}
		} catch(SQLException e) {
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt, rs);
			} catch(Exception ex) {
				throw new Exception(ex);
			}
		}

		return 0;
	}

	public int getmaxidx()  throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;

		ResultSet rs = null;
		StringBuffer strQuery = new StringBuffer();

		try {
			conn = dbConn.createConnection("MEETING_ROOM");

			strQuery.append("SELECT max(idx) mx ");
			strQuery.append("FROM room_reservation ");

			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();
			rs = pstmt.executeQuery();

			if(rs.next()) {
				return rs.getInt("mx");

			}
		} catch(SQLException e) {
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt, rs);
			} catch(Exception ex) {
				throw new Exception(ex);
			}
		}

		return 0;
	}

}
