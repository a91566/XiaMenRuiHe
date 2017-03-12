using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Reflection;

namespace CaiGouRuKu_inside
{
    public partial class csCaiGouRuKu_inside : Form
    {
        public csCaiGouRuKu_inside(string StrDept, string StrUser, Boolean BOnLine)
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
            DateTime dt = DateTime.Now;
            string OpeeDT=string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);
            string exsql = "insert into MatlInDepotZ (MIDDONO,SuprCode,DepotCode,UserCode,OpeeDT,Tips,State) values('"+
                DDONO + "','" + textBox11.Text + "','" + textBox12.Text + "','" + Func.PublicFuncProc.Globe.ZsbStrUser
                + "','" + OpeeDT + "','" + textBox13.Text + "','Y');";



            string exsql1 = "";
            string TempNull = "";
            for(int j=0;j<listView1.Items.Count;j++)
            {
                exsql1 = exsql1 + "insert into MatlInDepotMX (MIDDONO,MatlCode,MatlLot,MatlQuat,MatlVer,ShefCode,ProeNo,StockQuat,LostUsesDate,AutoLot,InOrOut) values('" +
                DDONO + "','" + listView1.Items[j].SubItems[0].Text + "','" + listView1.Items[j].SubItems[1].Text + "','" + listView1.Items[j].SubItems[2].Text +
                "','" + listView1.Items[j].SubItems[3].Text + "','" + textBox13.Text + "','" + TempNull + "','" + listView1.Items[j].SubItems[2].Text + 
                "','" + Func.PublicFuncProc.GetMatlLostUsesDate(listView1.Items[j].SubItems[0].Text, OpeeDT) +
                "','" + listView1.Items[j].SubItems[4].Text + "','" + listView1.Items[j].SubItems[5].Text + "');";       
            }
            exsql = exsql + exsql1;
            int i = PPDARHPRORETSYS.SQLHelper.ExecuteSql(exsql);
            if (i > 0)
            {
                i = i - 1;//2014年11月17日 11:43:31 因为一条是主单据,睿和那边说会误导，所以减一
                Func.PublicFuncProc.MsgBoxInfo("保存成功。共插入数据："+i.ToString()+"条");
                ClearAll(true);
                return;
            }
            else
            {
                Func.PublicFuncProc.MsgBoxError("对不起,保存失败。");
            }
        }

        private void ClearAll(Boolean bAll)
        {
            textBox1.Text = "";
            textBox3.Text = "";
            textBox4.Text = "";
            textBox5.Text = "";
            textBox6.Text = "";
            textBox7.Text = "";
            if (bAll)
            {
                textBox2.Text = "";
                textBox8.Text = "0";
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

        /// <summary>
        /// 验证是否可以出库 调用数据库的存储过程
        /// </summary>
        /// <param name="DDONO"></param>
        private int isCanInDepot()
        {
            //--供应商代码 ,   --料号 ,  --流水号
            string exsql = "declare @out int  exec @out=ZP_isCanInDepot_Matl ";
            exsql = exsql + "'" + textBox11.Text + "',";
            exsql = exsql + "'" + textBox2.Text + "',";
            exsql = exsql + "'" + textBox6.Text + "'";
            exsql = exsql + " select @out outvalue";
            string temp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(exsql, "outvalue");//outvalue 是写在存储过程里的
            return Convert.ToInt16(temp);
        }

        #endregion
       

        private void button1_Click(object sender, EventArgs e)
        {
            //打开扫描开关
            button4.Enabled = true;
            button1.Enabled = false;
            tabControl1.SelectedIndex = 1;
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
            if (textBox13.Text == "")
            {
                Func.PublicFuncProc.MsgBoxInfo("请扫描货架。");
                textBox13.Focus();
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

                    #region 6位标签  2014年11月18日 11:28:53 暂时先调整以便睿和处理旧的标签 过后删除
                    // 旧 inside,睿和料号,对方料号,数量,批次,流水号
                    //     0      1        2        3    4    5

                    //     0      1        2      3    4    5    6
                    // 新 inside,厂商码,睿和料号,数量,批次,版次,流水号
                    if (strCodeInfo.Count() == 6)
                    {

                        string strMatlCode = strCodeInfo[1];
                        if (textBox2.Text != "") //判断是否一样
                        {
                            if (textBox2.Text != strMatlCode)
                            {
                                Func.PublicFuncProc.MsgBoxError("错误，请扫描相同料号的材料标签.");
                                ClearAll(false);
                                return;
                            }
                        }
                        if (textBox11.Text == "") //赋初值 检索出供应商
                        {
                            textBox11.Text = Func.PublicFuncProc.GetSuprCode(strMatlCode) ;//厂商码
                        }
                        else
                        {
                            if (Func.PublicFuncProc.GetSuprCode(strMatlCode) != textBox11.Text)
                            {
                                Func.PublicFuncProc.MsgBoxError("错误，请扫描同一个供应商的材料标签.");
                                ClearAll(false);
                                return;                            
                            } 
                        }
                        textBox2.Text = strCodeInfo[1];//料号
                        textBox3.Text = strCodeInfo[4];//批次
                        textBox4.Text = strCodeInfo[3];//数量
                        textBox5.Text = ".";//版次
                        textBox6.Text = strCodeInfo[5];//流水号
                        textBox7.Text = strCodeInfo[0];//标识
                    }
                    #endregion

                    #region 7位标签  
                    if (strCodeInfo.Count() == 7)
                    {
                        string strMatlCode = strCodeInfo[2];
                        if (textBox2.Text != "") //判断是否一样
                        {
                            if (textBox2.Text != strMatlCode)
                            {
                                Func.PublicFuncProc.MsgBoxError("错误，请扫描相同料号的材料标签.");
                                ClearAll(false);
                                return;
                            }
                        }
                        else if (textBox11.Text == "") //赋初值 检索出供应商
                        {
                            //textBox11.Text =Func.PublicFuncProc.GetSuprCode(strMatlCode);
                            //textBox11.Text = strCodeInfo[1]; //厂商码
                            textBox11.Text = Func.PublicFuncProc.GetSuprCodeXXX(strCodeInfo[1]); //厂商码
                        }
                        textBox2.Text = strMatlCode;//料号
                        textBox3.Text = strCodeInfo[4];//批次
                        textBox4.Text = strCodeInfo[3];//数量
                        textBox5.Text = strCodeInfo[5];//版次
                        textBox6.Text = strCodeInfo[6];//流水号
                        textBox7.Text = strCodeInfo[0];//标识
                    }
                    #endregion

                    #region 添加数据
                    if (textBox6.Text == "")
                    {
                        Func.PublicFuncProc.MsgBoxError("错误，不可识别的材料标签.");
                        ClearAll(false);
                        textBox1.Text = "";
                        textBox1.Focus();
                        return;
                    }
                    
                    if (textBox7.Text != "inside")
                    {
                        if (textBox7.Text != "outside")
                        {
                            Func.PublicFuncProc.MsgBoxError("不可识别的标签标识.");
                            ClearAll(false);
                            textBox1.Text = "";
                            textBox1.Focus();
                            return;
                        }
                    }

                    #region 检测已经扫描
                    Boolean booTemp = false;
                    for (int i = 0; i < listView1.Items.Count; i++)
                    {
                        string strTemp = listView1.Items[i].SubItems[4].Text;//流水号
                        if (strTemp == textBox6.Text)//有相同的流水号
                        {
                            booTemp = true;
                            break;
                        }
                    }
                    if (booTemp == true)
                    {
                        Func.PublicFuncProc.MsgBoxError("已扫描.");
                        ClearAll(false);
                        return;
                    }

                    #endregion


                    #region 检测已经入库
                 

                    int iRt = isCanInDepot();
                    if (iRt == 1)
                    {
                        Func.PublicFuncProc.MsgBoxError("标签异常，可能是已经入库。");
                        ClearAll(false);
                        textBox1.Text = "";
                        textBox1.Focus();
                        return;
                    }

                    #endregion

                    ListViewItem lvwItem = new ListViewItem(textBox2.Text);//增加代号
                    lvwItem.SubItems.Add(textBox3.Text);//批次
                    string strQuat = Func.PublicFuncProc.SplitUnitQuat(textBox4.Text);
                    lvwItem.SubItems.Add(strQuat);//数量
                    lvwItem.SubItems.Add(textBox5.Text);//版次
                    lvwItem.SubItems.Add(textBox6.Text);//流水号
                    lvwItem.SubItems.Add(textBox7.Text);//标识
                    listView1.Items.Add(lvwItem);
                    ClearAll(false);
                    int iCount=Convert.ToInt16(textBox8.Text)+1;
                    textBox8.Text = iCount.ToString();
                    textBox1.Focus();

                    #endregion


                }
                catch (Exception ee)
                {
                    Func.PublicFuncProc.MsgBoxError("条码解析错误,请扫描正确的二维码。" + ee.Message);
                    ClearAll(false);
                }
            }
        }

        
        private void tabControl2_SelectedIndexChanged(object sender, EventArgs e)
        {
            textBox1.Focus();
        }

        private void listView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

       

        private void timer1_Tick(object sender, EventArgs e)
        {
            string fn = "CaiGouRuKu_inside.dll";
            string fp = @"\Application\Startup\"+fn;
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