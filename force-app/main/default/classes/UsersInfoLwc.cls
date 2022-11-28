public class UsersInfoLwc {

@AuraEnabled(cacheable=true)
public static List<User> getUsersInfo(){
return [Select Id, Name, Profile.UserLicense.Name, FullPhotoUrl, Email From User ];
}
// @AuraEnabled(cacheable=true)
//     public static List<AggregateResult> getUsersCount(){
//     return [SELECT Count(Name) From User];
//     }

}