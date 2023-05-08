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

import com.bdp2.camp.model.Jogos;
import com.bdp2.camp.persistence.JogosDAO;

@Controller
public class JogosController {
	
	@Autowired
	JogosDAO jDao;
	
	@RequestMapping(name = "jogos", value = "/jogos", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		List<Jogos> jogos = new ArrayList<>();
		String erro = "";
		String saida = "";
		
		try {
			jogos = jDao.listarJogos();
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("jogos", jogos);
		}
		return new ModelAndView("jogos");
	}
	
	@RequestMapping(name = "jogos", value = "/jogos", method = RequestMethod.POST)
	public ModelAndView jogos(ModelMap model, @RequestParam Map<String, String> allParam) {
		return new ModelAndView("jogos");
	}
}
