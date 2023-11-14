class FormsConsts {
  // int
  static const int nGramIndex = 2; // 検索に使用
  // create post
  static const int maxTitleLimit = 32;
  static const int maxDescriptionLimit = 1000;
  static const int maxSystemPromptLimit = 1000;
  // prifile
  static const int maxUserNameLimit = 32;
  static const int maxBioLimit = 200;
  // message
  static const int maxMessageLimit = 1000;
  // double
  // chatGPT request
  static const double defaultTemperature = 0.3;
  static const double defaultTopP = 1.0;
  static const double defaultPresencePenalty = 0.0;
  static const double defaultFrequencyPenalty = 0.0;
  // 文字列
  // プロフィール編集
  static const String bioHelpMsg =
      "プロフィールに表示される紹介文です。$maxBioLimit文字以下である必要があります。$negativeAlertMsg";
  static const String userNameHelpMsg =
      "ユーザーから検索される名前です。$nGramIndex文字以上、$maxUserNameLimit文字以下である必要があります。$negativeAlertMsg";
  // 投稿ページ
  static const String systemPromptHelpMsg =
      "キャラクターの特徴を決めるテキストです。AIの返答に大きく影響します。公開情報ゆえ、漏洩の対応は一切行っていません。最大$maxSystemPromptLimit文字までです。";
  static const String titleHelpMsg =
      "投稿のタイトルです。AIの返答には全く影響しません。最大$maxTitleLimit文字までです。$negativeAlertMsg";
  static const String descriptionHelpMsg =
      "AIの一言目です。使い方などを説明すると良いでしょう。最大$maxDescriptionLimit文字までです。$negativeAlertMsg";
  static const String temperatureHelpMsg =
      "値は0.0以上、2.0以下の数を設定できます。0.8のような高い値の場合、出力がランダムになります。0.2のような低い値の場合は出力が決定的になります。topPとどちらか一方しか初期値から変更できません。初期値は$defaultTemperatureです。AIの返答に影響します。$roundMsg";
  static const String topPHelpMsg =
      "核サンプリングと呼ばれる、temperatureによるサンプリングの代替案です。値は0.0以上、1.0以下の数を設定できます。モデルはtop_pの確率でトークンの結果を考慮します。つまり、0.1は上位10%の確率からなる珍しい文字列が生成されます。temperatureとどちらか一方しか初期値から変更できません。初期値は$defaultTopPです。AIの返答に影響します。$roundMsg";
  static const String presencePenaltyHelpMsg =
      "値は-2.0以上、2.0以下の数を設定できます。初期値は$defaultPresencePenaltyです。正の値は、新しいトークンがこれまでにテキストに現れたかどうかに基づいてペナルティを課し、モデルが新しいトピックについて話す可能性を高めます。AIの返答に影響します。$roundMsg";
  static const String frequencyPenaltyHelpMsg =
      "値は-2.0以上、2.0以下の数を設定できます。初期値は$defaultFrequencyPenaltyです。正の値は、新しいトークンに、これまでのテキストでの頻度に基づいてペナルティを与え、モデルが同じ行を逐語的に繰り返す可能性を減らします。AIの返答に影響します。$roundMsg";
  static const String roundMsg = "また、値は少数第二位で四捨五入されます。";
  static const String negativeAlertMsg =
      "ネガティブな内容を含むと、他のユーザーに表示されなくなる可能性があります。";
  static String textLimitMsg(int limit, String value) =>
      "最大$limit文字までです。（現在${value.length}文字)";
  // ヒントテキスト
  static const String hintTitle = "例: レオナルド";
  static const String hintDescription = "例: レオナルドと申します。以後お見知り置きを。";
  // 初期値
  static const String defaultSystemPrompt = """
  名前： （例：レオナルド）
  年齢： （例： 25歳）
  身長： （例： 185cm）
  職業： （例： 王位継承者）
  髪色： （例： ブロンド）
  眼色： （例： 青）
  性格： （例： 優雅で知識が豊富、しかし冷たい一面も）
  趣味： （例： 馬術、読書、芸術鑑賞）
  特技： （例： 剣術、外交術）
  特徴： （例： なかなか素直になれないが、ユーザーに好意を持っている）
  口調： （例： タメ口）
  好きなもの： （例： 赤ワイン、クラシック音楽）
  嫌いなもの： （例： 嘘、不誠実な人）
  バックグラウンド： （例： 二人の兄と激しい王位継承争いをしている）
  ----------
  ・具体的な回答を導き出すために、指示内に不足する情報を必ず質問してください。
  ・いきなりステップの提案は必要ありません。
  ・追加情報に情報が不足している場合にも、質問をしてください。
  ・繰り返し何度も質問をしてください。
  ・事例や条件が必要な場合にはそれに対応する質問をしてください。""";
}
