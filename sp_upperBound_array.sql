create or alter procedure dbo.sp_upperBound_array
	@nmArray	varchar(200)
as
begin
	
	--exemplo: exec dbo.sp_upperBound_array
	
	declare @nmAux				varchar(100)
	declare @sql				varchar(max)

	set @nmAux		= convert(varchar,@@SPID)
	set @nmArray	= @nmArray+'_'+@nmAux
	
	set @sql = 'if exists (select ''x'' from tempdb.sys.objects where type = ''U'' and name = ''##' + @nmArray + ''')  select top 1 indice, valor from ##' + @nmArray + ' order by indice desc else raiserror(''Array não existe'',16,1) '

	exec (@sql)

end
go
