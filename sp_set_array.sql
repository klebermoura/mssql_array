create or alter procedure dbo.sp_set_array
	@nmArray	varchar(200),
	@indice		int,
	@valor		varchar(8000)
with encryption	
as
begin
	
	-- exemplo: exec dbo.sp_set_array 'teste', 1, '300'
	
	declare @nmAux		varchar(100)
	declare @sql		varchar(2000)
	
	if (@nmArray is null or @nmArray = '') or (@indice is null) 
		raiserror('parametros não informados.',16,1)
	
	set @nmAux		= convert(varchar,@@SPID)
	set @nmArray	= @nmArray +'_'+@nmAux
	
	set @sql = 'if exists (select * from tempdb.sys.objects where type = ''U'' and name = ''' + '##'+@nmArray + ''') begin if exists (select ''x'' from ##' + @nmArray + ' where indice = ' + convert(varchar,@indice)+')  update ##'+@nmArray + ' set valor = ''' + isnull(@valor,'') + ''' where indice = ' + convert(varchar, @indice) + ' else insert into ##'+@nmArray + ' (indice, valor) values (' + convert(varchar,@indice) + ', ''' +isnull(@valor,'') + ''') end else raiserror(''Array não existe'',16,1) '
	exec (@sql)

end
go


