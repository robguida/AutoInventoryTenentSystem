using NomadEcommerce.Model;
using System;
using System.Web.SessionState;
using System.Web.UI;


namespace NomadEcommerce
{
    public partial class AuthMaster : MasterPage, IRequiresSessionState
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SessionModel sm = SessionModel.Current();
            if (!Page.IsPostBack)
            {
                if (!sm.IsAuthenticated())
                {
                    sm.ErrorMessage = "You are not authenticated";
                    Response.Redirect("~/Secure/Login.aspx");
                }
                this.SessionPnl.GroupingText = "Tenent Id = " + sm.TenentId.ToString();
            }
        }
    }
}