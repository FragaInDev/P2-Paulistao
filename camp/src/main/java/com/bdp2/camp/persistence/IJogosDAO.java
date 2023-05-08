package com.bdp2.camp.persistence;

import java.sql.SQLException;
import java.util.List;

public interface IJogosDAO<Jogos> {
	public List<Jogos> listarJogos() throws SQLException, ClassNotFoundException;
	public List<Jogos> buscarJogos(String data_jogo) throws SQLException, ClassNotFoundException;
}
