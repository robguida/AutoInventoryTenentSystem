using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Lib
{
    public class DBService
    {
        private string ConnectionString { get; set; }

        public enum RequestType { DataSet = 1, DataTable, DataRow, Reader, Scalar, NonQuery }

        public DBService()
        {
            this.ConnectionString = ConfigurationManager.ConnectionStrings["NomadEcommerceDev"].ConnectionString;
        }

        public static DBService Init
        {
            get
            {
                return new DBService();
            }
        }

        public object Execute(string storedProcedure, List<SqlParameter> parameters, RequestType type)
        {
            object output = null;
            SqlConnection sqlSACConnection = new SqlConnection(this.ConnectionString);
            sqlSACConnection.Open();
            using (SqlCommand sqlcmd = new SqlCommand(storedProcedure, sqlSACConnection))
            {
                if (parameters != null)
                {
                    foreach (SqlParameter sqlParameter in parameters)
                    {
                        sqlcmd.Parameters.Add(sqlParameter);
                    }
                }
                sqlcmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    switch (type)
                    {
                        case RequestType.Reader:
                            output = sqlcmd.ExecuteReader(CommandBehavior.CloseConnection);
                            break;
                        case RequestType.DataSet:
                            output = this.GetDataSet(sqlcmd);
                            break;
                        case RequestType.DataTable:
                            output = this.GetLastDataTable(sqlcmd);
                            break;
                        case RequestType.DataRow:
                            output = this.GetFirstDataRow(sqlcmd);
                            break;
                        case RequestType.Scalar:
                            output = sqlcmd.ExecuteScalar();
                            break;
                        default:
                            sqlcmd.ExecuteNonQuery();
                            break;
                    }
                }
                catch (Exception ex)
                {
                    sqlcmd.Parameters.Clear();
                    if (type == RequestType.Reader)
                    {
                        sqlSACConnection.Dispose();
                    }
                    throw ex;
                }
                finally
                {
                    //Closes the connection; we are done with is unless we have created a reader
                    //which will close itself.
                    if (type != RequestType.Reader)
                    {
                        sqlSACConnection.Dispose();
                    }
                    sqlcmd.Parameters.Clear();
                }
            }
            return output;
        }

        private DataSet GetDataSet(SqlCommand sqlcmd)
        {
            DataSet ds = new DataSet();
            SqlDataAdapter sqladapter;
            sqladapter = new SqlDataAdapter(sqlcmd);
            _ = sqladapter.Fill(ds);
            return ds;
        }

        private DataTable GetLastDataTable(SqlCommand sqlcmd)
        {
            DataTable output = new DataTable();
            DataSet ds = this.GetDataSet(sqlcmd);
            if (null != ds && 0 < ds.Tables.Count && 0 < ds.Tables[ds.Tables.Count - 1].Rows.Count)
            {
                output = ds.Tables[ds.Tables.Count - 1];
            }
            return output;
        }

        private DataRow GetFirstDataRow(SqlCommand sqlcmd)
        {
            DataRow output = null;
            DataTable dt = this.GetLastDataTable(sqlcmd);
            if (null != dt && 0 < dt.Rows.Count)
            {
                output = dt.Rows[0];
            }
            return output;
        }
    }
}