package com.bdp2.camp.persistence;

import java.sql.SQLException;
import java.util.List;

import com.bdp2.camp.model.Campeonato;

public interface ICampeonatoDAO {
	public List<Campeonato> resultado() throws SQLException, ClassNotFoundException;
}
