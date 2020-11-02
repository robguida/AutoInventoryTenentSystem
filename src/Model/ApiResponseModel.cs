using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NomadEcommerce.Model
{
    public class ApiResponseModel
    {
        public const string RESULT_SUCCESS = "success";
        public const string RESULT_ERROR = "error";

        private string _Result { get; set; }
        private string _Message { get; set; }
        private Dictionary<string, string> _Data { get; set; }

        public bool IsSuccesful()
        {
            return RESULT_SUCCESS == this._Result;
        }

        public bool IsError()
        {
            return RESULT_ERROR == this._Result;
        }

        public string GetJsonEncodeData()
        {
            string output = JsonConvert.SerializeObject(this._Data);
            return output;
        }

        public string ToJsonString()
        {
            return JsonConvert.SerializeObject(this);
        }

        public Dictionary<string, string> Data { get { return this._Data; } }

        public string Message { get { return this._Message; } }

        public string Result { get { return this._Result; } }

        public static ApiResponseModel SetSuccess(Dictionary<string, string> input)
        {
            ApiResponseModel output = new ApiResponseModel();
            output._Result = RESULT_SUCCESS;
            output._Data = input;
            return output;
        }

        public static ApiResponseModel SetError(string input)
        {
            ApiResponseModel output = new ApiResponseModel();
            output._Result = RESULT_ERROR;
            output._Message = input;
            return output;
        }
    }
}