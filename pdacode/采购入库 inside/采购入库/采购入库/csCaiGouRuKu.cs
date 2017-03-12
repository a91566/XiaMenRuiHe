using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace CaiGouRuKu
{
    public partial class csCaiGouRuKu : Form
    {
        public csCaiGouRuKu(string StrDept, string StrUser, Boolean BOnLine)
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
        private void SaveInDepot(string DDONO)
        {
            string strsql = "select SuprName from Supplier where SuprCode='" + textBox11.Text + "'";
            textBox11.Text = textBox11.Text + "/"+PPDARHPRORETSYS.SQLHelper.QueryForOneField(strsql, "SuprName");
           // DateTime dt = DateTime.Now;
           // string OpeeDT=string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);
            string OpeeDT = PPDARHPRORETSYS.SQLHelper.GetSysDateTime();
            string exsql = "insert into MatlInDepotZ (MIDDONO,SuprCode,DepotCode,UserCode,OpeeDT,Tips,State) values('"+
                DDONO + "','" + textBox11.Text + "','" + textBox12.Text + "','" + Func.PublicFuncProc.Globe.ZsbStrUser
                + "','" + OpeeDT + "','" + textBox13.Text + "','Y');";

           // InitProcessBar(true);
            string exsql1 = "";
            for(int j=0;j<listView1.Items.Count;j++)
            {
                exsql1 = exsql1 + "insert into MatlInDepotMX (MIDDONO,MatlCode,MatlLot,MatlQuat,MatlVer,ShefCode,ProeNo,StockQuat,LostUsesDate) values('" +
                DDONO + "','" + listView1.Items[j].SubItems[0].Text + "','" + listView1.Items[j].SubItems[1].Text + "','" + listView1.Items[j].SubItems[2].Text
                + "','" + listView1.Items[j].SubItems[3].Text + "','" + listView1.Items[j].SubItems[4].Text + "','" + listView1.Items[j].SubItems[5].Text +
                "','" + listView1.Items[j].SubItems[2].Text + "','" + Func.PublicFuncProc.GetMatlLostUsesDate(listView1.Items[j].SubItems[0].Text, OpeeDT) + "');";       
            }
            exsql = exsql + exsql1;
            int i = PPDARHPRORETSYS.SQLHelper.ExecuteSql(exsql);
            if (i > 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("保存成功。共插入数据："+i.ToString()+"条");
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
            textBox6.Text = "";
            textBox7.Text = "";
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
            textBox6.Text = "";
            textBox7.Text = "";
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
       

        private void button1_Click(object sender, EventArgs e)
        {
            //打开扫描开关
            button4.Enabled = true;
            button1.Enabled = false;
            tabControl1.SelectedIndex = 1;
            tabControl2.SelectedIndex = 0;
            textBox1.Focus();
        }

        private void csCaiGouRuKu_Load(object sender, EventArgs e)
        {
            textBox12.Text = Func.PublicFuncProc.Globe.ZsbStrDept;
            button1_Click(sender, e);
        }    

        private void button2_Click(object sender, EventArgs e)
        {
            if (Func.PublicFuncProc.MsgBoxOk("确定返回么？"))
            {
                this.Close();
            }

        }     

        private void button3_Click(object sender, EventArgs e)
        {
            if (textBox2.Text == "")
            {
                Func.PublicFuncProc.MsgBoxError("请扫描料号.");
                return;
            }
            if (textBox3.Text == "")
            {
                Func.PublicFuncProc.MsgBoxError("请扫描批次.");
                return;
            }
            if (textBox4.Text == "")
            {
                Func.PublicFuncProc.MsgBoxError("请扫描数量.");
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
            if (booTemp == true)//2013年12月4日 09:10:36 客户那边说批次无法做到唯一性，必须让程序走下去，这里给出提示就好，而不是禁止
            {
                if (Func.PublicFuncProc.MsgBoxOk(textBox2.Text + "批号" + textBox3.Text + "已经存在于列表中,是否继续.") == false)
                {
                    ClearText(false);
                    return;
                }
            }

            #endregion


            #region 检测已经入库

            //2013年12月4日 09:10:36 客户那边说批次无法做到唯一性，必须让程序走下去，这里给出提示就好，而不是禁止

            if (Func.PublicFuncProc.CheckMatlLot(textBox2.Text, textBox3.Text, "MatlInDepotMX", "MatlLot"))
            {
                if (Func.PublicFuncProc.MsgBoxOk(textBox2.Text + "批次[" + textBox3.Text + "]已入库，是否继续？") == false)
                {
                    ClearText(false);
                    if (listView1.Items.Count == 0)
                    {
                        textBox11.Text = "";
                    }
                    return;
                } 
            }
            #endregion

            ListViewItem lvwItem = new ListViewItem(textBox2.Text);//增加代号
            lvwItem.SubItems.Add(textBox3.Text);//批次
            string strQuat = Func.PublicFuncProc.SplitUnitQuat(textBox4.Text);
            lvwItem.SubItems.Add(strQuat);//数量
            lvwItem.SubItems.Add(textBox5.Text);//版次
            lvwItem.SubItems.Add(textBox6.Text);//货架
            lvwItem.SubItems.Add(textBox7.Text);//生产单号
            listView1.Items.Add(lvwItem);
            ClearText(false);
            textBox1.Focus();
        }

        private void button4_Click(object sender, EventArgs e)
        {            
            if (Func.PublicFuncProc.Globe.ZsbBOnLine==false)
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
                Func.PublicFuncProc.MsgBoxInfo("收货仓库不能为空。");
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

            
           // DateTime dt = DateTime.Now;
           // string OpeeDT=string.Format("{0:yyyy-MM-dd}", dt);//2014年3月18日 16:45:06 自动获取服务器时间

            string OpeeDT = PPDARHPRORETSYS.SQLHelper.GetSysDate();
            string Temp = Func.PublicFuncProc.GetDONO(OpeeDT, "MatlInDepotZ", "I");
            if (Temp == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("单号获取失败。");
                return;
            }
            else
            {
                SaveInDepot(Temp);
            }            
        }    

        private void textBox1_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
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
                    textBox4.Text = strCodeInfo[2];
                    textBox3.Text = strCodeInfo[3];
                    textBox5.Text = strCodeInfo[4];
                    textBox6.Text = Func.PublicFuncProc.GetMatlShefCode(strCodeInfo[1]);

                    if (checkBox1.Checked)
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

        private void checkBox2_Click(object sender, EventArgs e)
        {
            textBox2.Enabled = checkBox2.Checked;
            textBox3.Enabled = checkBox2.Checked;
            textBox4.Enabled = checkBox2.Checked;
            textBox5.Enabled = checkBox2.Checked;
            textBox6.Enabled = checkBox2.Checked;
            textBox7.Enabled = checkBox2.Checked;
            textBox1.Focus();
        }

        private void tabControl2_SelectedIndexChanged(object sender, EventArgs e)
        {
            textBox1.Focus();
        }

        private void radioButton2_Click(object sender, EventArgs e)
        {
            textBox1.Enabled = radioButton1.Checked;
            textBox2.Enabled = radioButton2.Checked;
            textBox3.Enabled = radioButton2.Checked;
            textBox4.Enabled = radioButton2.Checked;
            textBox5.Enabled = radioButton2.Checked;
            textBox6.Enabled = radioButton2.Checked;
            textBox7.Enabled = radioButton2.Checked;
            checkBox2.Checked = radioButton1.Checked;
            checkBox3.Enabled = radioButton2.Checked;
        }

        private void radioButton1_Click(object sender, EventArgs e)
        {
            radioButton2_Click(sender,e);
        }

        private void textBox2_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == (Keys)13)
            {
                PPDARHPRORETSYS.WavSound.Play();
                try
                {
                    string TempCode = "";
                    if (checkBox3.Checked == true)
                    {
                        TempCode = Func.PublicFuncProc.ChangeMatlCode(textBox2.Text.Trim(), textBox11.Text.Trim());
                        if (TempCode == "") 
                        {
                            Func.PublicFuncProc.MsgBoxError("错误，查找不到相应信息.");
                            ClearText(false);
                            return;
                        }
                        else
                        {
                            textBox2.Text = TempCode;
                        }
                    }
                    
                    
                    if (textBox11.Text == "") //赋初值
                    {
                        textBox11.Text = Func.PublicFuncProc.GetSuprCode(textBox2.Text);
                    }

                    textBox6.Text = Func.PublicFuncProc.GetMatlShefCode(textBox2.Text);
                    textBox3.Focus();
                    
                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误,请扫描正确的一维码。" + ee.Message);
                    ClearText(false);
                    textBox11.Text = "";
                }
            }
        }

       
     
    }
}