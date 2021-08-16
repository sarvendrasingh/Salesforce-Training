public class AddPrimaryContact implements Queueable {
  private Contact con;
  private String state;
  public AddPrimaryContact(Contact contact, String state) {
    this.con = contact;
    this.state = state;
  }
  public void execute(QueueableContext context) {
    List<Account> accounts = [
      SELECT Id, Name, (SELECT id FROM contacts)
      FROM Account
      WHERE BillingState = :state
      LIMIT 200
    ];
    List<Contact> contactsToAdd = new List<Contact>();
    for (Account acc : accounts) {
      Contact c = con.clone();
      c.AccountId = acc.Id;
      contactsToAdd.add(c);
    }
    if (contactsToAdd.size() > 0) {
      insert contactsToAdd;
    }
  }
}
