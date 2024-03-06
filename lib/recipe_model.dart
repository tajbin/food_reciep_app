class RecipeModel{
   String applabel;
   String appimgUrl;
   double appcalories;
   String appurl;

   RecipeModel({this.applabel="label", this.appcalories=0.00,this.appimgUrl="img",this.appurl="url"});
   factory RecipeModel.fromMap(Map recipe){
      return RecipeModel(
         applabel: recipe["label"],
         appimgUrl: recipe["image"],
         appcalories: recipe["calories"],
         appurl: recipe["url"]
      );
   }
}