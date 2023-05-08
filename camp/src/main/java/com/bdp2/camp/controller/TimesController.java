package com.bdp2.camp.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bdp2.camp.model.Times;
import com.bdp2.camp.persistence.TimesDAO;

@Controller
public class TimesController {
	
	@Autowired
	TimesDAO tDao;
	
	@RequestMapping(name = "times", value = "/times", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<Times> times = new ArrayList<>();
		String erro = "";
		String saida = "";
		
		try {
			times = tDao.list();
		}catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
			model.addAttribute("times", times);
		}
		return new ModelAndView("times");
	}
	
	@RequestMapping(name = "times", value = "/times", method = RequestMethod.POST)
	public ModelAndView times(ModelMap model, @RequestParam Map<String, String> allParam) {
	
		return new ModelAndView("times");
	}
}
