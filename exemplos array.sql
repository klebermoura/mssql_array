
--	PARA CRIAR UM ARRAY
	exec dbo.sp_create_array 'll_dia'
	
--	SETAR UM(NS) VALOR(ES) NO ARRAY
	exec dbo.sp_set_array 'll_dia', 1, 8
	exec dbo.sp_set_array 'll_dia', 2, 59898
	exec dbo.sp_set_array 'll_dia', 20, 'KLEBER MOURA'
	
--	OBTER UM VALOR DO ARRAY
	declare @resultado varchar(8000) 
	exec dbo.sp_get_array 'll_dia', 20, @resultado output
	select @resultado

	
--	PARA EXIBER O INDICE DE ARRAY PESQUISANDO PELO VALOR
	declare @resultado int 
	exec dbo.sp_search_array 'll_dia', 'kleber moura', @resultado output
	select @resultado
	
--	LISTAR TODOS OS ARRAY´S CRIADOS POR MIM
	exec dbo.sp_list_array 
	
--	LISTA TODOS OS INDECES E VALORES DE UM DETERMINADO ARRAY
	exec dbo.sp_list_array 'll_dia'	

--	DISPOSE - APAGA TODOS OS INDICES DO ARRAY
	exec dbo.sp_dispose_array 'll_dia'
	
--	PARA APAGAR UM ARRAY
	exec dbo.sp_drop_array 'll_dia'
	
--	PARA EXIBER O MAIOR INDICE (COM VALOR) DE ARRAY	
	exec dbo.sp_upperBound_array 'll_dia'
	
--	PARA EXIBER O MENOR INDICE (COM VALOR) DE ARRAY	
	exec dbo.sp_lowerBound_array 'll_dia'	
	
	