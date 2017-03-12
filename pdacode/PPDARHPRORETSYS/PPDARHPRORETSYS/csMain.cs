using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using YuanLiaoPanDian;
using CaiGouRuKu;
using FaLiaoChuKu;
using ChengPinChuKu;
using CaiGouTuiKu;
using BuLiangPinDengJi;

using System.Runtime.InteropServices;
using System.IO;
using Microsoft.Win32;
using System.Net;
using System.Reflection;

namespace PPDARHPRORETSYS
{
    public partial class csMain : Form
    {
        public csMain()
        {
            InitializeComponent();
        }

        #region 修改系统时间
        // [StructLayout(LayoutKind.Sequential)]
        public struct SYSTEMTIME
        {
            public ushort wYear;
            public ushort wMonth;
            public ushort wDayOfWeek;
            public ushort wDay;
            public ushort wHour;
            public ushort wMinute;
            public ushort wSecond;
            public ushort wMilliseconds;
        }

        [DllImport("coredll.dll")]
        private static extern bool SetLocalTime(ref SYSTEMTIME lpSystemTime);

        [DllImport("coredll.dll")]
        private static extern bool GetLocalTime(ref SYSTEMTIME lpSystemTime);

        public void SetSysTime(DateTime date)
        {
            SYSTEMTIME lpTime = new SYSTEMTIME();
            lpTime.wYear = Convert.ToUInt16(date.Year);
            lpTime.wMonth = Convert.ToUInt16(date.Month);
            lpTime.wDay = Convert.ToUInt16(date.Day);
            lpTime.wHour = Convert.ToUInt16(date.Hour);
            lpTime.wMinute = Convert.ToUInt16(date.Minute);
            lpTime.wSecond = Convert.ToUInt16(date.Second);
            SetLocalTime(ref lpTime);
        }

        #endregion
        
        #region 自定义函数

        /// <summary>
        /// 加载图标
        /// </summary>
        private void LoadListItem()
        {
            ListViewItem lvwItem0 = new ListViewItem();
            lvwItem0.Text = "采购入库";
            lvwItem0.ImageIndex = 0;
            listView1.Items.Add(lvwItem0);


            ListViewItem lvwItem1 = new ListViewItem();
            lvwItem1.Text = "采购退库";
            lvwItem1.ImageIndex = 1;
            listView1.Items.Add(lvwItem1);


            ListViewItem lvwItem2 = new ListViewItem();
            lvwItem2.Text = "前工发料";
            lvwItem2.ImageIndex = 2;
            listView1.Items.Add(lvwItem2);

            ListViewItem lvwItem9 = new ListViewItem();
            lvwItem9.Text = "后工发料";
            lvwItem9.ImageIndex = 2;
            listView1.Items.Add(lvwItem9);


            ListViewItem lvwItem3 = new ListViewItem();
            lvwItem3.Text = "非生产领料";
            lvwItem3.ImageIndex = 3;
            listView1.Items.Add(lvwItem3);


            ListViewItem lvwItem4 = new ListViewItem();
            lvwItem4.Text = "生产补料";
            lvwItem4.ImageIndex = 4;
            listView1.Items.Add(lvwItem4);


            ListViewItem lvwItem5 = new ListViewItem();
            lvwItem5.Text = "成品入库";
            lvwItem5.ImageIndex = 5;
            listView1.Items.Add(lvwItem5);

            ListViewItem lvwItem6 = new ListViewItem();
            lvwItem6.Text = "成品出库";
            lvwItem6.ImageIndex = 1;
            listView1.Items.Add(lvwItem6);


            ListViewItem lvwItem7 = new ListViewItem();
            lvwItem7.Text = "原料盘点";
            lvwItem7.ImageIndex = 6;
            listView1.Items.Add(lvwItem7);

            ListViewItem lvwItem8 = new ListViewItem();
            lvwItem8.Text = "不良品登记";
            lvwItem8.ImageIndex = 8;
            listView1.Items.Add(lvwItem8);


            //ListViewItem lvwItem10 = new ListViewItem();
            //lvwItem10.Text = "内部原料标签入库";
            //lvwItem10.ImageIndex = 0;
            //listView1.Items.Add(lvwItem10);


            ListViewItem lvwItem11 = new ListViewItem();
            lvwItem8.Text = "原料标签验证";
            lvwItem8.ImageIndex = 9;
            listView1.Items.Add(lvwItem11);

            ListViewItem lvwItem99 = new ListViewItem();
            lvwItem99.Text = "退出系统";
            lvwItem99.ImageIndex = 6;
            listView1.Items.Add(lvwItem99);

        }

        /// <summary>
        /// 初始化主窗体
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void InitForm()
        {
            button1.Text = Func.PublicFuncProc.Globe.ZsbStrUser;
            button2.Text = Func.PublicFuncProc.Globe.ZsbStrDept;
            Boolean b1 = Func.PublicFuncProc.Globe.ZsbBOnLine;
            if (b1)
            {
                //label1.Text = Func.PublicFuncProc.Globe.ZsbStrUserName;
                //label2.Text = "在线";
                button99.Text = "在线";
            }
            else
            {
                //label2.Text = "离线";
                button99.Text = "离线";
            }
        }

        /// <summary>
        /// 初始化进度条 //不能在线程里操作
        /// </summary>
        /// <param name="b"></param>
        private void InitProcessBar(Boolean b)
        {
            progressBar1.Visible = b;
            if (b)
            {
                progressBar1.Value = 0;
                for (int i = 0; i < 100; i++)
                {
                    progressBar1.Value = progressBar1.Value + 1;
                }
                progressBar1.Visible = false;
            }

        }

        //实时获取权限
        private int TheUNPower(string FuncName)
        {
            string exsql = "declare @out int  exec @out=ZP_PDA_TheUNPower ";
            exsql = exsql + "'" + Func.PublicFuncProc.Globe.ZsbStrUserCode + "',";
            exsql = exsql + "'" + FuncName + "'";
            exsql = exsql + " select @out outvalue";
            string temp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(exsql, "outvalue");//outvalue 是写在存储过程里的
            return Convert.ToInt16(temp);
        }

        #endregion

        private void csMain_Load(object sender, EventArgs e)
        {
            LoadListItem();
            InitForm();

            if (Func.PublicFuncProc.Globe.ZsbBOnLine == true)
            {
                string str = SQLHelper.GetSysDateTime();
                SetSysTime(Convert.ToDateTime(str));
            }
            Func.PublicFuncProc.ChangePDAOnLine(1);
            Func.PublicFuncProc.AddPDA_Operlog("登录");
        }

        #region 选择图标事件
        private void listView1_SelectedIndexChanged(object sender, EventArgs e)
        {           

            ListView lvw = (ListView)sender;

            if (lvw.SelectedIndices.Count <= 0)
            {
                return;
            }

            ListViewItem lvwItem = lvw.Items[lvw.SelectedIndices[0]];

            if (Func.PublicFuncProc.Globe.ZsbBOnLine == true)
            {
                if (TheUNPower(lvwItem.Text) == 1)
                {
                    Func.PublicFuncProc.MsgBoxError("对不起,您没有该功能的操作权限.");
                    return;
                }
            }

            switch (lvwItem.Text)
            {
                case "退出系统":
                    if (Func.PublicFuncProc.MsgBoxOk("确定退出系统么？"))
                    {
                        Func.PublicFuncProc.ChangePDAOnLine(0);
                        Application.Exit();
                    }
                    break;


                case "采购入库":
                    InitProcessBar(true);
                    CaiGouRuKu_inside.csCaiGouRuKu_inside csf_i = new CaiGouRuKu_inside.csCaiGouRuKu_inside(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);                  
                    csf_i.ShowDialog();
                    csf_i.Dispose();
                    break;

                case "采购退库":
                    InitProcessBar(true);
                    CaiGouTuiKu.csCaiGouTuiKu csf2 = new CaiGouTuiKu.csCaiGouTuiKu(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);
                    csf2.ShowDialog();
                    csf2.Dispose();
                    break;

                case "后工发料":
                       InitProcessBar(true);
                       HouGongFaLiao.csHouGongFaLiao csf3 = new HouGongFaLiao.csHouGongFaLiao(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);  
                       csf3.ShowDialog();
                       csf3.Dispose();
                    break;

                case "非生产领料":
                    InitProcessBar(true);
                    FeiShengChanLingLiao.csFeiShengChanLingLiao csf4 = new FeiShengChanLingLiao.csFeiShengChanLingLiao(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);
                    csf4.ShowDialog();
                    csf4.Dispose();
                    break;

                //case "生产补料":
                //    InitProcessBar(true);
                //    ShengChanBuLiao.csShengChanBuLiao csf5 = new ShengChanBuLiao.csShengChanBuLiao(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine); 
                //    csf5.ShowDialog();
                //    csf5.Dispose();
                //    break;

                case "成品入库": 
                    InitProcessBar(true);
                    ChengPinRuKu.csChengPinRuKu csf6 = new ChengPinRuKu.csChengPinRuKu(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);                   
                    csf6.ShowDialog();
                    csf6.Dispose();
                    break;

                case "成品出库":
                    InitProcessBar(true);
                    ChengPinChuKu.csChengPinChuKu csf7 = new csChengPinChuKu(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);   
                    csf7.ShowDialog();
                    csf7.Dispose();
                    break;

                case "原料盘点":
                    InitProcessBar(true);
                    YuanLiaoPanDian.csYuanLiaoPanDian csf8 = new YuanLiaoPanDian.csYuanLiaoPanDian(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);
                    csf8.ShowDialog();
                    csf8.Dispose();
                    break;

                case "不良品登记":
                    InitProcessBar(true);
                    BuLiangPinDengJi.csBuLiangPinDengJi csf9 = new BuLiangPinDengJi.csBuLiangPinDengJi(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);
                    csf9.ShowDialog();
                    csf9.Dispose();
                    break;

                case "前工发料":
                    InitProcessBar(true);
                    QianGongFaLiao.Form1 csf10 = new QianGongFaLiao.Form1(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);
                    csf10.ShowDialog();
                    csf10.Dispose();
                    break;

                case "原料标签验证":
                    InitProcessBar(true);
                    YuanLiaoBiaoQianYanZheng.csYuanLiaoBiaoQianYanZheng csf11 = new YuanLiaoBiaoQianYanZheng.csYuanLiaoBiaoQianYanZheng(Func.PublicFuncProc.Globe.ZsbStrDept, Func.PublicFuncProc.Globe.ZsbStrUser, Func.PublicFuncProc.Globe.ZsbBOnLine);
                    csf11.ShowDialog();
                    csf11.Dispose();
                    break;


                default:
                    MessageBox.Show("待定。。。。");
                    break;
            }
        }
        #endregion

        private void csMain_Closed(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button99_Click(object sender, EventArgs e)
        {
            Func.PublicFuncProc.ChangePDAOnLine(0);
            Application.Exit();
        }

        private void button3_Click(object sender, EventArgs e)
        {

           
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            string fp = @"\Application\Startup\力真(PDA)追溯管理系统.exe";
            string vH = Assembly.LoadFrom(fp).GetName().Version.ToString();

            string exsql = "declare @out int  exec @out=ZP_PDA_isExeUpdateOrNo ";
            exsql = exsql + "'" + vH + "'";
            exsql = exsql + " select @out outvalue";
            string temp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(exsql, "outvalue");

            if (temp != "0")
            {
                timer1.Enabled = false;
                timer2.Enabled = true;
                Func.PublicFuncProc.MsgBoxError("请注意，当前程序已经被管理员限制使用，请更新程序或者联系管理员。 ");
                timer1.Enabled = true;
                timer2.Enabled = false;
                timer2.Interval = 500;
            }
            else
            {
                timer1.Interval = 60000;//一分钟检查一次更新
            }
        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            timer2.Interval = 6000;
            PPDARHPRORETSYS.WavSound.PlayPause();
        }


             
    }
}