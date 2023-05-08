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

import com.bdp2.camp.model.Grupo_Jogos;
import com.bdp2.camp.persistence.Grupo_JogosDAO;

@Controller
public class GrupoJogosController {
	
	@Autowired
	Grupo_JogosDAO gDao;
	
	@RequestMapping(name = "grupojogos", value = "/grupojogos", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
	    return new ModelAndView("grupojogos");	
	}
	
	@RequestMapping(name = "grupojogoss", value = "/grupojogos", method = RequestMethod.POST)
	public ModelAndView grupojogos(ModelMap model, @RequestParam Map<String, String> allParam) {
		String btn = allParam.get("botao");
		List<Grupo_Jogos> grupoA = new ArrayList<>();
		List<Grupo_Jogos> grupoB = new ArrayList<>();
		List<Grupo_Jogos> grupoC = new ArrayList<>();
		List<Grupo_Jogos> grupoD = new ArrayList<>();
		
		String erro = "";
		String saida = "";
		
		try {
			if(btn.equalsIgnoreCase("exibir")) {
				grupoA = gDao.resultado("A");
				grupoB = gDao.resultado("B");
				grupoC = gDao.resultado("C");
				grupoD = gDao.resultado("D");
			}
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("grupoA", grupoA);
			model.addAttribute("grupoB", grupoB);
			model.addAttribute("grupoC", grupoC);
			model.addAttribute("grupoD", grupoD);
			model.addAttribute("saida", saida);
			model.addAttribute("erro", erro);
		}
		return new ModelAndView("grupojogos");
		
		}
}