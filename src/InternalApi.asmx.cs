using NomadEcommerce.Controller;
using NomadEcommerce.Model;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Services;

namespace NomadEcommerce
{
    /// <summary>
    /// Summary description for InternalApi
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class InternalApi : WebService
    {
        [WebMethod]
        [Route("AutoInventoryDelete")]
        public string AutoInventoryDelete(int AutoInventoryId, string AuthToken)
        {
            string output;
            try
            {
                TenentUserModel TUM = TenentUserModel.ValidateAuthToken(AuthToken);
                if (0 < TUM.TenentId)
                {
                    bool result = (new AutoInventoryController()).Delete(TUM.TenentId, AutoInventoryId);
                    Dictionary<string, string> Data = new Dictionary<string, string>
                        {
                            { "deleted", result.ToString() }
                        };
                    output = ApiResponseModel.SetSuccess(Data).ToJsonString();
                }
                else
                {
                    throw new Exception("The Authorization Token is invalid or expireed");
                }
            }
            catch (Exception Exp)
            {
                output = ApiResponseModel.SetError(Exp.Message).ToJsonString();
            }
            return output;
        }
    }
}