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

import com.bdp2.camp.model.Grupos;
import com.bdp2.camp.persistence.GruposDAO;

@Controller
public class GruposController {
	@Autowired
	GruposDAO gDao;
	
	@RequestMapping(name = "grupos", value = "/grupos", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("grupos");
	}
	
	@RequestMapping(name = "grupos", value = "/grupos", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, @RequestParam Map<String, String> allParam) {
		
		String botao = allParam.get("botao");
		
		List<Grupos> grupoA = new ArrayList<>();
		List<Grupos> grupoB = new ArrayList<>();
		List<Grupos> grupoC = new ArrayList<>();
		List<Grupos> grupoD = new ArrayList<>();
		
		String erro = "";
		String saida = "";
		
		try {
			if (botao.equalsIgnoreCase("gerar")) {
				gDao.divideGrupos();
				grupoA = gDao.mostraGrupo("A");
				grupoB = gDao.mostraGrupo("B");
				grupoC = gDao.mostraGrupo("C");
				grupoD = gDao.mostraGrupo("D");
			}
			
			
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		}finally {
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);     
			model.addAttribute("grupoA", grupoA);
			model.addAttribute("grupoB", grupoB); 
			model.addAttribute("grupoC", grupoC);
			model.addAttribute("grupoD", grupoD);
		}
		return new ModelAndView("grupos");
	}
}
