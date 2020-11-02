using NomadEcommerce.Model;
using System;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NomadEcommerce
{
    public partial class AuthMaster : MasterPage, IRequiresSessionState
    {
        public Panel SuccessMessagePanel
        {
            get
            {
                return this.SuccessMessage;
            }
        }
        public Panel ErrorMessagePanel
        {
            get
            {
                return this.ErrorMessage;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SessionModel sm = SessionModel.Current();
                if (!sm.IsAuthenticated())
                {
                    sm.ErrorMessage = "You are not authenticated";
                    Response.Redirect("~/Secure/Login.aspx");
                }
            }
        }
    }
}