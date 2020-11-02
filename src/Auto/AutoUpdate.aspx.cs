using NomadEcommerce.Controller;
using NomadEcommerce.Lib;
using NomadEcommerce.Model;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NomadEcommerce
{
    public partial class AutoUpdate : System.Web.UI.Page
    {
        AutoController AC;
        int AutoInventoryId;

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
                if (null == Request["AutoInventoryId"])
                {
                    sm.ErrorMessage = "Please select an automobile to edit";
                    Response.Redirect("~/Default.aspx");
                }
                this.AutoInventoryId = Int32.Parse(Request["AutoInventoryId"]);
                this.SetUpForm();
            }
            else
            {
                this.AC = new AutoController();
            }
        }

        protected void SetUpForm()
        {
            AutoInventoryModel AIM = AutoInventoryModel.LoadFromId(this.AutoInventoryId);
            AutoModel AM = AutoModel.LoadFromId(AIM.AutoId);

            this.ModelNumberDdl.DataSource = AutoModelNumberEnum.GetList();
            this.ModelNumberDdl.DataTextField = "display";
            this.ModelNumberDdl.DataValueField = "value";
            this.ModelNumberDdl.DataBind();
            this.ModelNumberDdl.Items.Insert(0, new ListItem("Select a Model", ""));
            this.ModelNumberDdl.SelectedValue = AM.ModelNumber;

            this.ClassificationDdl.DataSource = AutoClassificatioEnum.GetList();
            this.ClassificationDdl.DataTextField = "display";
            this.ClassificationDdl.DataValueField = "value";
            this.ClassificationDdl.DataBind();
            this.ClassificationDdl.Items.Insert(0, new ListItem("Select a Classification", ""));
            this.ClassificationDdl.SelectedValue = AM.Classification;

            this.ColorDdl.DataSource = (new AutoColorController()).List();
            this.ColorDdl.DataTextField = "DisplayName";
            this.ColorDdl.DataValueField = "AutoColorId";
            this.ColorDdl.DataBind();
            this.ColorDdl.Items.Insert(0, new ListItem("Select a Color", "0"));
            this.ColorDdl.SelectedValue = AIM.AutoColorId.ToString();

            this.TrimLevelDdl.DataSource = (new AutoTrimController()).List();
            this.TrimLevelDdl.DataTextField = "DisplayName";
            this.TrimLevelDdl.DataValueField = "AutoTrimId";
            this.TrimLevelDdl.DataBind();
            this.TrimLevelDdl.Items.Insert(0, new ListItem("Select a Trim Level", "0"));
            this.TrimLevelDdl.SelectedValue = AIM.AutoTrimId.ToString();
        }

        protected void UpdateAuto(object sender, EventArgs e)
        {
            try
            {
                AutoInventoryModel AIM = this.AC.Update(
                    this.AutoInventoryIdHidden.Value,
                    this.ModelNumberDdl.SelectedValue,
                    this.ClassificationDdl.SelectedValue,
                    this.VinText.Text,
                    this.ColorDdl.SelectedValue,
                    this.TrimLevelDdl.SelectedValue,
                    this.DoorsTextBox.Text
                    );
                SessionModel.Current().SuccessMessage = "Automobile saved!";
                Response.Redirect("~/Default.aspx");
            }
            catch (Exception Exp)
            {
                this.Master.ErrorMessagePanel.Visible = true;
                this.Master.ErrorMessagePanel.GroupingText = Exp.Message;
            }
        }

    }
}