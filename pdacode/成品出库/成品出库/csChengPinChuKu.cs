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
using System.Reflection;

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
                textBox14.Text = "XXX";
                listView1.Items.Clear();
                button1.Enabled = true;
                button2.Enabled = false;
                textBox1.Enabled = false;
            }
        }


        /// <summary>
        /// 保存出库
        /// </summary>
        /// <param name="DDONO"></param>
        private void SaveEndPortOutDepot(string DDONO)
        {

            string OpeeDT = PPDARHPRORETSYS.SQLHelper.GetSysDateTime();

            string exsql = "insert into EndProtOutDepotZ (OutNo,DepotCode,OpeeDT,UserCode,State) values('" +
                DDONO + "','" + textBox12.Text + "','" + OpeeDT + "','" + textBox13.Text + "','Y');";


            string lots = "";
            for (int j = 0; j < listView1.Items.Count; j++)
            {
                if (j == 0)
                {
                    lots = "(''" + listView1.Items[j].SubItems[4].Text + "''";
                }
                else
                {
                    lots = lots + ",''" + listView1.Items[j].SubItems[4].Text + "''";
                }
            }
            lots = lots + ")";
            int i = PPDARHPRORETSYS.SQLHelper.ExecuteSql(exsql);
            if (i == 1)
            {
                string temp = LotsOutDepot(DDONO, lots);
                if (temp != "0")
                {
                    Func.PublicFuncProc.MsgBoxInfo("保存成功。出库标签" + temp + "张，出库单号：" + DDONO);
                    ClearAll(true);
                    tabControl1.SelectedIndex = 0;
                    return;
                }
                else
                {
                    Func.PublicFuncProc.MsgBoxError("对不起,标签出库单号写入失败,请联系管理员。");
                }
            }
            else
            {
                Func.PublicFuncProc.MsgBoxError("对不起,出库主表保存失败,请联系管理员。");
            }

        }


        /// <summary>
        /// 保存明细
        /// </summary>
        /// <param name="DDONO"></param>
        private static string LotsOutDepot(string DDONO, string lots)
        {
            string exsql = "declare @out int  exec @out=ZP_setOutDepot ";
            exsql = exsql + "'" + DDONO + "',";
            exsql = exsql + "'" + lots + "'";
            exsql = exsql + " select @out outvalue";
            string temp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(exsql, "outvalue");//outvalue 是写在存储过程里的
            return temp;
        }

        #endregion



        private void csChengPinChuKu_Load(object sender, EventArgs e)
        {
            textBox12.Text = Func.PublicFuncProc.Globe.ZsbStrDept;
            textBox13.Text = Func.PublicFuncProc.Globe.ZsbStrUser;
            textBox14.Focus();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            button1.Enabled = false;
            button2.Enabled = true;
            tabControl1.SelectedIndex = 1;
            textBox1.Enabled = true;
            textBox1.Focus();
        }

        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == (Keys)13)
            {
                try
                {
                    string temp;

                    PPDARHPRORETSYS.WavSound.Play();

                    #region 解析条码
                    string[] strCodeInfo = Func.PublicFuncProc.SplitStr(textBox1.Text.Trim(), ",");
                    #endregion

                    //目前睿和的成品标签有两种  2015年就可以删除这个代码了
                    #region 检验标签的合法性
                    if (strCodeInfo.Count() != 5)
                    {
                        if (strCodeInfo.Count() != 6)
                        {
                            Func.PublicFuncProc.MsgBoxError("二维码格式不正确。");
                            textBox1.Focus();
                            ClearAll(false);
                            return;
                        }

                    }

                    if (strCodeInfo.Count() == 5)
                    {
                        if (strCodeInfo[strCodeInfo.Count() - 1] != "EndPC")
                        {
                            Func.PublicFuncProc.MsgBoxError("不可识别的标签。");
                            textBox1.Focus();
                            ClearAll(false);
                            return;
                        }
                    }
                    #endregion

                    #region 检验批次是否已经扫描
                    Boolean booTemp = false;
                    if (listView1.Items.Count > 0)
                    {
                        for (int i = 0; i < listView1.Items.Count; i++)
                        {
                            if (listView1.Items[i].SubItems[4].Text == strCodeInfo[3])//相同的
                            {
                                booTemp = true;
                                break;
                            }
                        }
                        if (booTemp == true)
                        {
                            Func.PublicFuncProc.MsgBoxInfo("批号[" + strCodeInfo[3] + "]已经存在,请勿再扫描.");
                            ClearAll(false);
                            textBox1.Focus();
                            return;
                        }
                    }
                    #endregion

                    #region 检验批次是否可以出库 存储过程处理
                    string strsql = "declare @out int  exec @out=ZP_isCanOutDepot '" + strCodeInfo[3] + "' select @out outvalue";
                    temp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(strsql, "outvalue");
                    string show = "";
                    if (temp != "0")
                    {
                        switch (temp)
                        {
                            case "1":
                                show = "批号[" + strCodeInfo[3] + "]不可识别.";
                                break;
                            case "2":
                                show = "批号[" + strCodeInfo[3] + "]已经出库,请勿再扫描.";
                                break;
                            case "3":
                                show = "批号[" + strCodeInfo[3] + "]已经报废.";
                                break;
                            case "4":
                                show = "批号[" + strCodeInfo[3] + "]还没有入库.";
                                break;
                        }
                        Func.PublicFuncProc.MsgBoxInfo(show);
                        ClearAll(false);
                        textBox1.Focus();
                        return;
                    }
                    #endregion

                    #region 插入数据
                    int iNo = listView1.Items.Count + 1;
                    ListViewItem lvwItem = new ListViewItem(iNo.ToString());//序号
                    lvwItem.SubItems.Add(strCodeInfo[0]);//品番
                    lvwItem.SubItems.Add(strCodeInfo[1]);//制令单
                    lvwItem.SubItems.Add(strCodeInfo[2]);//数量
                    lvwItem.SubItems.Add(strCodeInfo[3]);//批次

                    //lvwItem.SubItems.Add(strCodeInfo[4]);//制造部门
                    //lvwItem.SubItems.Add(strCodeInfo[5]);//库位
                    //2014年11月28日 14:14:42 屏蔽制造部门与时间

                    listView1.Items.Insert(0, lvwItem);
                    textBox1.Text = "";
                    textBox1.Focus();
                    #endregion

                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误。" + ee.Message);
                    ClearAll(false);
                }
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

            string OpeeDT = PPDARHPRORETSYS.SQLHelper.GetSysDate();
            string dt_no = PPDARHPRORETSYS.SQLHelper.GetSysDate_XX();


            textBox14.Text = Func.PublicFuncProc.GetDONO_New(OpeeDT, dt_no, "成出", "O");
            if (textBox14.Text == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("单号获取失败。");
                return;
            }
            else
            {
                SaveEndPortOutDepot(textBox14.Text);
            } 
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            string fn = "ChengPinChuKu.dll";
            string fp = @"\Application\Startup\" + fn;
            string vH = Assembly.LoadFrom(fn).GetName().Version.ToString();

            string exsql = "declare @out int  exec @out=ZP_PDA_isDLLCanUSES ";
            exsql = exsql + "'" + fn + "',";
            exsql = exsql + "'" + vH + "'";
            exsql = exsql + " select @out outvalue";
            string temp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(exsql, "outvalue");

            if (temp != "0")
            {
                MessageBox.Show("[ 请注意，当前程序已经被管理员限制使用，请更新程序或者联系管理员。 ]");
            }
        }

      
    }
}