package com.bdp2.camp.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bdp2.camp.model.Quartas;

@Repository
public class QuartasDAO implements IQuartasDAO {

		@Autowired
		GenericDAO gDao;

		@Override
		public List<Quartas> times() throws SQLException, ClassNotFoundException {
			List<Quartas> quartas = new ArrayList<>();
			Connection c = gDao.getConnection();
			
			String sql = "SELECT timeA, timeB FROM dbo.fn_quartas()";
			
			PreparedStatement ps = c.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Quartas jogos = new Quartas();
				jogos.setTimeA(rs.getString("timeA"));
				jogos.setTimeB(rs.getString("timeB"));
				quartas.add(jogos);
			}
			
			rs.close();
			ps.close();
			c.close();
			
			return quartas;
		}
		
}
