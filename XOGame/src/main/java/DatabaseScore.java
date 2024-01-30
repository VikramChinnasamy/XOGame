import java.sql.*;
public class DatabaseScore {
	String dbUrl="jdbc:mysql://localhost:3306/vkdb";
    String dbUname="root";
    String dbPassword="";
    String dbDriver="com.mysql.cj.jdbc.Driver";
    int score1,score2,losses1,losses2,draws1,draws2,total;
	  DatabaseScore(int total,int score1,int score2,int losses1,int losses2,int draws1,int draws2){
		  this.total=total;
		  this.score1=score1;    
		  this.score2=score2;
		  this.losses1=losses1;
		  this.losses2=losses2;
		  this.draws1=draws1;
		  this.draws2=draws2;
		  

	  }
      void storesco(){
    	  Connection con = null;
	   		try {
				Class.forName(dbDriver);  //class not found exception
				con = DriverManager.getConnection(dbUrl,dbUname,dbPassword);   //sql Exception
				String sql = "insert into matches (total,winX,winY,lossX,lossY,drawX,drawY)"
						+ "values('"+total+"','"+score1+"','"+score2+"','"+losses1+"','"+losses2+"','"+draws1+"','"+draws2+"')";			
				Statement s = con.createStatement();
				s.execute(sql);
			   
			   	con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
      }

}
