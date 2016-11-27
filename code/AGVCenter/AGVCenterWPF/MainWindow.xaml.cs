﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Timers;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using AGVCenterLib.Data;
using AGVCenterLib.Enum;
using AGVCenterLib.Model;
using AGVCenterLib.Model.OPC;
using AGVCenterLib.Service;
using Brilliantech.Framwork.Utils.LogUtil;
using OPCAutomation;

namespace AGVCenterWPF
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }
        #region 服务变量
        OPCServer AnOPCServer;
        OPCServer ConnectedOPCServer;
        #endregion

        #region
        // 总任务队列
        Dictionary<string, StockTaskItem> TaskCenterQueue;
        private static object WriteTaskCenterQueueLocker = new object();
        private static object TaskCetnerQueueLocker=new object();
       
        //小车放行队列
        Queue AgvInStockPassQueue;
        //机械手抓取队列
        Queue InRobootPickQueue;
        /// <summary>
        /// 入库任务队列，以条码为键
        /// </summary>
        Dictionary<string, OPCSetStockTask> InStockTaskQueue;
        private static object WriteStockTaskLocker = new object();
        private static object StockTaskQueueLocker = new object();

        #endregion
        #region 入库信息数据 OPC

        // 入库条码扫描
        OPCCheckInStockBarcode OPCCheckInStockBarcodeData;
        OPCGroup OPCCheckInstockBarcodeOPCGroup;
        // 小车入库放行
        OPCAgvInStockPass OPCAgvInStockPassData;
        OPCGroup OPCAgvInStockPassOPCGroup;
        // 入库机械手抓取
        OPCInRobootPick OPCInRobootPickData;
        OPCGroup OPCInRobootPickOPCGroup;



        // 库存任务, 巷道机1&2
        // 1
        OPCSetStockTask OPCSetStockTaskRoadMachine1Data;
        OPCGroup OPCSetStockTaskRoadMachine1OPCGroup;
        // 2
        OPCSetStockTask OPCSetStockTaskRoadMachine2Data;
        OPCGroup OPCSetStockTaskRoadMachine2OPCGroup;

        #endregion

        #region 监控定时器
        /// <summary>
        /// 写入OPC小车放行定时器，将队列AgvInStockPassQueue的任务写入OPC
        /// </summary>
        Timer SetOPCAgvPassTimer;


        /// <summary>
        /// 写入OPC入库机械手信息，将对列InRobootPickQueue的任务写入OPC
        /// </summary>
        Timer SetOPCInRobootPickTimer;

        /// <summary>
        /// 写入OPC入库任务定时器，将队列InStockTaskQueue的任务按序写入OPC
        /// </summary>
        Timer SetOPCInStockTaskTimer;
        #endregion

        /// <summary>
        /// 初始化数据
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            #region 加载初始化数据
            // 初始化并从数据库加载任务
            this.InitQueueAndLoadTaskFromDb();
            #endregion

            #region 初始化基本数据
            foreach (var i in OPCConfig.OPCServers)
            {
                OPCServersLB.Items.Add(i);
            }
            OPCServerTB.Text = OPCConfig.OPCServer;
            OPCNodeNameTB.Text = OPCConfig.OPCNodeName;

            #endregion

            #region 初始化OPC数据
            // 扫描入库码
            OPCCheckInStockBarcodeData = new OPCCheckInStockBarcode();
            OPCCheckInStockBarcodeData.RwFlagChangedEvent += new OPCCheckInStockBarcode.RwFlagChangedEventHandler(OPCCheckInStockBarcodeData_RwFlagChangedEvent);
           
            // Agv小车入库放行
            OPCAgvInStockPassData = new OPCAgvInStockPass();
            OPCAgvInStockPassData.RwFlagChangedEvent += new OPCAgvInStockPass.RwFlagChangedEventHandler( OPCAgvInStockPassData_RwFlagChangedEvent);

            // 入库机械手抓取
            OPCInRobootPickData = new OPCInRobootPick();
            OPCInRobootPickData.RwFlagChangedEvent +=new OPCInRobootPick.RwFlagChangedEventHandler(  OPCInRobootPickData_RwFlagChangedEvent);

            //库存操作任务  巷道机1
            OPCSetStockTaskRoadMachine1Data = new OPCSetStockTask("SetStockTaskRoadMachine1");
            OPCSetStockTaskRoadMachine1Data.RwFlagChangedEvent += new OPCSetStockTask.RwFlagChangedEventHandler(OPCSetStockTaskRoadMachine1Data_RwFlagChangedEvent);

            //库存操作任务 巷道机2
            OPCSetStockTaskRoadMachine2Data = new OPCSetStockTask("SetStockTaskRoadMachine1");
            OPCSetStockTaskRoadMachine2Data.RwFlagChangedEvent += new OPCSetStockTask.RwFlagChangedEventHandler( OPCSetStockTaskRoadMachine2Data_RwFlagChangedEvent);
            #endregion

            #region 初始化定时器
            // AGV入库放行Timer
            SetOPCAgvPassTimer = new Timer();
            SetOPCAgvPassTimer.Interval = OPCConfig.SetOPCAgvInStockPassTimerInterval;
            SetOPCAgvPassTimer.Enabled = true;
            SetOPCAgvPassTimer.Elapsed += SetOPCAgvPassTimer_Elapsed;

            // 入库机械手Timer
            SetOPCInRobootPickTimer = new Timer();
            SetOPCInRobootPickTimer.Interval = OPCConfig.SetOPCInRobootPickTimerInterval;
            SetOPCInRobootPickTimer.Enabled = true;
            SetOPCInRobootPickTimer.Elapsed += SetOPCInRobootPickTimer_Elapsed;



            // 入库任务定时器
            SetOPCInStockTaskTimer = new Timer();
            SetOPCInStockTaskTimer.Interval = 100;
            SetOPCInStockTaskTimer.Enabled = true;
            SetOPCInStockTaskTimer.Elapsed += SetOPCInStockTaskTimer_Elapsed;

            /// 启动定时器
            SetOPCAgvPassTimer.Start();
            SetOPCInStockTaskTimer.Start();
            #endregion
        }



        /// <summary>
        /// 读取AGV放行队列中的任务，写入OPC值并可读
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void SetOPCAgvPassTimer_Elapsed(object sender, ElapsedEventArgs e)
        {
            SetOPCAgvPassTimer.Stop();
            if (AgvInStockPassQueue.Count > 0 && OPCAgvInStockPassData.CanWrite)
            {
                StockTaskItem taskItem = AgvInStockPassQueue.Peek() as StockTaskItem;
                OPCAgvInStockPassData.AgvPassFlag = taskItem.AgvPassFlag;
                taskItem.State = StockTaskState.AgvInStcoking;
                if (OPCAgvInStockPassData.SyncWrite(OPCAgvInStockPassOPCGroup))
                {   
                    AgvInStockPassQueue.Dequeue();
                    RefreshList();
                }
            }
            SetOPCAgvPassTimer.Start();
        }

        /// <summary>
        /// 读取入库机械手数据队列中的任务，写入OPC值并可读
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void SetOPCInRobootPickTimer_Elapsed(object sender, ElapsedEventArgs e)
        {
            SetOPCInRobootPickTimer.Stop();
            if (InRobootPickQueue.Count > 0 && OPCInRobootPickData.CanWrite)
            {
                StockTaskItem taskItem = AgvInStockPassQueue.Peek() as StockTaskItem;
                taskItem.State = StockTaskState.RobootInStocking;
                OPCInRobootPickData.BoxType = taskItem.BoxType ;
                if (OPCInRobootPickData.SyncWrite(OPCInRobootPickOPCGroup))
                {
                    InRobootPickQueue.Dequeue();
                    RefreshList();
                }
            }
            SetOPCInRobootPickTimer.Start();
        }


        /// <summary>
        /// 验证可读和读取入库条码信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void SetOPCInStockTaskTimer_Elapsed(object sender, ElapsedEventArgs e)
        {
            SetOPCInStockTaskTimer.Stop();

            // 是否存在任务？ 并OPC可写
            if (OPCSetStockTaskRoadMachine1Data.CanWrite && this.HasWatingInStockTask())
            {
                OPCSetStockTask task = this.DequeueInStockTaskQueue();

                LogUtil.Logger.InfoFormat("【派发任务】条码为{0}, 库位为{1}-{2}-{3}", task.Barcode, task.PositionFloor, task.PositionColumn, task.PositionRow);
                if (task.SyncWrite(OPCSetStockTaskRoadMachine1OPCGroup))
                {
                    task.State = StockTaskState.RoadMachineInStocking;
                    // 置为可读，有新的任务
                    task.SyncSetReadableFlag(OPCSetStockTaskRoadMachine1OPCGroup);
                }
            }

            SetOPCInStockTaskTimer.Start();
        }

        /// <summary>
        /// 列出OPC服务
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ListOPCServerBtn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                AnOPCServer = new OPCServer();
                OPCServersLB.Items.Clear();
                dynamic allServerList = OPCNodeNameTB.Text.Length == 0 ? AnOPCServer.GetOPCServers() : AnOPCServer.GetOPCServers(OPCNodeNameTB.Text);

                foreach (var s in (allServerList as Array))
                {
                    OPCServersLB.Items.Add(s);
                }
                AnOPCServer = null;
            }
            catch (Exception ex)
            {
                LogUtil.Logger.Error(ex.Message, ex);
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// 选择OPC服务
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void OPCServersLB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            OPCServerTB.Text = OPCServersLB.SelectedValue.ToString();
        }

        /// <summary>
        /// 连接OPC服务
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ConnectOPCServerBtn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                ConnectedOPCServer = new OPCServer();
                ConnectedOPCServer.ServerShutDown += ConnectedOPCServer_ServerShutDown;

                ConnectedOPCServer.Connect(OPCServerTB.Text, OPCNodeNameTB.Text);
                ConnectedOPCServer.OPCGroups.DefaultGroupIsActive = true;
                ConnectedOPCServer.OPCGroups.DefaultGroupDeadband = 0;

                /// 初始化OPC组
                if (InitOPCGroup())
                {
                    ConnectOPCServerBtn.IsEnabled = false;
                    StartComponents();
                }
            }
            catch (Exception ex)
            {
                ConnectedOPCServer = null;
                ConnectOPCServerBtn.IsEnabled = true;
                LogUtil.Logger.Error(ex.Message, ex);
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// OPC 服务关闭事件处理
        /// </summary>
        /// <param name="Reason"></param>
        private void ConnectedOPCServer_ServerShutDown(string Reason)
        {
            LogUtil.Logger.Info(string.Format("【OPC Sever 自停止】{0}", Reason));
            #region 关闭Timer\线程 等活动
            ShutDownComponents();
            #endregion
        }

        /// <summary>
        /// 断开OPC服务
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void DisConnectOPCServerBtn_Click(object sender, RoutedEventArgs e)
        {
            this.DisconnectOPCServer();
        }



     
        /// <summary>
        /// 初始化组
        /// </summary>
        private bool InitOPCGroup()
        {
            try
            {
                #region 初始化入库扫描验证组
                // 初始化入库扫描验证组
                OPCCheckInstockBarcodeOPCGroup = ConnectedOPCServer.OPCGroups.Add(OPCConfig.OPCCheckInStockBarcodeOPCGroupName);
                OPCCheckInstockBarcodeOPCGroup.UpdateRate = OPCConfig.OPCCheckInStockBarcodeOPCGroupRate;
                OPCCheckInstockBarcodeOPCGroup.DeadBand = OPCConfig.OPCCheckInStockBarcodeOPCGroupDeadBand;
                OPCCheckInstockBarcodeOPCGroup.IsSubscribed = true;
                OPCCheckInstockBarcodeOPCGroup.IsActive = true;

                // 添加item
                OPCCheckInStockBarcodeData.AddItemToGroup(OPCCheckInstockBarcodeOPCGroup);
                OPCCheckInstockBarcodeOPCGroup.DataChange +=  OPCCheckInStockBarcodeOPCGroup_DataChange;
                #endregion

                #region Agv入库放行组
                OPCAgvInStockPassOPCGroup = ConnectedOPCServer.OPCGroups.Add(OPCConfig.OPCAgvInStockPassOPCGroupName);
                OPCAgvInStockPassOPCGroup.UpdateRate = OPCConfig.OPCAgvInStockPassOPCGroupRate;
                OPCAgvInStockPassOPCGroup.DeadBand = OPCConfig.OPCAgvInStockPassOPCGroupDeadBand;
                OPCAgvInStockPassOPCGroup.IsSubscribed = true;
                OPCAgvInStockPassOPCGroup.IsActive = true;

                // 添加item
                OPCAgvInStockPassData.AddItemToGroup(OPCAgvInStockPassOPCGroup);
                OPCAgvInStockPassOPCGroup.DataChange += OPCAgvInStockPassOPCGroup_DataChange; ;
                #endregion

                #region 入库机械手抓取信息组
                OPCInRobootPickOPCGroup = ConnectedOPCServer.OPCGroups.Add(OPCConfig.OPCInRobootPickOPCGroupName);
                OPCInRobootPickOPCGroup.UpdateRate = OPCConfig.OPCInRobootPickOPCGroupRate;
                OPCInRobootPickOPCGroup.DeadBand = OPCConfig.OPCInRobootPickOPCGroupDeadBand;
                OPCInRobootPickOPCGroup.IsSubscribed = true;
                OPCInRobootPickOPCGroup.IsActive = true;

                // 添加item
                OPCInRobootPickData.AddItemToGroup(OPCInRobootPickOPCGroup);
                OPCInRobootPickOPCGroup.DataChange += OPCInRobootPickOPCGroup_DataChange;

                #endregion

                #region 初始化巷道机入库任务组
                // 初始化 巷道机1 入库任务组
                OPCSetStockTaskRoadMachine1OPCGroup = ConnectedOPCServer.OPCGroups.Add(OPCConfig.OPCSetInStockTaskRM1OPCGroupName);
                OPCSetStockTaskRoadMachine1OPCGroup.UpdateRate = OPCConfig.OPCSetInStockTaskRM1OPCGroupRate;
                OPCSetStockTaskRoadMachine1OPCGroup.DeadBand = OPCConfig.OPCSetInStockTaskRM1OPCGroupDeadBand;
                OPCSetStockTaskRoadMachine1OPCGroup.IsSubscribed = true;
                OPCSetStockTaskRoadMachine1OPCGroup.IsActive = true;
                // 添加item
                OPCSetStockTaskRoadMachine1Data.AddItemToGroup(OPCSetStockTaskRoadMachine1OPCGroup);
                OPCSetStockTaskRoadMachine1OPCGroup.DataChange += OPCSetStockTaskRoadMachine1OPCGroup_DataChange;

                // 初始化 巷道机2 入库任务组
                OPCSetStockTaskRoadMachine2OPCGroup = ConnectedOPCServer.OPCGroups.Add(OPCConfig.OPCSetInStockTaskRM2OPCGroupName);
                OPCSetStockTaskRoadMachine2OPCGroup.UpdateRate = OPCConfig.OPCSetInStockTaskRM2OPCGroupRate;
                OPCSetStockTaskRoadMachine2OPCGroup.DeadBand = OPCConfig.OPCSetInStockTaskRM2OPCGroupDeadBand;
                OPCSetStockTaskRoadMachine2OPCGroup.IsSubscribed = true;
                OPCSetStockTaskRoadMachine2OPCGroup.IsActive = true;
                // 添加item
                OPCSetStockTaskRoadMachine2Data.AddItemToGroup(OPCSetStockTaskRoadMachine2OPCGroup);
                OPCSetStockTaskRoadMachine2OPCGroup.DataChange += OPCSetStockTaskRoadMachine2OPCGroup_DataChange; ;



                #endregion
                return true;

            }
            catch (Exception ex)
            {
                LogUtil.Logger.Error(ex.Message, ex);
                MessageBox.Show(ex.Message);
            }
            return false;
        }



        // 第一次会获取到opcserver的数据，即使没有触发，相当于初始化
        // 扫描入库的信息获取
        private void OPCCheckInStockBarcodeOPCGroup_DataChange(
            int TransactionID,
            int NumItems,
            ref Array ClientHandles,
            ref Array ItemValues,
            ref Array Qualities,
            ref Array TimeStamps)
        {
            try
            {
                // 从1开始
                for (var i = 1; i <= NumItems; i++)
                {
                    LogUtil.Logger.InfoFormat("【数据改变】【入库条码扫描】{0}", ItemValues.GetValue(i));
                }
                OPCCheckInStockBarcodeData.SetValue(NumItems,ClientHandles, ItemValues);
            }
            catch (Exception ex)
            {
                LogUtil.Logger.Error(ex.Message, ex);
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// AGV放行数据改变事件
        /// </summary>
        /// <param name="TransactionID"></param>
        /// <param name="NumItems"></param>
        /// <param name="ClientHandles"></param>
        /// <param name="ItemValues"></param>
        /// <param name="Qualities"></param>
        /// <param name="TimeStamps"></param>
        private void OPCAgvInStockPassOPCGroup_DataChange(int TransactionID, int NumItems, ref Array ClientHandles, ref Array ItemValues, ref Array Qualities, ref Array TimeStamps)
        {
            try
            {
                // 从1开始
                for (var i = 1; i <= NumItems; i++)
                {
                    LogUtil.Logger.InfoFormat("【数据改变】【AGV放行】{0}", ItemValues.GetValue(i));
                }
                OPCAgvInStockPassData.SetValue(NumItems, ClientHandles, ItemValues);
            }
            catch (Exception ex)
            {
                LogUtil.Logger.Error(ex.Message, ex);
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// 入库机械手抓手信息
        /// </summary>
        /// <param name="TransactionID"></param>
        /// <param name="NumItems"></param>
        /// <param name="ClientHandles"></param>
        /// <param name="ItemValues"></param>
        /// <param name="Qualities"></param>
        /// <param name="TimeStamps"></param>
        private void OPCInRobootPickOPCGroup_DataChange(int TransactionID, int NumItems, ref Array ClientHandles, ref Array ItemValues, ref Array Qualities, ref Array TimeStamps)
        {
            try
            {
                // 从1开始
                for (var i = 1; i <= NumItems; i++)
                {
                    LogUtil.Logger.InfoFormat("【数据改变】【机械手】{0}", ItemValues.GetValue(i));
                }
                OPCInRobootPickData.SetValue(NumItems, ClientHandles, ItemValues);
            }
            catch (Exception ex)
            {
                LogUtil.Logger.Error(ex.Message, ex);
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// 设置 巷道机1 入库任务的数据改变事件处理
        /// </summary>
        /// <param name="TransactionID"></param>
        /// <param name="NumItems"></param>
        /// <param name="ClientHandles"></param>
        /// <param name="ItemValues"></param>
        /// <param name="Qualities"></param>
        /// <param name="TimeStamps"></param>
        private void OPCSetStockTaskRoadMachine1OPCGroup_DataChange(int TransactionID, int NumItems, ref Array ClientHandles, ref Array ItemValues, ref Array Qualities, ref Array TimeStamps)
        {
            try
            {
                // 从1开始
                for (var i = 1; i <= NumItems; i++)
                {
                    LogUtil.Logger.InfoFormat("【数据改变】【巷道机1】{0}", ItemValues.GetValue(i));
                }
                OPCSetStockTaskRoadMachine1Data.SetValue(NumItems, ClientHandles, ItemValues);
            }
            catch (Exception ex)
            {
                LogUtil.Logger.Error(ex.Message, ex);
                MessageBox.Show(ex.Message);
            }
        }
        /// <summary>
        /// 设置 巷道机2 入库任务的数据改变事件处理
        /// </summary>
        /// <param name="TransactionID"></param>
        /// <param name="NumItems"></param>
        /// <param name="ClientHandles"></param>
        /// <param name="ItemValues"></param>
        /// <param name="Qualities"></param>
        /// <param name="TimeStamps"></param>
        private void OPCSetStockTaskRoadMachine2OPCGroup_DataChange(int TransactionID, int NumItems, ref Array ClientHandles, ref Array ItemValues, ref Array Qualities, ref Array TimeStamps)
        {
            try
            {
                // 从1开始
                for (var i = 1; i <= NumItems; i++)
                {
                    LogUtil.Logger.InfoFormat("【数据改变】【巷道机2】{0}", ItemValues.GetValue(i));
                }
                OPCSetStockTaskRoadMachine2Data.SetValue(NumItems, ClientHandles, ItemValues);
            }
            catch (Exception ex)
            {
                LogUtil.Logger.Error(ex.Message, ex);
                MessageBox.Show(ex.Message);
            }
        }




        /// <summary>
        /// 读取入库条码信息读写标记改变处理
        /// </summary>
        /// <param name="b"></param>
        /// <param name="toFlag"></param>
        private void OPCCheckInStockBarcodeData_RwFlagChangedEvent(OPCDataBase b, byte toFlag)
        {
            if (b.CanRead)
            {
                // 读取条码，获取放行信息写入队列
                LogUtil.Logger.InfoFormat("【根据-条码-判断放行】{0}", OPCCheckInStockBarcodeData.ScanedBarcode);
                try
                {
                    this.CreateTaskIntoTaskCenterQueue(OPCCheckInStockBarcodeData.ScanedBarcode);
                }
                catch (Exception ex)
                {
                    LogUtil.Logger.Error(ex.Message, ex);
                }
                finally
                {
                    // 置为可写
                    this.OPCCheckInStockBarcodeData.SyncSetWriteableFlag(OPCCheckInstockBarcodeOPCGroup);
                }
            }
        }

        /// <summary>
        /// agv入库放行读写标记改变处理
        /// </summary>
        /// <param name="b"></param>
        /// <param name="toFlag"></param>
        private void OPCAgvInStockPassData_RwFlagChangedEvent(OPCDataBase b, byte toFlag)
        {
            if (b.CanWrite)
            {
                /// 将放行信息队列中的信息写入OPC
                /// 使用定时器去写
               /// throw new NotImplementedException();
            }
        }

        /// <summary>
        /// 入库机械手抓取信息读写标记改变处理
        /// </summary>
        /// <param name="b"></param>
        /// <param name="toFlag"></param>
        private void OPCInRobootPickData_RwFlagChangedEvent(OPCDataBase b, byte toFlag)
        {
            if (b.CanWrite)
            {
                /// 将入库机械手抓取信息写入OPC
                /// 使用定时器去写
            }
        }


        /// <summary>
        /// 入库任务 巷道机1
        /// </summary>
        /// <param name="b"></param>
        /// <param name="toFlag"></param>
        private void OPCSetStockTaskRoadMachine1Data_RwFlagChangedEvent(OPCDataBase b, byte toFlag)
        {
            LogUtil.Logger.InfoFormat("【OPC 巷道机 1 入库任务读写标记改变】{0}",OPCSetStockTaskRoadMachine1Data.OPCRwFlag);
            //if (b.CanWrite)
            //{
            // 这边就不写了，使用定时器写入库任务！
            //}
        }

        /// <summary>
        /// 入库任务 巷道机2
        /// </summary>
        /// <param name="b"></param>
        /// <param name="toFlag"></param>
        private void OPCSetStockTaskRoadMachine2Data_RwFlagChangedEvent(OPCDataBase b, byte toFlag)
        {
            LogUtil.Logger.InfoFormat("【OPC  巷道机 1 入库任务读写标记改变】{0}", OPCSetStockTaskRoadMachine1Data.OPCRwFlag);
        }



        /// <summary>
        /// 将任务写入总任务队列，并派发到AGV放行队列
        /// </summary>
        /// <param name="barcode"></param>
        /// <returns></returns>
        private bool CreateTaskIntoTaskCenterQueue(string barcode)
        {
            lock (WriteTaskCenterQueueLocker)
            {
                StockTaskItem taskItem = new StockTaskItem() { Barcode = barcode,StockTaskType= StockTaskType.IN };
                UniqueItemService uniqItemService = new UniqueItemService(OPCConfig.DbString);
                UniqueItemView item = uniqItemService.FindDetail(barcode);
                if (item != null)
                {
                    // 是否可以入库
                    if (uniqItemService.CanUniqInStock(barcode))
                    {
                        // 是否是重复扫描
                        if (InStockTaskQueue.Keys.Contains(barcode))
                        {
                            // 重复扫描的不再生成任务
                            return true;
                        }


                        // 查询可用库位！
                        PositionService ps = new PositionService(OPCConfig.DbString);
                        Position position = ps.FindInStockPosition();
                        if (position == null)
                        {
                            taskItem.AgvPassFlag = (byte)AgvPassFlag.Alarm;
                            taskItem.State = StockTaskState.ErrorNoPositoin;
                        }
                        else
                        {
                            taskItem.AgvPassFlag = (byte)AgvPassFlag.Pass;
                            // 先放小车，不计算库位!
                            taskItem.BoxType = (byte)item.BoxType;
                            //taskItem.State = StockTaskState.AgvInStcoking;
                        }
                    }
                    else
                    {
                        // 不可入库
                        taskItem.AgvPassFlag = (byte)AgvPassFlag.Alarm;
                        taskItem.State = StockTaskState.ErrorUniqCannotInStock;
                    }
                }
                else
                {
                    // 条码不存在
                    if (TaskCenterQueue.Keys.Contains(barcode))
                    {
                        taskItem.AgvPassFlag = (byte)AgvPassFlag.Alarm;
                    }
                    else
                    {
                        taskItem.AgvPassFlag = (byte)AgvPassFlag.ReScan;
                    }
                    taskItem.State = StockTaskState.ErrorUniqNotExsits;
                }


                // 先插入数据库Task再加入队列，最后置可读
                StockTaskService ts = new StockTaskService(OPCConfig.DbString);
                if (!ts.CreateInStockTask(taskItem))
                {
                    taskItem.AgvPassFlag = (byte)AgvPassFlag.ReScan;
                    taskItem.State = StockTaskState.ErrorCreateDbTask;
                }
                /// 加入到总队列
                EnqueueTaskCenterQueue(taskItem);
                return false;
            }
        }

        #region 总队列任务
        /// <summary>
        /// 进入总任务队列
        /// </summary>
        /// <param name="taskItem"></param>
        private void EnqueueTaskCenterQueue(StockTaskItem taskItem)
        {
            lock (TaskCetnerQueueLocker)
            {
                // 加入总队列
                TaskCenterQueue.Add(taskItem.Barcode, taskItem);
                // 立刻加入到放行队列
                StockTaskItem passTaskItem = TaskCenterQueue
                    .Where(s => s.Value.State == StockTaskState.AgvInStcoking)
                    .Select(s=>s.Value).FirstOrDefault();
                if (passTaskItem!=null)
                {
                    AgvInStockPassQueue.Enqueue(passTaskItem);
                    InRobootPickQueue.Enqueue(passTaskItem);
                }
                // 刷新界面列表
                RefreshList();
            }
        }
        #endregion
        

        #region 入库任务队列
        /// <summary>
        /// 是否存在需要入库的任务
        /// </summary>
        /// <returns></returns>
        private bool HasWatingInStockTask()
        {
            lock (StockTaskQueueLocker)
            {
                if (this.InStockTaskQueue != null 
                    && this.InStockTaskQueue.Count(s => s.Value.State == StockTaskState.AgvInStcoking) > 0)
                {
                    return true;
                }
                return false;
            }
        }

        /// <summary>
        /// 出栈入库任务
        /// </summary>
        /// <returns></returns>
        private OPCSetStockTask DequeueInStockTaskQueue()
        {
            lock (StockTaskQueueLocker)
            {
                if (this.HasWatingInStockTask())
                {
                    var task = InStockTaskQueue.FirstOrDefault(s => s.Value.State == StockTaskState.AgvInStcoking).Value;
                    if (task != null)
                    {
                        task.State = StockTaskState.RoadMachineInStocking;
                        RefreshList();
                        return task;
                    }
                }
                return null;
            }
        }


        /// <summary>
        /// 入栈入库任务
        /// </summary>
        /// <returns></returns>
        private void EnqueueInStockTaskQueue(OPCSetStockTask task)
        {
            lock (StockTaskQueueLocker)
            {
                task.State = StockTaskState.AgvInStcoking;
                InStockTaskQueue.Add(task.Barcode, task);
               
                ///将扫描OPC设置为可写
                ///task.SyncSetWriteableFlag(OPCSetInStockTaskOPCGroup);
                OPCCheckInStockBarcodeData.SyncSetWriteableFlag(OPCCheckInstockBarcodeOPCGroup);
                RefreshList();
            }
        }
        #endregion

        /// <summary>
        /// 将数据库中的任务加载到Task中
        /// </summary>
        private void InitQueueAndLoadTaskFromDb()
        {
            AgvInStockPassQueue = new Queue();
            InRobootPickQueue = new Queue();
            TaskCenterQueue = new Dictionary<string, StockTaskItem>();
            InStockTaskQueue = new Dictionary<string, OPCSetStockTask>();
        }

        #region 组件操作
        /// <summary>
        /// 启动组件
        /// </summary>
        private void StartComponents()
        {

        }

        /// <summary>
        /// 关闭运行的组件
        /// </summary>
        private void ShutDownComponents()
        {
            this.DisconnectOPCServer();
            this.StopTimers();
        }

        /// <summary>
        /// 关闭OPC服务
        /// </summary>
        private void DisconnectOPCServer()
        {
            try
            {
                if (ConnectedOPCServer != null)
                {
                    ConnectedOPCServer.Disconnect();
                    ShutDownComponents();
                }
            }
            catch (Exception ex)
            {
                ConnectedOPCServer = null;
                ConnectOPCServerBtn.IsEnabled = true;
                LogUtil.Logger.Error(ex.Message, ex);
                MessageBox.Show(ex.Message);
            }
            finally
            {
                ConnectedOPCServer = null;
                ConnectOPCServerBtn.IsEnabled = true;
            }
        }
        
        /// <summary>
        /// 停止定时器
        /// </summary>
        private void StopTimers()
        {
            if (SetOPCAgvPassTimer != null)
            {
                SetOPCAgvPassTimer.Enabled = false;
                SetOPCAgvPassTimer.Stop();
            }
           if(SetOPCInStockTaskTimer != null)
            {
                SetOPCInStockTaskTimer.Enabled = false;
                SetOPCInStockTaskTimer.Stop();
            }
        }
        #endregion
        
        /// <summary>
        /// 写入入库条码信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void WirteGetPisitionBarBtn_Click(object sender, RoutedEventArgs e)
        {
            if (OPCCheckInStockBarcodeData.CanWrite)
            {
                OPCCheckInStockBarcodeData.ScanedBarcode = ScanedBarCodeTB.Text;
                if (OPCCheckInStockBarcodeData.SyncWrite(OPCCheckInstockBarcodeOPCGroup))
                {
                    MessageBox.Show("条码读取成功");
                }
            }
            else
            {
                MessageBox.Show("存在旧任务，OPC暂不可以写入数据");
            }
        }


        /// <summary>
        /// 读取入库条码信息
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ReadScanedBarCodeBtn_Click(object sender, RoutedEventArgs e)
        {
            if (OPCCheckInStockBarcodeData.CanRead)
            {
                if (OPCCheckInStockBarcodeData.SyncSetWriteableFlag(OPCCheckInstockBarcodeOPCGroup))
                {
                    MessageBox.Show("条码读取成功");
                }
            }
            else
            {
                MessageBox.Show("不存在任务，OPC暂不可以读取数据");
            }

        }
        /// <summary>
        /// 读取任务
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ReadInStockTaskBtn_Click(object sender, RoutedEventArgs e)
        {
            if (OPCSetStockTaskRoadMachine1Data.CanRead)
            {

            }
            else
            {
                MessageBox.Show("不存在任务，OPC暂不可以读取入库数据");
            }
        }

        /// <summary>
        /// 更新显示列表
        /// </summary>
        private void RefreshList()
        {
            this.Dispatcher.Invoke(new Action(() =>
            {
                InStockTaskLB.Items.Clear();
                foreach (var t in TaskCenterQueue.Values)
                {
                    InStockTaskLB.Items.Add(t.ToDisplay());
                }
            }));
        }

        /// <summary>
        /// 关闭窗口时
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            ShutDownComponents();
        }

       
    }
}
