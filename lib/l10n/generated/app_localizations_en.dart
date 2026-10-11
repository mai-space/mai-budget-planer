// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get catHousing => 'Housing';

  @override
  String get catInsurance => 'Insurance';

  @override
  String get catMobility => 'Transport';

  @override
  String get catCommunication => 'Communication';

  @override
  String get catSubscriptions => 'Subscriptions';

  @override
  String get catBanking => 'Banking & fees';

  @override
  String get catGroceries => 'Groceries & household';

  @override
  String get catLeisure => 'Leisure & wishes';

  @override
  String get catSavings => 'Savings';

  @override
  String get bucketNeeds => 'Needs';

  @override
  String get bucketWants => 'Wants';

  @override
  String get bucketSavings => 'Savings';

  @override
  String get intervalMonthly => 'Monthly';

  @override
  String get intervalQuarterly => 'Quarterly';

  @override
  String get intervalHalfYearly => 'Half-yearly';

  @override
  String get intervalYearly => 'Yearly';

  @override
  String get intervalWeekly => 'Weekly';

  @override
  String get accountKindChecking => 'Current account';

  @override
  String get accountKindSavings => 'Savings account';

  @override
  String get accountKindCard => 'Card';

  @override
  String get accountKindOther => 'Other';

  @override
  String get splitTitle => 'Split shared costs';

  @override
  String get splitProportional => 'By income';

  @override
  String get splitEqual => 'Equally';

  @override
  String get splitEqualRemainder => 'Equal free money';

  @override
  String get splitProportionalHint =>
      'Whoever earns more carries more of the shared costs.';

  @override
  String get splitEqualHint =>
      'Shared costs are divided equally between everyone.';

  @override
  String get splitEqualRemainderHint =>
      'At the end of the month everyone has the same amount left.';

  @override
  String get appTitle => 'Budget';

  @override
  String get commonBack => 'Back';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonChange => 'Change';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonInvalidAmount => 'Please enter a valid amount';

  @override
  String get commonName => 'Name';

  @override
  String get commonNegativeAmount => 'Amount must not be negative';

  @override
  String get commonNone => 'None';

  @override
  String get commonPerMonth => 'Month';

  @override
  String get commonPerYear => 'Year';

  @override
  String get commonRequired => 'Required';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonSave => 'Save';

  @override
  String get commonUnderstood => 'Got it';

  @override
  String get commonUndo => 'Undo';

  @override
  String get tabOverview => 'Overview';

  @override
  String get tabItems => 'Items';

  @override
  String get tabDistribution => 'Split';

  @override
  String get tabInsights => 'Tips';

  @override
  String get tabSettings => 'Settings';

  @override
  String get tabMore => 'More';

  @override
  String get distributionIntro =>
      'Standing orders at the start of the month: what each person transfers to which account and what is left afterwards.';

  @override
  String get distributionNoAccount => 'No account';

  @override
  String get distributionRemainder => 'Left to spend';

  @override
  String distributionRemainderTo(String account) {
    return 'Left on $account';
  }

  @override
  String get distributionFairness => 'Fair settlement';

  @override
  String get distributionBalanced =>
      'Balanced — nobody needs to transfer anything.';

  @override
  String distributionSettlement(String from, String to) {
    return '$from pays $to';
  }

  @override
  String get distributionSavings => 'Savings accounts in 12 months';

  @override
  String distributionProjection(String deposit, String rate, String interest) {
    return '$deposit per month · $rate % interest · interest earned $interest';
  }

  @override
  String get distributionProjectionHint =>
      'Projection with monthly compounding, before tax. Start value = entered balance.';

  @override
  String get insightsEmptyTitle => 'Looking good';

  @override
  String get insightsEmptyText =>
      'No suggestions right now. The more items you add, the better the tips get.';

  @override
  String get insightsPotentialTitle => 'Estimated savings potential';

  @override
  String insightsPotentialValue(String monthly, String yearly) {
    return '$monthly per month · $yearly per year';
  }

  @override
  String insightsPerMonth(String amount) {
    return 'approx. $amount/month';
  }

  @override
  String get insightsDisclaimer =>
      'Tips are based on fixed rules and your data; savings are rough estimates. Not tax, legal or investment advice.';

  @override
  String get insightDeficitTitle => 'Spending exceeds income';

  @override
  String insightDeficitText(String amount) {
    return 'You are $amount short per month. Check wishes and subscriptions first or temporarily lower savings.';
  }

  @override
  String get insightNeedsTitle => 'Needs above target';

  @override
  String insightNeedsText(String percent, int target, String amount) {
    return 'Needs take $percent % instead of $target % (≈ $amount per month over). The biggest levers are usually housing, transport and insurance.';
  }

  @override
  String get insightSavingsTitle => 'Savings rate below target';

  @override
  String insightSavingsText(String percent, int target, String amount) {
    return 'You save $percent % instead of $target %. You need $amount more per month — easiest via a standing order on payday.';
  }

  @override
  String get insightFlaggedTitle => 'Flagged savings';

  @override
  String insightFlaggedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You entered possible savings for $count items.',
      one: 'You entered a possible saving for one item.',
    );
    return '$_temp0 Set a date to cancel or switch.';
  }

  @override
  String insightDuplicateTitle(String label) {
    return '“$label” appears more than once';
  }

  @override
  String insightDuplicateText(int count, String amount) {
    return '$count contracts costing $amount per month together. A partner or family plan is often cheaper.';
  }

  @override
  String insightOverlapTitle(String label) {
    return 'Several subscriptions: $label';
  }

  @override
  String insightOverlapText(int count) {
    return '$count subscriptions of the same kind run in parallel. Rotating saves money: keep only one active and switch monthly.';
  }

  @override
  String get insightInsuranceTitle => 'Pay insurance annually';

  @override
  String insightInsuranceText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count policies are',
      one: 'One policy is',
    );
    return '$_temp0 paid in instalments. Many insurers charge a few percent extra for that — ask for annual payment.';
  }

  @override
  String get insightZeroTitle => 'Items without amount';

  @override
  String insightZeroText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items have',
      one: 'One item has',
    );
    return '$_temp0 0 €. Is the amount missing, or can the contract go?';
  }

  @override
  String get insightInterestTitle => 'Check savings interest';

  @override
  String insightInterestText(String rate) {
    return 'At least one savings account has no or less than $rate % interest. Comparing savings accounts pays off with regular deposits.';
  }

  @override
  String get insightEmergencyTitle => 'Emergency fund';

  @override
  String insightEmergencyText(String amount, String percent) {
    return 'Three months of needs are recommended, about $amount. Your savings accounts hold $percent % of that.';
  }

  @override
  String insightEmergencyUnknown(String amount) {
    return 'Three months of needs are recommended, about $amount. Enter balances for your savings accounts to track it.';
  }

  @override
  String insightBiggestWantTitle(String label) {
    return 'Biggest want: $label';
  }

  @override
  String insightBiggestWantText(String percent, String amount) {
    return 'It takes $percent % of your net income — $amount per year. Even a small cut has a big effect here.';
  }

  @override
  String get insightMissingAccountTitle => 'Items without account';

  @override
  String insightMissingAccountText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items have',
      one: 'One item has',
    );
    return '$_temp0 no account. With an account, the split view shows exact standing orders.';
  }

  @override
  String get insightReserveTitle => 'Save up for annual payments';

  @override
  String insightReserveText(String amount) {
    return 'Move $amount per month to a separate sub-account so annual fees never leave a hole.';
  }

  @override
  String get itemsAdd => 'Add item';

  @override
  String get itemsEdit => 'Edit item';

  @override
  String get itemsEmptyTitle => 'No items yet';

  @override
  String get itemsEmptyText =>
      'Tap “Add item”. Suggestions help with rent, insurance, subscriptions and more.';

  @override
  String get itemsSearch => 'Search items';

  @override
  String get itemsFilterAll => 'All';

  @override
  String get itemsFilterShared => 'Shared';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get itemsHasPotential => 'Savings potential';

  @override
  String itemsDeleted(String label) {
    return '“$label” deleted';
  }

  @override
  String get itemsLabel => 'Name';

  @override
  String get itemsCategory => 'Category';

  @override
  String get itemsAmount => 'Amount';

  @override
  String get itemsInterval => 'Frequency';

  @override
  String itemsMonthlyEquivalent(String amount) {
    return 'Equals $amount per month';
  }

  @override
  String get itemsDueMonth => 'Due in';

  @override
  String get itemsPayer => 'Who pays?';

  @override
  String get itemsJoint => 'Joint account';

  @override
  String get itemsBeneficiary => 'For whom?';

  @override
  String get itemsBeneficiaryHint => 'Used for the fair settlement';

  @override
  String get itemsHousehold => 'Whole household';

  @override
  String get itemsAccount => 'Paid from account';

  @override
  String get itemsAccountSavings => 'Saved to account';

  @override
  String get itemsDetails => 'Details';

  @override
  String get itemsDetailsHint =>
      'Bucket, provider, contract number, savings potential …';

  @override
  String get itemsBucket => 'Bucket (budget rule)';

  @override
  String get itemsBucketHint => 'e.g. count treats under groceries as “wants”';

  @override
  String itemsBucketFromCategory(String bucket) {
    return 'Same as category ($bucket)';
  }

  @override
  String get itemsTag => 'Sub-category';

  @override
  String get itemsTagHint =>
      'e.g. streaming, sport — items with the same sub-category are compared';

  @override
  String get itemsProvider => 'Provider';

  @override
  String get itemsContract => 'Contract / policy number';

  @override
  String get itemsPhone => 'Phone';

  @override
  String get itemsPotential => 'Possible savings per month';

  @override
  String get itemsPotentialHint =>
      'Your own estimate, e.g. after comparing tariffs or cancelling';

  @override
  String get itemsTarget => 'Savings goal';

  @override
  String get itemsNotes => 'Notes';

  @override
  String get onboardingTitle => 'Your budget stays with you';

  @override
  String get onboardingSubtitle =>
      'Income, fixed costs, subscriptions and savings goals in one place — for you alone or the whole household.';

  @override
  String get onboardingPointEncrypted =>
      'All numbers are stored encrypted on this device only. No account, no server.';

  @override
  String get onboardingPointOffline =>
      'The app needs no internet and no bank connection — you enter your items yourself.';

  @override
  String get onboardingPointDistribution =>
      'The split view shows who transfers how much to which account and how to settle fairly.';

  @override
  String get onboardingPointInsights =>
      'Tips point out savings: duplicate subscriptions, payment frequency, interest, budget rule.';

  @override
  String get onboardingHouseholdTitle => 'Who is in the household?';

  @override
  String get onboardingHouseholdText =>
      'Add everyone who contributes to the budget with their monthly net income.';

  @override
  String get onboardingNet => 'Net per month';

  @override
  String get onboardingHint =>
      'You can add more income sources, gross pay and accounts later in the settings.';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get onboardingIncomeLabel => 'Salary';

  @override
  String onboardingMainAccount(String name) {
    return '$name\'s current account';
  }

  @override
  String get overviewFree => 'Free to spend';

  @override
  String get overviewIncome => 'Net income';

  @override
  String get overviewPlanned => 'Planned items';

  @override
  String get overviewPlannedHint =>
      'Fixed costs, subscriptions, groceries, wishes and savings';

  @override
  String overviewFreeOf(String name) {
    return 'Free for $name';
  }

  @override
  String overviewDeductions(String percent) {
    return 'Deductions (tax and social security): $percent % of gross';
  }

  @override
  String get overviewEmptyTitle => 'No items yet';

  @override
  String get overviewEmptyText =>
      'Add rent, insurance, subscriptions, groceries and savings — the overview converts everything to month and year.';

  @override
  String overviewRuleTitle(int needs, int wants, int savings) {
    return 'Budget rule $needs/$wants/$savings';
  }

  @override
  String get overviewRuleNoIncome => 'Add an income to see the split.';

  @override
  String overviewRuleShare(String share, int target) {
    return '$share % of $target %';
  }

  @override
  String get overviewRuleHint =>
      'Shares of net income. The line marks the target; whatever is left is free to spend.';

  @override
  String get overviewCategories => 'Categories';

  @override
  String get overviewReserveTitle => 'Reserve for annual payments';

  @override
  String overviewReserveText(String amount) {
    return 'Set aside $amount per month for insurance, taxes and other non-monthly items.';
  }

  @override
  String get overviewDueSoon => 'Due soon';

  @override
  String get overviewDueThisMonth => 'This month';

  @override
  String overviewDueInMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'In $months months',
      one: 'Next month',
    );
    return '$_temp0';
  }

  @override
  String overviewInsights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tips for your budget',
      one: '1 tip for your budget',
    );
    return '$_temp0';
  }

  @override
  String overviewInsightsPotential(String amount) {
    return 'Possible savings approx. $amount per month';
  }

  @override
  String get settingsBudgetSection => 'Budget';

  @override
  String get settingsHousehold => 'Household & income';

  @override
  String settingsHouseholdSummary(int count, String income) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people',
      one: '1 person',
    );
    return '$_temp0 · $income net/month';
  }

  @override
  String get settingsAccounts => 'Accounts';

  @override
  String settingsAccountsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts',
      one: '1 account',
      zero: 'No accounts yet',
    );
    return '$_temp0';
  }

  @override
  String get settingsCategories => 'Categories';

  @override
  String settingsCategoriesSummary(int count) {
    return '$count categories';
  }

  @override
  String get settingsRule => 'Budget rule';

  @override
  String settingsRuleValue(int needs, int wants, int savings) {
    return '$needs % needs · $wants % wants · $savings % savings';
  }

  @override
  String get settingsRuleHint =>
      'How much of net income should go into each bucket. 50/30/20 is a common choice.';

  @override
  String get settingsSecuritySection => 'Security';

  @override
  String get settingsLockTitle => 'App lock';

  @override
  String get settingsLockSubtitle =>
      'Unlock with fingerprint or device PIN; hide content in recent apps and screenshots';

  @override
  String get settingsLockNoDeviceLock =>
      'Set up a screen lock on your device first.';

  @override
  String get settingsLockReasonSetup => 'Turn on app lock';

  @override
  String get settingsLockReasonDisable => 'Turn off app lock';

  @override
  String get settingsLockReasonUnlock => 'Unlock Budget';

  @override
  String get settingsLockLockedTitle => 'Budget is locked';

  @override
  String get settingsLockLockedText => 'Unlock the app to see your numbers.';

  @override
  String get settingsLockUnlock => 'Unlock';

  @override
  String get settingsBackupSection => 'Backup';

  @override
  String get settingsPrivacySection => 'Privacy';

  @override
  String get settingsPrivacyText =>
      'All data is stored encrypted inside the app on this device (SQLCipher compatible, key in the Android Keystore). The app has no internet permission, is excluded from Android backups and sends nothing anywhere. Data only leaves the device via a password-protected backup you create yourself.';

  @override
  String get settingsKeyUnavailableTitle => 'Key temporarily unavailable';

  @override
  String get settingsKeyUnavailableText =>
      'The key for your encrypted data could not be read right now. Your data is unchanged — please try again in a moment.';

  @override
  String get settingsUnreadableTitle => 'Old data not readable';

  @override
  String get settingsUnreadableText =>
      'Your stored data could not be decrypted (e.g. after resetting device security) and was set aside. Restore it from a backup.';

  @override
  String get householdAddPerson => 'Add person';

  @override
  String get householdRename => 'Rename';

  @override
  String householdRemoveTitle(String name) {
    return 'Remove $name?';
  }

  @override
  String get householdRemoveText =>
      'Their income and accounts are archived. Their items remain and count as shared afterwards.';

  @override
  String householdNet(String amount) {
    return '$amount net per month';
  }

  @override
  String householdGross(String amount) {
    return 'gross $amount';
  }

  @override
  String get householdAddIncome => 'Add income';

  @override
  String householdIncomeOf(String name) {
    return 'Income of $name';
  }

  @override
  String get householdIncomeLabel => 'Name';

  @override
  String get householdNetLabel => 'Net';

  @override
  String get householdGrossLabel => 'Gross (optional)';

  @override
  String get householdGrossHint => 'Only used to show deductions';

  @override
  String get accountsAdd => 'Add account';

  @override
  String get accountsEdit => 'Edit account';

  @override
  String get accountsIntro =>
      'Accounts are the targets in the split view: current accounts, savings sub-accounts for holidays or gifts, cards. A person\'s main account receives what is left.';

  @override
  String get accountsKind => 'Type';

  @override
  String get accountsOwner => 'Owner';

  @override
  String get accountsJoint => 'Joint';

  @override
  String get accountsMain => 'Main account';

  @override
  String get accountsMainHint => 'Receives the money left to spend';

  @override
  String get accountsRate => 'Interest rate';

  @override
  String get accountsBalance => 'Current balance (optional)';

  @override
  String get accountsBalanceHint => 'For emergency fund and savings projection';

  @override
  String get categoriesAdd => 'Add category';

  @override
  String get categoriesEdit => 'Edit category';

  @override
  String get categoriesIntro =>
      'Categories group your items. The bucket decides how they count in the budget rule.';

  @override
  String get categoriesNotEmpty => 'Only empty categories can be deleted.';

  @override
  String get backupIntro =>
      'Encrypted file with all data (AES-256). It cannot be opened without the password — keep it safe.';

  @override
  String get backupCreate => 'Create backup';

  @override
  String get backupRestore => 'Restore';

  @override
  String get backupCreated => 'Backup created';

  @override
  String get backupFailed => 'Backup failed';

  @override
  String get backupShareSubject => 'Budget backup';

  @override
  String get backupPick => 'Choose backup';

  @override
  String get backupRestoreConfirmTitle => 'Replace all data?';

  @override
  String get backupRestoreConfirmText =>
      'The backup replaces all current data in the app. This cannot be undone.';

  @override
  String get backupReplace => 'Replace';

  @override
  String backupRestored(String date) {
    return 'Backup from $date restored';
  }

  @override
  String get backupPassphrase => 'Password';

  @override
  String get backupPassphraseRepeat => 'Repeat password';

  @override
  String get backupPassphraseCreateHint =>
      'The backup is encrypted with this password. It is not stored anywhere.';

  @override
  String get backupPassphraseRestoreHint => 'Enter the backup password.';

  @override
  String get backupPassphraseTooShort => 'At least 8 characters';

  @override
  String get backupPassphraseMismatch => 'Passwords do not match';

  @override
  String get backupWrongApp => 'This file is not a Budget backup.';

  @override
  String get backupTooNew =>
      'The backup comes from a newer app version — please update the app first.';

  @override
  String get backupUnsupported => 'Backups are not available in this version.';

  @override
  String get settingsWidgetsSection => 'Widgets';

  @override
  String get settingsWidgetsHideAmounts => 'Hide amounts in widgets';

  @override
  String get settingsWidgetsHideAmountsSubtitle =>
      'The home screen then only shows names, months and shares.';

  @override
  String get settingsWidgetsHint =>
      'Long-press your home screen → Widgets → Budget. Three widgets: Free to spend, Due soon and New item — all resizable.';
}
