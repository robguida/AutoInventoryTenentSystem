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

        public DataTable List(string ColumnName = null, string SearchTerm = null, string OrderBy = "ModelNumber ASC", int PageOffset = 0, int PagingLimit = 50)
        {
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@OrderBy", OrderBy),
                new SqlParameter("@PagingOffset", PageOffset),
                new SqlParameter("@PagingLimit", PagingLimit)
            };

            if (null != ColumnName && null != SearchTerm)
            {
                string SearchParameter = "@" + ColumnName;
                parameters.Add(new SqlParameter(SearchParameter, SearchTerm));
           }

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


        public AutoInventoryModel Update(string AutoInventoryId, string ModelNumber, string Classification, string VIN, string ColorId, string TrimId, string Doors)
        {
            AutoInventoryModel AIM = AutoInventoryModel.LoadFromId(Int32.Parse(AutoInventoryId));
            AIM.VIN = VIN;
            AIM.AutoColorId = Int32.Parse(ColorId);
            AIM.AutoTrimId = Int32.Parse(TrimId);
            AIM.Doors = Int32.Parse(Doors);
            AIM.Update();

            AutoModel AM = AutoModel.LoadFromId(AIM.AutoId);
            AM.ModelNumber = ModelNumber;
            AM.Classification = Classification;
            AM.Update();

            return AIM;
        }

        public bool Delete(int AutoInventoryId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@AutoId", AutoInventoryId)
            };
            return this.Delete(parameters);            
        }
    }
}