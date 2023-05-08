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

import com.bdp2.camp.model.Quartas;
import com.bdp2.camp.persistence.QuartasDAO;

@Controller
public class QuartasController {

	@Autowired
	QuartasDAO qDao;
	
	@RequestMapping(name = "quartas", value = "/quartas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<Quartas> quartas = new ArrayList<>();
		
		String saida = "";
		String erro = "";
		try {
			quartas = qDao.times();
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("quartas", quartas);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			
		}
		return new ModelAndView("quartas");
	}
	
	@RequestMapping(name = "quartas", value = "/quartas", method = RequestMethod.POST)
	public ModelAndView quartas(ModelMap model, @RequestParam Map<String, String> allParam) {
		return new ModelAndView("quartas");
	}
}
