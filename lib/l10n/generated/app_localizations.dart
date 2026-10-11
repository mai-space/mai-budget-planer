import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @catHousing.
  ///
  /// In de, this message translates to:
  /// **'Wohnen'**
  String get catHousing;

  /// No description provided for @catInsurance.
  ///
  /// In de, this message translates to:
  /// **'Versicherungen'**
  String get catInsurance;

  /// No description provided for @catMobility.
  ///
  /// In de, this message translates to:
  /// **'Mobilität'**
  String get catMobility;

  /// No description provided for @catCommunication.
  ///
  /// In de, this message translates to:
  /// **'Kommunikation'**
  String get catCommunication;

  /// No description provided for @catSubscriptions.
  ///
  /// In de, this message translates to:
  /// **'Abos'**
  String get catSubscriptions;

  /// No description provided for @catBanking.
  ///
  /// In de, this message translates to:
  /// **'Konten & Gebühren'**
  String get catBanking;

  /// No description provided for @catGroceries.
  ///
  /// In de, this message translates to:
  /// **'Lebensmittel & Haushalt'**
  String get catGroceries;

  /// No description provided for @catLeisure.
  ///
  /// In de, this message translates to:
  /// **'Freizeit & Wünsche'**
  String get catLeisure;

  /// No description provided for @catSavings.
  ///
  /// In de, this message translates to:
  /// **'Sparen'**
  String get catSavings;

  /// No description provided for @bucketNeeds.
  ///
  /// In de, this message translates to:
  /// **'Grundbedarf'**
  String get bucketNeeds;

  /// No description provided for @bucketWants.
  ///
  /// In de, this message translates to:
  /// **'Wünsche'**
  String get bucketWants;

  /// No description provided for @bucketSavings.
  ///
  /// In de, this message translates to:
  /// **'Sparen'**
  String get bucketSavings;

  /// No description provided for @intervalMonthly.
  ///
  /// In de, this message translates to:
  /// **'Monatlich'**
  String get intervalMonthly;

  /// No description provided for @intervalQuarterly.
  ///
  /// In de, this message translates to:
  /// **'Vierteljährlich'**
  String get intervalQuarterly;

  /// No description provided for @intervalHalfYearly.
  ///
  /// In de, this message translates to:
  /// **'Halbjährlich'**
  String get intervalHalfYearly;

  /// No description provided for @intervalYearly.
  ///
  /// In de, this message translates to:
  /// **'Jährlich'**
  String get intervalYearly;

  /// No description provided for @intervalWeekly.
  ///
  /// In de, this message translates to:
  /// **'Wöchentlich'**
  String get intervalWeekly;

  /// No description provided for @accountKindChecking.
  ///
  /// In de, this message translates to:
  /// **'Girokonto'**
  String get accountKindChecking;

  /// No description provided for @accountKindSavings.
  ///
  /// In de, this message translates to:
  /// **'Tagesgeld / Sparkonto'**
  String get accountKindSavings;

  /// No description provided for @accountKindCard.
  ///
  /// In de, this message translates to:
  /// **'Karte'**
  String get accountKindCard;

  /// No description provided for @accountKindOther.
  ///
  /// In de, this message translates to:
  /// **'Sonstiges'**
  String get accountKindOther;

  /// No description provided for @splitTitle.
  ///
  /// In de, this message translates to:
  /// **'Gemeinsame Kosten aufteilen'**
  String get splitTitle;

  /// No description provided for @splitProportional.
  ///
  /// In de, this message translates to:
  /// **'Nach Einkommen'**
  String get splitProportional;

  /// No description provided for @splitEqual.
  ///
  /// In de, this message translates to:
  /// **'Zu gleichen Teilen'**
  String get splitEqual;

  /// No description provided for @splitEqualRemainder.
  ///
  /// In de, this message translates to:
  /// **'Gleiches Restgeld'**
  String get splitEqualRemainder;

  /// No description provided for @splitProportionalHint.
  ///
  /// In de, this message translates to:
  /// **'Wer mehr verdient, trägt mehr von den gemeinsamen Kosten.'**
  String get splitProportionalHint;

  /// No description provided for @splitEqualHint.
  ///
  /// In de, this message translates to:
  /// **'Gemeinsame Kosten werden durch die Anzahl der Personen geteilt.'**
  String get splitEqualHint;

  /// No description provided for @splitEqualRemainderHint.
  ///
  /// In de, this message translates to:
  /// **'Am Monatsende hat jede Person gleich viel frei verfügbar.'**
  String get splitEqualRemainderHint;

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'Mai Budget'**
  String get appTitle;

  /// No description provided for @commonBack.
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get commonBack;

  /// No description provided for @commonCancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get commonCancel;

  /// No description provided for @commonChange.
  ///
  /// In de, this message translates to:
  /// **'Ändern'**
  String get commonChange;

  /// No description provided for @commonContinue.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get commonContinue;

  /// No description provided for @commonDelete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get commonDelete;

  /// No description provided for @commonInvalidAmount.
  ///
  /// In de, this message translates to:
  /// **'Bitte einen gültigen Betrag eingeben'**
  String get commonInvalidAmount;

  /// No description provided for @commonName.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get commonName;

  /// No description provided for @commonNegativeAmount.
  ///
  /// In de, this message translates to:
  /// **'Betrag darf nicht negativ sein'**
  String get commonNegativeAmount;

  /// No description provided for @commonNone.
  ///
  /// In de, this message translates to:
  /// **'Keins'**
  String get commonNone;

  /// No description provided for @commonPerMonth.
  ///
  /// In de, this message translates to:
  /// **'Monat'**
  String get commonPerMonth;

  /// No description provided for @commonPerYear.
  ///
  /// In de, this message translates to:
  /// **'Jahr'**
  String get commonPerYear;

  /// No description provided for @commonRequired.
  ///
  /// In de, this message translates to:
  /// **'Pflichtfeld'**
  String get commonRequired;

  /// No description provided for @commonRetry.
  ///
  /// In de, this message translates to:
  /// **'Erneut versuchen'**
  String get commonRetry;

  /// No description provided for @commonSave.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get commonSave;

  /// No description provided for @commonUnderstood.
  ///
  /// In de, this message translates to:
  /// **'Verstanden'**
  String get commonUnderstood;

  /// No description provided for @commonUndo.
  ///
  /// In de, this message translates to:
  /// **'Rückgängig'**
  String get commonUndo;

  /// No description provided for @tabOverview.
  ///
  /// In de, this message translates to:
  /// **'Übersicht'**
  String get tabOverview;

  /// No description provided for @tabItems.
  ///
  /// In de, this message translates to:
  /// **'Posten'**
  String get tabItems;

  /// No description provided for @tabDistribution.
  ///
  /// In de, this message translates to:
  /// **'Verteiler'**
  String get tabDistribution;

  /// No description provided for @tabInsights.
  ///
  /// In de, this message translates to:
  /// **'Tipps'**
  String get tabInsights;

  /// No description provided for @tabSettings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get tabSettings;

  /// No description provided for @tabMore.
  ///
  /// In de, this message translates to:
  /// **'Mehr'**
  String get tabMore;

  /// No description provided for @distributionIntro.
  ///
  /// In de, this message translates to:
  /// **'Daueraufträge zum Monatsanfang: was jede Person auf welches Konto überweist und was danach frei bleibt.'**
  String get distributionIntro;

  /// No description provided for @distributionNoAccount.
  ///
  /// In de, this message translates to:
  /// **'Ohne Konto'**
  String get distributionNoAccount;

  /// No description provided for @distributionRemainder.
  ///
  /// In de, this message translates to:
  /// **'Bleibt frei'**
  String get distributionRemainder;

  /// No description provided for @distributionRemainderTo.
  ///
  /// In de, this message translates to:
  /// **'Bleibt frei auf {account}'**
  String distributionRemainderTo(String account);

  /// No description provided for @distributionFairness.
  ///
  /// In de, this message translates to:
  /// **'Fairer Ausgleich'**
  String get distributionFairness;

  /// No description provided for @distributionBalanced.
  ///
  /// In de, this message translates to:
  /// **'Ausgeglichen — niemand muss etwas überweisen.'**
  String get distributionBalanced;

  /// No description provided for @distributionSettlement.
  ///
  /// In de, this message translates to:
  /// **'{from} überweist an {to}'**
  String distributionSettlement(String from, String to);

  /// No description provided for @distributionSavings.
  ///
  /// In de, this message translates to:
  /// **'Sparkonten in 12 Monaten'**
  String get distributionSavings;

  /// No description provided for @distributionProjection.
  ///
  /// In de, this message translates to:
  /// **'{deposit} pro Monat · {rate} % Zinsen · davon Zinsen {interest}'**
  String distributionProjection(String deposit, String rate, String interest);

  /// No description provided for @distributionProjectionHint.
  ///
  /// In de, this message translates to:
  /// **'Hochrechnung mit monatlicher Verzinsung, ohne Steuern. Startwert = eingetragener Kontostand.'**
  String get distributionProjectionHint;

  /// No description provided for @insightsEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Alles im grünen Bereich'**
  String get insightsEmptyTitle;

  /// No description provided for @insightsEmptyText.
  ///
  /// In de, this message translates to:
  /// **'Gerade gibt es keine Vorschläge. Je mehr Posten du einträgst, desto genauer werden die Tipps.'**
  String get insightsEmptyText;

  /// No description provided for @insightsPotentialTitle.
  ///
  /// In de, this message translates to:
  /// **'Geschätztes Sparpotenzial'**
  String get insightsPotentialTitle;

  /// No description provided for @insightsPotentialValue.
  ///
  /// In de, this message translates to:
  /// **'{monthly} pro Monat · {yearly} pro Jahr'**
  String insightsPotentialValue(String monthly, String yearly);

  /// No description provided for @insightsPerMonth.
  ///
  /// In de, this message translates to:
  /// **'ca. {amount}/Monat'**
  String insightsPerMonth(String amount);

  /// No description provided for @insightsDisclaimer.
  ///
  /// In de, this message translates to:
  /// **'Die Tipps beruhen auf festen Regeln und deinen Angaben; Ersparnisse sind grobe Schätzungen. Keine Steuer-, Rechts- oder Anlageberatung.'**
  String get insightsDisclaimer;

  /// No description provided for @insightDeficitTitle.
  ///
  /// In de, this message translates to:
  /// **'Ausgaben übersteigen das Einkommen'**
  String get insightDeficitTitle;

  /// No description provided for @insightDeficitText.
  ///
  /// In de, this message translates to:
  /// **'Es fehlen {amount} pro Monat. Prüfe zuerst Wünsche und Abos oder passe Sparraten vorübergehend an.'**
  String insightDeficitText(String amount);

  /// No description provided for @insightNeedsTitle.
  ///
  /// In de, this message translates to:
  /// **'Grundbedarf über dem Ziel'**
  String get insightNeedsTitle;

  /// No description provided for @insightNeedsText.
  ///
  /// In de, this message translates to:
  /// **'Fixkosten und Grundbedarf liegen bei {percent} % statt {target} % (≈ {amount} pro Monat zu viel). Größte Hebel sind meist Wohnen, Mobilität und Versicherungen.'**
  String insightNeedsText(String percent, int target, String amount);

  /// No description provided for @insightSavingsTitle.
  ///
  /// In de, this message translates to:
  /// **'Sparquote unter dem Ziel'**
  String get insightSavingsTitle;

  /// No description provided for @insightSavingsText.
  ///
  /// In de, this message translates to:
  /// **'Du sparst {percent} % statt {target} %. Für das Ziel fehlen {amount} pro Monat — am einfachsten per Dauerauftrag direkt am Gehaltstag.'**
  String insightSavingsText(String percent, int target, String amount);

  /// No description provided for @insightFlaggedTitle.
  ///
  /// In de, this message translates to:
  /// **'Markierte Sparpotenziale'**
  String get insightFlaggedTitle;

  /// No description provided for @insightFlaggedText.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{Bei einem Posten hast du eine mögliche Ersparnis eingetragen.} other{Bei {count} Posten hast du eine mögliche Ersparnis eingetragen.}} Setze dir einen Termin, um zu kündigen oder zu wechseln.'**
  String insightFlaggedText(int count);

  /// No description provided for @insightDuplicateTitle.
  ///
  /// In de, this message translates to:
  /// **'„{label}“ gibt es mehrfach'**
  String insightDuplicateTitle(String label);

  /// No description provided for @insightDuplicateText.
  ///
  /// In de, this message translates to:
  /// **'{count} Verträge mit zusammen {amount} pro Monat. Ein Partner- oder Familientarif ist oft günstiger.'**
  String insightDuplicateText(int count, String amount);

  /// No description provided for @insightOverlapTitle.
  ///
  /// In de, this message translates to:
  /// **'Mehrere Abos: {label}'**
  String insightOverlapTitle(String label);

  /// No description provided for @insightOverlapText.
  ///
  /// In de, this message translates to:
  /// **'{count} Abos derselben Art laufen parallel. Rotieren spart: immer nur eins aktiv halten und monatlich wechseln.'**
  String insightOverlapText(int count);

  /// No description provided for @insightInsuranceTitle.
  ///
  /// In de, this message translates to:
  /// **'Versicherungen jährlich zahlen'**
  String get insightInsuranceTitle;

  /// No description provided for @insightInsuranceText.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{Eine Versicherung wird} other{{count} Versicherungen werden}} unterjährig bezahlt. Viele Versicherer berechnen dafür Aufschläge von einigen Prozent — jährliche Zahlweise anfragen.'**
  String insightInsuranceText(int count);

  /// No description provided for @insightZeroTitle.
  ///
  /// In de, this message translates to:
  /// **'Posten ohne Betrag'**
  String get insightZeroTitle;

  /// No description provided for @insightZeroText.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{Ein Posten hat} other{{count} Posten haben}} 0 €. Fehlt der Betrag, oder kann der Vertrag weg?'**
  String insightZeroText(int count);

  /// No description provided for @insightInterestTitle.
  ///
  /// In de, this message translates to:
  /// **'Zinsen auf dem Sparkonto prüfen'**
  String get insightInterestTitle;

  /// No description provided for @insightInterestText.
  ///
  /// In de, this message translates to:
  /// **'Mindestens ein Sparkonto hat keinen oder weniger als {rate} % Zins eingetragen. Ein Tagesgeldvergleich lohnt sich bei regelmäßigen Sparraten.'**
  String insightInterestText(String rate);

  /// No description provided for @insightEmergencyTitle.
  ///
  /// In de, this message translates to:
  /// **'Notgroschen'**
  String get insightEmergencyTitle;

  /// No description provided for @insightEmergencyText.
  ///
  /// In de, this message translates to:
  /// **'Empfohlen sind drei Monate Grundbedarf, also etwa {amount}. Auf deinen Sparkonten liegen {percent} % davon.'**
  String insightEmergencyText(String amount, String percent);

  /// No description provided for @insightEmergencyUnknown.
  ///
  /// In de, this message translates to:
  /// **'Empfohlen sind drei Monate Grundbedarf, also etwa {amount}. Trage Kontostände bei deinen Sparkonten ein, um den Stand zu sehen.'**
  String insightEmergencyUnknown(String amount);

  /// No description provided for @insightBiggestWantTitle.
  ///
  /// In de, this message translates to:
  /// **'Größter Wunsch-Posten: {label}'**
  String insightBiggestWantTitle(String label);

  /// No description provided for @insightBiggestWantText.
  ///
  /// In de, this message translates to:
  /// **'Er macht {percent} % deines Nettoeinkommens aus — {amount} im Jahr. Schon eine kleine Reduzierung wirkt hier stark.'**
  String insightBiggestWantText(String percent, String amount);

  /// No description provided for @insightMissingAccountTitle.
  ///
  /// In de, this message translates to:
  /// **'Posten ohne Konto'**
  String get insightMissingAccountTitle;

  /// No description provided for @insightMissingAccountText.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{Ein Posten ist} other{{count} Posten sind}} keinem Konto zugeordnet. Mit Konto zeigt der Verteiler genaue Daueraufträge.'**
  String insightMissingAccountText(int count);

  /// No description provided for @insightReserveTitle.
  ///
  /// In de, this message translates to:
  /// **'Jahreszahlungen ansparen'**
  String get insightReserveTitle;

  /// No description provided for @insightReserveText.
  ///
  /// In de, this message translates to:
  /// **'Lege {amount} pro Monat auf ein eigenes Unterkonto, dann sind Jahresbeiträge kein Loch im Konto.'**
  String insightReserveText(String amount);

  /// No description provided for @itemsAdd.
  ///
  /// In de, this message translates to:
  /// **'Posten hinzufügen'**
  String get itemsAdd;

  /// No description provided for @itemsEdit.
  ///
  /// In de, this message translates to:
  /// **'Posten bearbeiten'**
  String get itemsEdit;

  /// No description provided for @itemsEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Posten'**
  String get itemsEmptyTitle;

  /// No description provided for @itemsEmptyText.
  ///
  /// In de, this message translates to:
  /// **'Tippe auf „Posten hinzufügen“. Vorschläge helfen bei Miete, Versicherungen, Abos und mehr.'**
  String get itemsEmptyText;

  /// No description provided for @itemsSearch.
  ///
  /// In de, this message translates to:
  /// **'Posten suchen'**
  String get itemsSearch;

  /// No description provided for @itemsFilterAll.
  ///
  /// In de, this message translates to:
  /// **'Alle'**
  String get itemsFilterAll;

  /// No description provided for @itemsFilterShared.
  ///
  /// In de, this message translates to:
  /// **'Gemeinsam'**
  String get itemsFilterShared;

  /// No description provided for @itemsCount.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =0{Keine Posten} =1{1 Posten} other{{count} Posten}}'**
  String itemsCount(int count);

  /// No description provided for @itemsHasPotential.
  ///
  /// In de, this message translates to:
  /// **'Sparpotenzial'**
  String get itemsHasPotential;

  /// No description provided for @itemsDeleted.
  ///
  /// In de, this message translates to:
  /// **'„{label}“ gelöscht'**
  String itemsDeleted(String label);

  /// No description provided for @itemsLabel.
  ///
  /// In de, this message translates to:
  /// **'Bezeichnung'**
  String get itemsLabel;

  /// No description provided for @itemsCategory.
  ///
  /// In de, this message translates to:
  /// **'Bereich'**
  String get itemsCategory;

  /// No description provided for @itemsAmount.
  ///
  /// In de, this message translates to:
  /// **'Betrag'**
  String get itemsAmount;

  /// No description provided for @itemsInterval.
  ///
  /// In de, this message translates to:
  /// **'Rhythmus'**
  String get itemsInterval;

  /// No description provided for @itemsMonthlyEquivalent.
  ///
  /// In de, this message translates to:
  /// **'Entspricht {amount} pro Monat'**
  String itemsMonthlyEquivalent(String amount);

  /// No description provided for @itemsDueMonth.
  ///
  /// In de, this message translates to:
  /// **'Fällig im'**
  String get itemsDueMonth;

  /// No description provided for @itemsPayer.
  ///
  /// In de, this message translates to:
  /// **'Wer zahlt?'**
  String get itemsPayer;

  /// No description provided for @itemsJoint.
  ///
  /// In de, this message translates to:
  /// **'Gemeinschaftskonto'**
  String get itemsJoint;

  /// No description provided for @itemsBeneficiary.
  ///
  /// In de, this message translates to:
  /// **'Für wen?'**
  String get itemsBeneficiary;

  /// No description provided for @itemsBeneficiaryHint.
  ///
  /// In de, this message translates to:
  /// **'Wichtig für den fairen Ausgleich'**
  String get itemsBeneficiaryHint;

  /// No description provided for @itemsHousehold.
  ///
  /// In de, this message translates to:
  /// **'Ganzer Haushalt'**
  String get itemsHousehold;

  /// No description provided for @itemsAccount.
  ///
  /// In de, this message translates to:
  /// **'Abbuchung von Konto'**
  String get itemsAccount;

  /// No description provided for @itemsAccountSavings.
  ///
  /// In de, this message translates to:
  /// **'Sparen auf Konto'**
  String get itemsAccountSavings;

  /// No description provided for @itemsDetails.
  ///
  /// In de, this message translates to:
  /// **'Details'**
  String get itemsDetails;

  /// No description provided for @itemsDetailsHint.
  ///
  /// In de, this message translates to:
  /// **'Topf, Anbieter, Vertragsnummer, Sparpotenzial …'**
  String get itemsDetailsHint;

  /// No description provided for @itemsBucket.
  ///
  /// In de, this message translates to:
  /// **'Topf (Budgetregel)'**
  String get itemsBucket;

  /// No description provided for @itemsBucketHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Genussmittel unter Lebensmittel als „Wünsche“ zählen'**
  String get itemsBucketHint;

  /// No description provided for @itemsBucketFromCategory.
  ///
  /// In de, this message translates to:
  /// **'Wie Bereich ({bucket})'**
  String itemsBucketFromCategory(String bucket);

  /// No description provided for @itemsTag.
  ///
  /// In de, this message translates to:
  /// **'Unterkategorie'**
  String get itemsTag;

  /// No description provided for @itemsTagHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Streaming, Sport — gleiche Unterkategorien werden verglichen'**
  String get itemsTagHint;

  /// No description provided for @itemsProvider.
  ///
  /// In de, this message translates to:
  /// **'Anbieter'**
  String get itemsProvider;

  /// No description provided for @itemsContract.
  ///
  /// In de, this message translates to:
  /// **'Vertrags-/Versicherungsnummer'**
  String get itemsContract;

  /// No description provided for @itemsPhone.
  ///
  /// In de, this message translates to:
  /// **'Telefon'**
  String get itemsPhone;

  /// No description provided for @itemsPotential.
  ///
  /// In de, this message translates to:
  /// **'Mögliche Ersparnis pro Monat'**
  String get itemsPotential;

  /// No description provided for @itemsPotentialHint.
  ///
  /// In de, this message translates to:
  /// **'Eigene Einschätzung, z. B. nach Tarifvergleich oder Kündigung'**
  String get itemsPotentialHint;

  /// No description provided for @itemsTarget.
  ///
  /// In de, this message translates to:
  /// **'Sparziel'**
  String get itemsTarget;

  /// No description provided for @itemsNotes.
  ///
  /// In de, this message translates to:
  /// **'Notizen'**
  String get itemsNotes;

  /// No description provided for @onboardingTitle.
  ///
  /// In de, this message translates to:
  /// **'Dein Budget bleibt bei dir'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Einkommen, Fixkosten, Abos und Sparziele an einem Ort — für dich allein oder den ganzen Haushalt.'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingPointEncrypted.
  ///
  /// In de, this message translates to:
  /// **'Alle Zahlen liegen verschlüsselt nur auf diesem Gerät. Kein Konto, kein Server.'**
  String get onboardingPointEncrypted;

  /// No description provided for @onboardingPointOffline.
  ///
  /// In de, this message translates to:
  /// **'Die App braucht kein Internet und keine Bankverbindung — du trägst deine Posten selbst ein.'**
  String get onboardingPointOffline;

  /// No description provided for @onboardingPointDistribution.
  ///
  /// In de, this message translates to:
  /// **'Der Verteiler zeigt, wer wie viel auf welches Konto überweist und wie ihr fair ausgleicht.'**
  String get onboardingPointDistribution;

  /// No description provided for @onboardingPointInsights.
  ///
  /// In de, this message translates to:
  /// **'Tipps zeigen Sparpotenziale: doppelte Abos, Zahlweise, Zinsen, Budgetregel.'**
  String get onboardingPointInsights;

  /// No description provided for @onboardingHouseholdTitle.
  ///
  /// In de, this message translates to:
  /// **'Wer gehört zum Haushalt?'**
  String get onboardingHouseholdTitle;

  /// No description provided for @onboardingHouseholdText.
  ///
  /// In de, this message translates to:
  /// **'Trage alle Personen ein, die zum Budget beitragen, mit ihrem monatlichen Nettoeinkommen.'**
  String get onboardingHouseholdText;

  /// No description provided for @onboardingNet.
  ///
  /// In de, this message translates to:
  /// **'Netto pro Monat'**
  String get onboardingNet;

  /// No description provided for @onboardingHint.
  ///
  /// In de, this message translates to:
  /// **'Weitere Einkommen, Brutto und Konten kannst du später in den Einstellungen ergänzen.'**
  String get onboardingHint;

  /// No description provided for @onboardingStart.
  ///
  /// In de, this message translates to:
  /// **'Los geht\'s'**
  String get onboardingStart;

  /// No description provided for @onboardingIncomeLabel.
  ///
  /// In de, this message translates to:
  /// **'Gehalt'**
  String get onboardingIncomeLabel;

  /// No description provided for @onboardingMainAccount.
  ///
  /// In de, this message translates to:
  /// **'Girokonto {name}'**
  String onboardingMainAccount(String name);

  /// No description provided for @overviewFree.
  ///
  /// In de, this message translates to:
  /// **'Frei verfügbar'**
  String get overviewFree;

  /// No description provided for @overviewIncome.
  ///
  /// In de, this message translates to:
  /// **'Nettoeinkommen'**
  String get overviewIncome;

  /// No description provided for @overviewPlanned.
  ///
  /// In de, this message translates to:
  /// **'Geplante Posten'**
  String get overviewPlanned;

  /// No description provided for @overviewPlannedHint.
  ///
  /// In de, this message translates to:
  /// **'Fixkosten, Abos, Lebensmittel, Wünsche und Sparraten'**
  String get overviewPlannedHint;

  /// No description provided for @overviewFreeOf.
  ///
  /// In de, this message translates to:
  /// **'Frei für {name}'**
  String overviewFreeOf(String name);

  /// No description provided for @overviewDeductions.
  ///
  /// In de, this message translates to:
  /// **'Abzüge (Steuern und Sozialabgaben): {percent} % vom Brutto'**
  String overviewDeductions(String percent);

  /// No description provided for @overviewEmptyTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Posten'**
  String get overviewEmptyTitle;

  /// No description provided for @overviewEmptyText.
  ///
  /// In de, this message translates to:
  /// **'Lege Miete, Versicherungen, Abos, Lebensmittel und Sparraten an — die Übersicht rechnet alles auf Monat und Jahr um.'**
  String get overviewEmptyText;

  /// No description provided for @overviewRuleTitle.
  ///
  /// In de, this message translates to:
  /// **'Budgetregel {needs}/{wants}/{savings}'**
  String overviewRuleTitle(int needs, int wants, int savings);

  /// No description provided for @overviewRuleNoIncome.
  ///
  /// In de, this message translates to:
  /// **'Trage ein Einkommen ein, um die Verteilung zu sehen.'**
  String get overviewRuleNoIncome;

  /// No description provided for @overviewRuleShare.
  ///
  /// In de, this message translates to:
  /// **'{share} % von {target} %'**
  String overviewRuleShare(String share, int target);

  /// No description provided for @overviewRuleHint.
  ///
  /// In de, this message translates to:
  /// **'Anteile am Nettoeinkommen. Der Strich markiert das Ziel; was übrig bleibt, ist frei verfügbar.'**
  String get overviewRuleHint;

  /// No description provided for @overviewCategories.
  ///
  /// In de, this message translates to:
  /// **'Bereiche'**
  String get overviewCategories;

  /// No description provided for @overviewReserveTitle.
  ///
  /// In de, this message translates to:
  /// **'Rücklage für Jahreszahlungen'**
  String get overviewReserveTitle;

  /// No description provided for @overviewReserveText.
  ///
  /// In de, this message translates to:
  /// **'Für Versicherungen, Steuern und andere nicht monatliche Posten solltest du {amount} pro Monat zurücklegen.'**
  String overviewReserveText(String amount);

  /// No description provided for @overviewDueSoon.
  ///
  /// In de, this message translates to:
  /// **'Demnächst fällig'**
  String get overviewDueSoon;

  /// No description provided for @overviewDueThisMonth.
  ///
  /// In de, this message translates to:
  /// **'Diesen Monat'**
  String get overviewDueThisMonth;

  /// No description provided for @overviewDueInMonths.
  ///
  /// In de, this message translates to:
  /// **'{months, plural, =1{Nächsten Monat} other{In {months} Monaten}}'**
  String overviewDueInMonths(int months);

  /// No description provided for @overviewInsights.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{1 Tipp für dein Budget} other{{count} Tipps für dein Budget}}'**
  String overviewInsights(int count);

  /// No description provided for @overviewInsightsPotential.
  ///
  /// In de, this message translates to:
  /// **'Mögliche Ersparnis ca. {amount} pro Monat'**
  String overviewInsightsPotential(String amount);

  /// No description provided for @settingsBudgetSection.
  ///
  /// In de, this message translates to:
  /// **'Budget'**
  String get settingsBudgetSection;

  /// No description provided for @settingsHousehold.
  ///
  /// In de, this message translates to:
  /// **'Haushalt & Einkommen'**
  String get settingsHousehold;

  /// No description provided for @settingsHouseholdSummary.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{1 Person} other{{count} Personen}} · {income} netto/Monat'**
  String settingsHouseholdSummary(int count, String income);

  /// No description provided for @settingsAccounts.
  ///
  /// In de, this message translates to:
  /// **'Konten'**
  String get settingsAccounts;

  /// No description provided for @settingsAccountsSummary.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =0{Noch keine Konten} =1{1 Konto} other{{count} Konten}}'**
  String settingsAccountsSummary(int count);

  /// No description provided for @settingsCategories.
  ///
  /// In de, this message translates to:
  /// **'Bereiche'**
  String get settingsCategories;

  /// No description provided for @settingsCategoriesSummary.
  ///
  /// In de, this message translates to:
  /// **'{count} Bereiche'**
  String settingsCategoriesSummary(int count);

  /// No description provided for @settingsRule.
  ///
  /// In de, this message translates to:
  /// **'Budgetregel'**
  String get settingsRule;

  /// No description provided for @settingsRuleValue.
  ///
  /// In de, this message translates to:
  /// **'{needs} % Grundbedarf · {wants} % Wünsche · {savings} % Sparen'**
  String settingsRuleValue(int needs, int wants, int savings);

  /// No description provided for @settingsRuleHint.
  ///
  /// In de, this message translates to:
  /// **'Wie viel vom Nettoeinkommen in welchen Topf gehen soll. Bekannt ist 50/30/20.'**
  String get settingsRuleHint;

  /// No description provided for @settingsSecuritySection.
  ///
  /// In de, this message translates to:
  /// **'Sicherheit'**
  String get settingsSecuritySection;

  /// No description provided for @settingsLockTitle.
  ///
  /// In de, this message translates to:
  /// **'App-Sperre'**
  String get settingsLockTitle;

  /// No description provided for @settingsLockSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Entsperren mit Fingerabdruck oder Geräte-PIN; Inhalte in „Zuletzt verwendet“ und Screenshots ausblenden'**
  String get settingsLockSubtitle;

  /// No description provided for @settingsLockNoDeviceLock.
  ///
  /// In de, this message translates to:
  /// **'Richte zuerst eine Displaysperre auf dem Gerät ein.'**
  String get settingsLockNoDeviceLock;

  /// No description provided for @settingsLockReasonSetup.
  ///
  /// In de, this message translates to:
  /// **'App-Sperre einschalten'**
  String get settingsLockReasonSetup;

  /// No description provided for @settingsLockReasonDisable.
  ///
  /// In de, this message translates to:
  /// **'App-Sperre ausschalten'**
  String get settingsLockReasonDisable;

  /// No description provided for @settingsLockReasonUnlock.
  ///
  /// In de, this message translates to:
  /// **'Mai Budget entsperren'**
  String get settingsLockReasonUnlock;

  /// No description provided for @settingsLockLockedTitle.
  ///
  /// In de, this message translates to:
  /// **'Mai Budget ist gesperrt'**
  String get settingsLockLockedTitle;

  /// No description provided for @settingsLockLockedText.
  ///
  /// In de, this message translates to:
  /// **'Entsperre die App, um deine Zahlen zu sehen.'**
  String get settingsLockLockedText;

  /// No description provided for @settingsLockUnlock.
  ///
  /// In de, this message translates to:
  /// **'Entsperren'**
  String get settingsLockUnlock;

  /// No description provided for @settingsBackupSection.
  ///
  /// In de, this message translates to:
  /// **'Sicherung'**
  String get settingsBackupSection;

  /// No description provided for @settingsPrivacySection.
  ///
  /// In de, this message translates to:
  /// **'Datenschutz'**
  String get settingsPrivacySection;

  /// No description provided for @settingsPrivacyText.
  ///
  /// In de, this message translates to:
  /// **'Alle Daten liegen verschlüsselt in der App auf diesem Gerät (SQLCipher-kompatibel, Schlüssel im Android-Keystore). Die App hat keine Internet-Berechtigung, nimmt nicht an Android-Backups teil und überträgt nichts. Daten verlassen das Gerät nur über eine Sicherung, die du selbst mit Passwort erstellst.'**
  String get settingsPrivacyText;

  /// No description provided for @settingsKeyUnavailableTitle.
  ///
  /// In de, this message translates to:
  /// **'Schlüssel gerade nicht verfügbar'**
  String get settingsKeyUnavailableTitle;

  /// No description provided for @settingsKeyUnavailableText.
  ///
  /// In de, this message translates to:
  /// **'Der Schlüssel deiner verschlüsselten Daten konnte gerade nicht gelesen werden. Deine Daten sind unverändert — bitte versuche es gleich noch einmal.'**
  String get settingsKeyUnavailableText;

  /// No description provided for @settingsUnreadableTitle.
  ///
  /// In de, this message translates to:
  /// **'Alte Daten nicht lesbar'**
  String get settingsUnreadableTitle;

  /// No description provided for @settingsUnreadableText.
  ///
  /// In de, this message translates to:
  /// **'Die gespeicherten Daten ließen sich nicht entschlüsseln (z. B. nach Zurücksetzen der Gerätesicherheit) und wurden beiseitegelegt. Stelle sie aus einer Sicherung wieder her.'**
  String get settingsUnreadableText;

  /// No description provided for @householdAddPerson.
  ///
  /// In de, this message translates to:
  /// **'Person hinzufügen'**
  String get householdAddPerson;

  /// No description provided for @householdRename.
  ///
  /// In de, this message translates to:
  /// **'Umbenennen'**
  String get householdRename;

  /// No description provided for @householdRemoveTitle.
  ///
  /// In de, this message translates to:
  /// **'{name} entfernen?'**
  String householdRemoveTitle(String name);

  /// No description provided for @householdRemoveText.
  ///
  /// In de, this message translates to:
  /// **'Einkommen und Konten der Person werden archiviert. Ihre Posten bleiben erhalten und zählen danach als gemeinsam.'**
  String get householdRemoveText;

  /// No description provided for @householdNet.
  ///
  /// In de, this message translates to:
  /// **'{amount} netto pro Monat'**
  String householdNet(String amount);

  /// No description provided for @householdGross.
  ///
  /// In de, this message translates to:
  /// **'brutto {amount}'**
  String householdGross(String amount);

  /// No description provided for @householdAddIncome.
  ///
  /// In de, this message translates to:
  /// **'Einkommen hinzufügen'**
  String get householdAddIncome;

  /// No description provided for @householdIncomeOf.
  ///
  /// In de, this message translates to:
  /// **'Einkommen von {name}'**
  String householdIncomeOf(String name);

  /// No description provided for @householdIncomeLabel.
  ///
  /// In de, this message translates to:
  /// **'Bezeichnung'**
  String get householdIncomeLabel;

  /// No description provided for @householdNetLabel.
  ///
  /// In de, this message translates to:
  /// **'Netto'**
  String get householdNetLabel;

  /// No description provided for @householdGrossLabel.
  ///
  /// In de, this message translates to:
  /// **'Brutto (optional)'**
  String get householdGrossLabel;

  /// No description provided for @householdGrossHint.
  ///
  /// In de, this message translates to:
  /// **'Nur für die Anzeige der Abzüge'**
  String get householdGrossHint;

  /// No description provided for @accountsAdd.
  ///
  /// In de, this message translates to:
  /// **'Konto hinzufügen'**
  String get accountsAdd;

  /// No description provided for @accountsEdit.
  ///
  /// In de, this message translates to:
  /// **'Konto bearbeiten'**
  String get accountsEdit;

  /// No description provided for @accountsIntro.
  ///
  /// In de, this message translates to:
  /// **'Konten sind die Ziele im Verteiler: Girokonten, Tagesgeld-Unterkonten für Urlaub oder Geschenke, Karten. Das Hauptkonto einer Person bekommt, was übrig bleibt.'**
  String get accountsIntro;

  /// No description provided for @accountsKind.
  ///
  /// In de, this message translates to:
  /// **'Art'**
  String get accountsKind;

  /// No description provided for @accountsOwner.
  ///
  /// In de, this message translates to:
  /// **'Inhaber'**
  String get accountsOwner;

  /// No description provided for @accountsJoint.
  ///
  /// In de, this message translates to:
  /// **'Gemeinsam'**
  String get accountsJoint;

  /// No description provided for @accountsMain.
  ///
  /// In de, this message translates to:
  /// **'Hauptkonto'**
  String get accountsMain;

  /// No description provided for @accountsMainHint.
  ///
  /// In de, this message translates to:
  /// **'Bekommt das frei verfügbare Geld'**
  String get accountsMainHint;

  /// No description provided for @accountsRate.
  ///
  /// In de, this message translates to:
  /// **'Zinssatz'**
  String get accountsRate;

  /// No description provided for @accountsBalance.
  ///
  /// In de, this message translates to:
  /// **'Aktueller Kontostand (optional)'**
  String get accountsBalance;

  /// No description provided for @accountsBalanceHint.
  ///
  /// In de, this message translates to:
  /// **'Für Notgroschen und Sparprognose'**
  String get accountsBalanceHint;

  /// No description provided for @categoriesAdd.
  ///
  /// In de, this message translates to:
  /// **'Bereich hinzufügen'**
  String get categoriesAdd;

  /// No description provided for @categoriesEdit.
  ///
  /// In de, this message translates to:
  /// **'Bereich bearbeiten'**
  String get categoriesEdit;

  /// No description provided for @categoriesIntro.
  ///
  /// In de, this message translates to:
  /// **'Bereiche gliedern deine Posten. Der Topf bestimmt, wie sie in der Budgetregel zählen.'**
  String get categoriesIntro;

  /// No description provided for @categoriesNotEmpty.
  ///
  /// In de, this message translates to:
  /// **'Nur leere Bereiche können gelöscht werden.'**
  String get categoriesNotEmpty;

  /// No description provided for @backupIntro.
  ///
  /// In de, this message translates to:
  /// **'Verschlüsselte Datei mit allen Daten (AES-256). Ohne Passwort lässt sie sich nicht öffnen — bewahre es gut auf.'**
  String get backupIntro;

  /// No description provided for @backupCreate.
  ///
  /// In de, this message translates to:
  /// **'Sicherung erstellen'**
  String get backupCreate;

  /// No description provided for @backupRestore.
  ///
  /// In de, this message translates to:
  /// **'Wiederherstellen'**
  String get backupRestore;

  /// No description provided for @backupCreated.
  ///
  /// In de, this message translates to:
  /// **'Sicherung erstellt'**
  String get backupCreated;

  /// No description provided for @backupFailed.
  ///
  /// In de, this message translates to:
  /// **'Sicherung fehlgeschlagen'**
  String get backupFailed;

  /// No description provided for @backupShareSubject.
  ///
  /// In de, this message translates to:
  /// **'Mai Budget Sicherung'**
  String get backupShareSubject;

  /// No description provided for @backupPick.
  ///
  /// In de, this message translates to:
  /// **'Sicherung auswählen'**
  String get backupPick;

  /// No description provided for @backupRestoreConfirmTitle.
  ///
  /// In de, this message translates to:
  /// **'Alle Daten ersetzen?'**
  String get backupRestoreConfirmTitle;

  /// No description provided for @backupRestoreConfirmText.
  ///
  /// In de, this message translates to:
  /// **'Die Sicherung ersetzt alle aktuellen Daten in der App. Das lässt sich nicht rückgängig machen.'**
  String get backupRestoreConfirmText;

  /// No description provided for @backupReplace.
  ///
  /// In de, this message translates to:
  /// **'Ersetzen'**
  String get backupReplace;

  /// No description provided for @backupRestored.
  ///
  /// In de, this message translates to:
  /// **'Sicherung vom {date} wiederhergestellt'**
  String backupRestored(String date);

  /// No description provided for @backupPassphrase.
  ///
  /// In de, this message translates to:
  /// **'Passwort'**
  String get backupPassphrase;

  /// No description provided for @backupPassphraseRepeat.
  ///
  /// In de, this message translates to:
  /// **'Passwort wiederholen'**
  String get backupPassphraseRepeat;

  /// No description provided for @backupPassphraseCreateHint.
  ///
  /// In de, this message translates to:
  /// **'Mit diesem Passwort wird die Sicherung verschlüsselt. Es wird nirgends gespeichert.'**
  String get backupPassphraseCreateHint;

  /// No description provided for @backupPassphraseRestoreHint.
  ///
  /// In de, this message translates to:
  /// **'Passwort der Sicherung eingeben.'**
  String get backupPassphraseRestoreHint;

  /// No description provided for @backupPassphraseTooShort.
  ///
  /// In de, this message translates to:
  /// **'Mindestens 8 Zeichen'**
  String get backupPassphraseTooShort;

  /// No description provided for @backupPassphraseMismatch.
  ///
  /// In de, this message translates to:
  /// **'Passwörter stimmen nicht überein'**
  String get backupPassphraseMismatch;

  /// No description provided for @backupWrongApp.
  ///
  /// In de, this message translates to:
  /// **'Diese Datei ist keine Mai-Budget-Sicherung.'**
  String get backupWrongApp;

  /// No description provided for @backupTooNew.
  ///
  /// In de, this message translates to:
  /// **'Die Sicherung stammt aus einer neueren App-Version — bitte erst die App aktualisieren.'**
  String get backupTooNew;

  /// No description provided for @backupUnsupported.
  ///
  /// In de, this message translates to:
  /// **'Sicherungen sind in dieser Version nicht verfügbar.'**
  String get backupUnsupported;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
