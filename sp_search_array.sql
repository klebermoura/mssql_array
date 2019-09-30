create or alter procedure dbo.sp_search_array
	@nmArray	varchar(200),
	@valor		varchar(8000),
	@indice		int output
as
begin
	
	--exemplo: declare @result varchar(8000) exec dbo.sp_get_array 'teste', 1, @result output select @result
	
	declare @nmAux				varchar(100)
	declare @sql				varchar(max)

	declare @result				table (resultado int)
	
	if (@nmArray is null or @nmArray = '') or (@valor is null) 
		raiserror('parametros não informados.',16,1)
	
	set @nmAux		= convert(varchar,@@SPID)
	set @nmArray	= @nmArray +'_'+@nmAux
	
	set @sql = 'if exists (select * from tempdb.sys.objects where type = ''U'' and name = ''' + '##'+@nmArray + ''') select indice from ##' + @nmArray + ' where valor = ''' + @valor + ''' else raiserror(''Array não existe'',16,1)'
	
	insert into @result
	exec (@sql)
	
	select @indice = resultado from @result
	
	return
	
end
go

