

execSQL('execute createcontractsLT');
logready(20);
execSQL('execute createOrgphonesEx');
logready(30);
execSQL('execute cleanupPhones');
logready(40);
execSQL('execute CreateOrgphonesLT_NonUsed)';
logready(50);
execSQL('execute createOrgEmailsEx');
logready(70);
execSQL('execute createOrgEmailsLT');
logready(90);
execSQL('execute cleanupEmails');
logready(100);