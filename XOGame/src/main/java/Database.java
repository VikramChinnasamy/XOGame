import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class Database {
		String dbUrl="jdbc:mysql://localhost:3306/vkdb";
	    String dbUname="root";
	    String dbPassword="";
	    String dbDriver="com.mysql.cj.jdbc.Driver";
	    String id,name,pass,email,number;
		  Database(String id,String name,String pass,String email,String number){
			  this.id=id;
			  this.name=name;    
			  this.pass=pass;
			  this.email=email;
			  this.number=number;
		  }
	 
      void store(){
    	  Connection con = null;
	   		try {
				Class.forName(dbDriver);  //class not found exception
				con = DriverManager.getConnection(dbUrl,dbUname,dbPassword);   //sql Exception
				String sql = "insert into student_table (id,name,password,email,phone)"
						+ "values('"+id+"','"+name+"','"+pass+"','"+email+"','"+number+"')";			
				Statement s = con.createStatement();
				s.execute(sql);
			   
			   	con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
      }
}
