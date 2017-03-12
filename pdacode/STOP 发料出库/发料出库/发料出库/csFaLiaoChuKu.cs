using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace FaLiaoChuKu //ML
{
    public partial class csFaLiaoChuKu : Form
    {       
        public csFaLiaoChuKu(string StrDept, string StrUser,Boolean BOnLine)
        {
            Func.PublicFuncProc.Globe.ZsbStrDept = StrDept;
            Func.PublicFuncProc.Globe.ZsbStrUser = StrUser;
            Func.PublicFuncProc.Globe.ZsbBOnLine=BOnLine;
            InitializeComponent();
        }

        #region 自定义

        #region 加载生产单

        private void ClearAll(Boolean b)
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";
            textBox5.Text = "";
            if (b == true)
            {
                textBox11.ReadOnly = false;
                textBox11.Text = "";
                textBox12.Text = "";
                textBox13.Text = "";
                textBox14.Text = "";
                listView1.Items.Clear();
                listView2.Items.Clear();
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
            //加载生产单主单---------------------------------------------------
            string strsql = "select ProeDept,EndProtCode,EndProtQuat from ERPProduceDocZ where ERPPDNO='" + textBox11.Text + "'";
            DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(strsql);
            if (ds.Tables[0].Rows.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxError("生产单号[" + textBox11.Text + "]不存在，或者还未下载。");
                textBox11.Text="";
                textBox11.Focus();
                return;
            }
            DataRow drs = ds.Tables[0].Rows[0];
            textBox12.Text = drs["ProeDept"].ToString().Trim();
            textBox13.Text = drs["EndProtCode"].ToString().Trim();
            textBox14.Text = drs["EndProtQuat"].ToString().Trim();

            //加载生产单明细---------------------------------------------------
            string strsql1 = "select MatlCode,OldestMatlLot,MatlName,MatlQuat,MatlQuatAlreadyOut,DepotCode from ERPProduceDocMX where ERPPDNO='" + textBox11.Text + "'";
            DataSet ds1 = PPDARHPRORETSYS.SQLHelper.Query(strsql1);
            foreach (DataRow drs1 in ds1.Tables[0].Rows)
            {
                ListViewItem lvwItem = new ListViewItem(drs1["MatlCode"].ToString().Trim());//增加代号
                ListViewItem lvwItem1 = new ListViewItem(drs1["MatlCode"].ToString().Trim());//不晓得为何要这么做才可以，直接  listView2.Items.Add(lvwItem);会报错

              //  lvwItem.SubItems.Add(drs1["OldestMatlLot"].ToString().Trim());//名称
                lvwItem1.SubItems.Add(drs1["OldestMatlLot"].ToString().Trim());//名称

                lvwItem.SubItems.Add(drs1["MatlName"].ToString().Trim());//名称
                lvwItem1.SubItems.Add(drs1["MatlName"].ToString().Trim());//名称

                lvwItem.SubItems.Add(drs1["DepotCode"].ToString().Trim());//仓库
                lvwItem1.SubItems.Add(drs1["DepotCode"].ToString().Trim());//仓库

                lvwItem.SubItems.Add(drs1["MatlQuat"].ToString().Trim());//应出数量
                lvwItem1.SubItems.Add(drs1["MatlQuat"].ToString().Trim());//应出数量

                lvwItem.SubItems.Add("");//批次
                lvwItem1.SubItems.Add("");//批次

                lvwItem.SubItems.Add("");//数量
                lvwItem1.SubItems.Add("");//数量

                lvwItem.SubItems.Add("");//版次
                lvwItem1.SubItems.Add("");//版次

                lvwItem.SubItems.Add("0");//超待发
                lvwItem1.SubItems.Add("0");//超待发

              //  listView1.Items.Add(lvwItem);
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

            string exsql = "insert into MatlInProeZ (MIPDONO,ERPPDNO,DeptCode,UserCode,OpeeDT,MOPType,State) values('" +
                DDONO + "','" + textBox11.Text + "','" + textBox12.Text + "','" + Func.PublicFuncProc.Globe.ZsbStrUser
                + "','" + OpeeDT + "','后工出库','Y');";

            
            string exsql1 = "";
            string Temp="";
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
                dNeedOut=Convert.ToDouble(listView2.Items[i].SubItems[4].Text);//应该出的数量
                dNeedOut = 0;//已经出库的数量

                for (int j = 0; j < listView1.Items.Count; j++)
                {
                    if (strMatlCode == listView2.Items[i].SubItems[0].Text)
                    {
                        dOut = dOut + Convert.ToDouble(listView2.Items[i].SubItems[4].Text);
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

        #endregion

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
                if (textBox11.ReadOnly==true)//取消
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

        private void button1_Click(object sender, EventArgs e)
        {
            button4.Enabled = true;
            button1.Enabled = false;
            tabControl1.SelectedIndex = 1;
            tabControl2.SelectedIndex = 0;
            textBox1.Focus();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            
            #region 检验有没有数据
            if (listView2.Items.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("请先导入生产单");
                tabControl1.SelectedIndex = 0;
                ClearAll(false);
                textBox11.Focus();
                return;
            }
            if (textBox1.Text == "")
            {
                ClearAll(false);
                return;
            }
            if (textBox2.Text == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("请扫描材料条形码。");
                textBox1.Focus();
                return;
            }
            #endregion         

            
            #region 检验是不是在出库单里的材料

            double dNeedOutCount = 0;//需要出库的数量
            string strMatlName = "";//名称
            string strMatlDepotCode = "";//仓库
            Boolean booTemp = false;
            for (int i = 0; i < listView2.Items.Count; i++)
            {
                string strTemp = listView2.Items[i].SubItems[0].Text;
                if (strTemp == textBox2.Text)//有相同的
                {
                    booTemp = true;
                    dNeedOutCount = Convert.ToDouble(listView2.Items[i].SubItems[4].Text);// 数量在第四列
                    strMatlName = listView2.Items[i].SubItems[2].Text;
                    strMatlDepotCode = listView2.Items[i].SubItems[3].Text;
                    break;
                }
            }
            if (booTemp == false)
            {
                Func.PublicFuncProc.MsgBoxInfo("此条码不属于该出库单,请勿扫描。");
                ClearAll(false);
                return;
            }
            #endregion

            
            #region 检验批次是否已经扫描
            if (listView1.Items.Count > 0)
            {
                booTemp = false;
                for (int i = 0; i < listView1.Items.Count; i++)
                {
                    if (listView1.Items[i].SubItems[0].Text == textBox2.Text)//料号相同的
                    {
                        string strTemp = listView1.Items[i].SubItems[4].Text;//批号
                        if (strTemp == textBox3.Text)//有相同的
                        {
                            booTemp = true;
                            break;
                        }
                    }
                }
                if (booTemp == true)
                {
                    Func.PublicFuncProc.MsgBoxInfo(textBox2.Text + "批号" + textBox3.Text + "已经存在,请勿再扫描.");
                    ClearAll(false);
                    return;
                } 
            }
            
            #endregion

            #region 检验库存
            booTemp = Func.PublicFuncProc.CheckMatlBarCode(textBox2.Text, textBox3.Text, textBox4.Text);
            if (booTemp == false)
            {
                Func.PublicFuncProc.MsgBoxInfo(textBox2.Text + "标签有误，条码数量与库存数量不符合。请更正标签后出库。");
                ClearAll(false);
                return;
            }
            #endregion

            #region 检验过期与否
            booTemp = Func.PublicFuncProc.CheckMatlLotGuoQiOrNo(textBox2.Text, textBox3.Text);
            if (booTemp == true)
            {
                Func.PublicFuncProc.MsgBoxInfo(textBox2.Text + "该批次已过期，禁止出库.");
                ClearAll(false);
                return;
            }
            #endregion 
           
            #region 检验是不是最早的批次(先进先出)
            string strMatlLotFirst = textBox3.Text;
            string strRt = Func.PublicFuncProc.CheckMatlLotOrFirst(textBox2.Text, strMatlLotFirst);
            if (strRt != strMatlLotFirst)
            {
                Func.PublicFuncProc.MsgBoxInfo(textBox2.Text + "存在更早的批号" + strRt + ",请将此先扫描出库.");
                ClearAll(false);
                return;
            }
            #endregion
            
            #region 检验是否已经扫描或者数量够不够
            double DOutA = 0;//已经出库的数量
            for (int i = 0; i < listView1.Items.Count; i++)
            {
                string strTemp = listView1.Items[i].SubItems[0].Text;
                if (strTemp == textBox2.Text)//有相同的
                {
                    DOutA = DOutA + Convert.ToDouble(listView1.Items[i].SubItems[5].Text);
                }
            }
            if (DOutA >= dNeedOutCount)
            {
                Func.PublicFuncProc.MsgBoxInfo("此类材料出库数量已足够,请勿再扫描.");
                ClearAll(false);
                return;
            }
            #endregion
            
            #region 插入出库

            ListViewItem lvwItem = new ListViewItem(textBox2.Text);//增加料号
            lvwItem.SubItems.Add(strMatlName);//名称
            lvwItem.SubItems.Add(strMatlDepotCode);//仓库
            lvwItem.SubItems.Add(dNeedOutCount.ToString());//应出数量
            lvwItem.SubItems.Add(textBox3.Text);//批次
            lvwItem.SubItems.Add(textBox4.Text);//数量
            lvwItem.SubItems.Add(textBox5.Text);//版次

            double DOverCount = 0;
            DOverCount = DOutA+Convert.ToDouble(textBox4.Text) - dNeedOutCount;
            if (DOverCount < 0)
            {
                DOverCount = 0;
            }
            lvwItem.SubItems.Add(DOverCount.ToString());//超待发
            listView1.Items.Add(lvwItem);
            ClearAll(false);
            #endregion
            
        }

        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {

            if (e.KeyCode == (Keys)13)
            {
                #region 条码解析

                PPDARHPRORETSYS.WavSound.Play();
                try
                {
                    string[] strCodeInfo = Func.PublicFuncProc.SplitStr(textBox1.Text.Trim(), ",");
                    string strSuprCode = strCodeInfo[0];

                    if (textBox11.Text == "") //赋初值
                    {
                        textBox11.Text = strSuprCode;
                    }
                    textBox2.Text = strCodeInfo[1];
                    textBox4.Text = Func.PublicFuncProc.SplitUnitQuat(strCodeInfo[2]);//数量
                    textBox3.Text = strCodeInfo[3];
                    textBox5.Text = strCodeInfo[4];
                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误,请扫描正确的二维码。" + ee.Message);
                    ClearAll(false);
                }
            #endregion

                #region 插入数据

                try
                {
                    if (checkBox1.Checked == true)
                    {
                        button3_Click(sender, e);
                    }                    
                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("数据添加错误。" + ee.Message);
                    ClearAll(false);
                }
                #endregion

            }
         }

        private void csFaLiaoChuKu_Load(object sender, EventArgs e)
        {
            textBox11.Focus();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            #region 判断条件（能否入库）
            if (Func.PublicFuncProc.Globe.ZsbBOnLine == false)
            {
                Func.PublicFuncProc.MsgBoxInfo("当前为离线状态,无法完成保存操作。");
                return;
            }
            if (textBox11.Text == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("生产单号不能为空。");
                textBox11.Focus();
                return;
            }
            if (listView1.Items.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("没有可保存的内容。");
                return;
            }
            if (CheckScanAllOrNo() == false)
            {
                Func.PublicFuncProc.MsgBoxInfo("此单还没有完全扫描噢。");
                tabControl1.SelectedIndex = 1;
                tabControl2.SelectedIndex = 0;
                textBox1.Focus();
                return;
            }
            #endregion



            Func.PublicFuncProc.Loading(true);


            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd}", dt);
            string Temp = Func.PublicFuncProc.GetDONO(OpeeDT, "MatlInProeZ", "O");
            if (Temp == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("单号获取失败。");
                return;
            }
            else
            {
                SaveMatlInPore(Temp);
            }  
        }

        private void checkBox2_Click(object sender, EventArgs e)
        {
            textBox2.Enabled = checkBox2.Checked;
            textBox3.Enabled = checkBox2.Checked;
            textBox4.Enabled = checkBox2.Checked;
            textBox5.Enabled = checkBox2.Checked;
        }

        private void tabControl2_SelectedIndexChanged(object sender, EventArgs e)
        {
            textBox1.Focus();
        }

        private void checkBox2_CheckStateChanged(object sender, EventArgs e)
        {

        }

      
      
      
    }
}