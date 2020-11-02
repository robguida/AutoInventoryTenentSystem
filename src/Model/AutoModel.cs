using NomadEcommerce.Lib;
using System;
using System.Collections.Generic;
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
    }
}