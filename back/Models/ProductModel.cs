namespace ATDapi.Models;
public class productModel
{
    public int Id {get; set;}
    public string Product_name { get; set; }

    public int Price { get; set; }
    public string? Image_path {get; set;}
    public string Description {get; set;}
    public int Stock { get; set; }
}