package com.bdp2.camp.persistence;

import java.sql.SQLException;
import java.util.List;

public interface IGruposDAO<G> {
	public List<G> divideGrupos() throws SQLException, ClassNotFoundException;
	public List<G> mostraGrupo(String grupo) throws SQLException, ClassNotFoundException;
}
