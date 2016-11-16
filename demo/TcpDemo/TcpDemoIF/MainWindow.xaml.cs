﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using Brilliantech.Framwork.Utils.ConvertUtil;
using Brilliantech.Framwork.Utils.LogUtil;

namespace TcpDemoIF
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
        private static byte[] buf = new byte[1024];
        Socket SocketTcp = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        private void MakeConnect_Click(object sender, RoutedEventArgs e)
        {
            //   Socket SocketTcp = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            SocketTcp.Connect(new IPEndPoint(IPAddress.Parse("127.0.0.1"), 8080));
            MessageBox.Show("连接服务器成功");

            Thread ClientRecieveThread = new Thread(() =>
            {
                while (true)
                {
                    try
                    {
                        SocketTcp.Receive(buf);
                        string serverResponse = System.Text.Encoding.UTF8.GetString(buf).Trim(("\0".ToCharArray()));
                      
                        byte[] MessageBytes = ScaleConvertor.HexStringToHexByte(serverResponse);
                        string means = readMessage(MessageBytes);
                        MessageBox.Show(means);
                        LogUtil.Logger.Info(means);                     
                        buf = new byte[1024];
                        serverResponse = "";
                    }
                    catch (Exception ee)
                    {
                        MessageBox.Show(ee.Message);
                    }
                }
            });
            ClientRecieveThread.Start();

        }
       

        private void CallingCar_Click(object sender, RoutedEventArgs e)
        {

           
            string name = "FF FF 12 00 01 01 01 01 05 48 65 6C 6C 6F 0A 0B 0B 0B 01  09 08  0A 0B";
            byte[] nameBuf = Encoding.UTF8.GetBytes(name);
            
            SocketTcp.Send(nameBuf,nameBuf.Length,SocketFlags.None);
            name = null;

        }

       

        private void CarArriving_Click(object sender, RoutedEventArgs e)
        {
            string name = "FF FF 07 00 01 06 01 01 09 08  0A 0B";

            byte[] nameBuf = Encoding.UTF8.GetBytes(name);

            SocketTcp.Send(nameBuf, nameBuf.Length, SocketFlags.None);
            name = null;
        }

        private void CarStart_Click(object sender, RoutedEventArgs e)
        {
            string name = "FF FF 07 00 01 03 01 01 09 08  0A 0B";

            byte[] nameBuf = Encoding.UTF8.GetBytes(name);

            SocketTcp.Send(nameBuf, nameBuf.Length, SocketFlags.None);
            name = null;
        }


        public static string readMessage(byte[] MessageBytes)
        {

            //string name = "FF FF 12 00 01 01 01 01 05 48 65 6C 6C 6F 0A 0B 0B 0B 01  09 08  0A 0B";

            // string name = "FF FF 08 00 01 02 01 01 01  09 08  0A 0B";

            //定义指令头
            string head = "FF FF";
            byte[] heads = ScaleConvertor.HexStringToHexByte(head);
            //定义停止位
            string end = "0A 0B";
            byte[] ends = ScaleConvertor.HexStringToHexByte(end);
            //指令类型          
            string TypeMean = "";
            string MessageId = "第 " + MessageBytes[3].ToString() + MessageBytes[4].ToString() + " 条";
            int MessageCount = MessageBytes.Count();
            //定义CRC校验
            byte[] CRC = new byte[2] { MessageBytes[MessageCount - 4], MessageBytes[MessageCount - 3] };
            //是否通过CRC校验
            bool CRCpass = ScaleConvertor.IsCrc16Good(CRC);
            string mean = "";
            string CarNr = "小车编号: ";
            string CallingWorkstation = "呼唤工位为: ";
            string StartWorkstation = "出发点的工位编号为： ";
            string FailureReason = "";

            //判断指令头和指令我ie
            if (MessageBytes[0] == heads[0] && MessageBytes[1] == heads[1] && MessageBytes[MessageCount - 2] == ends[0] && MessageBytes[MessageCount - 1] == ends[1])
            {

                switch (MessageBytes[5])
                {
                    case (byte)01:
                        {

                            TypeMean = "呼唤小车的指令，";
                            string BoxType = "";

                            CallingWorkstation = CallingWorkstation + MessageBytes[7] + ",";
                            string Ctx = "条码内容为:";
                            char CtxContext = new char();
                            string StoreNr = "仓库号" + MessageBytes[MessageCount - 9] + ",";
                            string StoreFloor = "仓库层" + MessageBytes[MessageCount - 8] + ",";
                            string StoreColum = "仓库列" + MessageBytes[MessageCount - 7] + ",";
                            string StoreRow = "仓库排" + MessageBytes[MessageCount - 6] + ",";
                            string Priority = "优先级" + MessageBytes[MessageCount - 5];



                            switch (MessageBytes[6])
                            {
                                case (byte)01: BoxType = "小箱，"; break;
                                case (byte)02: BoxType = "大箱，"; break;
                                default: BoxType = "未知箱型"; break;

                            }
                            for (int i = 1; i <= MessageBytes[8]; i++)
                            {
                                CtxContext = Convert.ToChar(MessageBytes[8 + i]);
                                Ctx += CtxContext;

                            }
                            Ctx += ",";
                            mean = MessageId + TypeMean + BoxType + CallingWorkstation + Ctx + StoreNr + StoreFloor + StoreColum + StoreRow + Priority;

                            return mean;

                        }

                    case (byte)02:
                        {
                            TypeMean = "呼唤小车响应";
                            string SuccessOrFailure = "";
                            CarNr = CarNr + MessageBytes[7] + "。";
                            switch (MessageBytes[6])
                            {
                                case (byte)01:
                                    {
                                        SuccessOrFailure = "指令成功,";
                                        mean = MessageId + TypeMean + SuccessOrFailure + CarNr;

                                    }
                                    break;


                                case (byte)02:
                                    {
                                        SuccessOrFailure = "指令失败，";
                                        switch (MessageBytes[8])
                                        {
                                            case (byte)01: FailureReason = "失败原因：小车未响应"; break;
                                            case (byte)02: FailureReason = "失败原因：工位未设置"; break;
                                            case (byte)255: FailureReason = "失败原因：未知"; break;
                                            default: FailureReason = "失败原因：未知错误"; break;
                                        }
                                        mean = MessageId + TypeMean + SuccessOrFailure + CarNr + FailureReason;
                                    }
                                    break;
                                default: SuccessOrFailure = "未知"; break;

                            }
                            return mean;
                        }


                    case (byte)03:
                        {
                            TypeMean = "小车出发";
                            StartWorkstation = StartWorkstation + MessageBytes[6] + ",";
                            CarNr = CarNr + MessageBytes[7] + "。";
                            mean = MessageId + TypeMean + StartWorkstation + CarNr;
                            return mean;
                        }

                    case (byte)04: TypeMean = "小车出发响应"; break;
                    case (byte)05:
                        {
                            TypeMean = "小车状态";
                            break;
                        }

                    case (byte)06:
                        {
                            TypeMean = "小车到达指令,";
                            CallingWorkstation = CallingWorkstation + MessageBytes[6] + ",";
                            CarNr = CarNr + MessageBytes[7] + "。";
                            mean = MessageId + TypeMean + CallingWorkstation + CarNr;
                            return mean;
                        }
                    case (byte)07: TypeMean = "小车到达响应"; break;
                    case (byte)08: TypeMean = "取消小车呼唤"; break;
                    case (byte)09: TypeMean = "取消小车呼唤响应"; break;
                    case (byte)10: TypeMean = "获出库物库位信息"; break;
                    case (byte)11: TypeMean = "获出库物库位信息响应"; break;
                    case (byte)12: TypeMean = "入库操作完成"; break;
                    case (byte)13: TypeMean = "入库操作完成响应"; break;
                    case (byte)14: TypeMean = "出库"; break;
                    case (byte)15: TypeMean = "出库响应"; break;
                    case (byte)16: TypeMean = "出库操作完成"; break;
                    case (byte)17: TypeMean = "出库操作完成响应"; break;
                    case (byte)18: TypeMean = "码垛（整个托盘）完成"; break;
                    case (byte)19: TypeMean = "码垛（整个托盘）完成响应"; break;
                    case (byte)20: TypeMean = "请求启动或停止设备"; break;
                    case (byte)21: TypeMean = "请求启动或停止设备响应"; break;
                    case (byte)22: TypeMean = "启动或停止设备"; break;
                    case (byte)23: TypeMean = "启动或停止设备响应"; break;
                    case (byte)24: TypeMean = "警报"; break;
                    case (byte)25: TypeMean = "警报响应"; break;
                    default: TypeMean = "未知类型"; break;


                }




            }
            else
            {
                mean = ("指令格式有误");

            }

            return mean;


        }

    }
}
