package com.stub.web.controller;

import com.common.dict.Constant2;
import com.common.util.SystemHWUtil;
import com.io.hw.file.util.FileUtils;
import com.io.hw.json.HWJacksonUtils;
import com.string.widget.util.ValueWidget;
import com.string.widget.util.XSSUtil;
import com.stub.bean.Address;
import com.stub.bean.Student;
import oa.bean.stub.ReadAndWriteResult;
import oa.util.HWUtils;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/***
 * stub test后台管理
 * @author huangweii
 * 2016年2月19日
 */
@Component
@RequestMapping("/stubEdit")
public class StubEditController {
    private static String getPrefix(String servletAction) {
        String prefix = null;
        if (servletAction.startsWith(Constant2.Slash)) {
            prefix = Constant2.stub_folder_no_Slash;
        } else {
            prefix = Constant2.stub_folder;
        }
        return prefix;
    }

	/***
	 * 仅仅进入页面
	 * @return
     */
	@RequestMapping("/searchInput")
	public String searchInput(){
		return "edit";
	}

	@RequestMapping("/search")
	public String search(HttpServletRequest request,Model model, @RequestParam(required = true)String servletAction,String charset,String tips){
		if(!ValueWidget.isNullOrEmpty(servletAction)){
			if(ValueWidget.isNullOrEmpty(charset)){
				charset=SystemHWUtil.CHARSET_UTF;
			}
            servletAction = XSSUtil.deleteXSS(servletAction);
			String prefix = getPrefix(servletAction);
			ReadAndWriteResult readAndWriteResult = HWUtils.stub(request, prefix +servletAction/*+ StubController.stub_file_Suffix*/, charset);
			if(readAndWriteResult.isResult()){
				model.addAttribute("content", readAndWriteResult.getContent());
                model.addAttribute("stubs", readAndWriteResult.getStubRange());
                model.addAttribute("url",readAndWriteResult.getUrl());
			}else{
				model.addAttribute(Constant2.RESPONSE_KEY_ERROR_MESSAGE, readAndWriteResult.getErrorMessage());
			}
			model.addAttribute("servletAction", servletAction);
			if(!ValueWidget.isNullOrEmpty(tips)){
				model.addAttribute("tips", tips);
			}
		}
        model.addAttribute("action","编辑");
		return "edit";
	}

	@RequestMapping("/add")
	public String add(HttpServletRequest request,Model model, String charset,String tips){
        model.addAttribute("action","新增");
		return "edit";
	}

	/***
	 * 编辑保存
	 * @param request
	 * @param model
	 * @param servletAction
	 * @param content
     * @return
     */
	@RequestMapping("/update")
	public String update(HttpServletRequest request, Model model, @RequestParam(required = true)String servletAction, @RequestParam(required = true)String content){
		if(!ValueWidget.isNullOrEmpty(servletAction)){
			servletAction = XSSUtil.deleteXSS(servletAction);
			ReadAndWriteResult readAndWriteResult = updateStub(request, servletAction, content);
			if (!afterDeal(model, servletAction, content, readAndWriteResult)) return "edit";
		}
		return Constant2.SPRINGMVC_REDIRECT_PREFIX+"stubEdit/search?servletAction="+servletAction;//TODO 重复代码
	}
	@RequestMapping(value="/updateJson", produces = SystemHWUtil.RESPONSE_CONTENTTYPE_JSON_UTF)
	@ResponseBody
    public String updateJson(HttpServletRequest request, Model model, @RequestParam(required = true) String servletAction, @RequestParam(required = true) String content
            , Integer index) {
        if(!ValueWidget.isNullOrEmpty(servletAction)){
            servletAction = XSSUtil.deleteXSS(servletAction);
			ReadAndWriteResult readAndWriteResult = updateStub(request, servletAction, content);
			return HWJacksonUtils.getJsonP(readAndWriteResult);
		}
		return Constant2.RESPONSE_WRONG_RESULT;
	}

	@RequestMapping(value="/saveJson", produces = SystemHWUtil.RESPONSE_CONTENTTYPE_JSON_UTF)
	@ResponseBody
	public String saveJson(HttpServletRequest request, Model model, @RequestParam(required = true)String servletAction, @RequestParam(required = true)String content){
		if(!ValueWidget.isNullOrEmpty(servletAction)){
            servletAction = XSSUtil.deleteXSS(servletAction);
			ReadAndWriteResult readAndWriteResult = saveStub(request, servletAction, content);
			return HWJacksonUtils.getJsonP(readAndWriteResult);
		}
		return Constant2.RESPONSE_WRONG_RESULT;
	}

	/***
	 * 新增保存
	 * @param request
	 * @param model
	 * @param servletAction
	 * @param content
     * @return
     */
	@RequestMapping("/save")
	public String save(HttpServletRequest request,Model model, @RequestParam(required = true)String servletAction,@RequestParam(required = true)String content){
		if(!ValueWidget.isNullOrEmpty(servletAction)){
			servletAction = XSSUtil.deleteXSS(servletAction);
			ReadAndWriteResult readAndWriteResult = saveStub(request, servletAction, content);
			if (!afterDeal(model, servletAction, content, readAndWriteResult)) return "edit";
		}
		return Constant2.SPRINGMVC_REDIRECT_PREFIX+"stubEdit/search?servletAction="+servletAction;
	}

	/***
	 * 更新stub 接口
	 * @param request
	 * @param servletAction
	 * @param content
     * @return
     */
	private ReadAndWriteResult updateStub(HttpServletRequest request, String servletAction, String content) {
		String prefix = getPrefix(servletAction);
        return HWUtils.updateStub(request, prefix + servletAction + Constant2.stub_file_Suffix, content, SystemHWUtil.CHARSET_UTF, 0);
    }
	private ReadAndWriteResult saveStub(HttpServletRequest request,  String servletAction, String content) {
		String prefix = getPrefix(servletAction);
        return HWUtils.saveStub(request, prefix + servletAction + Constant2.stub_file_Suffix, content, SystemHWUtil.CHARSET_UTF, 0);
    }

	/***
	 * 判断操作结果
	 * @param model
	 * @param servletAction
	 * @param content
	 * @param readAndWriteResult
     * @return
     */
	private boolean afterDeal(Model model, String servletAction, String content, ReadAndWriteResult readAndWriteResult) {
		if(readAndWriteResult.isResult()){
            model.addAttribute("tips", readAndWriteResult.getTips());
			model.addAttribute("url",readAndWriteResult.getUrl());
			return true;
        }else{
            model.addAttribute("content", content);
            model.addAttribute("servletAction", servletAction);
            model.addAttribute(Constant2.RESPONSE_KEY_ERROR_MESSAGE, readAndWriteResult.getErrorMessage());
			return false;
        }
	}

	@RequestMapping("/dispachInput")
	public String dispach(HttpServletRequest request,Model model,String targetUrl){
		if(!ValueWidget.isNullOrEmpty(targetUrl)){
			model.addAttribute("targetUrl",targetUrl);
		}
		return "dispach";
	}
	
	/***
	 * 用于测试pojo传递参数<br>
	 * http://127.0.0.1:80/stub_test/stubEdit/param?address.street=abc
	 * @param student
	 * @return
	 */
	@RequestMapping(value="/param", produces = SystemHWUtil.RESPONSE_CONTENTTYPE_JSON_UTF)
	@ResponseBody
	public String para(Student student){
		Address address=student.getAddress();
		System.out.println(address);
		return HWJacksonUtils.getJsonP(address);
	}
	@RequestMapping(value = "/test/body")
    @ResponseBody
    public String shareTest( Model model, HttpServletRequest request) throws IOException {
        String body= FileUtils.getFullContent4(request.getInputStream(),"UTF-8");
        System.out.println(body);
        return body;
    }
}
