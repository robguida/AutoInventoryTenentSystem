using NomadEcommerce.Lib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Model
{
    public class AutoInventoryModel : AbstractModel
    {
        public int AutoInventoryId { get; set; }
        public int AutoId { get; set; }
        public int TenentId { get; set; }
        public string VIN { get; set; }
        public int AutoColorId { get; set; }
        public int AutoTrimId { get; set; }
        public int Doors { get; set; }

        public AutoInventoryModel() { }

        public static AutoInventoryModel LoadModel(int AutoId, string VIN, int AutoColorId, int AutoTrimId, int Doors)
        {
            AutoInventoryModel output = new AutoInventoryModel
            {
                AutoId = AutoId,
                VIN = VIN,
                AutoColorId = AutoColorId,
                AutoTrimId = AutoTrimId,
                Doors = Doors
            };
            return output;
        }

        protected override void SetTable()
        {
            this.TableName = "AutoInventory";
        }

        public static AutoInventoryModel LoadFromId(int AutoInventoryId)
        {
            AutoInventoryModel output = new AutoInventoryModel();
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@AutoInventoryId", AutoInventoryId)
            };
            DataRow dr = output.Read(parameters);
            if (null != dr)
            {
                output.AutoInventoryId = dr.Field<int>("AutoInventoryId");
                output.AutoId = dr.Field<int>("AutoId");
                output.TenentId = dr.Field<int>("TenentId");
                output.VIN = dr.Field<string>("VIN");
                output.AutoColorId = dr.Field<int>("AutoColorId");
                output.AutoTrimId = dr.Field<int>("AutoTrimId");
                output.Doors = dr.Field<int>("Doors");
            }
            return output;
        }

        public AutoInventoryModel Create()
        {
            if (0 >= this.AutoId)
            {
                throw new Exception("An Auto is required to create an auto");
            }
            if (0 >= this.AutoColorId)
            {
                throw new Exception("A Color is required to create an auto");
            }
            if (0 >= this.AutoTrimId)
            {
                throw new Exception("A Trim Level is required to create an auto");
            }
            if (0 >= this.AutoTrimId)
            {
                throw new Exception("A Trim Level is required to create an auto");
            }
            if (0 >= this.Doors)
            {
                throw new Exception("A VIN is required to create an auto");
            }

            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@AutoId", this.AutoId),
                new SqlParameter("@AutoColorId", this.AutoColorId),
                new SqlParameter("@AutoTrimId", this.AutoTrimId),
                new SqlParameter("@VIN", this.VIN),
                new SqlParameter("@Doors", this.Doors)
            };
            int result = this.Create(parameters);
            if (0 < result)
            {
                this.TenentId = SessionModel.Current().TenentId;
                this.AutoInventoryId = result;
            }
            return this;
        }

        public bool Update()
        {
            if (0 >= this.AutoInventoryId)
            {
                throw new Exception("The Auto Inventory record id is required to update an auto");
            }
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@AutoInventoryId", this.AutoInventoryId),
                new SqlParameter("@AutoId", this.AutoId),
                new SqlParameter("@AutoColorId", this.AutoColorId),
                new SqlParameter("@AutoTrimId", this.AutoTrimId),
                new SqlParameter("@VIN", this.VIN),
                new SqlParameter("@Doors", this.Doors)
            };
            this.Update(parameters);
            return true;
        }
    }
}