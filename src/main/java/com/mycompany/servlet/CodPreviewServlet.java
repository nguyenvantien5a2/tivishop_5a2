package com.mycompany.servlet;

import com.mycompany.model.PendingOrder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/cod-preview")
public class CodPreviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        PendingOrder pendingOrder = (PendingOrder) session.getAttribute("pendingOrder");
        if (pendingOrder == null) {
            resp.sendRedirect("checkout");
            return;
        }
        req.setAttribute("pendingOrder", pendingOrder);
        req.getRequestDispatcher("/cod-preview.jsp").forward(req, resp);
    }
}