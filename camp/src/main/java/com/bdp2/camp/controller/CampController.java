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

import com.bdp2.camp.model.Campeonato;
import com.bdp2.camp.persistence.CampeonatoDAO;

@Controller
public class CampController {

	@Autowired
	CampeonatoDAO cDao;
	
	@RequestMapping(name = "campeonato", value = "/campeonato", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<Campeonato> camp = new ArrayList<>();
		
		String saida = "";
		String erro = "";
		try {
			camp = cDao.resultado();
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("camp", camp);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			
		}
		return new ModelAndView("campeonato");
	}
	
	@RequestMapping(name = "campeonato", value = "/campeonato", method = RequestMethod.POST)
	public ModelAndView campeonato(ModelMap model, @RequestParam Map<String, String> allParam) {
		return new ModelAndView("campeonato");
	}
}
