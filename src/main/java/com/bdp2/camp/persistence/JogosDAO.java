package com.bdp2.camp.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bdp2.camp.model.Jogos;

@Repository
public class JogosDAO implements IJogosDAO<Jogos>{

	@Autowired
	GenericDAO gDao;
	
	@Override
	public List<Jogos> listarJogos() throws SQLException, ClassNotFoundException {
		List<Jogos> jogos = new ArrayList<>();
		
		Connection c = gDao.getConnection();
		
		String gerar = "{CALL sp_gerar_rodadas}";
		CallableStatement cs = c.prepareCall(gerar);
		cs.execute();
		
		String sql = "SELECT ta.nome_time AS TimeA, j.gols_timeA, tb.nome_time AS TimeB, j.gols_timeB, j.data_jogo\r\n"+
					 "FROM jogos j, times ta, times tb\r\n"+
					 "WHERE ta.cod_time = j.cod_timeA AND tb.cod_time = j.cod_timeB";
		
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			Jogos jogo = new Jogos();
			jogo.setNome_timeA(rs.getString("TimeA"));
			jogo.setGols_timeA(rs.getInt("gols_timeA"));
			jogo.setNome_timeB(rs.getString("TimeB"));
			jogo.setGols_timeB(rs.getInt("gols_timeB"));
			jogo.setData_jogo(LocalDate.parse(rs.getString("data_jogo")));
			
			jogos.add(jogo);
		}
		rs.close();
		ps.close();
		cs.close();
		c.close();
		return jogos;
	}

	@Override
	public List<Jogos> buscarJogos(String data_jogo) throws SQLException, ClassNotFoundException {
		List<Jogos> jogos = new ArrayList<>();
		
		Connection c = gDao.getConnection();
		
		String sql = "{CALL sp_pesquisa_jogos '?'}";
		
		try {
			
			CallableStatement cs = c.prepareCall(sql);
			cs.setString(1, data_jogo);
			ResultSet rs = cs.executeQuery();
			
			while(rs.next()) {
				Jogos jogo = new Jogos();
				jogo.setNome_timeA(rs.getString("TimeA"));
				jogo.setGols_timeA(rs.getInt("gols_timeA"));
				jogo.setNome_timeB(rs.getString("TimeB"));
				jogo.setGols_timeB(rs.getInt("gols_timeB"));
				jogo.setData_jogo(LocalDate.parse(rs.getString("data_jogo")));
				
				jogos.add(jogo);
			}
			
			rs.close();
			cs.close();
			c.close();
		} catch (Exception e) {
			CallableStatement cs = c.prepareCall(sql);
			ResultSet rs = cs.executeQuery();
			
			while(rs.next()) {
				Jogos jogo = new Jogos();
				jogo.setNome_timeA(rs.getString("TimeA"));
				jogo.setGols_timeA(rs.getInt("gols_timeA"));
				jogo.setNome_timeB(rs.getString("TimeB"));
				jogo.setGols_timeB(rs.getInt("gols_timeB"));
				jogo.setData_jogo(LocalDate.parse(rs.getString("data_jogo")));
				
				jogos.add(jogo);
			}
			
			rs.close();
			cs.close();
			c.close();
		}
		
		return jogos;
	}
	
}
