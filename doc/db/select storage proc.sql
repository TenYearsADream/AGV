USE [AgvWarehouseDb]
GO

/****** Object:  StoredProcedure [dbo].[SelectCurrentStorage]    Script Date: 05/02/2017 17:44:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectCurrentStorage]
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
select UniqueItemPartNr as '���ú�',	UniqueItemKNr as '����K��',
   UniqueItemKskNr as '�����ڲ�K��', UniqueItemCheckCode as	'��֤��',PositionNr as '��λ��', FIFO as 'FIFO',
     '����'=case when UniqueItemBoxTypeId=1 then 'Big' when UniqueItemBoxTypeId=2 then 'Small' else '' end,	PositionRoadMachineIndex as '�������'
 from StorageUniqueItemView;
END


GO


