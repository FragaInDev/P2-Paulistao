package com.bdp2.camp.persistence;

import java.sql.SQLException;
import java.util.List;

import com.bdp2.camp.model.Grupo_Jogos;

public interface IGrupo_Jogos {
	public List<Grupo_Jogos> resultado(String grupo) throws SQLException, ClassNotFoundException;
}
