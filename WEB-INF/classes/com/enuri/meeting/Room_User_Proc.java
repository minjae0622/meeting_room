package com.enuri.meeting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.enuri.db.DBConnection;

public class Room_User_Proc {

	private DBConnection dbConn = null;

	public Room_User_Proc() {
		dbConn = new DBConnection(); 
	}

	// �ъ슜��李얘린
	public boolean find_userid(String userid) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer strQuery = new StringBuffer();
		boolean findFlag = false;

		try {
			conn = dbConn.createConnection("MEETING_ROOM");

			strQuery.append("SELECT userid FROM room_user WHERE userid=? ");

			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			pstmt.setString(1, userid);

			rs = pstmt.executeQuery();

			if(rs.next()) findFlag = true;

		} catch(SQLException e) {
			System.out.println("SQLException="+e.getMessage());
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt, rs);
			} catch(Exception e) {
				System.out.println("Exception="+e.getMessage());
				throw new Exception(e);
			}
		}

		return findFlag;
	}

    public Room_User_Data getUserInfo(String userid,String pass) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuffer strQuery = new StringBuffer();
        
        Room_User_Data room_user_data = null;
        
        try {
            conn = dbConn.createConnection("MEETING_ROOM");

            strQuery.append(" SELECT userid   ");
            strQuery.append("       ,company  ");
            strQuery.append("       ,team     ");
            strQuery.append("       ,name     ");
            strQuery.append("   FROM room_user WHERE userid=? ");
			if(!pass.equals("")){
				strQuery.append(" AND pass=? ");
			}

            pstmt = conn.prepareStatement(strQuery.toString());
            pstmt.clearParameters();

            pstmt.setString(1, userid);
			if(!pass.equals("")){
				pstmt.setString(2, pass);
			}

            rs = pstmt.executeQuery();

            if(rs.next()){
                room_user_data = new Room_User_Data();
                
                room_user_data.setUserid(rs.getString("userid"));
                room_user_data.setCompany(rs.getString("company"));
                room_user_data.setTeam(rs.getString("team"));
                room_user_data.setName(rs.getString("name"));
            }

        } catch(SQLException e) {
            System.out.println("SQLException="+e.getMessage());
            throw new Exception(e);
        } finally {
            try {
                dbConn.closeConnection(conn, pstmt, rs);
            } catch(Exception e) {
                System.out.println("Exception="+e.getMessage());
                throw new Exception(e);
            }
        }

        return room_user_data;
    }
    
	// �ъ슜���몄쬆
	public boolean find_userid(String userid, String pass) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer strQuery = new StringBuffer();
		boolean findFlag = false;

		try {
			conn = dbConn.createConnection("MEETING_ROOM");

			strQuery.append("SELECT count(*) AS cnt FROM room_user WHERE userid=? AND pass=? ");

			pstmt = conn.prepareStatement(strQuery.toString());
			pstmt.clearParameters();

			pstmt.setString(1, userid);
			pstmt.setString(2, pass);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				if(rs.getInt("cnt")>0) {
					findFlag = true;
				}
			}

		} catch(SQLException e) {
			System.out.println("SQLException="+e.getMessage());
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt, rs);
			} catch(Exception e) {
				System.out.println("Exception="+e.getMessage());
				throw new Exception(e);
			}
		}

		return findFlag;
	}

	// �ъ슜���낅젰
	public boolean insertRoom_user(Room_User_Data room_user_data) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean insert_check = false;
		StringBuffer strQuery = new StringBuffer();

		try {
			strQuery.append("INSERT INTO room_user (userid, pass, company, team, name) ");
			strQuery.append("VALUES (?, ?, ?, ?, ?) ");

			conn = dbConn.createConnection("MEETING_ROOM");

			if(room_user_data.getUserid().length()>0) {
				pstmt = conn.prepareStatement(strQuery.toString());

				pstmt.clearParameters();

				int num = 1;
				pstmt.setString(num++, room_user_data.getUserid());
				pstmt.setString(num++, room_user_data.getPass());
				pstmt.setString(num++, room_user_data.getCompany());
				pstmt.setString(num++, room_user_data.getTeam());
				pstmt.setString(num++, room_user_data.getName());

				pstmt.executeUpdate();
				pstmt.close();

				insert_check = true;
			}

		} catch(SQLException e) {
			insert_check = false;
			System.out.println("SQLException="+e.getMessage());
			throw new Exception(e);
		} catch(Exception e) {
			insert_check = false;
			System.out.println("Exception="+e.getMessage());
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt);
			} catch(Exception e) {
				System.out.println("Exception="+e.getMessage());
				throw new Exception(e);
			}
		}
		return insert_check;				
	}

	// �ъ슜���섏젙
	public boolean updateRoom_user(Room_User_Data room_user_data) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean update_check = false;
		StringBuffer strQuery = new StringBuffer();

		try {
			strQuery.append("UPDATE room_user SET pass=?, company=?, team=?, name=? ");
			strQuery.append("WHERE userid=? ");

			conn = dbConn.createConnection("MEETING_ROOM");

			if(room_user_data.getUserid().length()>0) {
				pstmt = conn.prepareStatement(strQuery.toString());

				pstmt.clearParameters();

				int num = 1;
				pstmt.setString(num++, room_user_data.getPass());
				pstmt.setString(num++, room_user_data.getCompany());
				pstmt.setString(num++, room_user_data.getTeam());
				pstmt.setString(num++, room_user_data.getName());
				pstmt.setString(num++, room_user_data.getUserid());

				pstmt.executeUpdate();
				pstmt.close();

				update_check = true;
			}

		} catch(SQLException e) {
			update_check = false;
			System.out.println("SQLException="+e.getMessage());
			throw new Exception(e);
		} catch(Exception e) {
			update_check = false;
			System.out.println("Exception="+e.getMessage());
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt);
			} catch(Exception e) {
				System.out.println("Exception="+e.getMessage());
				throw new Exception(e);
			}
		}
		return update_check;				
	}
	
	public boolean updateRoom_user2(Room_User_Data room_user_data) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean update_check = false;
		StringBuffer strQuery = new StringBuffer();

		try {
			strQuery.append("UPDATE room_user SET team=?, name=? ");
			strQuery.append("WHERE userid=? ");

			conn = dbConn.createConnection("MEETING_ROOM");

			if(room_user_data.getUserid().length()>0) {
				pstmt = conn.prepareStatement(strQuery.toString());

				pstmt.clearParameters();

				int num = 1;
				
				pstmt.setString(num++, room_user_data.getTeam());
				pstmt.setString(num++, room_user_data.getName());
				pstmt.setString(num++, room_user_data.getUserid());

				pstmt.executeUpdate();
				pstmt.close();

				update_check = true;
			}

		} catch(SQLException e) {
			update_check = false;
			System.out.println("SQLException="+e.getMessage());
			throw new Exception(e);
		} catch(Exception e) {
			update_check = false;
			System.out.println("Exception="+e.getMessage());
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt);
			} catch(Exception e) {
				System.out.println("Exception="+e.getMessage());
				throw new Exception(e);
			}
		}
		return update_check;				
	}

	// �ъ슜����젣
	public boolean deleteRoom_user(String userid) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean delete_check = false;
		StringBuffer strQuery = new StringBuffer();

		try {
			strQuery.append("DELETE room_user WHERE userid=? ");

			conn = dbConn.createConnection("MEETING_ROOM");

			if(userid.length()>0) {
				pstmt = conn.prepareStatement(strQuery.toString());

				pstmt.clearParameters();
				pstmt.setString(1, userid);
				pstmt.executeUpdate();
				pstmt.close();

				delete_check = true;
			}

		} catch(SQLException e) {
			delete_check = false;
			System.out.println("SQLException="+e.getMessage());
			throw new Exception(e);
		} catch(Exception e) {
			delete_check = false;
			System.out.println("Exception="+e.getMessage());
			throw new Exception(e);
		} finally {
			try {
				dbConn.closeConnection(conn, pstmt);
			} catch(Exception e) {
				System.out.println("Exception="+e.getMessage());
				throw new Exception(e);
			}
		}
		return delete_check;				
	}
}
