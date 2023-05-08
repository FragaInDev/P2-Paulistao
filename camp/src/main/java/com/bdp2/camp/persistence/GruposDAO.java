package com.bdp2.camp.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bdp2.camp.model.Grupos;

@Repository
public class GruposDAO implements IGruposDAO<Grupos>{
	
	@Autowired
	GenericDAO gDao;

	@Override
	public List<Grupos> divideGrupos() throws SQLException, ClassNotFoundException {
		List<Grupos> grupos = new ArrayList<>();
		
		Connection c = gDao.getConnection();
		String timesExclusivos = "{CALL sp_divide_times_excluidos}";
		String timesRestantes = "{CALL sp_divide_times_em_grupos}";
		String sql = "SELECT t.nome_time, g.grupo\r\n"+
					 "FROM grupos g, times t\r\n"+
					 "WHERE t.cod_time = g.cod_time";
		try {
			CallableStatement c1 = c.prepareCall(timesExclusivos);
			c1.execute();
			
			CallableStatement c2 = c.prepareCall(timesRestantes);
			c2.execute();
			
			PreparedStatement ps = c.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Grupos grupo = new Grupos();
				grupo.setNome_time(rs.getString("nome_time"));
				grupo.setGrupo(rs.getString("grupo"));
				grupos.add(grupo);
			}
			
			rs.close();
			ps.close();
			c2.close();
			c1.close();
			
		} catch (Exception e) {
			PreparedStatement ps = c.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				Grupos grupo = new Grupos();
				grupo.setNome_time(rs.getString("nome_time"));
				grupo.setGrupo(rs.getString("grupo"));
				grupos.add(grupo);
			}
			
			rs.close();
			ps.close();
		}
		
		c.close();
		return grupos;
	}

	@Override
	public List<Grupos> mostraGrupo(String grupo) throws SQLException, ClassNotFoundException {
		List<Grupos> grupos = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = "SELECT t.nome_time, g.grupo\r\n"+
					 "FROM grupos g, times t\r\n"+
					 "WHERE t.cod_time = g.cod_time AND grupo = ?";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, grupo);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Grupos group = new Grupos();
			group.setNome_time(rs.getString("nome_time"));
			group.setGrupo(rs.getString("grupo"));
			grupos.add(group);
		}
		
		rs.close();
		ps.close();
		c.close();
		
		return grupos;
	}

	
}
