package se.ttms.filters;

import org.springframework.web.filter.OncePerRequestFilter;
import se.ttms.model.Employee;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by colin on 2017/6/7.
 */

public class AdminFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        Employee employee = (Employee) request.getSession().getAttribute("employee");

        String type = null;
        if (employee != null)
            type = String.valueOf(employee.getAccess());


        if (type != null) {
                if (type.equals("1")) {

                } else {
                    request.setAttribute("info", "权限不足");
                    request.getSession().removeAttribute("employee");
                    request.getRequestDispatcher("/login").forward(request, response);
                    return;
                }
        } else {
            request.setAttribute("info", "请登录后访问");
            request.getSession().removeAttribute("employee");
            request.getSession().invalidate();
            request.getRequestDispatcher("/login").forward(request, response);
            return;
        }

        filterChain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
