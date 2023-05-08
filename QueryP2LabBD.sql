CREATE DATABASE campeonatoPaulista
GO
USE campeonatoPaulista
GO
CREATE TABLE times(
cod_time            INT           NOT NULL,
nome_time           VARCHAR(200)  NOT NULL,
cidade              VARCHAR(200)  NOT NULL,
estadio             VARCHAR(200)  NOT NULL,
material_esportivo  VARCHAR(200)  NOT NULL
PRIMARY KEY (cod_time)
)
GO
CREATE TABLE grupos(
cod_time      INT      NOT NULL,
grupo         CHAR(1)  NOT NULL,
PRIMARY KEY (grupo, cod_time),
FOREIGN KEY (cod_time) REFERENCES times (cod_time)
)
GO
CREATE TABLE jogos(
cod_rodada     INT       NOT NULL,
cod_timeA      INT       NOT NULL,
cod_timeB      INT       NOT NULL,
gols_timeA     INT       NULL,
gols_timeB     INT       NULL,
data_jogo      DATETIME  NOT NULL,
PRIMARY KEY (cod_timeA, cod_timeB, data_jogo)
)
GO
INSERT INTO times VALUES 
(1,'Água Santa', 'Diadema', 'Distrital do Inamar', 'Karilu'),
(2, 'Botafogo-SP', 'Ribeirão Preto', 'Santa Cruz', 'Volt Sport'),
(3, 'Corinthians', 'São Paulo', 'Neo Química Arena', 'Nike'),
(4, 'Ferroviária', 'Araraquara', 'Fonte Luminosa', 'Lupo'),
(5, 'Guarani', 'Campinas', 'Brinco de Ouro', 'Kappa'),
(6, 'Inter de Limeira', 'Limeira', 'Limeirão', 'Alluri Sports'),
(7, 'Ituano', 'Itu', 'Novelli Júnior', 'Kanxa'),
(8, 'Mirassol', 'Mirassol', 'José Maria de Campos Maia', 'Super Bolla'),
(9, 'Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biase', 'Physicus'),
(10, 'Palmeiras', 'São Paulo', 'Allianz Parque', 'Puma'),
(11, 'Ponte Preta', 'Campinas', 'Moisé Lucarelli', '1900'),
(12, 'Red Bull Bragantino', 'Bragança Paulista', 'Nabi Abi Chedid', 'Nike'),
(13, 'Santo André', 'Santo André', 'Bruno José Daniel', 'Icone Sports'),
(14, 'Santos', 'Santos', 'Vila Belmiro', 'Umbro'),
(15, 'São Bernardo', 'São Bernardo do Campo', 'Primeiro de Maio', 'Magnum Group'),
(16, 'São Paulo', 'São Paulo', 'Morumbi', 'Adidas')

CREATE PROCEDURE sp_divide_times_excluidos
AS
    DECLARE @grupo          CHAR(1),
            @grupos VARCHAR(4),
            @time_exclui    INT

    DECLARE @times_excluidos TABLE (cod_time int)
    INSERT INTO @times_excluidos SELECT cod_time FROM times WHERE nome_time IN ('Corinthians', 'Palmeiras', 'Santos', 'São Paulo')

	DELETE FROM grupos

	SET @grupos = 'ABCD'
    WHILE (SELECT COUNT(*) FROM @times_excluidos) > 0
    BEGIN
		SET @time_exclui = (SELECT TOP 1 cod_time FROM @times_excluidos ORDER BY RAND() * (SELECT COUNT(*) FROM @times_excluidos))
		SET @grupo = SUBSTRING(@grupos, CAST(RAND() * LEN(@grupos) + 1 AS INT), 1)
        INSERT INTO grupos VALUES (@time_exclui, @grupo)
		DELETE FROM @times_excluidos WHERE cod_time = @time_exclui
		SET @grupos = REPLACE(@grupos, @grupo, '')
	END


CREATE PROCEDURE sp_divide_times_em_grupos
AS
BEGIN
  DECLARE @grupoA TABLE (cod_time int, grupo VARCHAR(1))
  DECLARE @grupoB TABLE (cod_time int, grupo VARCHAR(1))
  DECLARE @grupoC TABLE (cod_time int, grupo VARCHAR(1))
  DECLARE @grupoD TABLE (cod_time int, grupo VARCHAR(1))

  -- Adiciona todos os times em uma tabela temporária para facilitar a divisão
  DECLARE @todosOsTimes TABLE (cod_time int)
  INSERT INTO @todosOsTimes (cod_time)
  SELECT cod_time FROM times

  -- Garante que os quatro times não estejam no mesmo grupo
  DECLARE @times_excluidos TABLE (cod_time int)
  INSERT INTO @times_excluidos SELECT cod_time FROM times WHERE nome_time IN ('Corinthians', 'Palmeiras', 'Santos', 'São Paulo')
	

  -- Distribui os times aleatoriamente nos quatro grupos
  WHILE (SELECT COUNT(*) FROM @todosOsTimes) > 0
  BEGIN
    DECLARE @codigoTime int
    SELECT TOP 1 @codigoTime = cod_time FROM @todosOsTimes ORDER BY NEWID()

    -- Verifica em que grupo o time deve ser inserido
    IF (SELECT COUNT(*) FROM @grupoA) < 3 AND @codigoTime NOT IN(SELECT cod_time FROM @times_excluidos)
    BEGIN
      INSERT INTO @grupoA(cod_time, grupo) VALUES (@codigoTime, 'A')
    END
    ELSE IF (SELECT COUNT(*) FROM @grupoB) < 3 AND @codigoTime NOT IN(SELECT cod_time FROM @times_excluidos)
    BEGIN
      INSERT INTO @grupoB (cod_time, grupo) VALUES (@codigoTime, 'B')
    END
    ELSE IF (SELECT COUNT(*) FROM @grupoC) < 3 AND @codigoTime NOT IN(SELECT cod_time FROM @times_excluidos)
    BEGIN
      INSERT INTO @grupoC (cod_time, grupo) VALUES (@codigoTime, 'C')
    END
    ELSE IF (SELECT COUNT(*) FROM @grupoD) < 3 AND @codigoTime NOT IN(SELECT cod_time FROM @times_excluidos)
    BEGIN
      INSERT INTO @grupoD (cod_time, grupo) VALUES (@codigoTime, 'D')
    END

	-- Remove o time da tabela temporária
    DELETE FROM @todosOsTimes WHERE cod_time = @codigoTime
    END

  -- Insere os times nos grupos definitivos
	INSERT INTO grupos SELECT cod_time, grupo FROM @grupoA
	INSERT INTO grupos SELECT cod_time, grupo FROM @grupoB
	INSERT INTO grupos SELECT cod_time, grupo FROM @grupoC
	INSERT INTO grupos SELECT cod_time, grupo FROM @grupoD
END





CREATE PROCEDURE sp_gerar_rodadas
AS
	DECLARE @times_rodada TABLE (cod_time INT, grupo CHAR(1))
	DECLARE	@rodada TABLE (num_rodada INT, timeA INT, timeB INT, golsA INT, golsB INT, data_rodada DATE)
	DECLARE	@numRodadas INT = 1,
			@numJogos INT = 1,
			@timeA INT,
			@timeB INT,
			@dataRodada DATE = '2022-01-23',
			@diaSemana VARCHAR(10) = 'domingo'
	
	DELETE FROM jogos
	
	INSERT INTO @times_rodada SELECT cod_time, grupo FROM grupos
	
	WHILE @numRodadas <= 12
	BEGIN
		DELETE FROM @rodada
		SET @numJogos = 1

		WHILE @numJogos <= 8
		BEGIN
			 -- seleciona um time aleatório
                 -- Sorteia o time A
            SELECT TOP 1 @timeA = cod_time
            FROM @times_rodada
            WHERE grupo NOT IN (SELECT grupo FROM @times_rodada WHERE cod_time = @timeB)
            ORDER BY NEWID()

            -- Sorteia o time B
            SELECT TOP 1 @timeB = cod_time
            FROM @times_rodada
            WHERE grupo NOT IN (SELECT grupo FROM @times_rodada WHERE cod_time = @timeA)
            ORDER BY NEWID()

			-- verifica se o time já jogou contra o outro time selecionado
			IF NOT EXISTS(SELECT * FROM @rodada WHERE ((timeA = @timeA AND timeB = @timeB) OR (timeA = @timeB AND timeB = @timeA)) AND data_rodada = @dataRodada)
			BEGIN
				INSERT INTO @rodada VALUES(@numRodadas, @timeA, @timeB, CAST(ROUND(RAND() * 7 + 1, 0) AS INT), CAST(ROUND(RAND() * 9 + 1, 0) AS INT), @dataRodada)
				DELETE FROM @times_rodada WHERE cod_time = @timeA
				DELETE FROM @times_rodada WHERE cod_time = @timeB
			END

			SET @numJogos = @numJogos + 1
		END
		
		INSERT INTO jogos SELECT * FROM @rodada
		INSERT INTO @times_rodada SELECT cod_time, grupo FROM grupos 
		
		SET @numRodadas = @numRodadas + 1

			-- Atualiza a data para a próxima rodada
        IF @diaSemana = 'domingo'
        BEGIN
            SET @diaSemana = 'quarta'
            SET @dataRodada = DATEADD(day, 3, @dataRodada)
        END
        ELSE
        BEGIN
            SET @diaSemana = 'domingo'
            SET @dataRodada = DATEADD(day, 4, @dataRodada)
        END

	END


--EXECS
GO
exec sp_divide_times_excluidos
GO
exec sp_divide_times_em_grupos
GO
EXEC sp_gerar_rodadas

--SELECTS
SELECT * FROM times
SELECT * FROM grupos
SELECT * FROM jogos ORDER BY data_jogo
SELECT ta.nome_time AS timeA, tb.nome_time AS timeB,
	   j.gols_timeA, j.gols_timeB, j.data_jogo 
	   FROM jogos j, times ta, times tb
       WHERE j.cod_timeA = ta.cod_time
	   AND j.cod_timeB = tb.cod_time
	   ORDER BY data_jogo



CREATE PROCEDURE sp_pesquisa_jogos (@data_jogo DATE)
AS
BEGIN
    IF (@data_jogo IS NOT NULL)
    BEGIN
        IF EXISTS(SELECT 1 FROM jogos WHERE data_jogo = @data_jogo)
        BEGIN
            SELECT ta.nome_time AS timeA, tb.nome_time AS timeB,
			j.gols_timeA, j.gols_timeB, j.data_jogo 
			FROM jogos j, times ta, times tb
			WHERE data_jogo = @data_jogo
			AND j.cod_timeA = ta.cod_time
			AND j.cod_timeB = tb.cod_time
			ORDER BY data_jogo
        END
        ELSE
        BEGIN
            RAISERROR('Não há jogos na data selecionada', 16, 1)
        END
    END
    ELSE
    BEGIN
        RAISERROR('Data inválida', 16, 1)
    END
END

EXEC sp_pesquisa_jogos '2022-01-23'


--Trigger para impedir insert, update e delete na tabela times
CREATE TRIGGER t_insert_updt_del_times ON times
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
	SELECT * FROM times
	RAISERROR('Não é permitido fazer alterações em times', 16, 1)
END
 
DELETE times 
WHERE cod_time = 2
--------------------------------------------------------------------------------------------------------
--Trigger para impedir insert, update e delete na tabela grupos
CREATE TRIGGER t_insert_updt_del_grupos ON grupos
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
	SELECT * FROM grupos
	RAISERROR('Não é permitido fazer alterações em grupos', 16, 1)
END
--------------------------------------------------------------------------------------------------------
--Trigger para impedir insert e delete na tabela jogos
CREATE TRIGGER t_ins_del_jogos ON jogos
INSTEAD OF INSERT, DELETE
AS
BEGIN
	SELECT * FROM jogos
	RAISERROR('Não é permitido adicionar ou excluir jogos', 16, 1)
END



-- Função para validar o grupo, e mostrar a pontuação e os outros parâmetros
CREATE FUNCTION fn_table_grupo(@grupo Char(1))
RETURNS @tabela TABLE (
nome_time				VARCHAR(250),
num_jogos_disputados  INT,
vitoria               INT,
derrotas              INT,
empates               INT,
gols_marcados         INT,
gols_sofridos         INT,
saldo_gols            INT,
pontos                INT
)
AS
BEGIN
	DECLARE @nome_time				VARCHAR(250),
			@num_jogos_disputados  INT = 0,
			@vitoria               INT = 0,
			@derrotas              INT = 0,
			@empates               INT = 0,
			@gols_marcados         INT = 0,
			@gols_sofridos         INT = 0,
			@saldo_gols            INT = 0,
			@pontos                INT = 0,
			@cod_timeA             INT,
			@cod_timeB             INT,
			@cod				INT,
			@gols_timeA            INT,
			@gols_timeB            INT

	DECLARE cTime CURSOR FOR SELECT cod_time FROM grupos WHERE grupo = @grupo
	OPEN cTime
	FETCH NEXT FROM cTime INTO @cod
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @nome_time = t.nome_time
        FROM times t
        WHERE t.cod_time = @cod

		DECLARE cJogos CURSOR FOR SELECT cod_timeA, cod_timeB, gols_timeA, gols_timeB FROM jogos
		OPEN cJogos
		FETCH NEXT FROM cJogos INTO @cod_timeA, @cod_timeB, @gols_timeA, @gols_TimeB
		--SET @num_jogos_disputados = 0
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@cod_timeA = @cod OR @cod_timeB = @cod)
			BEGIN
				SET @num_jogos_disputados = @num_jogos_disputados + 1
					IF ((@cod_timeA = @cod AND @gols_timeA > @gols_timeB) OR (@cod_timeB = @cod AND @gols_timeA < @gols_timeB))
					BEGIN
						SET @vitoria = @vitoria + 1
					END
					ELSE
					BEGIN
						IF (@cod_timeA = @cod AND @gols_timeA < @gols_timeB OR @cod_timeB = @cod AND @gols_timeA > @gols_timeB)
						BEGIN
							SET @derrotas = @derrotas + 1
						END
						ELSE 
						BEGIN
							SET @empates = @empates + 1
						END
					END
					IF (@cod_timeA = @cod)
					BEGIN
						SET @gols_marcados = @gols_marcados + @gols_timeA
						SET @gols_sofridos = @gols_sofridos + @gols_timeB
					END
					ELSE
					BEGIN
						SET @gols_marcados = @gols_marcados + @gols_timeB
						SET @gols_sofridos = @gols_sofridos + @gols_timeA
					END
			END

			FETCH NEXT FROM cJogos INTO @cod_timeA, @cod_timeB, @gols_timeA, @gols_TimeB
		END
		SET @saldo_gols = @gols_marcados - @gols_sofridos
		SET @pontos = (@vitoria * 3) + @empates
		INSERT INTO @tabela VALUES (@nome_time, @num_jogos_disputados, @vitoria, @derrotas, @empates, @gols_marcados, @gols_sofridos, @saldo_gols, @pontos)
		CLOSE cJogos
		DEALLOCATE cJogos

		SET @num_jogos_disputados = 0
		SET	@vitoria = 0
		SET	@derrotas = 0
		SET	@empates = 0
		SET	@gols_marcados = 0
		SET	@gols_sofridos = 0
		SET	@saldo_gols = 0
		SET	@pontos = 0
		FETCH NEXT FROM cTime INTO @cod
	END
	CLOSE cTime
	DEALLOCATE cTime
	RETURN
END

--Teste da function
SELECT * FROM dbo.fn_table_grupo('A') ORDER BY pontos DESC, vitoria DESC, gols_marcados DESC, saldo_gols DESC
SELECT t.nome_time
FROM times t, grupos g 
WHERE t.cod_time = g.cod_time AND g.grupo = 'A'

-- Function para apresentar a tabela geral do campeonato
CREATE FUNCTION fn_table_campeonato()
RETURNS @tabela TABLE (
nome_time				VARCHAR(250),
num_jogos_disputados  INT,
vitoria               INT,
derrotas              INT,
empates               INT,
gols_marcados         INT,
gols_sofridos         INT,
saldo_gols            INT,
pontos                INT
)
AS
BEGIN
	DECLARE @nome_time				VARCHAR(250),
			@num_jogos_disputados  INT = 0,
			@vitoria               INT = 0,
			@derrotas              INT = 0,
			@empates               INT = 0,
			@gols_marcados         INT = 0,
			@gols_sofridos         INT = 0,
			@saldo_gols            INT = 0,
			@pontos                INT = 0,
			@cod_timeA             INT,
			@cod_timeB             INT,
			@cod				INT,
			@gols_timeA            INT,
			@gols_timeB            INT

	DECLARE cTime CURSOR FOR SELECT cod_time FROM grupos
	OPEN cTime
	FETCH NEXT FROM cTime INTO @cod
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @nome_time = t.nome_time
        FROM times t
        WHERE t.cod_time = @cod

		DECLARE cJogos CURSOR FOR SELECT cod_timeA, cod_timeB, gols_timeA, gols_timeB FROM jogos
		OPEN cJogos
		FETCH NEXT FROM cJogos INTO @cod_timeA, @cod_timeB, @gols_timeA, @gols_TimeB

		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF (@cod_timeA = @cod OR @cod_timeB = @cod)
			BEGIN
				SET @num_jogos_disputados = @num_jogos_disputados + 1
					IF ((@cod_timeA = @cod AND @gols_timeA > @gols_timeB) OR (@cod_timeB = @cod AND @gols_timeA < @gols_timeB))
					BEGIN
						SET @vitoria = @vitoria + 1
					END
					ELSE
					BEGIN
						IF (@cod_timeA = @cod AND @gols_timeA < @gols_timeB OR @cod_timeB = @cod AND @gols_timeA > @gols_timeB)
						BEGIN
							SET @derrotas = @derrotas + 1
						END
						ELSE 
						BEGIN
							SET @empates = @empates + 1
						END
					END
					IF (@cod_timeA = @cod)
					BEGIN
						SET @gols_marcados = @gols_marcados + @gols_timeA
						SET @gols_sofridos = @gols_sofridos + @gols_timeB
					END
					ELSE
					BEGIN
						SET @gols_marcados = @gols_marcados + @gols_timeB
						SET @gols_sofridos = @gols_sofridos + @gols_timeA
					END
			END

			FETCH NEXT FROM cJogos INTO @cod_timeA, @cod_timeB, @gols_timeA, @gols_TimeB
		END
		SET @saldo_gols = @gols_marcados - @gols_sofridos
		SET @pontos = (@vitoria * 3) + @empates
		INSERT INTO @tabela VALUES (@nome_time, @num_jogos_disputados, @vitoria, @derrotas, @empates, @gols_marcados, @gols_sofridos, @saldo_gols, @pontos)
		CLOSE cJogos
		DEALLOCATE cJogos

		SET @num_jogos_disputados = 0
		SET	@vitoria = 0
		SET	@derrotas = 0
		SET	@empates = 0
		SET	@gols_marcados = 0
		SET	@gols_sofridos = 0
		SET	@saldo_gols = 0
		SET	@pontos = 0
		FETCH NEXT FROM cTime INTO @cod
	END
	CLOSE cTime
	DEALLOCATE cTime
	RETURN
END

-- Mostra a tabela em ordem dos critérios
SELECT * FROM dbo.fn_table_campeonato() ORDER BY pontos DESC, vitoria DESC, gols_marcados DESC, saldo_gols DESC
SELECT * FROM dbo.fn_table_grupo('A') ORDER BY pontos DESC

-- Function que gera as quartas de finais
CREATE FUNCTION fn_quartas()
RETURNS @quartas TABLE (
timeA VARCHAR(250),
timeB VARCHAR(250),
data_rodada DATE
)
AS
BEGIN
	DECLARE @grupoA TABLE (nome_time VARCHAR(250))
	DECLARE @grupoB TABLE (nome_time VARCHAR(250))
	DECLARE @grupoC TABLE (nome_time VARCHAR(250))
	DECLARE @grupoD TABLE (nome_time VARCHAR(250))
	DECLARE	@numJogos INT = 1,
			@timeA VARCHAR(250),
			@timeB VARCHAR(250),
			@grupos VARCHAR(4),
			@grupo CHAR(1),
			@dataJogo DATE = '2022-01-23'

	INSERT INTO @grupoA SELECT TOP 2 nome_time FROM dbo.fn_table_grupo('A') ORDER BY pontos DESC
	INSERT INTO @grupoB SELECT TOP 2 nome_time FROM dbo.fn_table_grupo('B') ORDER BY pontos DESC
	INSERT INTO @grupoC SELECT TOP 2 nome_time FROM dbo.fn_table_grupo('C') ORDER BY pontos DESC
	INSERT INTO @grupoD SELECT TOP 2 nome_time FROM dbo.fn_table_grupo('D') ORDER BY pontos DESC

	-- INSERT GRUPO A
	SET @timeA = (SELECT TOP 1 nome_time FROM @grupoA)
	DELETE FROM @grupoA WHERE @timeA = nome_time
	SET @timeB = (SELECT nome_time FROM @grupoA)

	INSERT INTO @quartas VALUES (@timeA, @timeB, @dataJogo)

	-- INSERT GRUPO B
	SET @timeA = (SELECT TOP 1 nome_time FROM @grupoB)
	DELETE FROM @grupoB WHERE @timeA = nome_time
	SET @timeB = (SELECT nome_time FROM @grupoB)

	INSERT INTO @quartas VALUES (@timeA, @timeB, @dataJogo)

	-- INSERT GRUPO C
	SET @timeA = (SELECT TOP 1 nome_time FROM @grupoC)
	DELETE FROM @grupoC WHERE @timeA = nome_time
	SET @timeB = (SELECT nome_time FROM @grupoC)

	INSERT INTO @quartas VALUES (@timeA, @timeB, @dataJogo)

	-- INSERT GRUPO D
	SET @timeA = (SELECT TOP 1 nome_time FROM @grupoD)
	DELETE FROM @grupoD WHERE @timeA = nome_time
	SET @timeB = (SELECT nome_time FROM @grupoD)

	INSERT INTO @quartas VALUES (@timeA, @timeB, @dataJogo)
	RETURN
	
END

SELECT * FROM dbo.fn_quartas()


