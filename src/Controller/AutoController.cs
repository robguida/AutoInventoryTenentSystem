using NomadEcommerce.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Controller
{
    public class AutoController : AbstractController
    {
        protected override void SetTable()
        {
            this.TableName = "Auto";
        }

        public DataTable List()
        {
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@OrderBy", "ModelNumber ASC"),
                new SqlParameter("@PagingOffset", 0),
                new SqlParameter("@PagingLimit", 50)
            };
            DataTable output = this.List(parameters);
            return output;
        }

        public AutoInventoryModel Create(string ModelNumber, string Classification, string VIN, string ColorId, string TrimId, string Doors)
        {
            AutoInventoryModel AIM = new AutoInventoryModel();
            AutoModel AM = AutoModel.LoadModel(ModelNumber, Classification).Create();
            if (0 < AM.AutoId)
            {
                AIM = AutoInventoryModel.LoadModel(AM.AutoId, VIN, Int32.Parse(ColorId), Int32.Parse(TrimId), Int32.Parse(Doors)).Create();
            }
            return AIM;
        }
    }
}