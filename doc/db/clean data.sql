use AgvWarehouseDb
go

-- 1. 重新开始所有，库位无库存
delete from StockTask;
delete from Storage;
delete from TrayItem;
delete from DeliveryTray;
delete from Tray;
delete from DeliveryItem;
delete from Delivery;

-- 2. 出库后删除运单
delete from TrayItem;
delete from DeliveryTray;
delete from Tray;
delete from DeliveryItem;
delete from Delivery;


-- 3. 如果入库错误
-- 编辑storage，修改 UniqItemNr 或者 PositionNr
-- 编辑storage，添加一条库存记录，PositionNr为库位号，UniqItemNr为条码号


-- 4. 删除任务，出现入库混乱时
delete from StockTask where [TYPE]=2;

-- 5. 删除任务，出现出库混乱时
delete from StockTask where [TYPE]=1;
--delete from UniqueItem   where createdat <'2016-12-21 09:00';

--delete from Position;



  update [AgvWarehouseDb].[dbo].[UniqueItem] set State=100;


  update [AgvWarehouseDb].[dbo].[Position] set isLocked=0
  where 
  Nr not in (select positionnr from storage);
/**
  
  
    update [AgvWarehouseDb].[dbo].[Position] set isLocked=1 where
  Nr in (select positionnr from storage);
/**
  delete from StockTask;
 delete from [AgvWarehouseDb].[dbo].[Storage];
  update [AgvWarehouseDb].[dbo].UniqueItem set State=100;
  
  **/
  
 -- delete from StockTask where [type]=2;
  
  
 -- update StockTask set State=7 where [type]=1;