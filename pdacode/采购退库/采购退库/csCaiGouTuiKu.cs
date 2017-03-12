using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace CaiGouTuiKu
{
    public partial class csCaiGouTuiKu : Form
    {   

        public csCaiGouTuiKu(string StrDept, string StrUser, Boolean BOnLine)
        {
            Func.PublicFuncProc.Globe.ZsbStrDept = StrDept;
            Func.PublicFuncProc.Globe.ZsbStrUser = StrUser;
            Func.PublicFuncProc.Globe.ZsbBOnLine = BOnLine;
            InitializeComponent();
        }

        #region 自定义

        /// <summary>
        /// 保存入库信息
        /// </summary>
        /// <param name="MID_DONO"></param>
        private void SaveInSupr(string DDONO)
        {
            string strsql = "select SuprName from Supplier where SuprCode='" + textBox11.Text + "'";
            textBox11.Text = textBox11.Text + "/" + PPDARHPRORETSYS.SQLHelper.QueryForOneField(strsql, "SuprName");
            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);

            string exsql = "insert into MatlInSuprZ (MISDONO,SuprCode,DepotCode,UserCode,OpeeDT,Tips,State) values('" +
                DDONO + "','" + textBox11.Text + "','" + textBox12.Text + "','" + Func.PublicFuncProc.Globe.ZsbStrUser
                + "','" + OpeeDT + "','" + textBox13.Text + "','Y');";

            // InitProcessBar(true);
            string exsql1 = "";
            string exsql2 = "";//操作库存的
            for (int j = 0; j < listView1.Items.Count; j++)
            {
                exsql1 = exsql1 + "insert into MatlInSuprMX (MISDONO,MatlCode,MatlLot,MatlQuat,MatlVer) values('" +
                DDONO + "','" + listView1.Items[j].SubItems[0].Text + "','" + listView1.Items[j].SubItems[1].Text + "','" + listView1.Items[j].SubItems[2].Text
                +  "','" + listView1.Items[j].SubItems[3].Text + "');";
                exsql2 = exsql2 +Func.PublicFuncProc.DownStockQuat(listView1.Items[j].SubItems[0].Text, listView1.Items[j].SubItems[1].Text, listView1.Items[j].SubItems[2].Text);
            }
            exsql = exsql + exsql1 + exsql2;
            int i = PPDARHPRORETSYS.SQLHelper.ExecuteSql(exsql);
            if (i > 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("保存成功。共操作数据：" + i.ToString() + "条");
                ClearText(true);
                return;
            }
            else
            {
                Func.PublicFuncProc.MsgBoxError("对不起,保存失败。");
            }
        }

        private void ClearText(Boolean bAll)
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";
            textBox5.Text = "";
            if (bAll)
            {
                textBox11.Text = "";
                textBox13.Text = "";
                listView1.Items.Clear();
            }
        }

        /// <summary>
        /// 解析条码
        /// </summary>
        private void JieXiBarCode()
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";
            textBox5.Text = "";
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

        #endregion

        private void button2_Click(object sender, EventArgs e)
        {
            if (Func.PublicFuncProc.MsgBoxOk("确定返回么？"))
            {
                this.Close();
            }
        }

        private void csCaiGouTuiKu_Load(object sender, EventArgs e)
        {
            textBox12.Text = Func.PublicFuncProc.Globe.ZsbStrDept;
            button1_Click(sender, e);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //打开扫描开关
            button4.Enabled = true;
            button1.Enabled = false;
            tabControl1.SelectedIndex = 1;
            tabControl2.SelectedIndex = 0;
            textBox1.Focus();
        }

        private void textBox1_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == (Keys)13)
            {
                PPDARHPRORETSYS.WavSound.Play();
                try
                {
                    string[] strCodeInfo = Func.PublicFuncProc.SplitStr(textBox1.Text.Trim(), ",");
                    string strSuprCode = strCodeInfo[0];
                    if (textBox11.Text != "") //判断是否一样
                    {
                        if (textBox11.Text != strSuprCode)
                        {
                            Func.PublicFuncProc.MsgBoxError("错误，此材料供应商与之前扫描的材料供应商不同，请按供应商入库");
                            ClearText(false);
                            textBox11.Text = "";
                            return;
                        }
                    }
                    else if (textBox11.Text == "") //赋初值
                    {
                        textBox11.Text = strSuprCode;
                    }
                    textBox2.Text = strCodeInfo[1];
                    textBox4.Text = Func.PublicFuncProc.SplitUnitQuat(strCodeInfo[2]);                    
                    textBox3.Text = strCodeInfo[3];
                    textBox5.Text = strCodeInfo[4];


                    if (checkBox1.Checked == true)
                    {
                        button3_Click(sender, e);
                    }                    
                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误,请扫描正确的二维码。" + ee.Message);
                    ClearText(false);
                    textBox11.Text = "";
                }
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (textBox2.Text == "")
            {
                return;
            }

            #region 检测已经扫描
            Boolean booTemp = false;
            for (int i = 0; i < listView1.Items.Count; i++)
            {
                string strTemp = listView1.Items[i].SubItems[0].Text;//料号
                if (strTemp == textBox2.Text)//有相同的
                {
                    string strTemp1 = listView1.Items[i].SubItems[1].Text;//批号
                    if (strTemp1 == textBox3.Text)//有相同的
                    {
                        booTemp = true;
                        break;
                    }
                }
            }
            if (booTemp == true)
            {
                Func.PublicFuncProc.MsgBoxInfo(textBox2.Text + "批号" + textBox3.Text + "已经存在于列表中,请勿再扫描.");
                ClearText(false);
                return;
            }

            #endregion

            #region 检测是否存在库存

            if (Func.PublicFuncProc.CheckMatlBarCode(textBox2.Text, textBox3.Text, textBox4.Text)==false)
            {
                Func.PublicFuncProc.MsgBoxError(textBox2.Text + "批次[" + textBox3.Text + "]条码信息不正确！");
                ClearText(false);
                if (listView1.Items.Count == 0)
                {
                    textBox11.Text = "";
                }
                return;
            }
            #endregion

            #region 插入数据
            ListViewItem lvwItem = new ListViewItem(textBox2.Text);//增加代号
            lvwItem.SubItems.Add(textBox3.Text);//批次
            lvwItem.SubItems.Add(textBox4.Text);//数量
            lvwItem.SubItems.Add(textBox5.Text);//版次
            listView1.Items.Add(lvwItem);
            #endregion

            ClearText(false);
            textBox1.Focus();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (Func.PublicFuncProc.Globe.ZsbBOnLine == false)
            {
                Func.PublicFuncProc.MsgBoxInfo("当前为离线状态,无法完成保存操作。");
                return;
            }
            if (textBox11.Text == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("供应商不能为空。");
                textBox11.Focus();
                return;
            }
            if (textBox12.Text == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("发货仓库不能为空。");
                textBox12.Focus();
                return;
            }
            if (listView1.Items.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("没有可保存的内容。");
                return;
            }
            //InitProcessBar(true);
            Func.PublicFuncProc.Loading(true);


            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd}", dt);
            string Temp = Func.PublicFuncProc.GetDONO(OpeeDT, "MatlInSuprZ", "T");
            if (Temp == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("单号获取失败。");
                return;
            }
            else
            {
                SaveInSupr(Temp);
            }   
        }
            
    }
}