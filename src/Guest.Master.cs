using NomadEcommerce.Model;
using System;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NomadEcommerce
{
    public partial class GuestMaster : MasterPage, IRequiresSessionState
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
            SessionModel sm = SessionModel.Current();
            if (null != sm.SuccessMessage)
            {
                SuccessMessage.Visible = true;
                SuccessMessage.GroupingText = sm.SuccessMessage;
                sm.ClearMessage();
            }
            else if (null != sm.ErrorMessage)
            {
                ErrorMessage.Visible = true;
                ErrorMessage.GroupingText = sm.ErrorMessage;
                sm.ClearMessage();
            }
            if ("true" == Request.QueryString["Logout"])
            {
                sm.DestroySession();
            }
        }
    }
}