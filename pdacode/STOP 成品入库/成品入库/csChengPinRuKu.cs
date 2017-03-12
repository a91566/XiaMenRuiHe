/*
 * 
 *   厦门睿和电子有限公司（详情见主程序）
 *   
 *   成品的入库，根据生产单号进行入库（一个生产单只会生产一类成品）
 *   （需要同步生产单）
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

namespace ChengPinRuKu
{
    public partial class csChengPinRuKu : Form
    {    

        public csChengPinRuKu(string StrDept, string StrUser, Boolean BOnLine)
        {
            Func.PublicFuncProc.Globe.ZsbStrDept = StrDept;
            Func.PublicFuncProc.Globe.ZsbStrUser = StrUser;
            Func.PublicFuncProc.Globe.ZsbBOnLine=BOnLine;
            InitializeComponent();
        }

        #region 自定义

        private void ClearAll(Boolean b)
        {
            textBox1.Text = "";
            if (b == true)
            {
                textBox11.ReadOnly = false;
                textBox11.Text = "MO";
                textBox13.Text = "";
                textBox14.Text = "0";
                textBox15.Text = "0";
                textBox16.Text = "0";
                listView1.Items.Clear();
                button1.Enabled = false;
            }
        }

        private void LoadProduceDoc()
        {
            if (textBox11.Text == "")
            {
                Func.PublicFuncProc.MsgBoxError("没有生产单号。");
                textBox11.Focus();
                return;
            }

            textBox16.Text = Func.PublicFuncProc.GetEndProtQuatInDepotForProe(textBox11.Text).ToString();//已经入库的数量

            //加载生产单主单---------------------------------------------------
            string strsql = "select EndProtCode,EndProtQuat from ERPProduceDocZ where ERPPDNO='" + textBox11.Text + "'";
            DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(strsql);
            if (ds.Tables[0].Rows.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxError("生产单号[" + textBox11.Text + "]不存在，或者还未下载。");
                textBox11.Text = "";
                textBox11.Focus();
                return;
            }
            DataRow drs = ds.Tables[0].Rows[0];
            textBox13.Text = drs["EndProtCode"].ToString().Trim();
            textBox14.Text = drs["EndProtQuat"].ToString().Trim();
            textBox15.Text = "0";

            if (Convert.ToInt16(textBox16.Text) >= Convert.ToInt16(textBox14.Text))
            {  
                Func.PublicFuncProc.MsgBoxError("生产单号[" + textBox11.Text + "]的成品已经全部入库,请勿重复操作。");
                textBox11.Focus();
                ClearAll(true);
                return;
            }

            button1.Enabled = true;
            textBox11.ReadOnly = true;
            button1.Enabled = true;
        }

        private Boolean CheckEndPortQuat()
        {
            //检查数量是否大于出库数量
            Boolean booTemp = false;
            int iNeedIn=0;
            int iAlreadyIn=0;
            iNeedIn = Convert.ToInt32(textBox14.Text);
            iAlreadyIn = Convert.ToInt32(textBox15.Text) + Convert.ToInt32(textBox16.Text);
            if (iAlreadyIn > iNeedIn)
            {
                booTemp = true;//不能继续操作了
            }
            return booTemp; 
        }

        /// <summary>
        /// 保存出库
        /// </summary>
        /// <param name="DDONO"></param>
        private void SaveEndPortInDepot(string DDONO)
        {
            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);
         
            string exsql = "insert into EndProtInDepotZ (EPIDDONO,DepotCode,EndProtCode,ERPPDNO,OpeeDT,UserCode,EndProtQuat,State) values('" +
                DDONO + "','" + textBox12.Text + "','" + textBox13.Text + "','" + textBox11.Text + "','" + OpeeDT
                + "','" + Func.PublicFuncProc.Globe.ZsbStrUser + "','" + textBox15.Text + "','Y');";


            string exsql1 = "";
            for (int j = 0; j < listView1.Items.Count; j++)
            {
                exsql1 = exsql1 + "insert into EndProtInDepotMX (EPIDDONO,EndProtLot) values('" + DDONO + "','" + listView1.Items[j].SubItems[0].Text + "');";  //插入入库明细              
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

        #endregion     

        private void button1_Click(object sender, EventArgs e)
        {
            button1.Enabled = false;
            button2.Enabled = true;
            tabControl1.SelectedIndex = 1;
            textBox1.Focus();
        }

        private void csChengPinRuKu_Load(object sender, EventArgs e)
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
                    if (Func.PublicFuncProc.MsgBoxOk("取消该生产单的出库么?"))
                    {
                        ClearAll(true);
                    }
                }
                else
                {
                    LoadProduceDoc();
                }
            }
        }

        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == (Keys)13)
            {
                PPDARHPRORETSYS.WavSound.Play();

                if (textBox13.Text == "")
                {
                    Func.PublicFuncProc.MsgBoxInfo("请先导入生产单.");
                    tabControl1.SelectedIndex = 0;
                    ClearAll(false);
                    textBox11.Focus();
                    return;
                }
                if (CheckEndPortQuat()== true)
                {
                    Func.PublicFuncProc.MsgBoxInfo("入库数量已大于生产数量,请勿再扫描.");
                    ClearAll(false);
                    textBox11.Focus();
                    return;
                }

                #region 检验批次是否已经扫描
                Boolean booTemp = false;
                if (listView1.Items.Count > 0)
                {                    
                    for (int i = 0; i < listView1.Items.Count; i++)
                    {
                        if (listView1.Items[i].SubItems[0].Text == textBox1.Text)//料号相同的
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

                #region 检验批次是否已经入库
                string temp = "select EndProtInDepotMX.id from EndProtInDepotZ,EndProtInDepotMX where EndProtInDepotMX.EndProtLot=  '" +
                    textBox1.Text.Trim() + "' and  EndProtInDepotZ.ERPPDNO='" + textBox11.Text.Trim() + "' and EndProtInDepotZ.EPIDDONO=EndProtInDepotMX.EPIDDONO";
                int ii = PPDARHPRORETSYS.SQLHelper.GetDataCount(temp);
                if (ii > 0)
                {
                    Func.PublicFuncProc.MsgBoxInfo("批号[" + textBox1.Text + "]已经入库,请勿再扫描.");
                    ClearAll(false);
                    return;
                }  
                #endregion

                #region 插入数据

                try
                {
                    string strsql = "select EndProtQuat,CustCode,EndProtVer,OrderNo,Tips from EndProtBarCode where  EndProtCode=  '" + textBox13.Text + "' and EndProtLot='" + textBox1.Text + "'";
                    DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(strsql);
                    if (ds.Tables[0].Rows.Count == 0)
                    {
                        Func.PublicFuncProc.MsgBoxError("根据标签打印记录，品番[" + textBox13.Text + "]不存在批次[" + textBox1.Text + "]。");
                        textBox1.Text = "";
                        textBox1.Focus();
                        return;
                    }
                    int iInQuat = 0;
                    DataRow drs = ds.Tables[0].Rows[0];
                    ListViewItem lvwItem = new ListViewItem(textBox1.Text);//批次
                    lvwItem.SubItems.Add(textBox13.Text);//品番
                    lvwItem.SubItems.Add(drs["EndProtQuat"].ToString().Trim());//数量
                    iInQuat = Convert.ToInt16(drs["EndProtQuat"].ToString().Trim());
                    iInQuat = iInQuat + Convert.ToInt16(textBox15.Text);
                    textBox15.Text = iInQuat.ToString();
                    lvwItem.SubItems.Add(drs["CustCode"].ToString().Trim());//客户代码
                    lvwItem.SubItems.Add(drs["EndProtVer"].ToString().Trim());//版次
                    lvwItem.SubItems.Add(drs["Tips"].ToString().Trim());//产品说明
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

        private void button222_Click(object sender, EventArgs e)
        {
            if (Func.PublicFuncProc.MsgBoxOk("确定返回么？"))
            {
                this.Close();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (listView1.Items.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("没有可保存的内容。");
                return;
            }

            if (CheckEndPortQuat() == true)
            {
                Func.PublicFuncProc.MsgBoxInfo("入库数量大于生产数量,请删除部分数据.");
                ClearAll(false);
                textBox11.Focus();
                return;
            }       

            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd}", dt);
            string Temp = Func.PublicFuncProc.GetDONO(OpeeDT, "EndProtInDepotZ", "R");
            if (Temp == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("单号获取失败。");
                return;
            }
            else
            {
                SaveEndPortInDepot(Temp);
            } 
        }
    }
}