using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Model
{
    public class AutoModel : AbstractModel
    {
        public int AutoId { get; set; }
        public int TenentId { get; set; }
        public string ModelNumber { get; set; }
        public string Classification { get; set; }

        public AutoModel() { }

        public static AutoModel LoadModel(int TenentId, string ModelNumber, string Classification)
        {
            AutoModel output = new AutoModel
            {
                TenentId = TenentId,
                ModelNumber = ModelNumber,
                Classification = Classification
            };
            return output;
        }

        protected override void SetTable()
        {
            this.TableName = "Auto";
        }
    }
}