using NomadEcommerce.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Controller
{
    public class AutoInventoryController : AbstractController
    {
        protected override void SetTable()
        {
            this.TableName = "AutoInventory";
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

        public bool Delete(int AutoInventoryId)
        {
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@AutoInventoryId", AutoInventoryId)
            };
            return this.Delete(parameters);            
        }
    }
}