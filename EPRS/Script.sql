USE [master]
GO
/****** Object:  Database [EPRS]    Script Date: 5/1/2018 4:53:57 PM ******/
CREATE DATABASE [EPRS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EPRS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EPRS.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EPRS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\EPRS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EPRS] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EPRS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EPRS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EPRS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EPRS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EPRS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EPRS] SET ARITHABORT OFF 
GO
ALTER DATABASE [EPRS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EPRS] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EPRS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EPRS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EPRS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EPRS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EPRS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EPRS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EPRS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EPRS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EPRS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EPRS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EPRS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EPRS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EPRS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EPRS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EPRS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EPRS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EPRS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EPRS] SET  MULTI_USER 
GO
ALTER DATABASE [EPRS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EPRS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EPRS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EPRS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [EPRS]
GO
/****** Object:  StoredProcedure [dbo].[spx_Add_New_Parking]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Add_New_Parking](
@cust_id as int,
@statusid int,
@parkingname nvarchar(50),
@streetname as nvarchar(50),
@aptno as nvarchar(50),
@state as nvarchar(50),
@city as nvarchar(50),
@zip as nvarchar(50),
@noofparking as int
)
as
begin
DECLARE @Result AS INT
DECLARE @Rowcount AS INT
Declare @Pid as int
begin
insert into tblParkingSpace values(@cust_id,@statusid,@parkingname,@streetname,@aptno,@state,@city,@zip,@noofparking);
set @Pid = SCOPE_IDENTITY();
set @Rowcount = @@ROWCOUNT;
if @Rowcount = 0
begin
set @Result= -1;
select @Result;
end
else
begin
select @Pid;
end
end
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Admin_GetReport]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Admin_GetReport](
@Date as date
)
as
begin

select H.Booking_Customer_Id, H.Customer_Id as 'Owner_Customer_Id', S.Street_Name, S.Apt_No, S.City, S.State, S.ZipCode, CONVERT(date, Booking_Date) as 'Booking_Date', C.First_Name+' ' + C.Last_Name as 'Owner_Name', CC.First_Name+' ' + CC.Last_Name as 'Customer_Name' from tblParkingHours H join tblParkingSpace S on H.Parking_Id = S.Parking_Id 
join tblCustomer C on C.Customer_Id = S.Customer_Id
join tblCustomer CC on CC.Customer_Id = H.Booking_Customer_Id
where CONVERT(date, Booking_Date) = @Date 


end

GO
/****** Object:  StoredProcedure [dbo].[spx_Change_User_Password]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[spx_Change_User_Password](
@custid as int,
@oldpswd as nvarchar(50),
@newpswd as nvarchar(50)
)
as
begin

DECLARE @Result AS INT
update tblCustomer set Password = @newpswd where Customer_Id = @custid and Password = @oldpswd;
set @Result = 1
Select @Result

end
GO
/****** Object:  StoredProcedure [dbo].[spx_Check_If_Booked]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Check_If_Booked](
@rentid as int
)
as
begin
declare @temp int
set @temp = (select ISNUll ( (select Booked from tblParkingHours where Rent_Id = @rentid ),0))
select @temp
end

GO
/****** Object:  StoredProcedure [dbo].[spx_CheckDuplicateParking]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_CheckDuplicateParking](
@cust_id as int,
@streetname as nvarchar(50),
@aptno as nvarchar(50),
@state as nvarchar(50),
@city as nvarchar(50),
@zip as nvarchar(50),
@noofparking as int
)
as
begin
DECLARE @Result AS INT
if exists (select P.Customer_Id from tblParkingSpace P where Street_Name=@streetname and Apt_No=@aptno and State=@state and City=@city and ZipCode=@zip and No_of_Parking=@noofparking)
begin
set @Result=-1;
select @Result;
end 
else
begin 
set @Result=1;
Select @Result;
end
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Get_All_Rent_Spots]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Get_All_Rent_Spots](
@custid as int
)
as
begin
select S.Parking_Id, S.Customer_Id, SS.Status_Type, S.Parking_Name, S.Street_Name, S.Apt_No, S.City,S.State, S.ZipCode, H.Rent_Id , H.Date_Available, H.Open_Date_Time, H.Close_Date_Time, H.OpenTime, H.CloseTime ,H.Price from tblParkingSpace S join tblParkingHours H on S.Parking_Id = H.Parking_Id join tblCustomer C on C.Customer_Id = S.Customer_Id join tblStatus Ss on Ss.Status_Id = H.Status_Id where C.Customer_Id = @custid and H.Date_Available > GETDATE()
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Get_All_Spots]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Get_All_Spots](
@custid as int
)
as
begin

select S.Parking_Id, S.Customer_Id,  S.Parking_Name, S.Street_Name, S.Apt_No, S.City,S.State, S.ZipCode from tblParkingSpace S join tblCustomer C on C.Customer_Id = S.Customer_Id  where S.Customer_Id = @custid

end

GO
/****** Object:  StoredProcedure [dbo].[spx_Get_Available_Parking_Spots]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Get_Available_Parking_Spots](
@date as date,
@city as nvarchar(50),
@custid as nvarchar(50)
)
as
begin
if(@city = '')
begin
select * from tblParkingHours H join tblParkingSpace S on H.Parking_Id = S.Parking_Id where Date_Available = @date and S.Customer_Id <> @custid and H.Booked <> 1 and H.Status_Id=1;
end
else
begin
select * from tblParkingHours H join tblParkingSpace S on H.Parking_Id = S.Parking_Id where Date_Available = @date and City= @city and S.Customer_Id <> @custid and H.Booked <> 1 and H.Status_Id=1;
end
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Get_Booked_Spot]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Get_Booked_Spot](
@spotId as nvarchar(20)
)
as
begin

select C.First_Name as 'OwnerFirstName', C.Last_Name as'OwnerLastName', S.Street_Name, S.Apt_No, S.City, S.State, S.Parking_Name, Email as 'OwnerEmail' , C.Phone as 'OwnerPhone' , OpenTime, CloseTime
from tblParkingHours H 
join tblCustomer C on C.Customer_Id = H.Customer_Id 
join tblParkingSpace S on H.Parking_Id = S.Parking_Id where Rent_Id = @spotId ;

end
GO
/****** Object:  StoredProcedure [dbo].[spx_Get_Rent_Spots_Details]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Get_Rent_Spots_Details](
@rentid as int
)
as
begin
select H.Rent_Id, S.Parking_Id, S.Customer_Id, SS.Status_Type, S.Parking_Name, S.Street_Name, S.Apt_No, S.City,S.State, S.ZipCode, H.Rent_Id , H.Date_Available, H.Open_Date_Time, H.Close_Date_Time, H.OpenTime, H.CloseTime ,H.Price from tblParkingSpace S join tblParkingHours H on S.Parking_Id = H.Parking_Id join tblCustomer C on C.Customer_Id = S.Customer_Id join tblStatus Ss on Ss.Status_Id = H.Status_Id where H.Rent_Id = @rentid
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Get_Reservations_By_User]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Get_Reservations_By_User](
@custid as int
)
as 
begin
select H.Booking_Customer_Id , H.Booking_Date , S.Street_Name, S.Apt_No, S.City, S.State, S.ZipCode , H.Price, H.OpenTime, H.CloseTime from tblParkingHours H join tblParkingSpace S on S.Parking_Id = H.Parking_Id join tblCustomer C on C.Customer_Id = H.Booking_Customer_Id where H.Booking_Customer_Id = @custid;
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Get_Spot_Details]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Get_Spot_Details](
@spotid as int
)
as
begin

select S.Parking_Id, S.Customer_Id, SS.Status_Type, S.Parking_Name, S.Street_Name, S.Apt_No, S.City,S.State, S.ZipCode, H.Rent_Id, H.Date_Available, H.Open_Date_Time, H.Close_Date_Time, H.OpenTime, H.CloseTime ,H.Price from tblParkingSpace S join tblParkingHours H on S.Parking_Id = H.Parking_Id join tblCustomer C on C.Customer_Id = S.Customer_Id join tblStatus Ss on Ss.Status_Id = H.Status_Id where S.Parking_Id = @spotid

end

GO
/****** Object:  StoredProcedure [dbo].[spx_Get_User]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Get_User](
@Username as nvarchar(50)
)
as
begin
select * from tblCustomer where Username = @Username
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Get_User_Info]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Get_User_Info](
@custid as int
)
as
begin
select * from tblCustomer where Customer_Id = @custid;
end

GO
/****** Object:  StoredProcedure [dbo].[spx_LoginUser]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_LoginUser](
@username as nvarchar(50),
@password as nvarchar(50),
@type as nvarchar(20)
)
as
begin
DECLARE @Result AS INT
if exists (select C.Username from tblCustomer C where Username = @username)
begin
select C.Customer_Id, C.Username, C.Password from tblCustomer C where C.Username = @username and C.Password = @password and Type = @type;
end
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Pay_Book_Spot]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Pay_Book_Spot](
@dateTime as datetime,
@spotid as int,
@custid as int
)
as
begin
declare @temp int;
declare @result int;
set @temp = (select Booked from tblParkingHours where Rent_Id=@spotid);
if(@temp = 1)
begin
set @result = 0;
select @result
end
else
begin
update tblParkingHours set Booked= 1, Booking_Customer_Id = @custid, Booking_Date = @dateTime where Rent_Id = @spotid;
set @result = 1
select @result
end
end

GO
/****** Object:  StoredProcedure [dbo].[spx_RegisterUser]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[spx_RegisterUser](
@username as nvarchar(50),
@fname as nvarchar(50),
@lname as nvarchar(50),
@email as nvarchar(50),
@password as nvarchar(50),
@phone as nvarchar(50),
@streetname as nvarchar(50),
@aptno as nvarchar(50),
@zip as nvarchar(50),
@city as nvarchar(50),
@state as nvarchar(50),
@country as nvarchar(50),
@user as nvarchar(50)
)
as
begin
DECLARE @Result AS INT
if exists (select C.Username from tblCustomer C where Username = @username)
begin
set @Result = 0
select @Result
end
else 
begin
insert into tblCustomer values(@username,@email,@password,@fname,@lname,@streetname,@aptno,@city,@state,@zip,@country,@phone,@user)
set @Result =1
select @Result
end
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Rent_Spot]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Rent_Spot](
@custid as int,
@spotid as int,
@statusid as int,
@datenow datetime,
@date nvarchar(50),
@starttime as nvarchar(50),
@closetime as nvarchar(50),
@price int
)
as
begin
declare @opendatetime datetime
declare @closedatetime datetime
declare @datewtime datetime
declare @temp1 int
declare @temp2 int
declare @starttemp nvarchar(50)
declare @closetemp nvarchar(50)
set @datewtime = CONVERT(Datetime, @date,120)
set @starttemp = SUBSTRING(@starttime,1,2)
set @closetemp = SUBSTRING(@closetime,1,2)
set @temp1 = CONVERT(INT, @starttemp)
set @temp2 = CONVERT(INT, @closetemp)
set @opendatetime = DATEADD (HOUR , @temp1 , @datewtime ) 
set @closedatetime = DATEADD (HOUR , @temp2 , @datewtime ) ;

if not exists (select * from tblParkingHours where Parking_Id = @spotid and Date_Available = @datewtime)
begin
insert into tblParkingHours([Customer_Id],[Parking_Id],[Status_Id],[Date_Added],[Date_Available],[Open_Date_Time],[Close_Date_Time],[OpenTime],[CloseTime],[Price]) values(@custid, @spotid, @statusid, @datenow, @datewtime, @opendatetime, @closedatetime, @starttime, @closetime, @price)
select @@ROWCOUNT
end

else

begin
Select 0
end

end

GO
/****** Object:  StoredProcedure [dbo].[spx_Update_Price]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Update_Price](
@price as int,
@rentid as int
)
as
begin

update tblParkingHours set Price = @price where Rent_Id = @rentid
Select 1
end

GO
/****** Object:  StoredProcedure [dbo].[spx_Update_Profile_Info]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[spx_Update_Profile_Info](
@custid as int,
@fname as nvarchar(50),
@lname as nvarchar(50),
@phone as nvarchar(50)
)
as
begin

DECLARE @Result AS INT
update tblCustomer set First_Name = @fname, Last_Name=@lname, Phone = @phone where Customer_Id = @custid;
set @Result = 1
Select @Result

end
GO
/****** Object:  StoredProcedure [dbo].[spx_Update_Status_And_Price]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_Update_Status_And_Price](
@rentid as int,
@statusid as int,
@price as int
)
as
begin
update tblParkingHours set Price = @price, Status_Id= @statusid where Rent_Id = @rentid
end

GO
/****** Object:  StoredProcedure [dbo].[spx_UpdateUser_Info]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[spx_UpdateUser_Info](
@custid as int,
@fname as nvarchar(50),
@lname as nvarchar(50),
@streetName as nvarchar(50),
@aptNo as nvarchar(50),
@zip as nvarchar(10),
@city as nvarchar(50),
@state as nvarchar(50),
@country as nvarchar(50)
)

as
begin

DECLARE @Result AS INT
update tblCustomer set First_Name = @fname, Last_Name=@lname, Street_Name=@streetName, Apt_No=@aptNo,City=@city,State=@state,Country=@country, ZipCode= @zip where Customer_Id = @custid;
set @Result = 1
Select @Result

end
GO
/****** Object:  StoredProcedure [dbo].[spx_ValidateAdmin]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_ValidateAdmin](
@username as nvarchar(50)
)
as
begin
DECLARE @Result AS INT
if exists (select C.Username from tblCustomer C where Username = @username and Type='Admin')
begin
set @Result = 1
select @Result
end
else
begin
set @Result = -1
select @Result
end
end

GO
/****** Object:  StoredProcedure [dbo].[spx_ValidateUser]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spx_ValidateUser](
@username as nvarchar(50)
)
as
begin
DECLARE @Result AS INT
if exists (select C.Username from tblCustomer C where Username = @username)
begin
set @Result = 1
select @Result
end
else
begin
set @Result = -1
select @Result
end
end

GO
/****** Object:  StoredProcedure [dbo].[Temp]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Temp](
@spotid as int,
@datenow datetime,
@date nvarchar(50),
@starttime as nvarchar(50),
@closetime as nvarchar(50)
)
as
begin
declare @opendatetime datetime
declare @closedatetime datetime
declare @datewtime datetime
declare @temp1 int
declare @temp2 int
declare @starttemp nvarchar(50)
declare @closetemp nvarchar(50)
set @datewtime = CONVERT(Datetime, @date,120)
set @starttemp = SUBSTRING(@starttime,1,2)
set @closetemp = SUBSTRING(@closetime,1,2)
set @temp1 = CONVERT(INT, @starttemp)
set @temp2 = CONVERT(INT, @closetemp)
set @opendatetime = DATEADD (HOUR , @temp1 , @datewtime ) 
set @closedatetime = DATEADD (HOUR , @temp2 , @datewtime ) ;

insert into tblParkingHours values(@spotid, @datenow, @datewtime, @opendatetime, @closedatetime, @starttime, @closetime)
select @@ROWCOUNT

end

GO
/****** Object:  Table [dbo].[tblCustomer]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomer](
	[Customer_Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[First_Name] [nvarchar](50) NULL,
	[Last_Name] [nvarchar](50) NULL,
	[Street_Name] [nvarchar](50) NULL,
	[Apt_No] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[ZipCode] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblParkingHours]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblParkingHours](
	[Rent_Id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_Id] [int] NULL,
	[Parking_Id] [int] NULL,
	[Status_Id] [int] NULL,
	[Date_Added] [datetime] NULL,
	[Date_Available] [datetime] NULL,
	[Open_Date_Time] [datetime] NULL,
	[Close_Date_Time] [datetime] NULL,
	[OpenTime] [nchar](10) NULL,
	[CloseTime] [nchar](10) NULL,
	[Price] [int] NULL,
	[Booking_Date] [datetime] NULL,
	[Booking_Customer_Id] [int] NULL,
	[Booked] [int] NOT NULL,
 CONSTRAINT [PK_ParkingHours] PRIMARY KEY CLUSTERED 
(
	[Rent_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblParkingSpace]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblParkingSpace](
	[Parking_Id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_Id] [int] NULL,
	[X_Status_Id] [int] NULL,
	[Parking_Name] [nvarchar](50) NULL,
	[Street_Name] [nvarchar](50) NULL,
	[Apt_No] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[ZipCode] [nvarchar](50) NULL,
	[No_of_Parking] [int] NULL,
 CONSTRAINT [PK_ParkingSpace] PRIMARY KEY CLUSTERED 
(
	[Parking_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblStatus]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblStatus](
	[Status_Id] [int] NOT NULL,
	[Status_Type] [nvarchar](50) NULL,
	[Status_Desc] [nvarchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[Status_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTime]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTime](
	[Time_Id] [int] IDENTITY(1,1) NOT NULL,
	[Time] [nvarchar](15) NULL,
	[Time_AMPM] [nvarchar](15) NULL,
 CONSTRAINT [PK_tblTime] PRIMARY KEY CLUSTERED 
(
	[Time_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[x_tblCity]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[x_tblCity](
	[City_Id] [int] IDENTITY(1,1) NOT NULL,
	[State_Id] [nvarchar](50) NULL,
	[City_Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[City_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[X_tblReservation]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[X_tblReservation](
	[Reservation_Id] [int] IDENTITY(1,1) NOT NULL,
	[Parking_Id] [int] NULL,
	[Customer_Id] [int] NULL,
	[Created_at] [datetime] NULL,
	[Start_Time] [datetime] NULL,
	[End_Time] [datetime] NULL,
	[Note] [nvarchar](1000) NULL,
	[Status_Id] [int] NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[Reservation_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[x_tblState]    Script Date: 5/1/2018 4:53:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[x_tblState](
	[State_Id] [int] IDENTITY(1,1) NOT NULL,
	[State_Name] [nvarchar](50) NULL,
	[State_Abbr] [nvarchar](50) NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[State_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[tblParkingHours] ADD  CONSTRAINT [DF_tblParkingHours_Booked]  DEFAULT ((0)) FOR [Booked]
GO
USE [master]
GO
ALTER DATABASE [EPRS] SET  READ_WRITE 
GO
