package com.bdp2.camp.persistence;

import java.sql.SQLException;
import java.util.List;

import com.bdp2.camp.model.Quartas;

public interface IQuartasDAO {
	public List<Quartas> times() throws SQLException, ClassNotFoundException;
}
