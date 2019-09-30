create or alter procedure dbo.sp_create_array
	(@nmArray	varchar(200))
as
begin
	
	--exemplo: exec dbo.sp_create_array 'teste'
	
	declare @sql		varchar(1000)
	declare @nmAux		varchar(100)
	declare @msgerro	varchar(1000)
	
	if @nmArray is null or @nmArray = '' begin
		set @msgerro = 'necessártio definir um nome para o Array.'
		raiserror(@msgerro,16,1)
		return -1
	end

	begin try
		set @nmAux		= convert(varchar,@@SPID)
		set @nmArray	= @nmArray +'_'+@nmAux
		set @sql = 'if exists (select * from tempdb.sys.objects where type = ''U'' and name = ''' + @nmArray + ''') drop table ##'+ @nmArray + '	create table ##'+@nmArray + ' (indice int, valor varchar(8000))' 
		exec (@sql)
	end try
	begin catch
		set @msgerro = 'não foi possivel criar o Array (' + isnull(error_message(),'')+')'
		raiserror(@msgerro,16,1)
		return -1	
	end catch

	return 1

end
go


