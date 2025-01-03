using ATDapi.Models;


namespace ATDapi.Responses;

public class BaseResponse
{
    public bool success {get; set;}         
    public bool error {get; set;}         
    public int code {get; set;}            
    public string message {get; set;}      

    public BaseResponse(bool success, int code, string message)
    {
        this.success = success;
        this.error = !success;
        this.code = code;
        this.message = message;
    }
}

public class DataResponse<T> : BaseResponse
{
    private List<T> dataList;

    public new T data {get; set;} = default;

    public DataResponse(bool success, int code, string message, T data = default) : base (success, code, message)
    {
        this.data = data;
    }

    public DataResponse(bool success, int code, string message, List<T> dataList) : base(success, code, message)
    {
        this.dataList = dataList;
    }
}
