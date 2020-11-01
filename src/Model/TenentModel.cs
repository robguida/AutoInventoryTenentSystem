using NomadEcommerce.Lib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Model
{
    public class TenentModel : AbstractModel
    {
        public int TenentId { get; set; }

        public string TenentName { get; set; }

        public Byte[] TenentHeaderBanner { get; set; }

        public string TenentDomain { get; set; }


        public TenentModel() { }

        public static TenentModel LoadModel(string TenentName, string TenentDomain)
        {
            TenentModel output = new TenentModel
            {
                TenentName = TenentName,
                TenentDomain = TenentDomain
            };
            return output;
        }

        public static TenentModel LoadModel(DataRow dr)
        {
            TenentModel output = new TenentModel
            {
                TenentId = dr.Field<int>("TenentId"),
                TenentName = dr.Field<string>("TenentName"),
                TenentDomain = dr.Field<string>("TenentDomain")
            };
            return output;
        }


        public int Create()
        {
            List<SqlParameter> parameters = new List<SqlParameter>() {
                new SqlParameter("@TenentName", this.TenentName),
                new SqlParameter("@TenentDomain", this.TenentDomain)
            };
            return this.Create(parameters);
        }

        protected override void SetTable()
        {
            this.TableName = "Tenent";
        }
    }
}