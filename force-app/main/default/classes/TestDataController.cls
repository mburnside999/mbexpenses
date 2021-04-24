@isTest
private class TestDataController {
    @isTest
    static void importSampleData() {
        Test.startTest();
        DataController.importSampleData();
        Test.stopTest();

        Integer expensesNumber = [SELECT COUNT() FROM MBExpense__c];
        Integer expenseItemsNumber = [SELECT COUNT() FROM MBEXpenseItem__c];

        System.assert(expensesNumber > 0, 'Expected expenses were created.');
        System.assert(expenseItemsNumber > 0, 'Expected items were created.');
    }
}
