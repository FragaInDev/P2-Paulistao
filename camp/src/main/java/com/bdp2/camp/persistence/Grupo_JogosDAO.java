package com.bdp2.camp.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bdp2.camp.model.Grupo_Jogos;

@Repository
public class Grupo_JogosDAO implements IGrupo_Jogos{
	
	@Autowired
	GenericDAO gDao;
	
	@Override
	public List<Grupo_Jogos> resultado(String grupo) throws SQLException, ClassNotFoundException {
		List<Grupo_Jogos> gj = new ArrayList<>();
		Connection c = gDao.getConnection();
		
		String sql = "SELECT nome_time, num_jogos_disputados, vitoria, "+
					 "empates, derrotas, gols_marcados, "+
					 "gols_sofridos, saldo_gols, pontos\r\n"+
					 "FROM dbo.fn_table_grupo(?) ORDER BY pontos DESC, vitoria DESC, gols_marcados DESC, saldo_gols DESC";
		
		 PreparedStatement ps = c.prepareStatement(sql);
		 ps.setString(1, grupo);
		 ResultSet rs = ps.executeQuery();
		 while(rs.next()) {
		    	Grupo_Jogos res = new Grupo_Jogos();
		    	res.setNome_time(rs.getString("nome_time"));
		    	res.setNum_jogos_disputados(rs.getInt("num_jogos_disputados"));
		    	res.setVitorias(rs.getInt("vitoria"));
		    	res.setEmpates(rs.getInt("empates"));
		    	res.setDerrotas(rs.getInt("derrotas"));
		    	res.setGols_marcados(rs.getInt("gols_marcados"));
		    	res.setGols_sofridos(rs.getInt("gols_sofridos"));
		    	res.setSaldo_gols(rs.getInt("saldo_gols"));
		    	res.setPontos(rs.getInt("pontos"));
		    	gj.add(res);
		 }
		 ps.close();
		 rs.close();
		 c.close();
		
		 return gj;
	}
	
}
