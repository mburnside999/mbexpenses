public with sharing class DataController {
    @AuraEnabled
    public static void importSampleData() {
        delete [SELECT Id FROM MBExpense__c];
        delete [SELECT Id FROM MBEXpenseItem__c];
/*insert*/
        insertMBExpenses();
    }

    private static void insertMBExpenses() {
        List<MBExpense__c> mbexpenses = new List<MBExpense__c>();
        MBExpense__c mbexpense = new MBExpense__c();
        mbexpense.Expense_Date__c = Date.today();
        mbexpense.Expense_Claim_Type__c = 'General Business';
        mbexpense.Status__c = 'New';
        mbexpense.Comments__c = 'my expense comments';
        insert mbexpense;

        MBExpenseItem__c mbexpenseitem = new MBExpenseItem__c();
        mbexpenseitem.MBExpense__c = mbexpense.id;
        mbexpenseitem.Amount__c = 100;
        mbexpenseitem.payment_method__c = 'Credit Card';
        mbexpenseitem.personal_expense__c = false;
        mbexpenseitem.expense_item_type__c = 'Meals';
        mbexpenseitem.expense_item_date__c = Date.today().addDays(-2);
        mbexpenseitem.Comments__c = 'meals item comment';

        insert mbexpenseitem;

        mbexpenseitem = new MBExpenseItem__c();
        mbexpenseitem.MBExpense__c = mbexpense.id;
        mbexpenseitem.Amount__c = 200;
        mbexpenseitem.payment_method__c = 'Credit Card';
        mbexpenseitem.personal_expense__c = false;
        mbexpenseitem.expense_item_type__c = 'Travel';
        mbexpenseitem.expense_item_date__c = Date.today().addDays(-3);
        mbexpenseitem.Comments__c = 'travel item comment';
        insert mbexpenseitem;

        mbexpenseitem = new MBExpenseItem__c();
        mbexpenseitem.MBExpense__c = mbexpense.id;
        mbexpenseitem.Amount__c = 12.99;
        mbexpenseitem.payment_method__c = 'Credit Card';
        mbexpenseitem.personal_expense__c = true;
        mbexpenseitem.expense_item_type__c = 'Office Supplies';
        mbexpenseitem.expense_item_date__c = Date.today().addDays(-4);
        mbexpenseitem.Comments__c = 'personal item comment';

        insert mbexpenseitem;
    }
}
