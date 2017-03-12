using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace HouGongFaLiao
{
    public partial class csHouGongFaLiao : Form
    {
        //ERPProduceDocZ -> LZz_ML_MO_FromERP 
        //ERPPDNO -> ML_NO
        //ERPProduceDocMx -> LZm_ML_MO_FromERP
        //ERPZLDH-> MO_NO
        //OccupyERPPDNO ->  OccupyML_NO

        public csHouGongFaLiao(string StrDept, string StrUser, Boolean BOnLine)
        {
            Func.PublicFuncProc.Globe.ZsbStrDept = StrDept;
            Func.PublicFuncProc.Globe.ZsbStrUser = StrUser;
            Func.PublicFuncProc.Globe.ZsbBOnLine=BOnLine;
            InitializeComponent();
        }

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
                listView1.Items.Clear();
                listView2.Items.Clear();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (Func.PublicFuncProc.MsgBoxOk("确定返回么？"))
            {
                this.Close();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            MessageBox.Show(PPDARHPRORETSYS.SQLHelper.GetSysDate());
            MessageBox.Show(PPDARHPRORETSYS.SQLHelper.GetSysTime());
            MessageBox.Show(PPDARHPRORETSYS.SQLHelper.GetSysDateTime());
        }

        private void button5_Click(object sender, EventArgs e)
        {
            string Temp="";
            string TempNO = "";
            int iNo = 0;//为了标识第一个不加逗号
            for (int j = 0; j < listView3.Items.Count; j++)
            {
                if(listView3.Items[j].Checked==true) 
                {
                    TempNO=listView3.Items[j].SubItems[0].Text;
                    if (iNo == 0)
                    {
                        Func.PublicFuncProc.Loading(true);
                        Temp = TempNO;
                        iNo = 1;
                    }
                    else
                    {
                        Temp = Temp + "," + TempNO;
                    }
                    LoadProduceDocMX(TempNO);
                }
            }
            panel2.Visible = false;
            textBox11.Text = Temp;
            textBox11.ReadOnly = true;
            button1.Enabled = true;
        }

        private void LoadProduceDocMX(string TempNo)
        {
            if (TempNo == "")
            {
                Func.PublicFuncProc.MsgBoxError("没有生产单号。");
                return;
            }

            /*
             
            //加载生产单主单---------------------------------------------------
            string strsql = "select ProeDept,EndProtCode,EndProtQuat from LZz_ML_MO_FromERP where ML_NO='" + TempNo + "'";
            DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(strsql);
            if (ds.Tables[0].Rows.Count == 0)
            {
                Func.PublicFuncProc.MsgBoxError("生产单号[" + TempNo + "]不存在，或者还未下载。");
                textBox11.Text = "";
                textBox11.Focus();
                return;
            }
            DataRow drs = ds.Tables[0].Rows[0];
            textBox12.Text = drs["ProeDept"].ToString().Trim();
            textBox13.Text = drs["EndProtCode"].ToString().Trim();
            textBox14.Text = drs["EndProtQuat"].ToString().Trim();

            */

            //加载生产单明细---------------------------------------------------
            string strsql1 = "select MatlCode,OldestMatlLot,MatlName,MatlQuat,MatlQuatAlreadyOut,DepotCode,ShefCode from LZm_ML_MO_FromERP where ML_NO='" + TempNo + "'";
            DataSet ds1 = PPDARHPRORETSYS.SQLHelper.Query(strsql1);
            foreach (DataRow drs1 in ds1.Tables[0].Rows)
            {
                ListViewItem lvwItem = new ListViewItem(drs1["MatlCode"].ToString().Trim());//增加代号
                ListViewItem lvwItem1 = new ListViewItem(drs1["MatlCode"].ToString().Trim());//不晓得为何要这么做才可以，直接  listView2.Items.Add(lvwItem);会报错

                lvwItem.SubItems.Add(drs1["OldestMatlLot"].ToString().Trim());//名称
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

                lvwItem.SubItems.Add(TempNo);//超待发
                lvwItem1.SubItems.Add(TempNo);//超待发

                lvwItem.SubItems.Add(drs1["ShefCode"].ToString().Trim());//货架
                lvwItem1.SubItems.Add(drs1["ShefCode"].ToString().Trim());//货架

                listView1.Items.Add(lvwItem);
              //  listView2.Items.Add(lvwItem1);
            }
        }

        private void csHouGongFaLiao_Load(object sender, EventArgs e)
        {
            string strsql = "select ML_NO from LZz_ML_MO_FromERP where State='正常'";
             DataSet ds1 = PPDARHPRORETSYS.SQLHelper.Query(strsql);
             foreach (DataRow drs1 in ds1.Tables[0].Rows)
             {
                 ListViewItem lvwItem = new ListViewItem(drs1["ML_NO"].ToString().Trim());//增加代号
                 listView3.Items.Add(lvwItem);
             }
        }

        private void radioButton2_Click(object sender, EventArgs e)
        {
            textBox1.Enabled = radioButton1.Checked;
            textBox2.Enabled = radioButton2.Checked;
            textBox3.Enabled = radioButton2.Checked;
            textBox4.Enabled = radioButton2.Checked;
            textBox5.Enabled = radioButton2.Checked;
            checkBox1.Checked = radioButton1.Checked;
            checkBox3.Enabled = radioButton2.Checked;
        }

        private void radioButton1_Click(object sender, EventArgs e)
        {
            radioButton2_Click(sender, e);
        }

        private void checkBox2_CheckStateChanged(object sender, EventArgs e)
        {

        }

        private void checkBox2_Click(object sender, EventArgs e)
        {
            textBox2.Enabled = checkBox2.Checked;
            textBox3.Enabled = checkBox2.Checked;
            textBox4.Enabled = checkBox2.Checked;
            textBox5.Enabled = checkBox2.Checked;
        }

        private void textBox1_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                PPDARHPRORETSYS.WavSound.Play();
                try
                {
                    string[] strCodeInfo = Func.PublicFuncProc.SplitStr(textBox1.Text.Trim(), ",");
                    textBox2.Text = strCodeInfo[1];
                    textBox4.Text = strCodeInfo[2];
                    textBox3.Text = strCodeInfo[3];
                    textBox5.Text = strCodeInfo[4];

                    if (checkBox1.Checked)
                    {
                        button3_Click(sender, e);
                    }
                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误,请扫描正确的二维码。" + ee.Message);
                    ClearAll(false);
                    textBox11.Text = "";
                }
            }
        }

        private void listView1_ColumnClick(object sender, ColumnClickEventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            int iMatlNo = 0;//第几行

            #region 检验有没有数据
            if (textBox2.Text == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("请扫描材料条形码。");
                textBox1.Focus();
                return;
            }
            #endregion  

            #region 检验是不是在出库单里的材料
            
            Boolean booTemp = false;
            for (int i = 0; i < listView1.Items.Count; i++)
            {
                string strTemp = listView1.Items[i].SubItems[0].Text;
                if (strTemp == textBox2.Text)//有相同的
                {
                    booTemp = true;
                    iMatlNo = i;
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
            //double DOutA = 0;//已经出库的数量
            //for (int i = 0; i < listView1.Items.Count; i++)
            //{
            //    string strTemp = listView1.Items[i].SubItems[0].Text;
            //    if (strTemp == textBox2.Text)//有相同的
            //    {
            //        DOutA = DOutA + Convert.ToDouble(listView1.Items[i].SubItems[5].Text);
            //    }
            //}
            //if (DOutA >= dNeedOutCount)
            //{
            //    Func.PublicFuncProc.MsgBoxInfo("此类材料出库数量已足够,请勿再扫描.");
            //    ClearAll(false);
            //    return;
            //}
            #endregion

            #region 更新出库信息

            listView1.Items[iMatlNo].SubItems[5].Text = textBox3.Text;
            listView1.Items[iMatlNo].SubItems[6].Text = textBox4.Text;
            listView1.Items[iMatlNo].SubItems[7].Text = textBox5.Text;
            
            #endregion

            #region 查询是否还有其他单子需要此材料

            listView1.Items[iMatlNo].SubItems[5].Text = textBox3.Text;
            listView1.Items[iMatlNo].SubItems[6].Text = textBox4.Text;
            listView1.Items[iMatlNo].SubItems[7].Text = textBox5.Text;

            ClearAll(false);
            #endregion

        }

        private void button4_Click(object sender, EventArgs e)
        {

        }

        private void button6_Click(object sender, EventArgs e)
        {
            if (listView1.Items.Count == 0)
            {
                return;
            }
            string temp = "料号:"+listView1.FocusedItem.SubItems[0].Text;
            temp = temp +"\r\n\r\n货架:"+ listView1.FocusedItem.SubItems[9].Text;
            MessageBox.Show(temp);
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
                        TempCode = Func.PublicFuncProc.ChangeMatlCode(textBox2.Text.Trim(), "");
                        if (TempCode == "")
                        {
                            Func.PublicFuncProc.MsgBoxError("错误，查找不到相应信息.");
                            ClearAll(false);
                            return;
                        }
                        else
                        {
                            textBox2.Text = TempCode;
                        }
                    }

                    textBox3.Focus();

                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误,请扫描正确的一维码。" + ee.Message);
                    ClearAll(false);
                }
            }
        }

        
    }
}