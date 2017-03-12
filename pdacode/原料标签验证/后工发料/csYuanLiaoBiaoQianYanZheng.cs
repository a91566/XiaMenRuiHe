using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Reflection;

namespace YuanLiaoBiaoQianYanZheng
{
    public partial class csYuanLiaoBiaoQianYanZheng : Form
    {
        //ERPProduceDocZ -> LZz_ML_MO_FromERP 
        //ERPPDNO -> ML_NO
        //ERPProduceDocMx -> LZm_ML_MO_FromERP
        //ERPZLDH-> MO_NO
        //OccupyERPPDNO ->  OccupyML_NO

        public csYuanLiaoBiaoQianYanZheng(string StrDept, string StrUser, Boolean BOnLine)
        {
            Func.PublicFuncProc.Globe.ZsbStrDept = StrDept;
            Func.PublicFuncProc.Globe.ZsbStrUser = StrUser;
            Func.PublicFuncProc.Globe.ZsbBOnLine=BOnLine;
            InitializeComponent();
        }
        
        /// <summary>
        /// 获取还需要出库的数量 调用数据库的存储过程
        /// </summary>
        /// <param name="DDONO"></param>
        private int getNum()
        {
            string exsql = "declare @out int  exec @out=ZP_TheMatlCodeState ";
            exsql = exsql + "'" + textBox7.Text + "',";
            exsql = exsql + "'" + textBox2.Text + "',";
            exsql = exsql + "'" + textBox6.Text + "',";
            exsql = exsql + "'" + textBox3.Text + "'";
            exsql = exsql + " select @out outvalue";
            string temp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(exsql, "outvalue");//outvalue 是写在存储过程里的
            return Convert.ToInt16(temp);
        }

        private void ClearAll(Boolean b)
        {
            textBox1.Text = "";
            if (b == true)
            {
                textBox2.Text = "";
                textBox3.Text = "";
                textBox4.Text = "";
                textBox5.Text = "";
                textBox6.Text = "";
                textBox7.Text = "";
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (Func.PublicFuncProc.MsgBoxOk("确定返回么？"))
            {
               this.Close();
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

                    int iRt = getNum();
                    if (iRt == 0)
                    {
                        if (checkBox1.Checked == false)
                        {
                            Func.PublicFuncProc.MsgBoxError("标签正常。");
                        }
                    }
                    else if (iRt == 1)
                    {
                        timer2.Enabled = true;
                        Func.PublicFuncProc.MsgBoxError("标签还没有入库。");
                        timer2.Enabled = false;
                        ClearAll(false);
                        textBox1.Focus();
                        return;
                    }
                    else if (iRt == 2)
                    {
                        timer2.Enabled = true;
                        Func.PublicFuncProc.MsgBoxError("标签已出库。");
                        timer2.Enabled = false;
                        ClearAll(false);
                        textBox1.Focus();
                        return;
                    }
                }
                catch (Exception ee)
                {
                    ClearAll(false);
                    Func.PublicFuncProc.MsgBoxError("条码解析异常,请扫描正确的二维码。" + ee.Message);
                    textBox1.Focus();
                }
            }
        }              

        private void button4_Click(object sender, EventArgs e)
        {
            ClearAll(true);
            textBox1.Focus();
        }

      
        private void timer1_Tick(object sender, EventArgs e)
        {
            string fn = "YuanLiaoBiaoQianYanZheng.dll";
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

        private void timer2_Tick(object sender, EventArgs e)
        {
            timer2.Interval = 6000;
            PPDARHPRORETSYS.WavSound.PlayPause();
        }

  
          
            
    }
}