package se.ttms.webcontroller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import se.ttms.model.DataDict;
import se.ttms.model.Play;
import se.ttms.service.mybatis.MbtDataDictService;
import se.ttms.service.mybatis.MbtPlayService;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Charley on 2017/6/5.
 */
@Controller
public class PlayController {

    @Autowired
    private MbtPlayService playSrv;

    @Autowired
    private MbtDataDictService datadictSrv;

    @Autowired
    private ServletContext context;

    @RequestMapping("/findPlayByPage")
    public ModelAndView findPlayByPage(int currentPage){

        PageHelper.startPage(currentPage, 5);
        ArrayList<Play> plays = (ArrayList<Play>) playSrv.FetchAll();
        PageInfo pageInfo = new PageInfo(plays);

        HashMap<Integer, DataDict> dictMap = new HashMap<Integer, DataDict>();
        List<DataDict> dataDicts = datadictSrv.FetchAll();
        for (int i = 0; i < dataDicts.size(); ++i) {

            dictMap.put(dataDicts.get(i).getId(), dataDicts.get(i));
        }

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("dictMap", dictMap);
        modelAndView.setViewName("views/admin/playList");
        modelAndView.addObject("plays", plays);
        modelAndView.addObject("pageInfo", pageInfo);

        return modelAndView;
    }

    @RequestMapping("/searchByPlayName")
    public ModelAndView searchByPlayName(String playName) {

        ArrayList<Play> plays = (ArrayList<Play>) playSrv.Fetch("play_name = " + "'" + playName.trim() + "'");
        PageInfo pageInfo = new PageInfo(plays);

        System.out.println(plays.size());
        HashMap<Integer, DataDict> dictMap = new HashMap<Integer, DataDict>();
        List<DataDict> dataDicts = datadictSrv.FetchAll();
        for (int i = 0; i < dataDicts.size(); ++i) {

            dictMap.put(dataDicts.get(i).getId(), dataDicts.get(i));
        }
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("plays", plays);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.addObject("dictMap", dictMap);
        modelAndView.setViewName("views/admin/playList");

        return modelAndView;
    }

    @RequestMapping(value = "/playModify", method = RequestMethod.POST)
    public ModelAndView playModify(Play play, @RequestParam(value = "playImage") MultipartFile playImage) throws IOException {

        String status;

        if (!playImage.isEmpty()) {

            String uploadPath =context.getRealPath("") + "static" + File.separator + "images" + File.separator
                    +playImage.getOriginalFilename();
            FileCopyUtils.copy(playImage.getBytes(), new File(uploadPath));
            play.setImage("static/images/" + playImage.getOriginalFilename());
        }

        if (playSrv.modify(play) != 0) {

            status = "修改影片：" + play.getName() + "成功";
        }
        else {
            status = "修改影片：" + play.getName() + "失败";
        }
        return findPlayByPage(1).addObject("tip", status);
    }

    @RequestMapping(value = "/playAdd", method = RequestMethod.POST)
    public ModelAndView playAdd(Play play, @RequestParam(value = "playImage") MultipartFile playImage) throws IOException {

        String status;

        if (!playImage.isEmpty()) {

            String uploadPath =context.getRealPath("") + "static" + File.separator + "images" + File.separator
                    +playImage.getOriginalFilename();
            FileCopyUtils.copy(playImage.getBytes(), new File(uploadPath));
            play.setImage("static/images/" + playImage.getOriginalFilename());
        }

        if (playSrv.add(play) != 0) {

            status = "添加影片：" + play.getName() + "成功";
        }
        else {
            status = "添加影片：" + play.getName() + "失败";
        }
        return findPlayByPage(1).addObject("tip", status);
    }

    @RequestMapping("/playDelete")
    public ModelAndView playDelete(int playId) {

        String status;

        if (playSrv.delete(playId) != 0) {

            status = "删除影片成功";
        }
        else {
            status = "删除影片失败";
        }
        return findPlayByPage(1).addObject("tip", status);
    }

    @RequestMapping("/playLang")
    public void playLang (HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.setCharacterEncoding("utf-8");

        ArrayList<DataDict> langDicts = (ArrayList<DataDict>) datadictSrv.Fetch("dict_parent_id = 3");
        JsonArray langArray = new JsonArray();
        JsonObject langJson;

        for (int i = 0; i < langDicts.size(); ++i) {
            langJson = new JsonObject();
            langJson.addProperty("langId", langDicts.get(i).getId());
            langJson.addProperty("langValue", langDicts.get(i).getValue());
            langArray.add(langJson);
        }

        PrintWriter writer = response.getWriter();
        writer.write(langArray.toString());
        writer.close();

    }

    @RequestMapping("/playType")
    public void playType(HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.setCharacterEncoding("utf-8");

        ArrayList<DataDict> typeDicts = (ArrayList<DataDict>) datadictSrv.Fetch("dict_parent_id = 2");
        JsonArray typeJsons = new JsonArray();
        JsonObject typeJson;

        for (int i = 0; i < typeDicts.size(); ++i) {

            typeJson = new JsonObject();
            typeJson.addProperty("typeId", typeDicts.get(i).getId());
            typeJson.addProperty("typeValue", typeDicts.get(i).getValue());
            typeJsons.add(typeJson);
        }

        PrintWriter writer = response.getWriter();
        writer.write(typeJsons.toString());
        writer.close();
    }
}
