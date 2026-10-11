// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get catHousing => 'Wohnen';

  @override
  String get catInsurance => 'Versicherungen';

  @override
  String get catMobility => 'Mobilität';

  @override
  String get catCommunication => 'Kommunikation';

  @override
  String get catSubscriptions => 'Abos';

  @override
  String get catBanking => 'Konten & Gebühren';

  @override
  String get catGroceries => 'Lebensmittel & Haushalt';

  @override
  String get catLeisure => 'Freizeit & Wünsche';

  @override
  String get catSavings => 'Sparen';

  @override
  String get bucketNeeds => 'Grundbedarf';

  @override
  String get bucketWants => 'Wünsche';

  @override
  String get bucketSavings => 'Sparen';

  @override
  String get intervalMonthly => 'Monatlich';

  @override
  String get intervalQuarterly => 'Vierteljährlich';

  @override
  String get intervalHalfYearly => 'Halbjährlich';

  @override
  String get intervalYearly => 'Jährlich';

  @override
  String get intervalWeekly => 'Wöchentlich';

  @override
  String get accountKindChecking => 'Girokonto';

  @override
  String get accountKindSavings => 'Tagesgeld / Sparkonto';

  @override
  String get accountKindCard => 'Karte';

  @override
  String get accountKindOther => 'Sonstiges';

  @override
  String get splitTitle => 'Gemeinsame Kosten aufteilen';

  @override
  String get splitProportional => 'Nach Einkommen';

  @override
  String get splitEqual => 'Zu gleichen Teilen';

  @override
  String get splitEqualRemainder => 'Gleiches Restgeld';

  @override
  String get splitProportionalHint =>
      'Wer mehr verdient, trägt mehr von den gemeinsamen Kosten.';

  @override
  String get splitEqualHint =>
      'Gemeinsame Kosten werden durch die Anzahl der Personen geteilt.';

  @override
  String get splitEqualRemainderHint =>
      'Am Monatsende hat jede Person gleich viel frei verfügbar.';

  @override
  String get appTitle => 'Mai Budget';

  @override
  String get commonBack => 'Zurück';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonChange => 'Ändern';

  @override
  String get commonContinue => 'Weiter';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonInvalidAmount => 'Bitte einen gültigen Betrag eingeben';

  @override
  String get commonName => 'Name';

  @override
  String get commonNegativeAmount => 'Betrag darf nicht negativ sein';

  @override
  String get commonNone => 'Keins';

  @override
  String get commonPerMonth => 'Monat';

  @override
  String get commonPerYear => 'Jahr';

  @override
  String get commonRequired => 'Pflichtfeld';

  @override
  String get commonRetry => 'Erneut versuchen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonUnderstood => 'Verstanden';

  @override
  String get commonUndo => 'Rückgängig';

  @override
  String get tabOverview => 'Übersicht';

  @override
  String get tabItems => 'Posten';

  @override
  String get tabDistribution => 'Verteiler';

  @override
  String get tabInsights => 'Tipps';

  @override
  String get tabSettings => 'Einstellungen';

  @override
  String get tabMore => 'Mehr';

  @override
  String get distributionIntro =>
      'Daueraufträge zum Monatsanfang: was jede Person auf welches Konto überweist und was danach frei bleibt.';

  @override
  String get distributionNoAccount => 'Ohne Konto';

  @override
  String get distributionRemainder => 'Bleibt frei';

  @override
  String distributionRemainderTo(String account) {
    return 'Bleibt frei auf $account';
  }

  @override
  String get distributionFairness => 'Fairer Ausgleich';

  @override
  String get distributionBalanced =>
      'Ausgeglichen — niemand muss etwas überweisen.';

  @override
  String distributionSettlement(String from, String to) {
    return '$from überweist an $to';
  }

  @override
  String get distributionSavings => 'Sparkonten in 12 Monaten';

  @override
  String distributionProjection(String deposit, String rate, String interest) {
    return '$deposit pro Monat · $rate % Zinsen · davon Zinsen $interest';
  }

  @override
  String get distributionProjectionHint =>
      'Hochrechnung mit monatlicher Verzinsung, ohne Steuern. Startwert = eingetragener Kontostand.';

  @override
  String get insightsEmptyTitle => 'Alles im grünen Bereich';

  @override
  String get insightsEmptyText =>
      'Gerade gibt es keine Vorschläge. Je mehr Posten du einträgst, desto genauer werden die Tipps.';

  @override
  String get insightsPotentialTitle => 'Geschätztes Sparpotenzial';

  @override
  String insightsPotentialValue(String monthly, String yearly) {
    return '$monthly pro Monat · $yearly pro Jahr';
  }

  @override
  String insightsPerMonth(String amount) {
    return 'ca. $amount/Monat';
  }

  @override
  String get insightsDisclaimer =>
      'Die Tipps beruhen auf festen Regeln und deinen Angaben; Ersparnisse sind grobe Schätzungen. Keine Steuer-, Rechts- oder Anlageberatung.';

  @override
  String get insightDeficitTitle => 'Ausgaben übersteigen das Einkommen';

  @override
  String insightDeficitText(String amount) {
    return 'Es fehlen $amount pro Monat. Prüfe zuerst Wünsche und Abos oder passe Sparraten vorübergehend an.';
  }

  @override
  String get insightNeedsTitle => 'Grundbedarf über dem Ziel';

  @override
  String insightNeedsText(String percent, int target, String amount) {
    return 'Fixkosten und Grundbedarf liegen bei $percent % statt $target % (≈ $amount pro Monat zu viel). Größte Hebel sind meist Wohnen, Mobilität und Versicherungen.';
  }

  @override
  String get insightSavingsTitle => 'Sparquote unter dem Ziel';

  @override
  String insightSavingsText(String percent, int target, String amount) {
    return 'Du sparst $percent % statt $target %. Für das Ziel fehlen $amount pro Monat — am einfachsten per Dauerauftrag direkt am Gehaltstag.';
  }

  @override
  String get insightFlaggedTitle => 'Markierte Sparpotenziale';

  @override
  String insightFlaggedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bei $count Posten hast du eine mögliche Ersparnis eingetragen.',
      one: 'Bei einem Posten hast du eine mögliche Ersparnis eingetragen.',
    );
    return '$_temp0 Setze dir einen Termin, um zu kündigen oder zu wechseln.';
  }

  @override
  String insightDuplicateTitle(String label) {
    return '„$label“ gibt es mehrfach';
  }

  @override
  String insightDuplicateText(int count, String amount) {
    return '$count Verträge mit zusammen $amount pro Monat. Ein Partner- oder Familientarif ist oft günstiger.';
  }

  @override
  String insightOverlapTitle(String label) {
    return 'Mehrere Abos: $label';
  }

  @override
  String insightOverlapText(int count) {
    return '$count Abos derselben Art laufen parallel. Rotieren spart: immer nur eins aktiv halten und monatlich wechseln.';
  }

  @override
  String get insightInsuranceTitle => 'Versicherungen jährlich zahlen';

  @override
  String insightInsuranceText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Versicherungen werden',
      one: 'Eine Versicherung wird',
    );
    return '$_temp0 unterjährig bezahlt. Viele Versicherer berechnen dafür Aufschläge von einigen Prozent — jährliche Zahlweise anfragen.';
  }

  @override
  String get insightZeroTitle => 'Posten ohne Betrag';

  @override
  String insightZeroText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Posten haben',
      one: 'Ein Posten hat',
    );
    return '$_temp0 0 €. Fehlt der Betrag, oder kann der Vertrag weg?';
  }

  @override
  String get insightInterestTitle => 'Zinsen auf dem Sparkonto prüfen';

  @override
  String insightInterestText(String rate) {
    return 'Mindestens ein Sparkonto hat keinen oder weniger als $rate % Zins eingetragen. Ein Tagesgeldvergleich lohnt sich bei regelmäßigen Sparraten.';
  }

  @override
  String get insightEmergencyTitle => 'Notgroschen';

  @override
  String insightEmergencyText(String amount, String percent) {
    return 'Empfohlen sind drei Monate Grundbedarf, also etwa $amount. Auf deinen Sparkonten liegen $percent % davon.';
  }

  @override
  String insightEmergencyUnknown(String amount) {
    return 'Empfohlen sind drei Monate Grundbedarf, also etwa $amount. Trage Kontostände bei deinen Sparkonten ein, um den Stand zu sehen.';
  }

  @override
  String insightBiggestWantTitle(String label) {
    return 'Größter Wunsch-Posten: $label';
  }

  @override
  String insightBiggestWantText(String percent, String amount) {
    return 'Er macht $percent % deines Nettoeinkommens aus — $amount im Jahr. Schon eine kleine Reduzierung wirkt hier stark.';
  }

  @override
  String get insightMissingAccountTitle => 'Posten ohne Konto';

  @override
  String insightMissingAccountText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Posten sind',
      one: 'Ein Posten ist',
    );
    return '$_temp0 keinem Konto zugeordnet. Mit Konto zeigt der Verteiler genaue Daueraufträge.';
  }

  @override
  String get insightReserveTitle => 'Jahreszahlungen ansparen';

  @override
  String insightReserveText(String amount) {
    return 'Lege $amount pro Monat auf ein eigenes Unterkonto, dann sind Jahresbeiträge kein Loch im Konto.';
  }

  @override
  String get itemsAdd => 'Posten hinzufügen';

  @override
  String get itemsEdit => 'Posten bearbeiten';

  @override
  String get itemsEmptyTitle => 'Noch keine Posten';

  @override
  String get itemsEmptyText =>
      'Tippe auf „Posten hinzufügen“. Vorschläge helfen bei Miete, Versicherungen, Abos und mehr.';

  @override
  String get itemsSearch => 'Posten suchen';

  @override
  String get itemsFilterAll => 'Alle';

  @override
  String get itemsFilterShared => 'Gemeinsam';

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Posten',
      one: '1 Posten',
      zero: 'Keine Posten',
    );
    return '$_temp0';
  }

  @override
  String get itemsHasPotential => 'Sparpotenzial';

  @override
  String itemsDeleted(String label) {
    return '„$label“ gelöscht';
  }

  @override
  String get itemsLabel => 'Bezeichnung';

  @override
  String get itemsCategory => 'Bereich';

  @override
  String get itemsAmount => 'Betrag';

  @override
  String get itemsInterval => 'Rhythmus';

  @override
  String itemsMonthlyEquivalent(String amount) {
    return 'Entspricht $amount pro Monat';
  }

  @override
  String get itemsDueMonth => 'Fällig im';

  @override
  String get itemsPayer => 'Wer zahlt?';

  @override
  String get itemsJoint => 'Gemeinschaftskonto';

  @override
  String get itemsBeneficiary => 'Für wen?';

  @override
  String get itemsBeneficiaryHint => 'Wichtig für den fairen Ausgleich';

  @override
  String get itemsHousehold => 'Ganzer Haushalt';

  @override
  String get itemsAccount => 'Abbuchung von Konto';

  @override
  String get itemsAccountSavings => 'Sparen auf Konto';

  @override
  String get itemsDetails => 'Details';

  @override
  String get itemsDetailsHint =>
      'Topf, Anbieter, Vertragsnummer, Sparpotenzial …';

  @override
  String get itemsBucket => 'Topf (Budgetregel)';

  @override
  String get itemsBucketHint =>
      'z. B. Genussmittel unter Lebensmittel als „Wünsche“ zählen';

  @override
  String itemsBucketFromCategory(String bucket) {
    return 'Wie Bereich ($bucket)';
  }

  @override
  String get itemsTag => 'Unterkategorie';

  @override
  String get itemsTagHint =>
      'z. B. Streaming, Sport — gleiche Unterkategorien werden verglichen';

  @override
  String get itemsProvider => 'Anbieter';

  @override
  String get itemsContract => 'Vertrags-/Versicherungsnummer';

  @override
  String get itemsPhone => 'Telefon';

  @override
  String get itemsPotential => 'Mögliche Ersparnis pro Monat';

  @override
  String get itemsPotentialHint =>
      'Eigene Einschätzung, z. B. nach Tarifvergleich oder Kündigung';

  @override
  String get itemsTarget => 'Sparziel';

  @override
  String get itemsNotes => 'Notizen';

  @override
  String get onboardingTitle => 'Dein Budget bleibt bei dir';

  @override
  String get onboardingSubtitle =>
      'Einkommen, Fixkosten, Abos und Sparziele an einem Ort — für dich allein oder den ganzen Haushalt.';

  @override
  String get onboardingPointEncrypted =>
      'Alle Zahlen liegen verschlüsselt nur auf diesem Gerät. Kein Konto, kein Server.';

  @override
  String get onboardingPointOffline =>
      'Die App braucht kein Internet und keine Bankverbindung — du trägst deine Posten selbst ein.';

  @override
  String get onboardingPointDistribution =>
      'Der Verteiler zeigt, wer wie viel auf welches Konto überweist und wie ihr fair ausgleicht.';

  @override
  String get onboardingPointInsights =>
      'Tipps zeigen Sparpotenziale: doppelte Abos, Zahlweise, Zinsen, Budgetregel.';

  @override
  String get onboardingHouseholdTitle => 'Wer gehört zum Haushalt?';

  @override
  String get onboardingHouseholdText =>
      'Trage alle Personen ein, die zum Budget beitragen, mit ihrem monatlichen Nettoeinkommen.';

  @override
  String get onboardingNet => 'Netto pro Monat';

  @override
  String get onboardingHint =>
      'Weitere Einkommen, Brutto und Konten kannst du später in den Einstellungen ergänzen.';

  @override
  String get onboardingStart => 'Los geht\'s';

  @override
  String get onboardingIncomeLabel => 'Gehalt';

  @override
  String onboardingMainAccount(String name) {
    return 'Girokonto $name';
  }

  @override
  String get overviewFree => 'Frei verfügbar';

  @override
  String get overviewIncome => 'Nettoeinkommen';

  @override
  String get overviewPlanned => 'Geplante Posten';

  @override
  String get overviewPlannedHint =>
      'Fixkosten, Abos, Lebensmittel, Wünsche und Sparraten';

  @override
  String overviewFreeOf(String name) {
    return 'Frei für $name';
  }

  @override
  String overviewDeductions(String percent) {
    return 'Abzüge (Steuern und Sozialabgaben): $percent % vom Brutto';
  }

  @override
  String get overviewEmptyTitle => 'Noch keine Posten';

  @override
  String get overviewEmptyText =>
      'Lege Miete, Versicherungen, Abos, Lebensmittel und Sparraten an — die Übersicht rechnet alles auf Monat und Jahr um.';

  @override
  String overviewRuleTitle(int needs, int wants, int savings) {
    return 'Budgetregel $needs/$wants/$savings';
  }

  @override
  String get overviewRuleNoIncome =>
      'Trage ein Einkommen ein, um die Verteilung zu sehen.';

  @override
  String overviewRuleShare(String share, int target) {
    return '$share % von $target %';
  }

  @override
  String get overviewRuleHint =>
      'Anteile am Nettoeinkommen. Der Strich markiert das Ziel; was übrig bleibt, ist frei verfügbar.';

  @override
  String get overviewCategories => 'Bereiche';

  @override
  String get overviewReserveTitle => 'Rücklage für Jahreszahlungen';

  @override
  String overviewReserveText(String amount) {
    return 'Für Versicherungen, Steuern und andere nicht monatliche Posten solltest du $amount pro Monat zurücklegen.';
  }

  @override
  String get overviewDueSoon => 'Demnächst fällig';

  @override
  String get overviewDueThisMonth => 'Diesen Monat';

  @override
  String overviewDueInMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'In $months Monaten',
      one: 'Nächsten Monat',
    );
    return '$_temp0';
  }

  @override
  String overviewInsights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tipps für dein Budget',
      one: '1 Tipp für dein Budget',
    );
    return '$_temp0';
  }

  @override
  String overviewInsightsPotential(String amount) {
    return 'Mögliche Ersparnis ca. $amount pro Monat';
  }

  @override
  String get settingsBudgetSection => 'Budget';

  @override
  String get settingsHousehold => 'Haushalt & Einkommen';

  @override
  String settingsHouseholdSummary(int count, String income) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Personen',
      one: '1 Person',
    );
    return '$_temp0 · $income netto/Monat';
  }

  @override
  String get settingsAccounts => 'Konten';

  @override
  String settingsAccountsSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Konten',
      one: '1 Konto',
      zero: 'Noch keine Konten',
    );
    return '$_temp0';
  }

  @override
  String get settingsCategories => 'Bereiche';

  @override
  String settingsCategoriesSummary(int count) {
    return '$count Bereiche';
  }

  @override
  String get settingsRule => 'Budgetregel';

  @override
  String settingsRuleValue(int needs, int wants, int savings) {
    return '$needs % Grundbedarf · $wants % Wünsche · $savings % Sparen';
  }

  @override
  String get settingsRuleHint =>
      'Wie viel vom Nettoeinkommen in welchen Topf gehen soll. Bekannt ist 50/30/20.';

  @override
  String get settingsSecuritySection => 'Sicherheit';

  @override
  String get settingsLockTitle => 'App-Sperre';

  @override
  String get settingsLockSubtitle =>
      'Entsperren mit Fingerabdruck oder Geräte-PIN; Inhalte in „Zuletzt verwendet“ und Screenshots ausblenden';

  @override
  String get settingsLockNoDeviceLock =>
      'Richte zuerst eine Displaysperre auf dem Gerät ein.';

  @override
  String get settingsLockReasonSetup => 'App-Sperre einschalten';

  @override
  String get settingsLockReasonDisable => 'App-Sperre ausschalten';

  @override
  String get settingsLockReasonUnlock => 'Mai Budget entsperren';

  @override
  String get settingsLockLockedTitle => 'Mai Budget ist gesperrt';

  @override
  String get settingsLockLockedText =>
      'Entsperre die App, um deine Zahlen zu sehen.';

  @override
  String get settingsLockUnlock => 'Entsperren';

  @override
  String get settingsBackupSection => 'Sicherung';

  @override
  String get settingsPrivacySection => 'Datenschutz';

  @override
  String get settingsPrivacyText =>
      'Alle Daten liegen verschlüsselt in der App auf diesem Gerät (SQLCipher-kompatibel, Schlüssel im Android-Keystore). Die App hat keine Internet-Berechtigung, nimmt nicht an Android-Backups teil und überträgt nichts. Daten verlassen das Gerät nur über eine Sicherung, die du selbst mit Passwort erstellst.';

  @override
  String get settingsKeyUnavailableTitle => 'Schlüssel gerade nicht verfügbar';

  @override
  String get settingsKeyUnavailableText =>
      'Der Schlüssel deiner verschlüsselten Daten konnte gerade nicht gelesen werden. Deine Daten sind unverändert — bitte versuche es gleich noch einmal.';

  @override
  String get settingsUnreadableTitle => 'Alte Daten nicht lesbar';

  @override
  String get settingsUnreadableText =>
      'Die gespeicherten Daten ließen sich nicht entschlüsseln (z. B. nach Zurücksetzen der Gerätesicherheit) und wurden beiseitegelegt. Stelle sie aus einer Sicherung wieder her.';

  @override
  String get householdAddPerson => 'Person hinzufügen';

  @override
  String get householdRename => 'Umbenennen';

  @override
  String householdRemoveTitle(String name) {
    return '$name entfernen?';
  }

  @override
  String get householdRemoveText =>
      'Einkommen und Konten der Person werden archiviert. Ihre Posten bleiben erhalten und zählen danach als gemeinsam.';

  @override
  String householdNet(String amount) {
    return '$amount netto pro Monat';
  }

  @override
  String householdGross(String amount) {
    return 'brutto $amount';
  }

  @override
  String get householdAddIncome => 'Einkommen hinzufügen';

  @override
  String householdIncomeOf(String name) {
    return 'Einkommen von $name';
  }

  @override
  String get householdIncomeLabel => 'Bezeichnung';

  @override
  String get householdNetLabel => 'Netto';

  @override
  String get householdGrossLabel => 'Brutto (optional)';

  @override
  String get householdGrossHint => 'Nur für die Anzeige der Abzüge';

  @override
  String get accountsAdd => 'Konto hinzufügen';

  @override
  String get accountsEdit => 'Konto bearbeiten';

  @override
  String get accountsIntro =>
      'Konten sind die Ziele im Verteiler: Girokonten, Tagesgeld-Unterkonten für Urlaub oder Geschenke, Karten. Das Hauptkonto einer Person bekommt, was übrig bleibt.';

  @override
  String get accountsKind => 'Art';

  @override
  String get accountsOwner => 'Inhaber';

  @override
  String get accountsJoint => 'Gemeinsam';

  @override
  String get accountsMain => 'Hauptkonto';

  @override
  String get accountsMainHint => 'Bekommt das frei verfügbare Geld';

  @override
  String get accountsRate => 'Zinssatz';

  @override
  String get accountsBalance => 'Aktueller Kontostand (optional)';

  @override
  String get accountsBalanceHint => 'Für Notgroschen und Sparprognose';

  @override
  String get categoriesAdd => 'Bereich hinzufügen';

  @override
  String get categoriesEdit => 'Bereich bearbeiten';

  @override
  String get categoriesIntro =>
      'Bereiche gliedern deine Posten. Der Topf bestimmt, wie sie in der Budgetregel zählen.';

  @override
  String get categoriesNotEmpty => 'Nur leere Bereiche können gelöscht werden.';

  @override
  String get backupIntro =>
      'Verschlüsselte Datei mit allen Daten (AES-256). Ohne Passwort lässt sie sich nicht öffnen — bewahre es gut auf.';

  @override
  String get backupCreate => 'Sicherung erstellen';

  @override
  String get backupRestore => 'Wiederherstellen';

  @override
  String get backupCreated => 'Sicherung erstellt';

  @override
  String get backupFailed => 'Sicherung fehlgeschlagen';

  @override
  String get backupShareSubject => 'Mai Budget Sicherung';

  @override
  String get backupPick => 'Sicherung auswählen';

  @override
  String get backupRestoreConfirmTitle => 'Alle Daten ersetzen?';

  @override
  String get backupRestoreConfirmText =>
      'Die Sicherung ersetzt alle aktuellen Daten in der App. Das lässt sich nicht rückgängig machen.';

  @override
  String get backupReplace => 'Ersetzen';

  @override
  String backupRestored(String date) {
    return 'Sicherung vom $date wiederhergestellt';
  }

  @override
  String get backupPassphrase => 'Passwort';

  @override
  String get backupPassphraseRepeat => 'Passwort wiederholen';

  @override
  String get backupPassphraseCreateHint =>
      'Mit diesem Passwort wird die Sicherung verschlüsselt. Es wird nirgends gespeichert.';

  @override
  String get backupPassphraseRestoreHint => 'Passwort der Sicherung eingeben.';

  @override
  String get backupPassphraseTooShort => 'Mindestens 8 Zeichen';

  @override
  String get backupPassphraseMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get backupWrongApp => 'Diese Datei ist keine Mai-Budget-Sicherung.';

  @override
  String get backupTooNew =>
      'Die Sicherung stammt aus einer neueren App-Version — bitte erst die App aktualisieren.';

  @override
  String get backupUnsupported =>
      'Sicherungen sind in dieser Version nicht verfügbar.';
}
