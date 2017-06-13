package se.ttms.filters;

import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//@WebFilter(urlPatterns = "/*", initParams =
//        { @WebInitParam(name = "encoding", value = "UTF-8") })
public class CharsetAllEncodingFilter extends OncePerRequestFilter
{

    private String encoding = "UTF-8";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        ;
        if(request.getMethod().equalsIgnoreCase("POST"))
        {
            // post方式发送，直接设置字符集
            request.setCharacterEncoding(encoding);
        }

        filterChain.doFilter(request, response);

    }

    public void destroy()
    {

    }
}