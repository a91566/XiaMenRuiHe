using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;//dll
using System.Security.Cryptography;
using System.Diagnostics;
using System.Data;

namespace Func
{
    class PublicFuncProc
    {
        

        public class Globe  //定义全局变量【C#没有全局变量这么一说】  
        {
            public static bool ZsbBOnLine=false;//在线还是离线操作
            public static string ZsbStr1="";
            public static string ZsbStr2 = "";
            public static string ZsbStr3 = "";
            public static string ZsbStr4 = "";
            public static string ZsbStr5 = "";
            public static string ZsbStr6 = "";
            public static string ZsbStr7 = "";
            public static string ZsbStr8 = "";
            public static string ZsbStr9 = "";
            public static string ZsbStr10 = "";
            public static string ZsbStrUser = "";
            public static string ZsbStrDept = "";
            public static string ZsbStrUserCode = "";
        }

        #region messbox函数

        public static void MsgBoxInfo(string Showmessage)
        {
            MessageBox.Show(Showmessage, "系统提示", MessageBoxButtons.OK, MessageBoxIcon.Asterisk, MessageBoxDefaultButton.Button1);
        }

        public static void MsgBoxError(string Showmessage)
        {
            MessageBox.Show(Showmessage, "系统提示", MessageBoxButtons.OK, MessageBoxIcon.Hand, MessageBoxDefaultButton.Button1);
        }

        public static bool MsgBoxOk(string Showmessage)
        {
            DialogResult dr = MessageBox.Show(Showmessage, "操作确认",
                                            MessageBoxButtons.YesNo,
                                            MessageBoxIcon.Question,
                                            MessageBoxDefaultButton.Button1
                                            );
            if (DialogResult.Yes.Equals(dr))
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        #endregion

        #region 日期函数

        /// <summary>
        /// 取得某月的第一天
        /// </summary>
        /// <param name="datetime">要取得月份第一天的时间</param>
        /// <returns></returns>
        public static DateTime FirstDayOfMonth(DateTime datetime)
        {
            return datetime.AddDays(1 - datetime.Day);
        }

        
        /// <summary>
        /// 取得某月的最后一天
        /// </summary>
        /// <param name="datetime">要取得月份最后一天的时间</param>
        /// <returns></returns>
        public static DateTime LastDayOfMonth(DateTime datetime)
        {
            return datetime.AddDays(1 - datetime.Day).AddMonths(1).AddDays(-1);
        }

        
        /// <summary>
        /// 取得上个月第一天
        /// </summary>
        /// <param name="datetime">要取得上个月第一天的当前时间</param>
        /// <returns></returns>
        public static DateTime FirstDayOfPreviousMonth(DateTime datetime)
        {
            return datetime.AddDays(1 - datetime.Day).AddMonths(-1);
        }

      
        /// <summary>
        /// 取得上个月的最后一天
        /// </summary>
        /// <param name="datetime">要取得上个月最后一天的当前时间</param>
        /// <returns></returns>
        public static DateTime LastDayOfPrdviousMonth(DateTime datetime)
        {
            return datetime.AddDays(1 - datetime.Day).AddDays(-1);
        }

        #endregion

        #region 动画变量

        public const Int32 AW_HIDE = 0x00010000;//隐藏窗口，缺省则显示窗口
        public const Int32 AW_ACTIVATE = 0x00020000;//激活窗口。在使用了AW_HIDE标志后不要使用这个标志

        public const Int32 AW_HOR_POSITIVE = 0x00000001;//自左向右显示窗口。该标志可以在滚动动画和滑动动画中使用。当使用AW_CENTER标志时，该标志将被忽略
        public const Int32 AW_HOR_NEGATIVE = 0x00000002;//自右向左显示窗口。当使用了 AW_CENTER 标志时该标志被忽略
        public const Int32 AW_VER_POSITIVE = 0x00000004;//自顶向下显示窗口。该标志可以在滚动动画和滑动动画中使用。当使用AW_CENTER标志时，该标志将被忽略
        public const Int32 AW_VER_NEGATIVE = 0x00000008;//自下向上显示窗口。该标志可以在滚动动画和滑动动画中使用。当使用AW_CENTER标志时，该标志将被忽略
        public const Int32 AW_CENTER = 0x00000010;//若使用了AW_HIDE标志，则使窗口向内重叠；若未使用AW_HIDE标志，则使窗口向外扩展
        public const Int32 AW_SLIDE = 0x00040000;//使用滑动类型。缺省则为滚动动画类型。当使用AW_CENTER标志时，这个标志就被忽略
        public const Int32 AW_BLEND = 0x00080000;//使用淡入效果。只有当hWnd为顶层窗口的时候才可以使用此标志

        [DllImport("user32.dll")]
        public static extern bool AnimateWindow(IntPtr hwnd, int dwTime, int dwFlags);

        #endregion 动画变量

        #region MD5

        public static string GetMd5(string strPwd)
        {
            MD5 md5 = new MD5CryptoServiceProvider();
            byte[] data = System.Text.Encoding.Default.GetBytes(strPwd);//将字符编码为一个字节序列 
            byte[] md5data = md5.ComputeHash(data);//计算data字节数组的哈希值 
            md5.Clear();
            string str = "";
            for (int i = 0; i < md5data.Length - 1; i++)
            {
                str += md5data[i].ToString("x").PadLeft(2, '0');
            }
            string str1=str.ToUpper();
            return str1;
        }


        public static string Get16Md5(string str)
        {
            string password = "";
            password = GetMd5(str);
            password = password.Substring(6,16);//为了与桌面程序的Delphi同步
            return password;
        }


        #endregion

        #region 单号

        /// <summary>
        /// 获取单号
        /// </summary>
        /// <param name="OppeDT">日期</param>
        /// <param name="TableName">表名</param>
        /// <param name="strBegin">前缀（采购入库 I、生产出库 O、采购退库 T、发料退库 B、生产补料 Q、成品入库 R、成品出库 X、盘点 P）</param>
        /// <returns></returns>
        public static string GetDONO(string OppeDT,string TableName,string strBegin)
        {   
            string strDONO=""; 
            if ((OppeDT == "") || (TableName==""))
            {
            }
            else
            {
                string temp = "select id from " + TableName + " where OpeeDT like '" + OppeDT + "%'";
                int i = PPDARHPRORETSYS.SQLHelper.GetDataCount(temp);
                i = i + 1;
                string strNo = "";
                if (i < 10)//至少两位  
                {
                    strNo = "0" + i.ToString();
                }
                else if (i >= 10)
                {
                    strNo =  i.ToString(); 
                }
                string OpeeDT1 = string.Format("{0:yyyyMMdd}", DateTime.Parse(OppeDT));
                strDONO = strBegin + OpeeDT1 + strNo;
            }
            return strDONO;
            // 例 Y2013032901
        }

        #endregion

        #region 单号 New

        /// <summary>
        /// 获取单号
        /// </summary>
        /// <param name="OppeDT">日期 【yyyy-MM-dd】</param>
        /// <param name="dt_no">日期2 【yyyyMMdd】</param>
        /// <param name="TableName">类型</param>
        /// <param name="strBegin">前缀（采购入库 I、生产出库 O、采购退库 T、发料退库 B、生产补料 Q、成品入库 R、成品出库 X、盘点 P）</param>
        /// <returns></returns>
        public static string GetDONO_New(string OppeDT, string dt_no, string sType, string strBegin)
        {
            string strDONO = "";
            if ((OppeDT == "") || (sType == ""))
            {
            }
            else
            {
               string strsql="declare @out nvarchar(15)  exec @out=ZP_getLotHistory_No ";
               strsql = strsql + "'" + OppeDT + "'";
               strsql = strsql + ",'" + dt_no + "'";
               strsql = strsql + ",'" + sType + "'";

               strDONO = strBegin+PPDARHPRORETSYS.SQLHelper.QueryForOneField(strsql, "outvalue");//outvalue 是写在存储过程里的
            }
            return strDONO;       // 例 Y2013032901
        }

        #endregion

        #region Loading
        
        public static void Loading(Boolean b)
        {
            System.Diagnostics.Process p = new System.Diagnostics.Process();

            if (b)
            {
                p.StartInfo.FileName = @"\Application\Startup\PleaseWait.exe"; //可执行程序在目录下
                p.StartInfo.UseShellExecute = false;

                //监视进程退出
                p.EnableRaisingEvents = true;
                //指定退出事件方法
                p.Exited += new EventHandler(p_Exited);

                p.Start();
            }
            else
            {
               // p.Kill();
            }
        }


        /// <summary>
        ///启动外部程序退出事件
        /// </summary>
        public static void p_Exited(object sender, EventArgs e)
        {
           // MessageBox.Show(String.Format("外部程序 {0} 已经退出！", this.appName), this.Text, MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        #endregion

        #region 分割字符串 
        
        // 成品（0 制令单）（1 品番）（2 数量）（3 批次）（4 制造部门）（5 库位）
       
        public static string[] SplitStr(string str, string strfenggefu)
        {
            char[] temp = strfenggefu.ToCharArray();
            string[] sArray = str.Split(temp);
            return sArray;
        }

        #endregion

        #region 解析数量单位，返回数量
        //如1500M → 1500 ，1500PCS→1500

        public static bool IsNumber(string str)
        {
            foreach (char c in str)
            {
                if (c < '0' || c > '9')
                {
                    return false;
                }
            }
            return true;
        }

        public static string SplitUnitQuat(string str)
        {
            string temp = "";
            for (int i = str.Length; i > 0; i--)
            {
                temp = str.Substring(0, i);
                if (IsNumber(temp) == true)
                {
                    break;
                }
            }
            
            return temp;
        }

        #endregion

        #region 检查原材料批次是否已经存在

      /// <summary>
        /// 验证批号是否已经存在
      /// </summary>
      /// <param name="strMatlLot">批号</param>
      /// <param name="TableName">表名</param>
      /// <param name="MatlLotFieldName">批号的字段名</param>
      /// <returns></returns>
        public static Boolean CheckMatlLot(string strMatlCode, string strMatlLot, string TableName, string MatlLotFieldName)
        {
            Boolean btemp = false;
            string temp = "select id from " + TableName + " where MatlCode=  '" + strMatlCode + "' and  " + MatlLotFieldName + "='" + strMatlLot + "'";
            int i = PPDARHPRORETSYS.SQLHelper.GetDataCount(temp); 
            if (i>0)  
            {
                btemp = true;
            }
            return btemp;          
        }

        #endregion

        #region 检查原材料流水号是否已经存在
    
        public static Boolean CheckMatlAutoLot(string strAutoLot)
        {
            Boolean btemp = false;
            string temp = "select id from MatlInDepotMX where AutoLot=  '" + strAutoLot + "'";
            int i = PPDARHPRORETSYS.SQLHelper.GetDataCount(temp);
            if (i > 0)
            {
                btemp = true;
            }
            return btemp;
        }

        #endregion

        #region 检查条形码是否正确（条形码上有数量，这个数量与数据库里边的库存数是否一致）

        public static Boolean CheckMatlBarCode(string strMatlCode, string strMatlLot, string strMatlLotStockQuat)
        {
            Boolean btemp = false;
            string temp = "select StockQuat from MatlInDepotMX where MIDDONO in (select MIDDONO from MatlInDepotZ where State='Y') and MatlCode=  '" + 
                strMatlCode + "' and MatlLot='" + strMatlLot + "'";//首先获取该批次的单号
            string strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "StockQuat");
            if (strMatlLotStockQuat == strTemp)
            {
                btemp = true;
            }
            return btemp;
        }

        #endregion

        #region 检查批次是不是最早的（先进先出）  
     
        public static string CheckMatlLotOrFirst(string strMatlCode, string strMatlLot)
        {
            string strRt = strMatlLot;
            string temp = "select MIDDONO from MatlInDepotMX where StockQuat>0 and MatlCode=  '" + strMatlCode + "' and MatlLot=  '" + strMatlLot + "'";//首先获取该批次的单号
            string strMIDDONO = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "MIDDONO");

            temp = "select MIDDONO from MatlInDepotMX where StockQuat>0 and MatlCode=  '" + strMatlCode + "' order by MIDDONO ASC";//获取含有该材料的单号
            DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(temp);
            if (ds.Tables[0].Rows.Count == 0)//没有记录说明没有库存，应该不存在这情况
            {
                strRt = ""; 
            }

            if (ds.Tables[0].Rows.Count == 1)//只有一条记录说明是最早的批次
            {
               // strRt = strMatlLot;
            }
            if (ds.Tables[0].Rows.Count > 1)//多跳记录
            {
                DataRow drs = ds.Tables[0].Rows[0];
                string strFirstDONO = drs["MIDDONO"].ToString().Trim();

                if (strFirstDONO == strMIDDONO)
                {
                    //
                }
                else
                {
                    temp = "select MatlLot from MatlInDepotMX where MatlCode=  '" + strMatlCode + "' and MIDDONO='" + strFirstDONO + "'";//获取最早批次
                    strRt = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "MatlLot");
                } 
            }


            return strRt;
        }

        #endregion

        #region 检查批次是不是最早的（先进先出）20130711

        public static Boolean CheckMatlLotOrFirst_20130711(string strMatlCode, string strMatlLot, string strMatlLotFirst)
        {
            Boolean btemp = true;
            string temp = "select MIDDONO from MatlInDepotMX where StockQuat>0 and MatlCode=  '" + strMatlCode + "' and MatlLot='" + strMatlLot + "'";//首先获取该批次的单号
            string strMIDDONO = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "MIDDONO");
            if (strMIDDONO != "")
            {
                temp = "select MIDDONO from MatlInDepotMX where StockQuat>0 and MatlCode=  '" + strMatlCode + "' order by MIDDONO ASC";//获取含有该材料的单号
                DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(temp);
                if (ds.Tables[0].Rows.Count == 0)//没有记录说明没有库存，应该不存在这情况
                {
                    btemp = false;
                }

                if (ds.Tables[0].Rows.Count == 1)//只有一条记录说明是最早的批次
                {
                    btemp = true;
                }
                if (ds.Tables[0].Rows.Count > 1)//多跳记录
                {
                    DataRow drs = ds.Tables[0].Rows[0];
                    string strFirstDONO = drs["MIDDONO"].ToString().Trim();

                    if (strFirstDONO == strMIDDONO)
                    {
                        btemp = true;
                    }
                    else
                    {
                        temp = "select MatlLot from MatlInDepotMX where MatlCode=  '" + strMatlCode + "' and MIDDONO='" + strFirstDONO + "'";//获取最早批次
                        strMatlLotFirst = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "MatlLot");
                    }
                }

            }
            return btemp;
        }

        #endregion

        #region 检查批次过期了没有 过期返回true

        public static Boolean CheckMatlLotGuoQiOrNo(string strMatlCode, string strMatlLot)
        {
            //首先查询原料有效年限，其次查询该批次的入库日期，最后比较得出结果  
            Boolean btemp = false;
            string temp = "select LostUsesDate from MatlInDepotMX where  MatlCode=  '" + strMatlCode + "' and MatlLot=  '" + strMatlLot + "'";//
            string strLostUsesDate = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "LostUsesDate");
            if (strLostUsesDate != "")
            {
                DateTime dtLostUsesDate = Convert.ToDateTime(strLostUsesDate);
                DateTime dtNow = DateTime.Now;
                if (dtNow > dtLostUsesDate)
                {
                    btemp = true; 
                }
            }
            return btemp;
        }

        #endregion

        #region 减库存 返回SQL 不去判断库存
        
        public static string DownStockQuat(string strMatlCode, string strMatlLot, string strDownQuat)
        {
            string exsql = "";
            exsql = "update MatlInDepotMX set StockQuat=StockQuat-" + strDownQuat + " where MIDDONO in (select MIDDONO from MatlInDepotZ where State='Y') and  MatlCode='" +
                strMatlCode + "' and MatlLot='" + strMatlLot + "';";
            return exsql;
        }

        #endregion

        #region 加库存 返回SQL

        /// <summary>
        /// 
        /// </summary>
        /// <param name="strMatlCode"></param>
        /// <param name="strMatlLot"></param>
        /// <param name="strMatlLotFirst"></param>
        /// <returns></returns>
        public static string AddStockQuat(string strMatlCode, string strMatlLot, string strAddQuat)
        {
            string exsql = "";
            exsql = "update MatlInDepotMX set StockQuat=StockQuat+" + strAddQuat + " where MIDDONO in (select MIDDONO from MatlInDepotZ where State='Y') and MatlCode='" +
                strMatlCode + "' and MatlLot='" + strMatlLot + "';";
            return exsql;            
        }

        #endregion

        #region 查询生产单总共入库了多少数量 一个生产单只会生产一个品番
       
        public static int GetEndProtQuatInDepotForProe(string ProeNo)
        {
            int iTemp = 0;
            string strsql = "select sum(EndProtQuat) EndProtQuat from EndProtInDepotZ where State='Y' and ERPPDNO='" + ProeNo + "'";
            DataSet ds = PPDARHPRORETSYS.SQLHelper.Query(strsql);
            if (ds.Tables[0].Rows.Count > 0)  //没有记录说明没有库存，应该不存在这情况
            {
                DataRow drs = ds.Tables[0].Rows[0];
                string strTemp = drs["EndProtQuat"].ToString().Trim();
                if (strTemp == "")
                {
                    strTemp = "0";
                }
                iTemp = Convert.ToInt16(strTemp);
            }
            return iTemp;            
        }

        #endregion

        #region 检查不良品的条形码是否可以被登记（无库存不可、已经登记过不可）

        public static Boolean CheckUMRecord(string strMatlCode, string strMatlLot, string strMatlLotStockQuat)
        {
            Boolean btemp = false;
            if (CheckMatlBarCode(strMatlCode, strMatlLot, strMatlLotStockQuat) == true)//先检查库存
            {
                string temp = "select id from UMRecord where MatlCode=  '" +
                    strMatlCode + "' and MatlLot='" + strMatlLot + "' and State='Y'";//首先获取该批次的单号
                int iTemp = PPDARHPRORETSYS.SQLHelper.GetDataCount(temp);
                if (iTemp>0)
                {
                    btemp = true;
                } 
            }
            return btemp;
        }

        #endregion

        #region 根据料号获取名称

        public static string GetMatlName(string strMatlCode)
        {
            //首先查询原料有效年限，其次查询该批次的入库日期，最后比较得出结果  
            string strTemp = "";
            string temp = "select MatlName from Material where  MatlCode=  '" + strMatlCode + "'";//
            strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "MatlName");
            return strTemp;
        }

        #endregion

        #region 根据料号获取仓库

        public static string GetMatlDepotCode(string strMatlCode)
        {
            //首先查询原料有效年限，其次查询该批次的入库日期，最后比较得出结果  
            string strTemp = "";
            string temp = "select DepotCode from Material where  MatlCode=  '" + strMatlCode + "'";//
            strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "DepotCode");
            return strTemp;
        }

        #endregion

        #region 根据料号获取库位

        public static string GetMatlShefCode(string strMatlCode)
        {
            //获取货架  
            string temp = "select ShefCode from Material where  MatlCode=  '" + strMatlCode + "'";//
            string strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "ShefCode");
            return strTemp;
        }

        #endregion

        #region 根据料号、日期获取失效日期

        public static string GetMatlLostUsesDate(string strMatlCode,string strOpeeDT)
        {
            //获取货架  
            string strTemp = "";
            string temp = "select ValidDate from Material where  MatlCode=  '" + strMatlCode + "'";//
            string strValidDate = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "ValidDate");
            if (strValidDate == "")
            {
                strValidDate = "12";
            }
            DateTime dt = Convert.ToDateTime(strOpeeDT);
            dt = dt.AddMonths(Convert.ToInt32(strValidDate));
            strTemp = string.Format("{0:yyyy-MM-dd}", dt);

            return strTemp;
        }

        #endregion

        #region 料号转换

        public static string ChangeMatlCode(string strMatlName, string strSuprCode)
        {
            //获取睿和料号  
            //string temp = "select MatlCode from Material where  MatlName=  '" + strMatlName + "'";//
         //   string temp = "select MatlCode from Material where  MatlBarCode=  '" + strMatlName + "'";
            string temp = "select MatlCode from Material where  MatlBarCode like   '%" + strMatlName + "%'";
            //2014年1月7日 15:11:24 一个会有多个条码 用like
            //2013年12月26日 16:08:13 由于睿和的料号和条码并不一致，所以加个条码标识

            if (strSuprCode != "")
            {
                temp = temp + " and  SuprCode=  '" + strSuprCode + "'";
            }
            string strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "MatlCode");
            return strTemp;
        }

        #endregion
      
        #region 获取供应商代码

        public static string GetSuprCode(string strMatlCode)
        {
            string temp = "select SuprCode from Material where  MatlCode=  '" + strMatlCode + "'";
            string strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "SuprCode");
            return strTemp;
        }

        #endregion

        #region PDA LOG

        public static int AddPDA_Operlog(string strLog)
        {
            if (Func.PublicFuncProc.Globe.ZsbBOnLine == false)
            {
                return 1;
            }
            DateTime dt = DateTime.Now;
            string OpeeDT = string.Format("{0:yyyy-MM-dd HH:mm:ss}", dt);

            string exsql = "insert into PDA_OperLog(PDADT,Text,un)values('" +
                OpeeDT + "','" + strLog + "','" + Func.PublicFuncProc.Globe.ZsbStrUser + "');";
            //MessageBox.Show(exsql);
            //int i = 0;
            int i = PPDARHPRORETSYS.SQLHelper.ExecuteSql(exsql);
            return i;
        }

        #endregion

        #region 更改PDA在线状态

        public static int ChangePDAOnLine(int iMode)
        {
            if (Func.PublicFuncProc.Globe.ZsbBOnLine == false)
            {
                return 1;
            }
            string exsql = "update staff set PDAOnLine= " + iMode + " where usercode='" + Func.PublicFuncProc.Globe.ZsbStrUserCode + "'";
            //MessageBox.Show(exsql);
            //int i = 0;
            int i = PPDARHPRORETSYS.SQLHelper.ExecuteSql(exsql);
            return i;
        }

        #endregion

        #region 获取供应商代码  2015 年应该删除
        // 因为二维码的错误，本来是供应商代码的却填成了对方料号，因此在此验证一下是否就是供应商代号
        public static string GetSuprCodeXXX(string strCode)
        {
            string temp = "select top 1 SuprCode from Material where  SuprCode=  '" + strCode + "'";
            string strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "SuprCode");
            if (strCode == strTemp)
            {
                return strCode;
            }
            else
            {
                temp = "select top 1 SuprCode from Material where  MatlName=  '" + strCode + "'";
                return strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "SuprCode");
            }
        }

        #endregion

        #region 获取原料需要发料的数量（后工程）  
        public static string GetNeedOutNum_Matl(string strCode,string ML_NO)
        {
            string temp = "select MatlQuat-MatlQuatAlreadyOut ND from LZm_ML_NO_FromErp where ML_NO= '" + ML_NO + "'and MatlLot='" + strCode + "'";
            temp = temp + " and ML_NO in (select ML_NO from LZz_ML_NO_FromErp where state in('2.待发料','3.发料中'))";
            string strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "ND");
            return strTemp;
        }

        #endregion

        #region 获取原料需要发料的数量（前工程）
        public static string GetNeedOutNum_Matl_Qian(string strCode, string QCNO)
        {
            string temp = "select SCLL-MatlQuatAlreadyOut ND from QGCFLHZMx where QCNO= '" + QCNO + "'and MatlLot='" + strCode + "'";
            temp = temp + " and QCNo in (select QCNo from QGCFLHZ where state in('2.待发料','3.发料中'))";
            string strTemp = PPDARHPRORETSYS.SQLHelper.QueryForOneField(temp, "ND");
            return strTemp;
        }

        #endregion

        
    }
}
