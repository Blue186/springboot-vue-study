package com.wen.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSON;
import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.wen.common.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

@RestController
@RequestMapping("/files")
public class FileController {
    @Value("${server.port}")
    private String port;

    private static final String ip = "http://localhost";

    /**
     * 上传接口
     * @param file
     * @return
     */

    @PostMapping("/upload")
    public Result<?> upload(MultipartFile file){
        String originalFilename = file.getOriginalFilename();//获取源文件的名称
//        定义文件的唯一标识（前缀）
        String flag = IdUtil.fastSimpleUUID();

        String rootFilePath = System.getProperty("user.dir")+"/springboot/src/main/resources/files/"+flag+"_"+originalFilename;//获取文件上传的路径
        try {
            FileUtil.writeBytes(file.getBytes(),rootFilePath);//把文件写入该路径
        } catch (IOException e) {
            e.printStackTrace();
        }
        String url = ip+":"+port+"/files/"+flag;
        return Result.success(url);//返回结果url
    }

    /**
     * 下载接口
     * @param flag
     * @param response
     */
    @GetMapping("/{flag}")
    public void getFiles(@PathVariable String flag, HttpServletResponse response){
        OutputStream os;//新建一个输出对象
        String basePath = System.getProperty("user.dir")+"/springboot/src/main/resources/files/";//文件路径
        List<String> fileNames = FileUtil.listFileNames((basePath));//获取所有的文件名称
        String fileName = fileNames.stream().filter(name -> name.contains(flag)).findAny().orElse("");//找到根参数一致的文件

        try {
            if (StrUtil.isNotEmpty(fileName)){
                response.addHeader("Content-Disposition","attachment;filename="+ URLEncoder.encode(fileName,"UTF-8"));
                response.setContentType("application/octet-stream");
                byte[] bytes = FileUtil.readBytes(basePath + fileName);//通过文件路径读取文字节流
                os = response.getOutputStream();//通过输出流返回文件
                os.write(bytes);
                os.flush();
                os.close();
            }
        }catch (Exception e){
            System.out.println("文件下载失败");
        }
    }
    /**
     * 富文本上传接口
     * @param file
     * @return
     */

    @PostMapping("editor/upload")
    public JSON editorUpload(MultipartFile file){
        String originalFilename = file.getOriginalFilename();//获取源文件的名称
//        定义文件的唯一标识（前缀）
        String flag = IdUtil.fastSimpleUUID();

        String rootFilePath = System.getProperty("user.dir")+"/springboot/src/main/resources/files/"+flag+"_"+originalFilename;//获取文件上传的路径
        try {
            FileUtil.writeBytes(file.getBytes(),rootFilePath);//把文件写入该路径
        } catch (IOException e) {
            e.printStackTrace();
        }
        String url = ip+":"+port+"/files/"+flag;
        JSONObject jsonObject = new JSONObject();
        jsonObject.set("errno",0);
        JSONArray arr = new JSONArray();
        JSONObject data = new JSONObject();
        arr.add(data);
        data.set("url",url);
        jsonObject.set("data",arr);
        return jsonObject;//返回结果url
    }
}
