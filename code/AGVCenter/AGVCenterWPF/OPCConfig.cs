﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using AGVCenterWPF.Properties;

namespace AGVCenterWPF
{
   public class OPCConfig
    {
        /// <summary>
        /// 数据库连接
        /// </summary>
        public static string DbString = Settings.Default.dbString;
        /// <summary>
        /// OPC 服务器列表
        /// </summary>
        public static List<string> OPCServers = new List<string>() { "OPC.SimaticNET.DP.1", "OPC.SimaticNET.1", "OPC.SimaticNET.PD.1" };

        /// <summary>
        /// OPC 服务
        /// </summary>
        public static string OPCServer = "OPC.SimaticNET.1";

        public static string OPCNodeName = "192.168.1.105";

        #region OPC组
        /// <summary>
        /// OPCCheckInStockBarcodeOPCGroup , 扫码入库
        /// </summary>
        public static string OPCCheckInStockBarcodeOPCGroupName = "OPCCheckInStockBarcodeOPCGroup";
        public static int OPCCheckInStockBarcodeOPCGroupRate = 10;
        public static int OPCCheckInStockBarcodeOPCGroupDeadBand = 0;

        /// <summary>
        /// OPCAgvInStockPassOPCGroup ，AGV 放行
        /// </summary>
        public static string OPCAgvInStockPassOPCGroupName = "OPCAgvInStockPassOPCGroup";
        public static int OPCAgvInStockPassOPCGroupRate = 10;
        public static int OPCAgvInStockPassOPCGroupDeadBand = 0;
        public static int SetOPCAgvInStockPassTimerInterval = 100;


        /// <summary>
        /// OPCSetInStockTaskOPCGroup
        /// </summary>
        public static string OPCSetInStockTaskOPCGroupName = "OPCSetInStockTaskOPCGroup";
        public static int OPCSetInStockTaskOPCGroupRate = 10;
        public static int OPCSetInStockTaskOPCGroupDeadBand = 0;

        #endregion
    }
}
