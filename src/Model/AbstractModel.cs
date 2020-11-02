using NomadEcommerce.Lib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Model
{
    public abstract class AbstractModel
    {
        private DBService DB { get; set; }
        protected DBService Db { get { return this.DB; } }

        protected DateTime _DateCreated { get; set; }
        public DateTime DateCreated { get { return this._DateCreated; } }

        protected string TableName { get; set; }

        protected string CreateProcedure { get { return "sp" + this.TableName + "_Create"; } }
        protected string ReadProcedure { get { return "sp" + this.TableName + "_Read"; } }
        protected string UpdateProcedure { get { return "sp" + this.TableName + "_Update"; } }

        abstract protected void SetTable();

        protected AbstractModel()
        {
            this.DB = DBService.Init;
            this.SetTable();
        }

        protected int Create(List<SqlParameter> parameters)
        {
            int output = 0;
            this.AddTenentId(ref parameters);
            object result = this.DB.Execute(this.CreateProcedure, parameters, DBService.RequestType.Scalar);
            if (null != result)
            {
                output = Int32.Parse(result.ToString());
            }
            return output;
        }

        protected DataRow Read(List<SqlParameter> parameters)
        {
            DataRow output = null;
            this.AddTenentId(ref parameters);
            object result = this.DB.Execute(this.ReadProcedure, parameters, DBService.RequestType.Scalar);
            if (null != result)
            {
                output = (DataRow)result;
            }
            return output;
        }

        protected DataRow Update(List<SqlParameter> parameters)
        {
            this.AddTenentId(ref parameters);
            this.DB.Execute(this.UpdateProcedure, parameters, DBService.RequestType.Scalar);
            return this.Read(parameters);
        }

        private void AddTenentId(ref List<SqlParameter> parameters)
        {
            if ("Tenent" != this.TableName)
            {
                parameters.Add(new SqlParameter("@TenentId", SessionModel.Current().TenentId));
            }
        }
    }
}