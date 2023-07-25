/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pe.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import pe.DTO.UserDTO;
import pe.utils.DBUtils;

/**
 *
 * @author meryc
 */
public class UserDAO {
    public UserDTO checkLogin(String userID, String password) throws SQLException{
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                String sql ="SELECT fullName, roleID "
                        +"FROM tblUsers "
                        +"WHERE userID = ? AND password = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if(rs.next()){
                    String fullname = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    user = new UserDTO(userID, password, fullname, roleID, true);
                }
            }
        } catch (Exception e) {
        }finally{
            if(conn != null) conn.close();
            if(stm != null) stm.close();
            if(rs != null) rs.close();
        }
        return user;
    }
    
    public List<UserDTO> getListUser(String search) throws SQLException{
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                String sql ="SELECT * "
                        +"FROM tblUsers "
                        +"WHERE fullName Like ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, "%" + search + "%");
                rs=stm.executeQuery();
                while(rs.next()){
                    String username = rs.getString("userID");
                    String password = rs.getString("password");
                    String fullname = rs.getString("fullName");
                    String roleID = rs.getString("roleID");
                    list.add(new UserDTO(username, password, fullname, roleID,true));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            if(conn !=null) conn.close();
            if(stm !=null) stm.close();
            if(rs != null) rs.close();
        }
        return list;
    }
    
    public boolean UpdateUser(UserDTO user) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                String sql = "UPDATE tblUsers "
                        +"SET fullName = ?, roleID = ? "
                        +"WHERE userID =?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, user.getFullname());
                stm.setString(2, user.getRoleID());
                stm.setString(3, user.getUserID());
                int value = stm.executeUpdate();
                check = value > 0 ? true : false;
            }
        } catch (Exception e) {
        }finally{
            if(conn != null) conn.close();
            if(stm != null) stm.close();
        }
        return check;
    }
}
