package com.bdp2.camp.model;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Jogos {
    private String nome_timeA;
	private String nome_timeB;
	private int gols_timeA;
	private int gols_timeB;
	private LocalDate data_jogo;
}
