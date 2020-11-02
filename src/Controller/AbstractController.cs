﻿using NomadEcommerce.Lib;
using NomadEcommerce.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace NomadEcommerce.Controller
{
    public abstract class AbstractController
    {
        private DBService DB { get; set; }
        protected DBService Db { get { return this.DB; } }

        protected string TableName { get; set; }

        protected string ListProcedure { get { return "sp" + this.TableName + "_List"; } }
       
        abstract protected void SetTable();

        protected AbstractController()
        {
            this.DB = DBService.Init;
            this.SetTable();
        }

        protected DataTable List(List<SqlParameter> parameters)
        {
            DataTable output = new DataTable();
            this.AddTenentId(ref parameters);
            object result = this.DB.Execute(this.ListProcedure, parameters, DBService.RequestType.DataTable);
            if (null != result)
            {
                output = (DataTable)result;
            }
            return output;
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