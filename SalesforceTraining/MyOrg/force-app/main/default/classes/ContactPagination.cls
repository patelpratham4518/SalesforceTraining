public  class ContactPagination {
    Integer totalRecords;
    Integer index = 0;
    Integer blockSize = 10 ;
    public ContactPagination() {
        totalRecords = [select count() from Contact];
    }
    public List<Contact> getContacts(){
        // List<Contact> contacts = [select Name from Contact LIMIT:-blockSize OFFSET:-index];
        List<Contact> contacts = [select Name from Contact LIMIT:blockSize OFFSET:index];
        return contacts;
    }
    public void previous(){
        if ((index - blockSize) >= 0) {
            index -= blockSize;
        }
    }
    public void next(){
        if((index + blockSize) < totalRecords){
            index += blockSize;
        }
    }
    
    public void beginning(){
        index = 0;
    }
    public void end(){
        index = totalRecords - math.mod(totalRecords,blockSize);
    }
    
}