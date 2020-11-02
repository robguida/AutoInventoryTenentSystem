using NomadEcommerce.Model;
using System;
using System.Collections.Generic;
using System.Data;
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
            DataTable output = new DataTable("Auto");
            //output.Columns.Add("AutoId", Type.GetType("System.Int32"));
            //output.Columns.Add("AutoInventoryId", Type.GetType("System.Int32"));
            //output.Columns.Add("Model", Type.GetType("System.String"));
            //output.Columns.Add("Classifications", Type.GetType("System.String"));
            //output.Columns.Add("VIN", Type.GetType("System.String"));
            //output.Columns.Add("Color", Type.GetType("System.String"));
            //output.Columns.Add("Trim Level", Type.GetType("System.String"));
            //output.Columns.Add("Doors", Type.GetType("System.Int32"));

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