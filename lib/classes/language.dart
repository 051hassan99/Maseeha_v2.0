class Language{

  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(
    this.id,
    this.flag,
    this.name,
    this.languageCode,
  ); 

  static List <Language> languageList(){
    return <Language>[
      Language(1, '🇵🇰', 'اردو', 'ur'),
      Language(2, '🇺🇸', 'English', 'en')
    ];
  }

  
}