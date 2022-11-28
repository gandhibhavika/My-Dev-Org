public class PaginationContact {
    
    private Integer totalRecs = 0;
    private Integer index = 0;
    public List<SelectOption> blockSize{get;set;}
    
    public PaginationContact(){
        totalRecs = [SELECT count() FROM Contact];
    } 
    
    public List<SelectOption> selectPageSize(){
        blockSize.add(new SelectOption('5','5'));
        blockSize.add(new SelectOption('10','10'));
        blockSize.add(new SelectOption('15','15'));
        blockSize.add(new SelectOption('25','25'));
        return blockSize;
    }
    
    public List<Contact> getcontact(){
        List<Contact> contacts = Database.Query('SELECT Name, Email, AccountId, Phone FROM Contact LIMIT :blockSize OFFSET :index');
        return contacts;
    }
    
}