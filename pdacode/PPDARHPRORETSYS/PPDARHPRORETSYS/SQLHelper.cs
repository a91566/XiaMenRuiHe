using System;
using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Collections;
using System.Xml;
using System.Reflection;
using System.IO;

namespace PPDARHPRORETSYS
{
    public class SQLHelper
    {
        private static string connectionString = ReadXmlFirst(null);//数据库连接字符串

        private static SqlConnection connection;  //公用连接

        private static int ErrorCode = -1;   //错误代码

        public static string ReadXmlFirst(string configStr) //读取xml文件中的字符串
        {
            
            string constr = string.Empty;//==连接字符串
            try
              {
                string filePath = @"\Application\Startup\IpConfig.txt";
                if (string.IsNullOrEmpty(configStr))
                {
                    Stream stream = new FileStream(filePath, FileMode.Open);
                    StreamReader sr = new StreamReader(stream);
                    string serverIp = sr.ReadToEnd().Trim();
                    sr.Close();
                    stream.Close();

                    if (string.IsNullOrEmpty(serverIp))
                    {
                        throw new Exception("应用程序配置文件（.txt)文件无数据！");
                    }
                    else
                    {
                       // constr = "Server=" + serverIp + ";DataBase=RuiHe;User ID=sa;Password=;Persist Security Info=True;";
                        constr = "Server=" + serverIp + ";DataBase=RuiHe;User ID=sa;Password=9106a00215;Persist Security Info=True;";//RH password:9106a00215
                    }

                }
                else
                {
                    //==Ip配置文件存在 就直接替换 否则直接创建在写入
                    if (!File.Exists(filePath))
                    {
                        Stream stream = new FileStream(filePath, FileMode.Create);
                        StreamWriter sw = new StreamWriter(stream);
                        sw.Write(configStr);
                        sw.Flush();
                        sw.Close();
                        stream.Close();
                    }
                    else
                    {
                        Stream stream = new FileStream(filePath, FileMode.Create);
                        StreamWriter sw = new StreamWriter(stream);
                        sw.Write(configStr);
                        sw.Flush();
                        sw.Close();
                        stream.Close();
                    }
                }
            }
            catch(Exception ex)
            {
                throw new Exception("本地数据库配置文件异常"+ex.Message);
            }
            return constr;    //连接字符串  
            //return "Data Source=192.168.18.101;Initial Catalog=XMTM;User ID=sa;pwd=123;";

        }

        /// <summary>
        /// 创建公用连接
        /// </summary>
        /// <returns></returns>
        private static void GetConnection()
        {
            connection = new SqlConnection(connectionString);
            try
            {
            if (connection.State != ConnectionState.Open)
                connection.Open();
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 关闭公用连接
        /// </summary>
        private static void CloseConnection()
        {
            if (connection.State == ConnectionState.Open)
                connection.Close();

        }

        #region 判断是否是存储过程
        /// <summary>
        /// 判断是否是存储过程
        /// </summary>
        /// <param name="cmdText">sql 查询语句</param>
        /// <returns></returns>
        private static bool IsProcedure(string cmdText)
        {
            if (cmdText.Contains(" "))
            {
                string[] tam = cmdText.Split(' ');

                if (tam[0].Equals("EXECUTE", StringComparison.OrdinalIgnoreCase)
                    || tam[0].Equals("EXEC", StringComparison.OrdinalIgnoreCase))//StringComparison.OrdinalIgnoreCase 不区分大小写
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return true;
            }
        }
        #endregion

        /// <summary>
        /// 执行查询语句，返回DataSet对象
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(string SQLString)
        {
            GetConnection();
            DataSet ds = new DataSet();
            try
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                command.Fill(ds, "ds");
                CloseConnection();

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }
            return ds;
        }


        /// <summary>
        /// 执行带参数sql语句，返回字段值，如果多跳记录返回为空
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public static string QueryForOneField(string SQLString, string strFieldName)
        {
            GetConnection();
            DataSet ds = new DataSet();
            string resutlstr = "";
            try
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                command.Fill(ds, "ds");

                if (ds.Tables[0].Rows.Count == 1)
                {
                    DataRow drs = ds.Tables[0].Rows[0];
                    resutlstr = drs[strFieldName].ToString().Trim();
                }

                CloseConnection();

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return resutlstr;
        } 

        /// <summary>
        /// 返回记录数
        /// </summary>
        /// <param name="SQLString"></param>
        /// <returns></returns>
        public static int GetDataCount(string SQLString)
        {
            GetConnection();
            DataSet ds = new DataSet();
            int iCount = 0;
            try
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);
                command.Fill(ds, "ds");
                iCount = ds.Tables[0].Rows.Count;
                CloseConnection();

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }
            return iCount;
        }

        /// <summary>
        /// 执行带参数sql语句，返回DataSet对象
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns>DataSet</returns>
        public static DataSet Query(string SQLString, SqlParameter[] parameters)
        {
            GetConnection();
            DataSet ds = new DataSet();    
            try
            { 
                if (connection.State != ConnectionState.Open)
                    connection.Open(); 
                SqlDataAdapter command = new SqlDataAdapter(SQLString, connection);  
                if (IsProcedure(SQLString))
                {
                    command.SelectCommand.CommandType = CommandType.StoredProcedure;    
                }
                else
                {
                    command.SelectCommand.CommandType = CommandType.Text;
                }                
                foreach (SqlParameter parameter in parameters)
                {
                    command.SelectCommand.Parameters.Add(parameter);
                }
                command.Fill(ds, "ds");
                CloseConnection();

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }
           
            return ds;
        }


        /// <summary>
        /// 执行SQL语句，返回影响的记录数
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数,若有异常则返回错误代码</returns>
        public static int ExecuteSql(string SQLString)
        {
            GetConnection();
            using (SqlCommand cmd = new SqlCommand(SQLString, connection))
            {
                try
                {
                    if (connection.State != ConnectionState.Open)
                        connection.Open();
                    int rows = cmd.ExecuteNonQuery();
                    CloseConnection();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException)
                {
                    CloseConnection();
                    return ErrorCode;
                }
            }

        }

        /// <summary>
        /// 执行带参数存储过程语句，返回最后一个输出参数
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数,若有异常则返回错误代码</returns>
        public static object  ExecuteSql(string SQLString, SqlParameter[] parameters)
        {
            GetConnection();
            object out_result = null;

            using (SqlCommand cmd = new SqlCommand(SQLString, connection))
            {
                try
                {
                    if (connection.State != ConnectionState.Open)
                        connection.Open();
                    foreach (SqlParameter parameter in parameters)
                    {
                        cmd.Parameters.Add(parameter);
                    }
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                    out_result = parameters[parameters.Length - 1].Value;

                    CloseConnection();
                   
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    CloseConnection();
                    throw new Exception(ex.Message);
                }
            }
            return out_result;

        }

        public static int Execute(string SQLString, SqlParameter[] parameters)
        {
            GetConnection();
            int out_result=0;

            using (SqlCommand cmd = new SqlCommand(SQLString, connection))
            {
                try
                {
                    if (connection.State != ConnectionState.Open)
                        connection.Open();
                    foreach (SqlParameter parameter in parameters)
                    {
                        cmd.Parameters.Add(parameter);
                    }
                    cmd.CommandType = CommandType.Text;
                    out_result=cmd.ExecuteNonQuery();  
                    CloseConnection();
                   
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    
                    CloseConnection(); 
                    throw new Exception(ex.Message);         
                    //return ErrorCode;
                }
            } 
            return out_result;

        }

        /// <summary>
        /// 执行存储过程，返回影响的记录数
        /// </summary>
        /// <param name="SQLString">SQL语句</param>
        /// <returns>影响的记录数,若有异常则返回错误代码</returns>
        public static int ExecuteStoredProcedure(string StoredProcedureStr, SqlParameter[] parameters)
        {
            GetConnection();
            using (SqlCommand cmd = new SqlCommand(StoredProcedureStr, connection))
            {
                try
                {
                    if (connection.State != ConnectionState.Open)
                    {
                        connection.Open();
                    }
                    foreach (SqlParameter parameter in parameters)
                    {
                        cmd.Parameters.Add(parameter);
                    }
                    cmd.CommandType = CommandType.StoredProcedure;
                    int rows = cmd.ExecuteNonQuery();
                    CloseConnection();
                    return rows;
                }
                catch (System.Data.SqlClient.SqlException)
                {
                    CloseConnection();
                    return ErrorCode;
                }
            }

        }

        /// <summary>
        /// 执行sql语句，返回DataReader对象
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns></returns>
        public static SqlDataReader ExecuteDataReader(string SQLString, SqlParameter[] parameters)
        {
            GetConnection();
            using (SqlCommand cmd = new SqlCommand(SQLString, connection))
            {
                try
                {
                    if (connection.State != ConnectionState.Open)
                        connection.Open();
                    foreach (SqlParameter parameter in parameters)
                    {
                        cmd.Parameters.Add(parameter);
                    }
                    cmd.CommandType = CommandType.Text;
                    SqlDataReader dr = cmd.ExecuteReader();
                   // CloseConnection();
                    return dr;
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    CloseConnection();
                    throw new Exception(ex.Message);
                }      
            }
        }

        /// <summary>
        /// 执行带参数sql语句，返回DataReader对象
        /// </summary>
        /// <param name="SQLString">查询语句</param>
        /// <returns></returns>
        public static SqlDataReader ExecuteDataReader(string SQLString)
        {
            GetConnection();
            using (SqlCommand cmd = new SqlCommand(SQLString, connection))
            {
                try
                {
                    if (connection.State != ConnectionState.Open)
                        connection.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    CloseConnection();
                    return dr;
                }
                catch (System.Data.SqlClient.SqlException ex)
                {
                    CloseConnection();
                    throw new Exception(ex.Message);
                }
                finally
                {
                    CloseConnection();
                }
            }
        }

        /// <summary>
        /// 执行多条SQL语句，实现数据库事务。
        /// </summary>
        /// <param name="SQLStringList">多条SQL语句</param>        
        public static void ExecuteSqlTran(ArrayList SQLStringList)
        {
            GetConnection();
            if (connection.State != ConnectionState.Open)
                connection.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = connection;
            SqlTransaction tx = connection.BeginTransaction();
            cmd.Transaction = tx;
            try
            {
                for (int n = 0; n < SQLStringList.Count; n++)
                {
                    string strsql = SQLStringList[n].ToString();
                    if (strsql.Trim().Length > 1)
                    {
                        cmd.CommandText = strsql;
                        cmd.ExecuteNonQuery();
                    }
                }
                tx.Commit();
                CloseConnection();
            }
            catch (System.Data.SqlClient.SqlException E)
            {
                tx.Rollback();
                throw new Exception(E.Message);
            }
        }

        /// <summary>
        /// 执行SELECT查询语句，并将结果以TABLE的形式加入到指定DataSet数据集；
        /// 可以执行多条SELECT查询语句，查询语句之间用分号标记，如下所示：
        /// SELECT * FROM TABLE1;SELECT * FROM TABLE2
        /// </summary>
        /// <param name="sqlQuery">SQL语句</param>
        /// <param name="dsTarget">已存在的DataSet数据集</param>
        /// <returns>返回DataSet数据集</returns>
        public static DataSet GetDataSet(string sqlQuery, DataSet dsTarget)
        {
            GetConnection();
            if (connection.State != ConnectionState.Open)
                connection.Open();
            SqlCommand cmd =  cmd = new SqlCommand(sqlQuery,connection);
            SqlDataAdapter da = null;
            SqlTransaction trans = connection.BeginTransaction();
            int i = 0;
            try
            {
               
                cmd.Transaction = trans;
                string[] strSqls = sqlQuery.Split(';');
                foreach (string strSql in strSqls)
                {
                    i++;
                    da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    DataTable dt = ds.Tables[0].Clone();
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        dt.ImportRow(dr);
                    }
                    dt.TableName = i.ToString();
                    dsTarget.Tables.Add(dt);
                }
                trans.Commit();
                CloseConnection();
            }
            catch
            {
                da.Dispose();
                cmd.Dispose();
                trans.Rollback();
                CloseConnection();
                connection.Dispose();

            }
            finally
            {
                da.Dispose();
                cmd.Dispose();
                CloseConnection();
                connection.Dispose();
            }
            return dsTarget;
        }

        /// <summary>
        /// 根据SQL语句创建DataSet数据集；
        /// 可以执行多条SELECT查询语句，查询语句之间用分号标记，如下所示：
        /// SELECT * FROM TABLE1;SELECT * FROM TABLE2
        /// </summary>
        /// <param name="sqlQuery">SQL语句</param>
        /// <returns>返回DataSet数据集</returns>
        public static DataSet GetDataSet(string sqlQuery)
        {
            GetConnection();
            SqlCommand cmd = null;
            SqlDataAdapter da = null;
            DataSet dsResult = new DataSet();
            SqlTransaction trans = connection.BeginTransaction();
            int i = 0;
            try
            {
                string[] strSqls = sqlQuery.Split(';');
                foreach (string strSql in strSqls)
                {
                    i++;
                    cmd = new SqlCommand(strSql, connection);
                    cmd.Transaction = trans;
                    da = new SqlDataAdapter(cmd);

                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    if (strSqls.Length == 1)
                    {
                        dsResult = ds;
                    }
                    else
                    {

                        DataTable dt = ds.Tables[0].Clone();
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                            dt.ImportRow(dr);
                        }
                        dt.TableName = i.ToString();
                        dsResult.Tables.Add(dt);

                    }

                }
                trans.Commit();
            }
            catch (SqlException ex)
            {

                da.Dispose();
                cmd.Dispose();
                trans.Rollback();
                CloseConnection();
                connection.Dispose();
                throw new Exception(ex.Message);
            }
            finally
            {
                da.Dispose();
                cmd.Dispose();
                CloseConnection();
                connection.Dispose();
            }

            return dsResult;
        }

        #region 获取日期 格式：2012-12-10 
        public static string GetSysDate()
        {
            GetConnection();
            DataSet ds = new DataSet();
            string resutlstr = "";
            try
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                SqlDataAdapter command = new SqlDataAdapter("select CONVERT(varchar(12) , getdate(), 23) DT", connection);
                command.Fill(ds, "ds");

                if (ds.Tables[0].Rows.Count == 1)
                {
                    DataRow drs = ds.Tables[0].Rows[0];
                    resutlstr = drs["DT"].ToString().Trim();
                }

                CloseConnection();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return resutlstr;
        } 

        #endregion

        #region 获取日期 格式：20121210
        public static string GetSysDate_XX()
        {
            GetConnection();
            DataSet ds = new DataSet();
            string resutlstr = "";
            try
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                SqlDataAdapter command = new SqlDataAdapter("select CONVERT(varchar(12) , getdate(), 112) DT", connection);
                command.Fill(ds, "ds");

                if (ds.Tables[0].Rows.Count == 1)
                {
                    DataRow drs = ds.Tables[0].Rows[0];
                    resutlstr = drs["DT"].ToString().Trim();
                }

                CloseConnection();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return resutlstr;
        }

        #endregion

        #region 获取时间 格式：15:52:48
        public static string GetSysTime()
        {
            GetConnection();
            DataSet ds = new DataSet();
            string resutlstr = "";
            try
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                SqlDataAdapter command = new SqlDataAdapter("select CONVERT(varchar(12) , getdate(), 108) DT", connection);
                command.Fill(ds, "ds");

                if (ds.Tables[0].Rows.Count == 1)
                {
                    DataRow drs = ds.Tables[0].Rows[0];
                    resutlstr = drs["DT"].ToString().Trim();
                }

                CloseConnection();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return resutlstr;
        }

        #endregion

        #region 获取日期时间  格式：2012-12-10 15:52:48
        public static string GetSysDateTime()
        {
            GetConnection();
            DataSet ds = new DataSet();
            string resutlstr = "";
            try
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                SqlDataAdapter command = new SqlDataAdapter("select CONVERT(varchar, getdate(), 120 ) DT;", connection);
                command.Fill(ds, "ds");

                if (ds.Tables[0].Rows.Count == 1)
                {
                    DataRow drs = ds.Tables[0].Rows[0];
                    resutlstr = drs["DT"].ToString().Trim();
                }

                CloseConnection();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return resutlstr;
        }

        #endregion
        
    }
}
