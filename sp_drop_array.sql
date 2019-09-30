create or alter procedure dbo.sp_drop_array
	@nmArray	varchar(200)
with encryption	
as
begin
	
	--exemplo: exec dbo.sp_drop_array 'teste'
	
	declare @nmAux				varchar(100)
	declare @sql				varchar(max)

	if (@nmArray is null or @nmArray = '') 
		raiserror('Array não informado!',16,1)
	
	set @nmAux		= convert(varchar,@@SPID)
	set @nmArray	= @nmArray +'_'+@nmAux
	
	set @sql = 'if exists (select * from tempdb.sys.objects where type = ''U'' and name = ''' + '##'+@nmArray + ''') drop table ##' + @nmArray + ' else raiserror(''Array não existe'',16,1) '
	
	exec (@sql)
	
end
go

