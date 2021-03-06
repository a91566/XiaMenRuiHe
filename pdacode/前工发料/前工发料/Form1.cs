﻿using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Reflection;

namespace QianGongFaLiao
{
    public partial class Form1 : Form
    {
        public Form1(string StrDept, string StrUser, Boolean BOnLine)
        {
            Func.PublicFuncProc.Globe.ZsbStrDept = StrDept;
            Func.PublicFuncProc.Globe.ZsbStrUser = StrUser;
            Func.PublicFuncProc.Globe.ZsbBOnLine=BOnLine;
            InitializeComponent();
        }


        private void ClearAll(Boolean b)
        {
            textBox2.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";
            textBox5.Text = "";
            textBox6.Text = "";
            textBox7.Text = "";
            if (b == true)
            {
                textBox1.Text = "";
                textBox11.Text = "";
            }
         
        }

        /// <summary>
        /// 保存出库 调用数据库的存储过程
        /// </summary>
        /// <param name="DDONO"></param>
        private int SetOutDepot()
        {
            //领退单号ML,供应商代码,料号,批次,版次,流水号,用户
            string exsql = "declare @out int  exec @out=ZP_setOutDepot_Matl_Qian ";
            exsql = exsql + "'" + textBox11.Text + "',";
            exsql = exsql + "'" + textBox7.Text + "',";
            exsql = exsql + "'" + textBox2.Text + "',";
            exsql = exsql + "'" + textBox3.Text + "',";
            exsql = exsql + "'" + textBox5.Text + "',";
            exsql = exsql + "'" + textBox6.Text + "',";
            exsql = exsql + "'" + Func.PublicFuncProc.Globe.ZsbStrUser + "'";
            exsql = exsql + " select @out outvalue";
            string temp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(exsql, "outvalue");//outvalue 是写在存储过程里的
            return Convert.ToInt16(temp);
        }

        /// <summary>
        /// 验证是否可以出库 调用数据库的存储过程
        /// </summary>
        /// <param name="DDONO"></param>
        private int isCanOutDepot()
        {
            //--供应商代码 ,   --料号 ,  --流水号
            string exsql = "declare @out int  exec @out=ZP_isCanOutDepot_Matl_Qian ";
            exsql = exsql + "'" + textBox7.Text + "',";
            exsql = exsql + "'" + textBox2.Text + "',";
            exsql = exsql + "'" + textBox6.Text + "',";
            exsql = exsql + "'" + Func.PublicFuncProc.Globe.ZsbStrUser + "'";
            exsql = exsql + " select @out outvalue";
            string temp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(exsql, "outvalue");//outvalue 是写在存储过程里的
            return Convert.ToInt16(temp); ;
        }
  
        private void AddlvwItem()
        {
            ListViewItem lvwItem = new ListViewItem(textBox11.Text);//  单号

            lvwItem.SubItems.Add(textBox2.Text);//料号

            lvwItem.SubItems.Add(textBox3.Text);//批次

            lvwItem.SubItems.Add(textBox4.Text);//数量

            lvwItem.SubItems.Add(textBox5.Text);//版次

            lvwItem.SubItems.Add(textBox6.Text);//流水号

            lvwItem.SubItems.Add(textBox7.Text);//供应商

            listView1.Items.Add(lvwItem);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (Func.PublicFuncProc.MsgBoxOk("确定返回么？"))
            {
                this.Close();
            }

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 0;
            textBox11.Focus();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            if (textBox11.Text == "")
            {
                Func.PublicFuncProc.MsgBoxError("请扫描发料单上的二维码。");
                textBox11.Focus();
                return;
            }
            if (textBox2.Text == "")
            {
                tabControl1.TabIndex = 0;
                Func.PublicFuncProc.MsgBoxError("请扫描原料的二维码。");
                textBox1.Focus();
                return;
            }
            string temp = textBox11.Text.Substring(0, 2);
            if (temp != "QC")
            {
                Func.PublicFuncProc.MsgBoxError("发料单号不正确,发料单号以QC开头。");
                ClearAll(false);
                textBox1.Focus();
                return;
            }
         


            //验证能否出库
            int iRt = isCanOutDepot();
            if (iRt == 1)
            {
                Func.PublicFuncProc.MsgBoxError("标签异常，可能还没有入库或者已经作废或者已经出库或者已经过期。");
                ClearAll(false);
                textBox1.Text = "";
                textBox1.Focus();
                return;
            }
            else if (iRt == 2)
            {
                Func.PublicFuncProc.MsgBoxError("按照先进先出原则，您需要扫描更早日期入库的标签。");
                ClearAll(false);
                textBox1.Text = "";
                textBox1.Focus();
                return;
            }




            //进行出库
            iRt = SetOutDepot();

            if (iRt == 1)
            {
                Func.PublicFuncProc.MsgBoxError("发料单Q号不合法,可能是已经发完，如有疑问请在PC端查询该发料单的状态信息！");
                ClearAll(false);
                textBox1.Text = "";
                textBox1.Focus();
            }
            else if (iRt == 2)
            {
                Func.PublicFuncProc.MsgBoxError("此发料单无需此发料，或者已经发完。");
                ClearAll(false);
                textBox1.Text = "";
                textBox1.Focus();
            }
            else if (iRt == 3)
            {
                Func.PublicFuncProc.MsgBoxError("标签不存在或者还未入库，或者都已经出库了。");
                ClearAll(false);
                textBox1.Text = "";
                textBox1.Focus();
            }
            else if (iRt == 10)
            {
                // 查询还需要出库的数量
                temp = Func.PublicFuncProc.GetNeedOutNum_Matl_Qian(textBox2.Text, textBox11.Text);
                Func.PublicFuncProc.MsgBoxInfo("保存成功。不过这张数量不够，您还需要再扫描一个标签出库，数量为 [ " + temp + " ]。");
                AddlvwItem();
                ClearAll(true);
                textBox1.Focus();
            }
            else if (iRt == 0)
            {
                Func.PublicFuncProc.MsgBoxInfo("保存成功。");
                AddlvwItem();
                ClearAll(true);
                textBox11.Focus();
            }

        }   

        private void timer1_Tick(object sender, EventArgs e)
        {
            string fn = "QianGongFaLiao.dll";
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

        private void textBox11_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                PPDARHPRORETSYS.WavSound.Play();
                if (textBox2.Text == "")
                {
                    textBox1.Focus();
                }
                else
                {
                    button4_Click(sender, e);
                }
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

                    if (strCodeInfo.Count() == 7)
                    {
                        //textBox7.Text = strCodeInfo[1];//厂商码
                        textBox7.Text = Func.PublicFuncProc.GetSuprCodeXXX(strCodeInfo[1]);//厂商码
                        textBox2.Text = strCodeInfo[2];//料号
                        textBox3.Text = strCodeInfo[4];//批次
                        textBox4.Text = strCodeInfo[3];//数量
                        textBox5.Text = strCodeInfo[5];//版次
                        textBox6.Text = strCodeInfo[6];//流水号
                    }
                    else if (strCodeInfo.Count() == 6)
                    {
                        if (strCodeInfo[0] == "inside")
                        {
                            textBox2.Text = strCodeInfo[1];
                            textBox3.Text = strCodeInfo[4];
                            textBox4.Text = strCodeInfo[3];
                            textBox5.Text = ".";             //内部标签 没有版次
                            textBox6.Text = strCodeInfo[5];
                            textBox7.Text = Func.PublicFuncProc.GetSuprCodeXXX(strCodeInfo[2]);//厂商码
                        }
                    }
                    else
                    {
                        ClearAll(false);
                        textBox1.Text = "";
                        Func.PublicFuncProc.MsgBoxError("条码解析错误,请扫描正确的二维码。");
                        textBox1.Focus();
                        return;
                    }
                    button4_Click(sender, e);
                }
                catch (Exception ee)
                {
                    ClearAll(false);
                    textBox1.Text = "";
                    Func.PublicFuncProc.MsgBoxError("条码解析异常,请扫描正确的二维码。" + ee.Message);
                    textBox1.Focus();
                }
            }
        }      
    }
}