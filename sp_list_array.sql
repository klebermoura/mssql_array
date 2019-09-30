create or alter procedure dbo.sp_list_array
	@nmArray	varchar(200) = null
as
begin
	
	--exemplo: exec dbo.sp_list_array
	
	declare @nmAux				varchar(100)
	declare @sql				varchar(max)

	set @nmAux		= convert(varchar,@@SPID)
	set @nmArray	= @nmArray+'_'+@nmAux
	
	if @nmArray is not null begin
		set @sql = 'if exists (select ''x'' from tempdb.sys.objects where type = ''U'' and name = ''##' + @nmArray + ''')  select indice, valor from ##' + @nmArray + ' else begin raiserror(''Array não existe'',16,1) return end'
		exec (@sql)
	end else begin
		set @sql = 'if exists (select ''x'' from tempdb.sys.objects where type = ''U'' and left(name,2) = ''##'' and right(name,len('''+@nmAux+''')+1) = ''_''+convert(varchar,'+@nmAux+')) select substring(name,3,(len(name)-len('''+@nmAux+'''))-3) from tempdb.sys.objects where type = ''U'' and  left(name,2) = ''##'' and right(name,len('''+@nmAux+''')+1) = ''_''+convert(varchar,'+@nmAux+')' + ' else raiserror(''Array não existe'',16,1)'
		exec (@sql)
	end
	
end
go
