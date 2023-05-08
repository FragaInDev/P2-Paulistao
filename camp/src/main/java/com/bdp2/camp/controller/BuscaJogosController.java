package com.bdp2.camp.controller;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
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
public class BuscaJogosController {
	
	@Autowired
	JogosDAO jDao;
	
	@RequestMapping(name = "buscajogos", value = "/buscajogos", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("buscajogos");
	}
	
	@RequestMapping(name = "buscajogos", value = "/buscajogos", method = RequestMethod.POST)
	public ModelAndView buscajogos(ModelMap model, @RequestParam Map<String, String> allParam) {
		String botao = allParam.get("botao");
		List<Jogos> jogos = new ArrayList<>();
		String erro = "";
		String saida = "";
		
		try {
			LocalDate data = (LocalDate.parse(allParam.get("data")));
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy", Locale.US);
			String data_jogo = data.format(dtf);
			
			if(botao.equalsIgnoreCase("pesquisar")) {
				 jogos = jDao.buscarJogos(data_jogo);
			}
			
		} catch (SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("jogos", jogos);
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
		}
		return new ModelAndView("buscajogos");
	}
}
