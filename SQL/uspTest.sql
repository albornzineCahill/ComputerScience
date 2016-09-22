if exists (select name from sysobjects where name = 'uspTest')
drop procedure uspTest
go
create procedure uspTest
@KeyField	smallint,
@Age		tinyint,
@Gender		varchar(1)
as
begin
update tblPeople set Age = @Age, Gender = @Gender where KeyField = @KeyField
end

exec uspTest @KeyField = 2, @Age = 18

select * from tblPeople

