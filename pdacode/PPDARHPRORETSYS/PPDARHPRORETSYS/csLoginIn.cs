/*
 * 
 *   厦门睿和电子有限公司
 *   PDA连接sql2000数据库，sql2000需要安装补丁
 *   连接方式直连，木有采取webservice,因为业务不复杂，直接用SQL语句实现，复杂的用存储过程
 *   桌面程序采取Delphi开发三层
 *   
 *   郑少宝  Tel:15059456425  QQ:726326217 
 *   2013年3月28日 10:55:36
 */

using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Threading;
using System.IO;
//using System.Runtime.InteropServices;

namespace PPDARHPRORETSYS
{
   // public delegate void SetValueCallback(int value);//托管线程

    public partial class F_LoginIn : Form
    {
        public F_LoginIn()
        {
            InitializeComponent();
        }   

               

        #region 自定义事件

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
        /// 循环加载
        /// </summary>
        //private void Foo()
        //{             
        //    for (int i = 1; i <= 100; i++)
        //    {
        //        Thread.Sleep(100);
        //        SetProcessBarValue(i);
        //        //this.progressBar1.Value = i;
        //        //SetLabelValue(i);
        //    }          
        //}

        /// <summary>
        /// 进度条
        /// </summary>
        /// <param name="value"></param>
        //private void SetProcessBarValue(int value)
        //{
        //    if (this.progressBar1.InvokeRequired)
        //    {
        //        SetValueCallback d = new SetValueCallback(SetProcessBarValue);
        //        this.Invoke(d, new object[] { value });
        //    }
        //    else
        //    {
        //        this.progressBar1.Value = value;
        //    }
        //}    

        ///// <summary>
        ///// 显示字体
        ///// </summary>
        ///// <param name="value"></param>
        //private void SetLabelValue(int value)
        //{
        //    if (this.label1.InvokeRequired)
        //    {
        //        SetValueCallback d = new SetValueCallback(SetLabelValue);
        //        this.Invoke(d, new object[] { value });
        //    }
        //    else
        //    {
        //        this.label1.Text = value.ToString() + '%';
        //    }
        //}
      

        /// <summary>
        /// 保存设置IP
        /// </summary>
        private void SaveIpConfig()
        {
            if (string.IsNullOrEmpty(txtIp.Text))
            {
                Func.PublicFuncProc.MsgBoxError("请输入IP");
                txtIp.Focus();
                return;
            }
            //==写设置IP
            if (IsValidIP(txtIp.Text.Trim()))
            {
                SQLHelper.ReadXmlFirst(txtIp.Text.Trim());
                Func.PublicFuncProc.MsgBoxInfo("设置成功！");
                txtUserCode.Focus();
            }
            else
            {
                Func.PublicFuncProc.MsgBoxError("请输入正确的IP地址,如***.***.***.***!");
                return;
            }
        }

        /// <summary>
        /// 验证IP地址
        /// </summary>
        /// <param name="p"></param>
        /// <returns></returns>
        private bool IsValidIP(string ip)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(ip, "[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}"))
            {
                string[] ips = ip.Split('.');
                if (ips.Length == 4 || ips.Length == 6)
                {
                    if (System.Int32.Parse(ips[0]) < 256
                        && System.Int32.Parse(ips[1]) < 256
                        && System.Int32.Parse(ips[2]) < 256
                        && System.Int32.Parse(ips[3]) < 256
                        )
                        return true;
                    else
                        return false;
                }
                else
                    return false;
            }
            else
                return false;

        }

        /// <summary>
        /// 验证登录在线
        /// </summary>
        /// <returns></returns>
        private void CheckLoginInOnLine(string usercode, string userpwd)
        {            
          //  InitProcessBar(true);
            try
            {
                string strsql = "select stafcode,stafname,deptcode,userstate from staff where UserCode='" + usercode + "' and UserPwd='" + userpwd + "'";
                DataSet ds = SQLHelper.Query(strsql);
                if (ds.Tables[0].Rows.Count == 0)
                {
                    Func.PublicFuncProc.MsgBoxError("帐号或密码错误。");
                    progressBar1.Visible = false;
                    return;
                }
                DataRow drs = ds.Tables[0].Rows[0];
                if (drs["userstate"].ToString().Trim() == "N")
                {
                    Func.PublicFuncProc.MsgBoxError("帐号已经被禁用，请更换帐号。");
                    progressBar1.Visible = false;
                    return;
                }
                Func.PublicFuncProc.Globe.ZsbStrUserCode = usercode;//用户名
                Func.PublicFuncProc.Globe.ZsbStrUser = drs["stafcode"].ToString().Trim() +"/" + drs["stafname"].ToString().Trim();//用户
                Func.PublicFuncProc.Globe.ZsbStrDept = drs["deptcode"].ToString().Trim();//部门

                LoadSaveUserCode(false);
                
                //2014年3月26日 08:49:55 人员信息表的部门信息就是代号加名称
                //string tempDentCode=drs["deptcode"].ToString().Trim();
                //string tempDeptName = "";
                //if (comboBox1.SelectedIndex == 0) //仓库
                //{
                //    tempDeptName = SQLHelper.QueryForOneField("select DepotName from Depot where DepotCode='" + tempDentCode + "'", "DepotName");
                //}
                //else//其他科室
                //{
                //    tempDeptName = SQLHelper.QueryForOneField("select DeptName from Department where DeptCode='" + tempDentCode + "'", "DeptName"); 
                //}
                //if (tempDeptName == "")
                //{
                //    Func.PublicFuncProc.MsgBoxError("登录失败，请更换操作类型或帐号后重新登录。");
                //    comboBox1.Focus();
                //    return; 
                //}
                //Func.PublicFuncProc.Globe.ZsbStrDept = tempDentCode+"/"+tempDeptName;//部门
            }
            catch (Exception ee)
            {
                Func.PublicFuncProc.MsgBoxError("系统异常："+ee.Message);
                return;
            }
            Func.PublicFuncProc.Globe.ZsbBOnLine = true;
            csMain csmain = new csMain();
           // InitProcessBar(false); 
            csmain.Show();
            this.Hide();
        }


        /// <summary>
        /// 验证登录 离线
        /// </summary>
        /// <returns></returns>
        private void CheckLoginInOffLine()
        {
            try
            {
                Func.PublicFuncProc.Globe.ZsbBOnLine = false;
                Func.PublicFuncProc.Globe.ZsbStrUser = txtUserCode.Text.Trim();//用户名
                Func.PublicFuncProc.Globe.ZsbStrDept = "";//部门
                csMain csmain = new csMain();
                csmain.Show();
                this.Hide();
                int i = Convert.ToInt16("aa");
            }
            catch(Exception ee)
            {
                string str = ee.ToString();
                SaveMessage(str);
                MessageBox.Show(str);                
            }
        }

        /// <summary>
        /// 加载保存登录帐号
        /// </summary>
        private void LoadSaveUserCode(Boolean bLoad)
        {
            if (bLoad == true)
            {
                string filePath = @"\Application\StartUp\LoginHistory.zsb";
                if (File.Exists(filePath))
                {
                    StreamReader sr = new StreamReader(filePath, Encoding.GetEncoding("gb2312")); //解决中文乱码
                    string strTemp;
                    while ((strTemp = sr.ReadLine()) != null)
                    {
                        txtUserCode.Text = strTemp;
                        txtPwd.Focus();
                        break;// 就取第一行
                    }
                    sr.Close();
                }              
            }
            else
            {
                string SaveFilePath = @"\Application\StartUp\LoginHistory.zsb";
                FileStream fst = new FileStream(SaveFilePath, FileMode.Create);
                StreamWriter swt = new StreamWriter(fst, System.Text.Encoding.GetEncoding("utf-8"));
                swt.WriteLine(txtUserCode.Text);
                swt.Close();
                fst.Close();
            }
        }

        /// <summary>
        /// 保存相关信息
        /// </summary>
        private void SaveMessage(string str)
        {
            DateTime dtdt = DateTime.Now;
            string DT = dtdt.ToString("yyyyMMddhhmmss");
            string SaveFilePath = @"\Application\StartUp\SysLog\";
            if (!Directory.Exists(SaveFilePath))//若文件夹不存在则新建文件夹  
            {
                Directory.CreateDirectory(SaveFilePath); //新建文件夹  
            }
            SaveFilePath = SaveFilePath + DT + ".zsb";
            FileStream fst = new FileStream(SaveFilePath, FileMode.Create);
            StreamWriter swt = new StreamWriter(fst, System.Text.Encoding.GetEncoding("utf-8"));
            swt.WriteLine(str);
            swt.Close();
            fst.Close();
         
        }
        #endregion



        private void btnLogin_Click(object sender, EventArgs e)
        {
            //progressBar1.Value = 0;
            //Thread t = new Thread(Foo);
            //t.Start(); //开始线程
            //InitProcessBar(true);   
            // 在PDA上就是不行，郁闷

            try
            {
                Func.PublicFuncProc.Loading(true);
                if (txtUserCode.Text == "")
                {
                    Func.PublicFuncProc.MsgBoxInfo("请输入帐号。");
                    // InitProcessBar(false);
                    txtUserCode.Focus();
                    return;
                }
                if (radioButton1.Checked==true)
                {
                    if (txtPwd.Text == "")
                    {
                        Func.PublicFuncProc.MsgBoxInfo("请输入密码。");
                        // InitProcessBar(false);
                        txtPwd.Focus();
                        return;
                    }
                    string tempmd5=Func.PublicFuncProc.Get16Md5(txtPwd.Text.Trim());
                    //MessageBox.Show(tempmd5);
                    CheckLoginInOnLine(txtUserCode.Text.Trim(), tempmd5);
                }
                else
                {
                    CheckLoginInOffLine();
                }
            }
            catch (Exception ee)
            {
                string str = ee.ToString();
                SaveMessage(str);
                MessageBox.Show(str);
            }  

        }        

        private void F_LoginIn_Load(object sender, EventArgs e)
        {
            tabControl1.TabIndex = 0;
            txtUserCode.Focus();
            comboBox1.SelectedIndex = 0;
            LoadSaveUserCode(true);
        }

        private void btnRight_Click(object sender, EventArgs e)
        {
              
        }

        private void btnExite_Click(object sender, EventArgs e)
        {
            Func.PublicFuncProc.Loading(false);
            if (Func.PublicFuncProc.MsgBoxOk("确定退出系统么？"))
            {
                Application.Exit();
            }
        }     
     

        private void button2_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtIp.Text))
            {
                MessageBox.Show("请输入IP", "提示");
                txtIp.Focus();
                return;
            }
            //==写设置IP
            if (IsValidIP(txtIp.Text.Trim()))
            {
                string SaveFilePath = @"\Application\StartUp\IpConfig.txt";
                try
                {
                    FileStream fst = new FileStream(SaveFilePath, FileMode.Create);
                    StreamWriter swt = new StreamWriter(fst, System.Text.Encoding.GetEncoding("utf-8"));
                    swt.WriteLine(txtIp.Text);
                    swt.WriteLine(textBox1.Text);
                    swt.Close();
                    fst.Close();
                    Func.PublicFuncProc.MsgBoxInfo("设置成功! ");
                }
                catch (Exception ex)
                {
                    Func.PublicFuncProc.MsgBoxInfo("文件保存异常,请联系管理员！" + ex.Message);
                    return;
                }
            }
            else
            {
                Func.PublicFuncProc.MsgBoxError("请输入正确的IP地址,如***.***.***.***!");
                return;
            }


            

        }

        private void button1_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 0;
        }
               

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(tabControl1.SelectedIndex==1)
            {
                if (txtIp.Text == "")
                {
                    string filePath = @"\Application\StartUp\IpConfig.txt";
                    StreamReader sr = new StreamReader(filePath, Encoding.GetEncoding("gb2312")); //解决中文乱码
                    string strTemp;//出库明细
                    int i = 0;
                    while ((strTemp = sr.ReadLine()) != null)
                    {
                        if (i == 0)
                        {
                            txtIp.Text = strTemp;
                            i = i + 1;
                        }
                        else if (i == 1)
                        {
                            textBox1.Text = strTemp;
                            break;
                        }
                    }
                    sr.Close();
                }
            }
        }

        private void txtPwd_KeyUp(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                btnLogin_Click(sender, e);
            }
        }   

      


      

       

       

    }
}