using NomadEcommerce.Controller;
using NomadEcommerce.Model;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NomadEcommerce
{
    public partial class Default : Page
    {
        private AutoController ac { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.ac = new AutoController();
                this.BindAutoResults();
            }
            else
            {

            }
        }

        protected void BindAutoResults()
        {
            DataTable dt = this.ac.List();
            if (0 < dt.Rows.Count)
            {
                this.AutoResultsRepeater.DataSource = dt;
                this.AutoResultsRepeater.DataBind();
                this.AutoResultsPanel.Visible = true;
                this.AutoNoResultPanel.Visible = false;
            }
            else
            {
                this.AutoResultsPanel.Visible = false;
                this.AutoNoResultPanel.Visible = true;
            }
        }

        protected void LoadAutoResults(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemIndex != -1)
            {
            }
        }
    }
}