import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MatchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MatchServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Scores and loss points are stored in database........ ");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Extract scores from the request
    	int total = Integer.parseInt(request.getParameter("totalMatches"));
    	int score1 = Integer.parseInt(request.getParameter("score1"));
        int score2 = Integer.parseInt(request.getParameter("score2"));
        int losses1 = Integer.parseInt(request.getParameter("losses1"));
        int losses2 = Integer.parseInt(request.getParameter("losses2"));
        int draws1 = Integer.parseInt(request.getParameter("draws1"));
        int draws2 = Integer.parseInt(request.getParameter("draws2"));
        

        // Create a DatabaseScore object and store scores
        DatabaseScore obj = new DatabaseScore(total,score1, score2,losses1,losses2,draws1,draws2);
        obj.storesco();

        // Forward to doGet method
        doGet(request, response);
    }
}
