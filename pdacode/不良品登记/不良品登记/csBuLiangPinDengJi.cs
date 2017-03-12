using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace BuLiangPinDengJi
{
    public partial class csBuLiangPinDengJi : Form
    {        
        public csBuLiangPinDengJi(string StrDept, string StrUser, Boolean BOnLine)
        {
            Func.PublicFuncProc.Globe.ZsbStrDept = StrDept;
            Func.PublicFuncProc.Globe.ZsbStrUser = StrUser;
            Func.PublicFuncProc.Globe.ZsbBOnLine = BOnLine;
            InitializeComponent();
        }

        #region

        /// <summary>
        /// 加载存放位置 
        /// </summary>
        private void LoadPlace()
        {
            if (Func.PublicFuncProc.Globe.ZsbBOnLine == true)
            {
                comboBox1.Items.Clear();
                string strsql1 = "select * from UMPlace order by PlaceCaption";
                DataSet ds1 = PPDARHPRORETSYS.SQLHelper.Query(strsql1);
                foreach (DataRow drs1 in ds1.Tables[0].Rows)
                {
                    comboBox1.Items.Add(drs1["PlaceCaption"].ToString().Trim());
                } 
            }
        }
       
        private void SaveInDB()
        {             
            string exsql1 = "";
            string exsql2 = "";//操作库存的
            for (int j = 0; j < listView1.Items.Count; j++)
            {
                exsql1 = exsql1 + "insert into UMRecord (MatlCode,MatlLot,MatlQuat,MatlVer,SuprCode,Place,OpeeDT,UserCode,State) values('" + listView1.Items[j].SubItems[0].Text + 
                    "','" + listView1.Items[j].SubItems[1].Text + "','" + listView1.Items[j].SubItems[2].Text + "','" + listView1.Items[j].SubItems[3].Text + 
                    "','" + listView1.Items[j].SubItems[4].Text + "','" + listView1.Items[j].SubItems[5].Text + "','" + listView1.Items[j].SubItems[6].Text +
                    "','" + Func.PublicFuncProc.Globe.ZsbStrUser + "','Y');";
                exsql2 = exsql2 + Func.PublicFuncProc.DownStockQuat(listView1.Items[j].SubItems[0].Text, listView1.Items[j].SubItems[1].Text, listView1.Items[j].SubItems[2].Text);
            }
            string exsql = exsql1 + exsql2;
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
            textBox6.Text = "";
            if (bAll)
            {
                comboBox1.SelectedIndex = 0;
                listView1.Items.Clear();
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

        private void button1_Click(object sender, EventArgs e)
        {
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
                    textBox2.Text = strCodeInfo[1];
                    textBox4.Text = Func.PublicFuncProc.SplitUnitQuat(strCodeInfo[2]);
                    textBox3.Text = strCodeInfo[3];
                    textBox5.Text = strCodeInfo[4];
                    textBox6.Text = strCodeInfo[0];
                    if (checkBox1.Checked == true)
                    {
                        button3_Click(sender, e);
                    }                    
                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误,请扫描正确的二维码。" + ee.Message);
                    ClearText(false);                   
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

            if (Func.PublicFuncProc.CheckMatlBarCode(textBox2.Text, textBox3.Text, textBox4.Text) == false)
            {
                Func.PublicFuncProc.MsgBoxError(textBox2.Text + "批次[" + textBox3.Text + "]条码信息不正确！");
                ClearText(false);
                return;
            }
            #endregion

            #region 插入数据
            ListViewItem lvwItem = new ListViewItem(textBox2.Text);//增加代号
            lvwItem.SubItems.Add(textBox3.Text);//批次
            lvwItem.SubItems.Add(textBox4.Text);//数量
            lvwItem.SubItems.Add(textBox5.Text);//版次
            lvwItem.SubItems.Add(textBox6.Text);//供应商
            lvwItem.SubItems.Add(comboBox1.Text);//位置

            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);
            lvwItem.SubItems.Add(OpeeDT);//时间

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
            if (listView1.Items.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("没有可保存的内容。");
                return;
            }
            //InitProcessBar(true);
            Func.PublicFuncProc.Loading(true);
            SaveInDB();  
        }

        private void csBuLiangPinDengJi_Load(object sender, EventArgs e)
        {
            LoadPlace();
            button1_Click(sender, e);
        }

    }
}