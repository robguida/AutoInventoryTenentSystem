using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Controller
{
    public class AutoTrimController : AbstractController
    {
        protected override void SetTable()
        {
            this.TableName = "AutoTrim";
        }

        public DataTable List()
        {
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter("@OrderBy", "DisplayName ASC"),
                new SqlParameter("@PagingOffset", 0),
                new SqlParameter("@PagingLimit", 50)
            };
            DataTable output = this.List(parameters);
            return output;
        }
    }
}