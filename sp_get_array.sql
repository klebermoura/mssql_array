create or alter procedure dbo.sp_get_array
	@nmArray	varchar(200),
	@indice		int,
	@valor		varchar(8000) output
as
begin
	
	--exemplo: declare @result varchar(8000) exec dbo.sp_get_array 'teste', 1, @result output select @result
	
	declare @nmAux				varchar(100)
	declare @sql				varchar(max)

	declare @result				table (resultado varchar(8000))
	
	if (@nmArray is null or @nmArray = '') or (@indice is null) 
		raiserror('parametros não informados.',16,1)
	
	set @nmAux		= convert(varchar,@@SPID)
	set @nmArray	= @nmArray +'_'+@nmAux
	
	set @sql = 'if exists (select * from tempdb.sys.objects where type = ''U'' and name = ''' + '##'+@nmArray + ''') select valor from ##' + @nmArray + ' where indice = ' + cast(@indice as varchar) + ' else raiserror(''Array não existe'',16,1)'
	
	insert into @result
	exec (@sql)
	
	select @valor = resultado from @result
	
	return
	
end
go

