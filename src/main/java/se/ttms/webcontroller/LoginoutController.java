package se.ttms.webcontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

/**
 * Created by colin on 2017/6/7.
 */
@Controller
public class LoginoutController {

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout (HttpSession session) {
        if (session.getAttribute("employee") != null)
            session.removeAttribute("employee");
            session.invalidate();
        return "redirect:/login";
    }
}
