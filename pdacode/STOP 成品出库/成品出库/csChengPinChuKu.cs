/*
 * 
 *   厦门睿和电子有限公司（详情见主程序）
 *   
 *   成品的出库，根据ERP的销货单进行出库
 *   （销货单在ERP数据库，出货前需要先下载ERP的销货单在本系统，然后进行出库）
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

namespace ChengPinChuKu
{
    public partial class csChengPinChuKu : Form
    {
        public csChengPinChuKu(string StrDept, string StrUser, Boolean BOnLine)
        {
            Func.PublicFuncProc.Globe.ZsbStrDept = StrDept;
            Func.PublicFuncProc.Globe.ZsbStrUser = StrUser;
            Func.PublicFuncProc.Globe.ZsbBOnLine = BOnLine;
            InitializeComponent();
        }

        #region 自定义



        private void ClearAll(Boolean b)
        {
            textBox1.Text = "";
            if (b == true)
            {
                textBox11.ReadOnly = false;
                textBox11.Text = "";
                textBox12.Text = "";
                textBox13.Text = "";
                listView1.Items.Clear();
                listView2.Items.Clear();
            }
        }

        private void LoadSellDoc()
        {
            if (textBox11.Text == "")
            {
                Func.PublicFuncProc.MsgBoxError("没有销货单号。");
                textBox11.Focus();
                return;
            }
            //加载生产单主单---------------------------------------------------
            string strsql = "select CustCode,DeptCode from ERPSellDocZ where ERPSDNO='" + textBox11.Text + "'";
            DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(strsql);
            if (ds.Tables[0].Rows.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxError("销货单号[" + textBox11.Text + "]不存在，或者还未下载。");
                textBox11.Text = "";
                textBox11.Focus();
                return;
            }
            DataRow drs = ds.Tables[0].Rows[0];
            textBox12.Text = drs["CustCode"].ToString().Trim();
            textBox13.Text = drs["DeptCode"].ToString().Trim();

            //加载生产单明细---------------------------------------------------
            string strsql1 = "select EndProtCode,EndProtName,EndProtQuat,EndProtQuatAlreadyOut,DepotCode,UNIT from ERPSellDocMX where ERPSDNO='" + textBox11.Text + "'";
            DataSet ds1 = PPDARHPRORETSYS.SQLHelper.Query(strsql1);
            foreach (DataRow drs1 in ds1.Tables[0].Rows)
            {
                ListViewItem lvwItem1 = new ListViewItem(drs1["EndProtCode"].ToString().Trim());//品号

                lvwItem1.SubItems.Add(drs1["EndProtName"].ToString().Trim());//品名

                lvwItem1.SubItems.Add(drs1["EndProtQuat"].ToString().Trim());//应出数量

                lvwItem1.SubItems.Add(drs1["EndProtQuatAlreadyOut"].ToString().Trim());//已经出库数量

                lvwItem1.SubItems.Add(drs1["DepotCode"].ToString().Trim());//数量

                lvwItem1.SubItems.Add(drs1["UNIT"].ToString().Trim());//版次                

                listView2.Items.Add(lvwItem1);
            }
            textBox11.ReadOnly = true;
            button1.Enabled = true;
        }

        /// <summary>
        /// 保存出库
        /// </summary>
        /// <param name="DDONO"></param>
        private void SaveMatlInPore(string DDONO)
        {
            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);

            string exsql = "insert into MatlInProeZ (MIPDONO,ProeNo,DeptCode,UserCode,OpeeDT,MOPType,State) values('" +
                DDONO + "','" + textBox11.Text + "','" + textBox12.Text + "','" + Func.PublicFuncProc.Globe.ZsbStrUser
                + "','" + OpeeDT + "','生产出库',','Y');";


            string exsql1 = "";
            string Temp = "";
            for (int j = 0; j < listView1.Items.Count; j++)
            {
                exsql1 = exsql1 + "insert into MatlInProeMX (MIPDONO,MatlCode,MatlLot,MatlQuat,MatlVer,OverQuat) values('" +
                DDONO + "','" + listView1.Items[j].SubItems[0].Text + "','" + listView1.Items[j].SubItems[4].Text + "','" + listView1.Items[j].SubItems[5].Text
                + "','" + listView1.Items[j].SubItems[6].Text + "','" + listView1.Items[j].SubItems[7].Text + "');";  //插入出库明细

                Temp = Func.PublicFuncProc.DownStockQuat(listView1.Items[j].SubItems[0].Text, listView1.Items[j].SubItems[4].Text, listView1.Items[j].SubItems[5].Text); //减库存
                if (Temp == "")
                {
                    Func.PublicFuncProc.MsgBoxError("对不起,库存操作失败，单子无法完成出库。");
                    break;
                }
                else
                {
                    exsql1 = exsql1 + Temp;
                }
            }
            exsql = exsql + exsql1;
            int i = PPDARHPRORETSYS.SQLHelper.ExecuteSql(exsql);
            if (i > 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("保存成功。共插入数据：" + i.ToString() + "条");
                ClearAll(true);
                return;
            }
            else
            {
                Func.PublicFuncProc.MsgBoxError("对不起,保存失败。");
            }

        }

        /// <summary>
        /// 验证是否完全扫描
        /// </summary>
        /// <returns></returns>
        private Boolean CheckScanAllOrNo()
        {
            string strMatlCode = "";
            double dNeedOut = 0;
            double dOut = 0;
            bool bTemp = true;

            for (int i = 0; i < listView2.Items.Count; i++)
            {
                strMatlCode = listView2.Items[i].SubItems[0].Text;//料号
                dNeedOut = Convert.ToDouble(listView2.Items[i].SubItems[3].Text);//应该出的数量
                dNeedOut = 0;//已经出库的数量

                for (int j = 0; j < listView1.Items.Count; j++)
                {
                    if (strMatlCode == listView2.Items[i].SubItems[0].Text)
                    {
                        dOut = dOut + Convert.ToDouble(listView2.Items[i].SubItems[3].Text);
                    }
                }
                if (dOut < dNeedOut)//现在出库数量 小于 应该出的数量 说明没有完全出库
                {
                    bTemp = false;
                    break;
                }
            }

            return bTemp;
        }

        /// <summary>
        /// 检查出库的数量
        /// </summary>
        /// <param name="EndProtCode">品番</param>
        /// <param name="iNowQuat">现在的数量</param>
        /// <returns></returns>
        private Boolean CheckEndPortQuat(string EndProtCode, int iNowQuat)
        {
            //检查数量是否大于出库数量
            Boolean booTemp = false;
            int iNeedIn = 0;//应该出的数量
            int iAlreadyIn = 0;//已经出的数量
            int iNowIn = 0;//现在要出库的数量

            for (int i = 0; i < listView2.Items.Count ;i++)
            {
                if (listView2.Items[i].SubItems[0].Text == EndProtCode)//品番相同的
                {
                    iNeedIn = Convert.ToInt32(listView2.Items[i].SubItems[2].Text);
                    iAlreadyIn = Convert.ToInt32(listView2.Items[i].SubItems[3].Text);
                    break;
                }
            }
            for (int i = 0; i < listView1.Items.Count ; i++)
            {
                if (listView1.Items[i].SubItems[0].Text == EndProtCode)//品番相同的
                {
                    iNowIn = iNowIn + Convert.ToInt32(listView1.Items[i].SubItems[2].Text);
                }
            }

            iAlreadyIn = iAlreadyIn + iNowIn + iNowQuat;
            if (iAlreadyIn > iNeedIn)
            {
                booTemp = true;//不能继续操作了
            }
            return booTemp;
        }

        /// <summary>
        /// 检查是否在库
        /// </summary>
        /// <param name="EndProtLot"></param>
        /// <returns></returns>
        private Boolean CheckEndPortLotInDepot(string EndProtLot)
        {

            Boolean booTemp = true;
            string strsql = "select id from EndProtInDepotMX where  InDepot='Y' and EndProtLot='" + textBox1.Text + "'";
            int ii = PPDARHPRORETSYS.SQLHelper.GetDataCount(strsql);
            if (ii == 0)
            {
                booTemp = false;
            }
            return booTemp;
        }

        /// <summary>
        /// 保存出库
        /// </summary>
        /// <param name="DDONO"></param>
        private void SaveEndPortInCust(string DDONO)
        {
            /*
             * 一、插入主表
             * 二、插入明细表
             * 三、更改销货单明细表的已出库数量
             * 四、根据批次更改货物（入库明细表）的在库情况  
             */


            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);

            string exsql = "insert into EndProtInCustZ (EPICDONO,ERPSDNO,OpeeDT,UserCode,State) values('" +
                DDONO + "','" + textBox11.Text + "','" + OpeeDT + "','" + Func.PublicFuncProc.Globe.ZsbStrUser + "','Y');";

            
            string exsql1 = "";
            string exsql2 = "";
            string exsql3 = "";
            for (int j = 0; j < listView1.Items.Count; j++)
            {
                exsql1 = exsql1 + "insert into EndProtInCustMX (EPICDONO,EndProtLot) values('" + DDONO + "','" + listView1.Items[j].SubItems[1].Text + "');";  //插入入库明细 
             
                exsql2 = exsql2 + "update ERPSellDOCMX  set EndProtQuatAlreadyOut=EndProtQuatAlreadyOut+" + listView1.Items[j].SubItems[2].Text +
                    " where EndProtCode='" + listView1.Items[j].SubItems[0].Text + "' and ERPSDNO='" + textBox11.Text + "';";  //更改已出库数量  

                exsql3 = exsql3 + "update EndProtInDepotMX  set InDepot='N' where EndProtLot='" + listView1.Items[j].SubItems[1].Text + "';";  //在库情况 
            }

            exsql = exsql + exsql1 + exsql2 + exsql3;
            int i = PPDARHPRORETSYS.SQLHelper.ExecuteSql(exsql);
            if (i > 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("保存成功。共操作数据：" + i.ToString() + "条");
                ClearAll(true);
                return;
            }
            else
            {
                Func.PublicFuncProc.MsgBoxError("对不起,保存失败。");
            }

        }

        #endregion

        private void button2_Click(object sender, EventArgs e)
        {
            if (Func.PublicFuncProc.MsgBoxOk("确定返回么？"))
            {
                this.Close();
            }
        }

        private void textBox11_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == (Keys)13)
            {
                if (Func.PublicFuncProc.Globe.ZsbBOnLine == false)
                {
                    Func.PublicFuncProc.MsgBoxError("当前为离线状态,无法加载单据.");
                    return;
                }
                if (textBox11.ReadOnly == true)//取消
                {
                    if (Func.PublicFuncProc.MsgBoxOk("取消该销货单的出库么?"))
                    {
                        ClearAll(true);
                    }
                }
                else
                {
                    LoadSellDoc();
                }
            }
        }

        private void csChengPinChuKu_Load(object sender, EventArgs e)
        {
            textBox11.Focus();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            button3.Enabled = true;
            button1.Enabled = false;
            tabControl1.SelectedIndex = 1;
            textBox1.Focus();
        }

        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == (Keys)13)
            {
                PPDARHPRORETSYS.WavSound.Play();

                if (textBox11.Text == "")
                {
                    Func.PublicFuncProc.MsgBoxInfo("请先导入销货单.");
                    tabControl1.SelectedIndex = 0;
                    ClearAll(false);
                    textBox11.Focus();
                    return;
                }
                #region 检验批次是否在库 
                if (CheckEndPortLotInDepot(textBox1.Text) == false)
                {
                    Func.PublicFuncProc.MsgBoxInfo("批号不存在或者没有库存.");
                    ClearAll(false);
                    textBox1.Focus();
                    return;
                }
                #endregion              

                #region 根据批次获取成品信息

                string strsql = "select EndProtCode,EndProtQuat,CustCode,EndProtVer,OrderNo,Tips from EndProtBarCode where  EndProtLot='" + textBox1.Text + "'";
                DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(strsql);
                if (ds.Tables[0].Rows.Count == 0)
                {
                    Func.PublicFuncProc.MsgBoxError("根据标签打印记录，不存在批次[" + textBox1.Text + "]。");
                    textBox1.Text = "";
                    textBox1.Focus();
                    return;
                }

                DataRow drs = ds.Tables[0].Rows[0];
                string EndProtCode = drs["EndProtCode"].ToString().Trim();
                string EndProtQuat = drs["EndProtQuat"].ToString().Trim();
                string CustCode = drs["CustCode"].ToString().Trim();

                if (CustCode != textBox12.Text)
                {
                    Func.PublicFuncProc.MsgBoxError("根据标签打印记录，批次[" + textBox1.Text + "]不是出库给客户[" + textBox12.Text + "]。");
                    textBox1.Text = "";
                    textBox1.Focus();
                    return;
                }

                #endregion

                #region 检验是不是属于此出库单的品番
                Boolean booTemp = false;
                if (listView2.Items.Count > 0)
                {
                    for (int i = 0; i < listView2.Items.Count; i++)
                    {
                        if (listView2.Items[i].SubItems[0].Text == EndProtCode)//品番相同的
                        {
                            booTemp = true;
                            break;
                        }
                    }
                    if (booTemp == false)
                    {
                        Func.PublicFuncProc.MsgBoxInfo("品番[" + EndProtCode + "]不属于此出库单,请勿再扫描.");
                        ClearAll(false);
                        return;
                    }
                }
                #endregion

                #region 检验是否完全出库  
                if (CheckEndPortQuat(EndProtCode, Convert.ToInt16(EndProtQuat)) == true)
                {
                    Func.PublicFuncProc.MsgBoxInfo("应出数量已经够了,请勿再扫描.");
                    ClearAll(false);
                    textBox1.Focus();
                    return;
                }
                #endregion                       

                #region 检验批次是否已经扫描
                booTemp = false;
                if (listView1.Items.Count > 0)
                {
                    for (int i = 0; i < listView1.Items.Count; i++)
                    {
                        if (listView1.Items[i].SubItems[1].Text == textBox1.Text)//批次相同的
                        {
                            booTemp = true;
                            break;
                        }
                    }
                    if (booTemp == true)
                    {
                        Func.PublicFuncProc.MsgBoxInfo("批号[" + textBox1.Text + "]已经存在,请勿再扫描.");
                        ClearAll(false);
                        return;
                    }
                }
                #endregion

                #region 插入数据

                try
                {
                    ListViewItem lvwItem = new ListViewItem(EndProtCode);//品番
                    lvwItem.SubItems.Add(textBox1.Text);//批次
                    lvwItem.SubItems.Add(EndProtQuat);//数量               
                    listView1.Items.Add(lvwItem);
                    textBox1.Text = "";
                    textBox1.Focus();

                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误。" + ee.Message);
                    ClearAll(false);
                }
                #endregion
            }



        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (listView1.Items.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("没有可保存的内容。");
                return;
            }

            //if (CheckEndPortQuat() == true)
            //{
            //    Func.PublicFuncProc.MsgBoxInfo("入库数量大于生产数量,请删除部分数据.");
            //    ClearAll(false);
            //    textBox11.Focus();
            //    return;
            //}

            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd}", dt);
            string Temp = Func.PublicFuncProc.GetDONO(OpeeDT, "EndProtInCustZ", "Q");
            if (Temp == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("单号获取失败。");
                return;
            }
            else
            {
                SaveEndPortInCust(Temp);
            } 
        }
    }
}