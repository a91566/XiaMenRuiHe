/*
 * 
 *   厦门睿和电子有限公司（详情见主程序）
 *   
 *   原料的盘点
 *   首先在PC端生成一个盘点单，然后在PDA根据盘点单号进行操作
 *  
 */

using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace YuanLiaoPanDian
{
    public partial class csYuanLiaoPanDian : Form
    {

        public csYuanLiaoPanDian(string StrDept, string StrUser, Boolean BOnLine)
        {
            Func.PublicFuncProc.Globe.ZsbStrDept = StrDept;
            Func.PublicFuncProc.Globe.ZsbStrUser = StrUser;
            Func.PublicFuncProc.Globe.ZsbBOnLine = BOnLine;
            InitializeComponent();
        }

        #region 自定义

        #region 加载生产单

        private void ClearAll(Boolean b)
        {
            textBox1.Text = "";
            if (b == true)
            {
                textBox11.ReadOnly = false;
                textBox11.Text = "";
                textBox12.Text = "";
                textBox13.Text = "";
                textBox14.Text = "";
                textBox15.Text = "";
                listView1.Items.Clear();
                button4.Enabled = false;
                button1.Enabled = false;
                textBox1.Enabled = false;
            }
        }

        private void LoadPanDianPlan()
        {
            if (textBox11.Text == "")
            {
                Func.PublicFuncProc.MsgBoxError("没有盘点单号。");
                textBox11.Focus();
                return;
            }
            //加载生产单主单---------------------------------------------------
            string strsql = "select OpeeDT,DepotCode,OPUserCode,State from MatlPanDianZ where MPDDONO='" + textBox11.Text + "'";
            DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(strsql);
            if (ds.Tables[0].Rows.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxError("盘点单号[" + textBox11.Text + "]不存在。");
                textBox11.Text = "";
                textBox11.Focus();
                return;
            }
            DataRow drs = ds.Tables[0].Rows[0];
            textBox12.Text = drs["DepotCode"].ToString().Trim();
            textBox13.Text = drs["State"].ToString().Trim();
            textBox14.Text = drs["OPUserCode"].ToString().Trim();
            textBox15.Text = drs["OpeeDT"].ToString().Trim();

            //加载生产单明细---------------------------------------------------
            string strsql1 = "select MatlCode,MatlLot,MatlVer,MatlQuat,ScanStockQuat,State,OpeeDT from MatlPanDianMX where MPDDONO='" + textBox11.Text + "'";
            DataSet ds1 = PPDARHPRORETSYS.SQLHelper.Query(strsql1);
            foreach (DataRow drs1 in ds1.Tables[0].Rows)
            {
                ListViewItem lvwItem = new ListViewItem(drs1["State"].ToString().Trim());//状态

                lvwItem.SubItems.Add(drs1["ScanStockQuat"].ToString().Trim());//扫描数量

                lvwItem.SubItems.Add(drs1["MatlQuat"].ToString().Trim());//库存数

                lvwItem.SubItems.Add(drs1["MatlCode"].ToString().Trim());//料号

                lvwItem.SubItems.Add(drs1["MatlLot"].ToString().Trim());//批次

                lvwItem.SubItems.Add(drs1["MatlVer"].ToString().Trim());//版次

                lvwItem.SubItems.Add(drs1["OpeeDT"].ToString().Trim());//时间

                listView1.Items.Add(lvwItem);
            }
            if (textBox13.Text=="ING")//盘点中才可进行操作
            {
                button1.Enabled = true; 
            }
            textBox11.ReadOnly = true;
        }

        /// <summary>
        /// 保存出库
        /// </summary>
        /// <param name="DDONO"></param>
        private void SavePanDianPlan(string DDONO)
        {
            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);

            string exsql = "update MatlPanDianZ set state='DONE',PDUserCode='" + Func.PublicFuncProc.Globe.ZsbStrUser + "' where MPDDONO='" + DDONO + "';";

            string exsql1 = "";
            string temp1, temp2, temp0;
            for (int j = 0; j < listView1.Items.Count; j++)
            {
                if (listView1.Items[j].SubItems[6].Text == "")//没有盘点到 盘亏
                {
                    temp0 = "盘亏";
                    temp1 = "0";
                    temp2 = ""; 
                }
                else //  有盘点到    盘亏、盘盈、正常
                {
                    temp0 = listView1.Items[j].SubItems[0].Text;
                    temp1 = listView1.Items[j].SubItems[1].Text;
                    temp2 = listView1.Items[j].SubItems[6].Text; 
                }
                exsql1 = exsql1 + "update MatlPanDianMX set ScanStockQuat='" + temp1 + "',State='" + temp0 + "',OpeeDT='" + temp2 +
                    "' where MPDDONO='" + DDONO + "' and MatlCode='" + listView1.Items[j].SubItems[3].Text + "' and MatlLot='" + listView1.Items[j].SubItems[4].Text +
                    "'  and MatlVer='" + listView1.Items[j].SubItems[5].Text + "';";  //更新盘点            
            }
            exsql = exsql + exsql1;
            int i = PPDARHPRORETSYS.SQLHelper.ExecuteSql(exsql);
            if (i > 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("保存成功。共操作数据：" + i.ToString() + "条");
                ClearAll(true);
                return;
            }
            else
            {
                Func.PublicFuncProc.MsgBoxError("对不起,操作失败。");
            }

        }

        /// <summary>
        /// 验证是否完全扫描
        /// </summary>
        /// <returns></returns>
        private Boolean CheckScanAllOrNo()
        {            
            bool bTemp = true;
            for (int i = 0; i < listView1.Items.Count; i++)
            {
                if (listView1.Items[i].SubItems[0].Text=="未盘点")
                {
                    bTemp = false;
                    break;
                }
            }
            return bTemp;
        }

        #endregion

        #endregion

        private void button2_Click(object sender, EventArgs e)
        {
            if (Func.PublicFuncProc.MsgBoxOk("确认退出系统么？"))
            {
                this.Close();
            }
            
        }      

        private void csYuanLiaoPanDian_Load(object sender, EventArgs e)
        {
            textBox12.Text = Func.PublicFuncProc.Globe.ZsbStrDept;
            textBox11.Focus();
        }               

        private void textBox11_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == (Keys)13)
            {
                if (textBox11.ReadOnly == true)//取消
                {
                    if (Func.PublicFuncProc.MsgBoxOk("取消该盘点单的盘点么?"))
                    {
                        ClearAll(true);
                    }
                }
                else
                {
                    LoadPanDianPlan();
                }
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 1;
            button4.Enabled = true;
            textBox1.Enabled = true;
            textBox1.Focus();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (CheckScanAllOrNo() == false)
            {
                if (Func.PublicFuncProc.MsgBoxOk("经检查还有没有扫描到的物品，是否就此提交盘点单。") == false)
                {
                    return;                
                }               
            }
            SavePanDianPlan(textBox11.Text);
        }

        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == (Keys)13)
            {
                #region 条码解析

                PPDARHPRORETSYS.WavSound.Play();
                string strMatlCode = "";
                string strMatlLot = "";
                string strMatlVer = "";
                string strMatlQuat = "";
                int iQuat = 0;//实际数量
                int iScanQuat = 0;//扫描到的数量
                try
                {
                    string[] strCodeInfo = Func.PublicFuncProc.SplitStr(textBox1.Text.Trim(), ",");

                    strMatlCode = strCodeInfo[1];
                    strMatlQuat = Func.PublicFuncProc.SplitUnitQuat(strCodeInfo[2]);//数量
                    iScanQuat = Convert.ToInt16(strMatlQuat);
                    strMatlLot = strCodeInfo[3];
                    strMatlVer = strCodeInfo[4];
                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误,请扫描正确的二维码。" + ee.Message);
                    ClearAll(false);
                    return;
                }
                #endregion

                #region 检验是否在盘点单里的

                Boolean booTemp = false;

                if (listView1.Items.Count > 0)
                {
                    for (int i = 0; i < listView1.Items.Count; i++)
                    {
                        if (listView1.Items[i].SubItems[3].Text == strMatlCode)//料号相同的
                        {
                            if (listView1.Items[i].SubItems[4].Text == strMatlLot)//批号有相同的
                            {
                                booTemp = true;
                                break;
                            }
                        }
                    }
                    if (booTemp == false)
                    {
                        Func.PublicFuncProc.MsgBoxInfo("料号" + strMatlCode + "批号" + strMatlLot + "不属于该盘点计划，请勿扫描。");
                        ClearAll(false);
                        return;
                    }
                }
           
                #endregion

                #region 验证是否已经扫描

                booTemp= true;
                string strOpeeDT = "";
                try
                {
                    if (listView1.Items.Count > 0)
                    {                       
                        for (int i = 0; i < listView1.Items.Count; i++)
                        {
                            if (listView1.Items[i].SubItems[3].Text == strMatlCode)//料号相同的
                            {                                
                                if (listView1.Items[i].SubItems[4].Text == strMatlLot)//批号有相同的
                                {
                                    if (listView1.Items[i].SubItems[0].Text == "未盘点")//批号有相同的
                                    {
                                        booTemp = false;
                                        break;
                                    }
                                    else
                                    {
                                        strOpeeDT = listView1.Items[i].SubItems[6].Text;
                                    }
                                }
                            }
                        }
                        if (booTemp == true)
                        {
                            Func.PublicFuncProc.MsgBoxInfo("料号" + strMatlCode + "批号" + strMatlLot + "已经扫描,扫描时间:" + strOpeeDT);
                            ClearAll(false);
                            return;
                        } 
                    }
                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("数据添加错误。" + ee.Message);
                    ClearAll(false);
                }
                #endregion

                #region 插入数据

                try
                {
                    for (int i = 0; i < listView1.Items.Count; i++)
                    {
                        if (listView1.Items[i].SubItems[3].Text == strMatlCode)//料号相同的
                        {
                            if (listView1.Items[i].SubItems[4].Text == strMatlLot)//批号有相同的
                            {
                                iQuat = Convert.ToInt16(listView1.Items[i].SubItems[2].Text);//数量
                                DateTime dt = DateTime.Now;
                                string OpeeDT = string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);
                                string strState="正常";
                                if (iQuat > iScanQuat)
                                { 
                                    strState="盘亏";
                                }
                                else if (iQuat < iScanQuat)
                                {
                                    strState = "盘盈";
                                }
                                listView1.Items[i].SubItems[0].Text = strState;//状态
                                listView1.Items[i].SubItems[1].Text = strMatlQuat;//扫描到的数量
                                listView1.Items[i].SubItems[6].Text = OpeeDT;//操作时间
                            }
                        }
                    }
                    ClearAll(false);                  
                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("数据添加错误。" + ee.Message);
                    ClearAll(false);
                }
                #endregion

            }
        }

     

       
    }
}