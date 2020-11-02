using NomadEcommerce.Lib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Model
{
    public class AutoModel : AbstractModel
    {
        public int AutoId { get; set; }
        public int TenentId { get; set; }
        public string ModelNumber { get; set; }
        private string classification { get; set; }
        public string Classification {
            get
            {
                return this.classification;
            }
            set
            {
                if (!AutoClassificatioEnum.Exists(value))
                {
                    throw new Exception("The Classification is not recognized");
                }
                this.classification = value;
            }
        }

        public AutoModel() { }

        public static AutoModel LoadModel(string ModelNumber, string Classification)
        {
            AutoModel output = new AutoModel
            {
                ModelNumber = ModelNumber,
                Classification = Classification
            };
            return output;
        }

        public static AutoModel LoadFromId(int AutoId)
        {
            AutoModel output = new AutoModel();
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@AutoId", AutoId)
            };
            DataRow dr = output.Read(parameters);
            if (null != dr)
            {
                output.AutoId = dr.Field<int>("AutoId");
                output.TenentId = dr.Field<int>("TenentId");
                output.ModelNumber = dr.Field<string>("ModelNumber");
                output.classification = dr.Field<string>("classification");
            }
            return output;
        }

        protected override void SetTable()
        {
            this.TableName = "Auto";
        }

        public AutoModel Create()
        {
            if (0 >= this.ModelNumber.Length)
            {
                throw new Exception("A Model is required to create an auto");
            }
            if (0 >= this.classification.Length)
            {
                throw new Exception("A Classification is required to create an auto");
            }
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@ModelNumber", this.ModelNumber),
                new SqlParameter("@Classification", this.classification)
            };
            int result = this.Create(parameters);
            if (0 < result)
            {
                this.TenentId = SessionModel.Current().TenentId;
                this.AutoId = result;
            }
            return this;
        }
        public bool Update()
        {
            if (0 >= this.AutoId)
            {
                throw new Exception("The Auto record id is required to update an auto");
            }
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@AutoId", this.AutoId),
                new SqlParameter("@ModelNumber", this.ModelNumber),
                new SqlParameter("@Classification", this.classification)
            };
            DataRow result = this.Update(parameters);
            return (null != result);
        }
    }
}