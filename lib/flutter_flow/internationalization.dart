import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['pt', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? ptText = '',
    String? enText = '',
  }) =>
      [ptText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Login
  {
    'f3mds808': {
      'pt': 'Log In',
      'en': 'Log In',
    },
    '4ifb8vmw': {
      'pt': 'Preencha os campos abaixo para fazer login',
      'en': 'Fill in the fields below to log in',
    },
    'r9kc4os7': {
      'pt': 'Email',
      'en': 'E-mail',
    },
    '87928wi0': {
      'pt': 'Senha',
      'en': 'Password',
    },
    '9w9ah4yp': {
      'pt': 'Log In',
      'en': 'Log In',
    },
    'xsau335m': {
      'pt': 'Esqueci a senha',
      'en': 'Forgot password',
    },
    'qzz0s51k': {
      'pt': 'Ou entre utilizando outra plataforma',
      'en': 'Or log in using another platform',
    },
    '18qloeoq': {
      'pt': 'Login pelo Google',
      'en': 'Login via Google',
    },
    'fkc8f053': {
      'pt': 'Login pela Apple',
      'en': 'Sign in with Apple',
    },
    'pakuj1bt': {
      'pt': 'Sign Up',
      'en': 'Sign Up',
    },
    'k98tugbd': {
      'pt': 'Preencha os campos abaixo para criar a sua conta',
      'en': 'Fill in the fields below to create your account',
    },
    'ysf6rsx9': {
      'pt': 'Nome',
      'en': 'Name',
    },
    'k9oed7eq': {
      'pt': 'Email',
      'en': 'E-mail',
    },
    'iea9y7mc': {
      'pt': 'Senha',
      'en': 'Password',
    },
    '03yjdyie': {
      'pt': 'Confirmar Senha',
      'en': 'Confirm Password',
    },
    'd35o7igx': {
      'pt': 'Aceito os termos da  ',
      'en': 'I accept the terms of the',
    },
    's193084w': {
      'pt': 'Política de Privacidade',
      'en': 'Privacy Policy',
    },
    '1dy55s0l': {
      'pt': 'Criar Conta',
      'en': 'Create Account',
    },
    'akqoqq1v': {
      'pt': 'Ou cadastre-se por outra plataforma',
      'en': 'Or register through another platform',
    },
    '9l0j1nvy': {
      'pt': 'Login pelo Google',
      'en': 'Login via Google',
    },
    '4vlbxtdy': {
      'pt': 'Login pela Apple',
      'en': 'Sign in with Apple',
    },
    'ai7tj6wu': {
      'pt': 'Home',
      'en': 'Home',
    },
  },
  // configuracoes
  {
    'qrbp2qkk': {
      'pt': 'Configurações',
      'en': 'Settings',
    },
    '0ek96lxe': {
      'pt': 'Informações gerais',
      'en': 'General information',
    },
    '9zg5o0kr': {
      'pt': '',
      'en': '',
    },
    '3xj8wu7w': {
      'pt': '',
      'en': '',
    },
    'jchs5rmt': {
      'pt': 'Salvar Alterações',
      'en': 'Save Changes',
    },
    '2ntatj3u': {
      'pt': 'Alterar senha',
      'en': 'Change password',
    },
    'zc3ercgj': {
      'pt': 'Interface e Linguagem',
      'en': 'Interface and Language',
    },
    '6luvncvn': {
      'pt': 'Modo escuro',
      'en': 'Dark mode',
    },
    'dg01gc5b': {
      'pt': '',
      'en': '',
    },
    'i28vtsvh': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'rt94lpkh': {
      'pt': 'Português',
      'en': 'Portuguese',
    },
    'z9rlde76': {
      'pt': 'Ingles',
      'en': 'English',
    },
    'wnywqz4c': {
      'pt': 'Assinaturas',
      'en': 'Signatures',
    },
    'i8hr3td9': {
      'pt': 'Clientes BAM',
      'en': 'BAM Clients',
    },
    'm4zh0edm': {
      'pt': 'Ativo durante o período do contrato vigente',
      'en': 'Active during the current contract period',
    },
    '5usl0fuf': {
      'pt': 'contas conectadas',
      'en': 'connected accounts',
    },
    'yzv7gkj8': {
      'pt': 'Gerenciar Contas',
      'en': 'Manage Accounts',
    },
    'ziomaow5': {
      'pt': 'Segurança e Privacidade',
      'en': 'Security and Privacy',
    },
    'iv5ibjf9': {
      'pt': 'Log Out',
      'en': 'Log Out',
    },
    'om3s6k6f': {
      'pt': 'Deletar Conta',
      'en': 'Delete Account',
    },
    '6b93svjc': {
      'pt': 'Última atualização: 24 de Janeiro de 2025',
      'en': 'Last updated: January 24, 2025',
    },
    'nj8ue3rh': {
      'pt': 'Ver Termos de Uso',
      'en': 'See Terms of Use',
    },
    'lu5i6pki': {
      'pt': 'Ver Política de Privacidade',
      'en': 'View Privacy Policy',
    },
    'win7qr55': {
      'pt': 'Alterar Senha',
      'en': 'Change Password',
    },
    'kpgq82px': {
      'pt': '',
      'en': '',
    },
    'd356haqk': {
      'pt': 'Nova Senha',
      'en': 'New Password',
    },
    'aifwfsn8': {
      'pt': '',
      'en': '',
    },
    'ztu4i111': {
      'pt': 'Confirmar Nova Senha',
      'en': 'Confirm New Password',
    },
    '6up0qbp1': {
      'pt': 'Alterar senha',
      'en': 'Change password',
    },
    'oq0d5yxr': {
      'pt': 'Log Out',
      'en': 'Log Out',
    },
    'expz1ghy': {
      'pt':
          'Essa ação irá desconectar sua conta, você tem certeza que quer fazer isso?',
      'en':
          'This action will disconnect your account, are you sure you want to do this?',
    },
    'gvtmdyvu': {
      'pt': 'Desconectar Conta',
      'en': 'Disconnect Account',
    },
    'y78pqusj': {
      'pt': 'Alterar senha',
      'en': 'Change password',
    },
    'gfasvg4o': {
      'pt':
          'Um email foi enviado com instruções para alterar sua senha, verifique seua caixa de entrada',
      'en':
          'An email has been sent with instructions to change your password, please check your inbox.',
    },
    'fdihuoml': {
      'pt': 'Deletar Conta',
      'en': 'Delete Account',
    },
    'p7n51y3l': {
      'pt':
          'Essa ação irá deletar sua conta e todos os dados relacionados a ela, essa ação é irreversível, não sendo possível recuperar os dados perdidos, você tem certeza que quer fazer isso?',
      'en':
          'This action will delete your account and all data related to it. This action is irreversible and it is not possible to recover lost data. Are you sure you want to do this?',
    },
    '0mvkp5bp': {
      'pt': 'Desejo continuar',
      'en': 'I want to continue',
    },
    '5juxkw6h': {
      'pt': 'Deletar conta',
      'en': 'Delete account',
    },
  },
  // politicadeprivacidade
  {
    '6h7bux5a': {
      'pt': 'Política de Privacidade',
      'en': 'Privacy Policy',
    },
    'zgym3l31': {
      'pt':
          'Na Bam Assessoria em Marketing, privacidade e segurança são prioridades e nos comprometemos com a transparência do tratamento de dados pessoais dos nossos usuários/clientes. Por isso, esta presente Política de Privacidade estabelece como é feita a coleta, uso e transferência de informações de clientes ou outras pessoas que acessam ou usam nosso site.\nAo utilizar nossos serviços, você entende que coletaremos e usaremos suas informações pessoais nas formas descritas nesta Política, sob as normas da Constituição Federal de 1988 (art. 5º, LXXIX; e o art. 22º, XXX – incluídos pela EC 115/2022), das normas de Proteção de Dados (LGPD, Lei Federal 13.709/2018), das disposições consumeristas da Lei Federal 8078/1990 e as demais normas do ordenamento jurídico brasileiro aplicáveis.\nDessa forma, a BAM Assessoria e Marketing, doravante denominada simplesmente como “BAM”, inscrita no CNPJ/MF sob o nº 52.784.384/0001-84, no papel de Controladora de Dados, obriga-se ao disposto na presente Política de Privacidade.\n',
      'en':
          'At Bam Marketing Consulting, privacy and security are priorities and we are committed to the transparency of the processing of our users\'/clients\' personal data. Therefore, this Privacy Policy establishes how we collect, use, and transfer information from customers or other people who access or use our website.\n By using our services, you understand that we will collect and use your personal information in the ways described in this Policy, under the rules of the Federal Constitution of 1988 (art. 5, LXXIX; and art. 22, XXX - included by EC 115/2022), the Data Protection rules (LGPD, Federal Law 13.709/2018), the consumer provisions of Federal Law 8078/1990, and other applicable rules of the Brazilian legal system.\n Therefore, BAM Assessoria e Marketing, hereinafter referred to simply as “BAM”, registered with the CNPJ/MF under no. 52.784.384/0001-84, in the role of Data Controller, is obliged to the provisions of this Privacy Policy.',
    },
    'z5vpz75d': {
      'pt': '\n1. Quais dados coletamos sobre você e para qual finalidade?\n',
      'en': '1. What data do we collect about you and for what purpose?',
    },
    'z7yputy0': {
      'pt':
          'Nosso site coleta e utiliza alguns dados pessoais seus, de forma a viabilizar a prestação de serviços e aprimorar a experiência de uso.\n1.1. Dados pessoais fornecidos pelo titular\n Email para login\n Nome para identificação no app\nAccess token do facebook para coleta automática de dados diários de páginas do instagram, facebook e dados da galeria de anúncio do meta\nGoogle Account id para coleta automática de dados diários de campanhas de anúncio\n1.2. Dados pessoais coletados automaticamente\n Métricas diárias de páginas do facebook e instagram, comentários, dados de publicações, dados de seguidores para visualização em dashboards interativos.\nMétricas diárias de campanhas do google, dados de veiculação de campanha, público alvo para visualização em dashboards interativos\n\n',
      'en':
          'Our website collects and uses some of your personal data in order to enable the provision of services and improve the user experience. \n 1.1. Personal data provided by the holder \n Email for login \n Name for identification in the app \n Facebook access token for automatic collection of daily data from Instagram pages, Facebook and Meta ad gallery data \n Google Account ID for automatic collection of daily data from ad campaigns \n 1.2. Personal data collected automatically \n Daily metrics from Facebook and Instagram pages, comments, publication data, follower data for viewing in interactive dashboards. \n Daily metrics from Google campaigns, campaign delivery data, target audience for viewing in interactive dashboards',
    },
    '3jmmeq5l': {
      'pt': '2. Como coletamos os seus dados?\n',
      'en': '2. How do we collect your data?',
    },
    'c27j6vrx': {
      'pt':
          'Nesse sentido, a coleta dos seus dados pessoais ocorre da seguinte forma:\n Integração e autenticação a partir da API Login with Facebook\nIntegração e autenticação a partir da API Google Ads\n Cadastro manual por nossa equipe de operação (caso seja um cliente BAM)\n2.1. Consentimento\nÉ a partir do seu consentimento que tratamos os seus dados pessoais. O consentimento é a manifestação livre, informada e inequívoca pela qual você autoriza a BAM Assessoria em Marketing a tratar seus dados.\nAssim, em consonância com a Lei Geral de Proteção de Dados, seus dados só serão coletados, tratados e armazenados mediante prévio e expresso consentimento. \nO seu consentimento será obtido de forma específica para cada finalidade acima descrita, evidenciando o compromisso de transparência e boa-fé da BAM Assessoria em Marketing para com seus usuários/clientes, seguindo as regulações legislativas pertinentes.\nAo utilizar os serviços da BAM Assessoria em Marketing e fornecer seus dados pessoais, você está ciente e consentindo com as disposições desta Política de Privacidade, além de conhecer seus direitos e como exercê-los.\nA qualquer tempo e sem nenhum custo, você poderá revogar seu consentimento.\nÉ importante destacar que a revogação do consentimento para o tratamento dos dados pode implicar a impossibilidade da performance adequada de alguma funcionalidade do site que dependa da operação. Tais consequências serão informadas previamente.\n\n',
      'en':
          'In this sense, the collection of your personal data occurs as follows:\n Integration and authentication from the Login with Facebook API\n Integration and authentication from the Google Ads API\n Manual registration by our operations team (if you are a BAM client)\n 2.1. Consent\n It is based on your consent that we process your personal data. Consent is the free, informed and unequivocal manifestation by which you authorize BAM Assessoria em Marketing to process your data.\n Therefore, in accordance with the General Data Protection Law, your data will only be collected, processed and stored with your prior and express consent. Your consent will be obtained specifically for each purpose described above, demonstrating BAM Marketing Consulting\'s commitment to transparency and good faith towards its users/clients, in accordance with applicable legal regulations. By using BAM Marketing Consulting\'s services and providing your personal data, you are aware of and consent to the provisions of this Privacy Policy, in addition to knowing your rights and how to exercise them. You may revoke your consent at any time and free of charge. It is important to note that revoking consent for data processing may impair the proper performance of some website functionality that depends on the operation. Such consequences will be communicated in advance.',
    },
    'sj37c1b5': {
      'pt': '3. Quais são os seus direitos?\n',
      'en': '3. What are your rights?',
    },
    '8lcy6gjv': {
      'pt':
          'A BAM Assessoria em Marketing assegura a seus usuários/clientes seus direitos de titular previstos no artigo 18 da Lei Geral de Proteção de Dados. Dessa forma, você pode, de maneira gratuita e a qualquer tempo:\nConfirmar a existência de tratamento de dados, de maneira simplificada ou em formato claro e completo.\nAcessar seus dados, podendo solicitá-los em uma cópia legível sob forma impressa ou por meio eletrônico, seguro e idôneo.\nCorrigir seus dados, ao solicitar a edição, correção ou atualização destes.\nLimitar seus dados quando desnecessários, excessivos ou tratados em desconformidade com a legislação através da anonimização, bloqueio ou eliminação.\nSolicitar a portabilidade de seus dados, através de um relatório de dados cadastrais que a (nome empresarial simplificado) trata a seu respeito.\nEliminar seus dados tratados a partir de seu consentimento, exceto nos casos previstos em lei.\nRevogar seu consentimento, desautorizando o tratamento de seus dados.\nInformar-se sobre a possibilidade de não fornecer seu consentimento e sobre as consequências da negativa.\n\n',
      'en':
          'BAM Assessoria em Marketing guarantees its users/clients their rights as data subjects as provided for in article 18 of the General Data Protection Law. This way, you can, free of charge and at any time: \n Confirm the existence of data processing, in a simplified manner or in a clear and complete format. \n Access your data, being able to request it in a legible copy in printed form or by electronic, secure and suitable means. \n Correct your data, by requesting its editing, correction or update. \n Limit your data when unnecessary, excessive or processed in non-compliance with the legislation through anonymization, blocking or deletion. \n Request the portability of your data, through a report of registration data that (simplified company name) processes about you. \n Delete your data processed based on your consent, except in cases provided for by law. \n Revoke your consent, disauthorizing the processing of your data. \n Find out about the possibility of not providing your consent and the consequences of refusal.',
    },
    'ue5aldyv': {
      'pt': '4. Como você pode exercer seus direitos de titular?\n',
      'en': '4. How can you exercise your rights as a data subject?',
    },
    'mye549lm': {
      'pt':
          'Para exercer seus direitos de titular, você deve entrar em contato com a BAM Assessoria em Marketing através dos seguintes meios disponíveis:\n Telefone: +55 11932137807\n Email: ops@bamassessoria.com\nDe forma a garantir a sua correta identificação como titular dos dados pessoais objeto da solicitação, é possível que solicitemos documentos ou demais comprovações que possam comprovar sua identidade. Nessa hipótese, você será informado previamente.\n\n',
      'en':
          'To exercise your rights as a data subject, you must contact BAM Marketing Consulting through the following available means: \n Telephone: +55 11932137807\n Email: ops@bamassessoria.com\n In order to ensure your correct identification as the data subject of the request, we may request documents or other evidence that can verify your identity. In this case, you will be informed in advance.',
    },
    'ejmz6hs8': {
      'pt': '5. Como e por quanto tempo seus dados serão armazenados?\n',
      'en': '5. How and for how long will your data be stored?',
    },
    '1ubnfc8k': {
      'pt':
          'Seus dados pessoais coletados pela BAM Assessoria em Marketing serão utilizados e armazenados durante o tempo necessário para a prestação do serviço ou para que as finalidades elencadas na presente Política de Privacidade sejam atingidas, considerando os direitos dos titulares dos dados e dos controladores.\nDe modo geral, seus dados serão mantidos enquanto a relação contratual entre você e a BAM Assessoria em Marketing perdurar. Findado o período de armazenamento dos dados pessoais, estes serão excluídos de nossas bases de dados ou anonimizados, ressalvadas as hipóteses legalmente previstas no artigo 16 lei geral de proteção de dados, a saber:\nI – cumprimento de obrigação legal ou regulatória pelo controlador;\nII – estudo por órgão de pesquisa, garantida, sempre que possível, a anonimização dos dados pessoais;\nIII – transferência a terceiro, desde que respeitados os requisitos de tratamento de dados dispostos nesta Lei; ou\nIV – uso exclusivo do controlador, vedado seu acesso por terceiro, e desde que anonimizados os dados.\nIsto é, informações pessoais sobre você que sejam imprescindíveis para o cumprimento de determinações legais, judiciais e administrativas e/ou para o exercício do direito de defesa em processos judiciais e administrativos serão mantidas, a despeito da exclusão dos demais dados. \nO armazenamento de dados coletados pela BAM Assessoria em Marketing reflete o nosso compromisso com a segurança e privacidade dos seus dados. Empregamos medidas e soluções técnicas de proteção aptas a garantir a confidencialidade, integridade e inviolabilidade dos seus dados. Além disso, também contamos com medidas de segurança apropriadas aos riscos e com controle de acesso às informações armazenadas.\n\n',
      'en':
          'Your personal data collected by BAM Marketing Consulting will be used and stored for the time necessary to provide the service or to achieve the purposes listed in this Privacy Policy, considering the rights of the data subjects and controllers.\nIn general, your data will be kept for the duration of the contractual relationship between you and BAM Marketing Consulting. After the personal data storage period ends, it will be deleted from our databases or anonymized, except in the cases legally provided for in article 16 of the General Data Protection Law, namely:\nI - compliance with a legal or regulatory obligation by the controller;\nII - study by a research body, ensuring, whenever possible, the anonymization of personal data;\nIII - transfer to a third party, provided that the data processing requirements set forth in this Law are met; or IV – exclusive use by the controller, with third-party access prohibited, and provided the data is anonymized. That is, personal information about you that is essential for complying with legal, judicial, and administrative requirements and/or for exercising your right to defense in judicial and administrative proceedings will be retained, despite the deletion of other data. The storage of data collected by BAM Marketing Consulting reflects our commitment to the security and privacy of your data. We employ technical protection measures and solutions capable of guaranteeing the confidentiality, integrity, and inviolability of your data. Furthermore, we also have risk-appropriate security measures and access control to the stored information.',
    },
    'wok8lr0g': {
      'pt': '6. O que fazemos para manter seus dados seguros?\n',
      'en': '6. What do we do to keep your data safe?',
    },
    'ix9s5cgu': {
      'pt':
          'Para mantermos suas informações pessoais seguras, usamos ferramentas físicas, eletrônicas e gerenciais orientadas para a proteção da sua privacidade.\nAplicamos essas ferramentas levando em consideração a natureza dos dados pessoais coletados, o contexto e a finalidade do tratamento e os riscos que eventuais violações gerariam para os direitos e liberdades do titular dos dados coletados e tratados.\nEntre as medidas que adotamos, destacamos as seguintes:\nApenas pessoas autorizadas têm acesso a seus dados pessoais\nO acesso a seus dados pessoais é feito somente após o compromisso de confidencialidade\nSeus dados pessoais são armazenados em ambiente seguro e idôneo.\nA BAM Assessoria em Marketing se compromete a adotar as melhores posturas para evitar incidentes de segurança. Contudo, é necessário destacar que nenhuma página virtual é inteiramente segura e livre de riscos. É possível que, apesar de todos os nossos protocolos de segurança, problemas de culpa exclusivamente de terceiros ocorram, como ataques cibernéticos de hackers, ou também em decorrência da negligência ou imprudência do próprio usuário/cliente.\nEm caso de incidentes de segurança que possa gerar risco ou dano relevante para você ou qualquer um de nossos usuários/clientes, comunicaremos aos afetados e a Autoridade Nacional de Proteção de Dados sobre o ocorrido, em consonância com as disposições da Lei Geral de Proteção de Dados.\n',
      'en':
          'To keep your personal information secure, we use physical, electronic, and managerial tools designed to protect your privacy. We apply these tools taking into account the nature of the personal data collected, the context and purpose of the processing, and the risks that any violations would generate for the rights and freedoms of the data subject. Among the measures we adopt, we highlight the following: Only authorized individuals have access to your personal data. Your personal data is only accessed after a confidentiality commitment. Your personal data is stored in a secure and suitable environment. BAM Marketing Consulting is committed to adopting the best practices to prevent security incidents. However, it is important to emphasize that no virtual page is entirely secure and risk-free. It is possible that, despite all our security protocols, problems may occur that are solely the fault of third parties, such as cyberattacks by hackers, or also due to the negligence or recklessness of the user/customer themselves.\nIn the event of security incidents that may generate significant risk or damage to you or any of our users/customers, we will notify those affected and the National Data Protection Authority about the incident, in accordance with the provisions of the General Data Protection Law.',
    },
    '2qghhg8p': {
      'pt': '7. Com quem seus dados podem ser compartilhados?\n',
      'en': '7. With whom can your data be shared?',
    },
    'ua6n44bo': {
      'pt':
          'Tendo em vista a preservação de sua privacidade, a BAM Assessoria em Marketing não compartilhará seus dados pessoais com nenhum terceiro não autorizado. \nAlém disso, também existem outras hipóteses em que seus dados poderão ser compartilhados, que são:\nI – Determinação legal, requerimento, requisição ou ordem judicial, com autoridades judiciais, administrativas ou governamentais competentes.\nII – Caso de movimentações societárias, como fusão, aquisição e incorporação, de forma automática\nIII – Proteção dos direitos da BAM Assessoria em Marketing em qualquer tipo de conflito, inclusive os de teor judicial.\n7.1. Transferência internacional de dados\nAlguns dos terceiros com quem compartilhamos seus dados podem ser localizados ou ou possuir instalações localizadas em países estrangeiros. Nessas condições, de toda forma, seus dados pessoais estarão sujeitos à Lei Geral de Proteção de Dados e às demais legislações brasileiras de proteção de dados\nNesse sentido, a BAM Assessoria em Marketing se compromete a sempre adotar eficientes padrões de segurança cibernética e de proteção de dados, nos melhores esforços de garantir e cumprir as exigências legislativas.\nAo concordar com essa Política de Privacidade, você concorda com esse compartilhamento, que se dará conforme as finalidades descritas no presente instrumento.\n\n',
      'en':
          'To protect your privacy, BAM Marketing Consulting will not share your personal data with any unauthorized third party. Furthermore, there are other circumstances in which your data may be shared, including: I – Legal determination, request, requisition, or court order with competent judicial, administrative, or government authorities. II – In the event of automatic corporate transactions, such as mergers, acquisitions, and incorporations. III – Protection of BAM Marketing Consulting\'s rights in any type of dispute, including those of a judicial nature. 7.1. International Data Transfer. Some of the third parties with whom we share your data may be located or have facilities in foreign countries. Under these conditions, in any case, your personal data will be subject to the General Data Protection Law and other Brazilian data protection legislation. In this sense, BAM Assessoria em Marketing is committed to always adopting efficient cybersecurity and data protection standards, in the best efforts to guarantee and comply with legislative requirements. By agreeing to this Privacy Policy, you agree to this sharing, which will occur in accordance with the purposes described in this instrument.',
    },
    'vg9ra9j8': {
      'pt': '8. Alteração desta Política de Privacidade\n',
      'en': '8. Amendment of this Privacy Policy',
    },
    '8i5cwsf7': {
      'pt':
          'A atual versão da Política de Privacidade foi formulada e atualizada pela última vez em: 23/01/2025.\nReservamos o direito de modificar essa Política de Privacidade a qualquer tempo, principalmente em função da adequação a eventuais alterações feitas em nosso site ou em âmbito legislativo. Recomendamos que você a revise com frequência.\nEventuais alterações entrarão em vigor a partir de sua publicação em nosso site e sempre lhe notificaremos acerca das mudanças ocorridas.\nAo utilizar nossos serviços e fornecer seus dados pessoais após tais modificações, você as consente. \n\n',
      'en':
          'The current version of the Privacy Policy was formulated and last updated on: January 23, 2025. We reserve the right to modify this Privacy Policy at any time, particularly to adapt to any changes made to our website or in the legislative sphere. We recommend that you review it frequently. Any changes will be effective upon their publication on our website, and we will always notify you of any changes. By using our services and providing your personal data after such changes, you consent to them.',
    },
    'cg1hthsy': {
      'pt': '9. Responsabilidade\n',
      'en': '9. Responsibility',
    },
    '4kdkmfdr': {
      'pt':
          'A BAM Assessoria em Marketing prevê a responsabilidade dos agentes que atuam nos processos de tratamento de dados, em conformidade com os artigos 42 ao 45 da Lei Geral de Proteção de Dados.\nNos comprometemos em manter esta Política de Privacidade atualizada, observando suas disposições e zelando por seu cumprimento.\nAlém disso, também assumimos o compromisso de buscar condições técnicas e organizativas seguramente aptas a proteger todo o processo de tratamento de dados.\nCaso a Autoridade Nacional de Proteção de Dados exija a adoção de providências em relação ao tratamento de dados realizado pela BAM Assessoria em Marketing, comprometemo-nos a segui-las. \n9.1 Isenção de responsabilidade\nConforme mencionado no Tópico 6, embora adotemos elevados padrões de segurança a fim de evitar incidentes, não há nenhuma página virtual inteiramente livre de riscos. Nesse sentido, a BAM Assessoria em Marketing não se responsabiliza por:\nI – Quaisquer consequências decorrentes da negligência, imprudência ou imperícia dos usuários em relação a seus dados individuais. Garantimos e nos responsabilizamos apenas pela segurança dos processos de tratamento de dados e do cumprimento das finalidades descritas no presente instrumento.\nDestacamos que a responsabilidade em relação à confidencialidade dos dados de acesso é do usuário.\nII – Ações maliciosas de terceiros, como ataques de hackers, exceto se comprovada conduta culposa ou deliberada da BAM Assessoria em Marketing.\nDestacamos que em caso de incidentes de segurança que possam gerar risco ou dano relevante para você ou qualquer um de nossos usuários/clientes, comunicaremos aos afetados e a Autoridade Nacional de Proteção de Dados sobre o ocorrido e cumpriremos as providências necessárias.\nIII – Inveracidade das informações inseridas pelo usuário/cliente nos registros necessários para a utilização dos serviços da BAM Assessoria em Marketing; quaisquer consequências decorrentes de informações falsas ou inseridas de má-fé são de inteiramente responsabilidade do usuário/cliente.\n\n',
      'en':
          'BAM Marketing Consulting assumes the responsibility of its data processing agents, in accordance with Articles 42 to 45 of the General Data Protection Law. We are committed to keeping this Privacy Policy up to date, observing its provisions and ensuring its compliance. We are also committed to seeking technical and organizational conditions that are securely capable of protecting the entire data processing process. Should the National Data Protection Authority require the adoption of measures regarding the data processing carried out by BAM Marketing Consulting, we undertake to follow them. 9.1 Disclaimer As mentioned in Topic 6, although we adopt high security standards to prevent incidents, no website is entirely risk-free. In this sense, BAM Marketing Consulting is not responsible for: I – Any consequences arising from the negligence, recklessness, or incompetence of users in relation to their personal data. We guarantee and are responsible only for the security of the data processing processes and the fulfillment of the purposes described in this instrument. We emphasize that the responsibility for the confidentiality of access data lies with the user. II – Malicious actions by third parties, such as hacker attacks, unless proven to be negligent or deliberate behavior by BAM Marketing Consulting. We emphasize that in the event of security incidents that may generate significant risk or damage to you or any of our users/clients, we will notify those affected and the National Data Protection Authority of the incident and will take the necessary measures. III – Inaccuracy of the information entered by the user/client in the records required for the use of BAM Marketing Consulting services; Any consequences arising from false information or information entered in bad faith are the sole responsibility of the user/customer.',
    },
    '3q4khy87': {
      'pt': '10. Encarregado de Proteção de Dados\n',
      'en': '10. Data Protection Officer',
    },
    '85ubaqi2': {
      'pt':
          'A BAM Assessoria em Marketing disponibiliza os seguintes meios para que você possa entrar em contato conosco para exercer seus direitos de titular: telefone: +55 11 932137807.\nCaso tenha dúvidas sobre esta Política de Privacidade ou sobre os dados pessoais que tratamos, você pode entrar em contato com o nosso Encarregado de Proteção de Dados Pessoais, através dos seguintes canais:\nNatan Michneves telefone: +55 11 932137807\nemail: natan@bamassessoria.com\n',
      'en':
          'BAM Assessoria em Marketing provides the following means for you to contact us to exercise your rights as a data subject: telephone: +55 11 932137807. If you have any questions about this Privacy Policy or the personal data we process, you can contact our Personal Data Protection Officer through the following channels: Natan Michneves telephone: +55 11 932137807 email: natan@bamassessoria.com',
    },
  },
  // gerenciamentocontas
  {
    '5cythrhf': {
      'pt': 'Gerenciar Contas',
      'en': 'Manage Accounts',
    },
    'np32qhlh': {
      'pt': 'contas conectadas',
      'en': 'connected accounts',
    },
    'avbrz2mg': {
      'pt': 'Oculto no Menu',
      'en': '',
    },
    '7cw8txps': {
      'pt': 'Adicionar nova conta',
      'en': 'Add new account',
    },
    'bgnfbwxr': {
      'pt': 'Remover Conta',
      'en': 'Remove Account',
    },
    't8ttqhyb': {
      'pt':
          'Essa ação irá remover essa conta do seu usuário e deletar todos os dados relacionados a ela , não será possível recuperar os dados nem análises de meses anteriores. Essa ação é irreversível, deseja prosseguir?',
      'en':
          'This action will remove this account from your user account and delete all related data. You won\'t be able to recover data or analytics from previous months. This action is irreversible. Do you want to continue?',
    },
    'xadtufgt': {
      'pt': 'Desejo continuar',
      'en': 'I want to continue',
    },
    'dsmde4oe': {
      'pt': 'Remover conta',
      'en': 'Remove account',
    },
    'ghyxt2ci': {
      'pt': 'Adicionar Conta',
      'en': 'Add Account',
    },
    '87v4lk45': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account you must log in with a valid Facebook account integrated into your profile. When you click the button you will be redirected to a Facebook login menu.',
    },
    '9di1f8fq': {
      'pt': 'Conectar conta',
      'en': 'Connect account',
    },
    'cui6ozvk': {
      'pt': 'Conectar conta Google',
      'en': 'Connect Google account',
    },
    'ct6z34wv': {
      'pt': 'Vincular Leads',
      'en': 'Remove Account',
    },
    'z0s8bafh': {
      'pt':
          'Selecione a conta que deseja vincular os dados de lead do canal, os leads apareceram nessa conta e estarão integrados ao CRM e Pipeline',
      'en':
          'This action will remove this account from your user account and delete all related data. You won\'t be able to recover data or analytics from previous months. This action is irreversible. Do you want to continue?',
    },
    'quyonkrf': {
      'pt': 'conta conectada',
      'en':
          'This action will remove this account from your user account and delete all related data. You won\'t be able to recover data or analytics from previous months. This action is irreversible. Do you want to continue?',
    },
    'mx51p6ky': {
      'pt': 'Vincular leads',
      'en': 'Add new account',
    },
  },
  // selecaocontas
  {
    '36fgendm': {
      'pt': 'Selecionar Contas',
      'en': 'Select Accounts',
    },
    'u46f6ih7': {
      'pt': 'contas conectadas',
      'en': 'connected accounts',
    },
    'pt16esyp': {
      'pt':
          'Selecione as contas abaixo que deseja conectar ao aplicativo e em seguida clique no botão de confirmar',
      'en':
          'Select the accounts below that you want to connect to the application and then click the confirm button.',
    },
    '9b4w5zpn': {
      'pt': 'Adicionar contas selecionadas',
      'en': 'Add selected accounts',
    },
    'w8dol088': {
      'pt': 'Adicionar contas selecionadas',
      'en': 'Add selected accounts',
    },
  },
  // insights
  {
    'nl52sjzh': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'eu2o7uw1': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    '2nbu0l1u': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'ddvlc22i': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    'oluj20cj': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '07zcdmva': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'cxf01fft': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    '5fc5wmbi': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '2mymi2ik': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'cdlen6ql': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '2rutellg': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'gpuhdrpe': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    '19d0sg27': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'f9l4kf43': {
      'pt': 'Indisponível',
      'en': 'Unavailable',
    },
    'bwytpihq': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'utn2e1a4': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    '4tsmvu50': {
      'pt': 'Select...',
      'en': 'Select...',
    },
    'imd974r1': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'bare8ouw': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'sd9b2njb': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '6lqdxnnw': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    't7xpo486': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'aaen7yj6': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'oeqvix5d': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'uze4coa3': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'q4bp411k': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'knp3rhgb': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'oh7ynda7': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    '1obrdbgn': {
      'pt': 'Demografia',
      'en': 'Demography',
    },
    'bbxc4tq0': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'n85nl99u': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'lanwzps1': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'oiu2gvu6': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    'h5ajy16v': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'uuqgf5lq': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    '1u0puell': {
      'pt': '13-17',
      'en': '13-17',
    },
    'jclgsonh': {
      'pt': '18-24',
      'en': '18-24',
    },
    'lslx42xh': {
      'pt': '25-34',
      'en': '25-34',
    },
    'vem0ov4n': {
      'pt': '35-44',
      'en': '35-44',
    },
    '727gnpre': {
      'pt': '45-54',
      'en': '45-54',
    },
    '0k7o3qwe': {
      'pt': '55-64',
      'en': '55-64',
    },
    'k2cyxuuc': {
      'pt': '65+',
      'en': '65+',
    },
    'qu6si0xz': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'zo2ri258': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'ibc7ko9o': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '535g8ghm': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '783duf40': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'xuvblqqo': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '5lwft7ff': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'evtgjzjh': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '908fmefl': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    '92stfohs': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'muunx8l3': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'q3ldzak1': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'b2sopqaa': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'cogqldis': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'ip2f7dja': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'd34b5v4k': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'xzbd5aj8': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    '2iu49rwc': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    're4c2jcy': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'i3zgv3kd': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'ko6t39zk': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    '5aw6pojd': {
      'pt': 'Indisponível',
      'en': 'Unavailable',
    },
    'xw193qpw': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'mz3xaldl': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    'w2aapf3u': {
      'pt': 'Select...',
      'en': 'Select...',
    },
    '0ii4wocp': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'dngfkt7l': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'r6bl096p': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'aw9idixi': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'hirquoaw': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'uc3ad1ix': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'oo7wg1pr': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'vdjc8tam': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'h92ohef5': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'gd6k7u7l': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    '4wli3dp4': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'l0bltr4o': {
      'pt': 'Demografia - Gênero',
      'en': 'Demographics - Gender',
    },
    'dyxeypfi': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'gx13umqe': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'bnaxenek': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    'ta5tqkpn': {
      'pt': 'Homens',
      'en': 'Men',
    },
    '9b15325c': {
      'pt': 'Demografia - Gênero e Idade',
      'en': 'Demographics - Gender and Age',
    },
    'b0zgrv1n': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'chcziqzk': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    '88prtzwt': {
      'pt': '13-17',
      'en': '13-17',
    },
    'acuzlhj1': {
      'pt': '18-24',
      'en': '18-24',
    },
    'njajbz9e': {
      'pt': '25-34',
      'en': '25-34',
    },
    'h0683jqr': {
      'pt': '35-44',
      'en': '35-44',
    },
    '5k4hbts8': {
      'pt': '45-54',
      'en': '45-54',
    },
    '8fnx8p1g': {
      'pt': '55-64',
      'en': '55-64',
    },
    'jk8nwbam': {
      'pt': '65+',
      'en': '65+',
    },
    'onvrp46z': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'rh4ypqe9': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '3w5x009i': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '80as6p0v': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '6oaaz16i': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'uswtnsnj': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'r0j0dcwg': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'xqn37p49': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'vk60ay8n': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // Termosdeuso
  {
    '2c2hoqaj': {
      'pt': 'Termos de uso',
      'en': 'Terms of Use',
    },
    'k87ust56': {
      'pt': '1. Definições\n',
      'en': '1. Definitions',
    },
    'da0cr6g5': {
      'pt':
          'Considera-se, para o presente instrumento, as seguintes definições:\nBAMAssessoria ou Empresa: é a pessoa jurídica de marketing, com sede na Rua Aviador Gil Guilherme 38 - Bloco 2 Santana, São Paulo - SP, 02012-130, inscrito no CNPJ/MF sob o nº 52.784.384/0001-84.\nCliente: Corresponde ao titular do Cartão, com quem foi formalizada a relação contratual, que terá direito ao usufruto de todos os benefícios do produto, ao mesmo tempo que se responsabilizará pelas obrigações nele previstas.\nUsuários (ou “Usuário”): Constitui-se pelos Clientes que utilizarão o Aplicativo, qualificados como pessoas capazes para a prática dos atos da vida civil, maiores de 18 (dezoito) anos ou emancipadas. Para a utilização dos serviços por pessoa relativamente incapaz, em atenção ao regramento disposto no Estatuto da Pessoa com Deficiência e no Código Civil, esta deverá estar devidamente curatelada, representada ou assistida para prática de atos de disposição patrimonial.\nAplicativo: programa concebido para o processamento de dados eletronicamente, consistente no objeto deste documento, abrangendo informações detidas pela BAM Assessoria, relacionadas aos dados de contas do Facebook e Instagram  dos clientes usuários do aplicativo. É nele que estarão centralizadas todas as informações dos perfis do cliente para análise da comunicação das redes, desde o momento de sua solicitação, até o encerramento da relação.\n\n',
      'en':
          'For this instrument, the following definitions are considered:\nBAMAssessoria or Company: is the marketing legal entity, with headquarters at Rua Aviador Gil Guilherme 38 - Bloco 2 Santana, São Paulo - SP, 02012-130, registered with the CNPJ/MF under number 52.784.384/0001-84.\nCustomer: Corresponds to the Cardholder, with whom the contractual relationship was formalized, who will be entitled to enjoy all the benefits of the product, at the same time as being responsible for the obligations provided for therein.\nUsers (or “User”): Consists of the Customers who will use the Application, qualified as people capable of practicing acts of civil life, over 18 (eighteen) years of age or emancipated. For the use of the services by a relatively incapacitated person, in accordance with the rules set forth in the Statute of Persons with Disabilities and the Civil Code, such person must be duly under guardianship, represented, or assisted to carry out acts of asset disposal.\nApplication: program designed for electronic data processing, consistent with the purpose of this document, covering information held by BAM Assessoria, related to the Facebook and Instagram account data of clients using the application. This program will centralize all client profile information for analysis of social media communications, from the moment of the request until the termination of the relationship.',
    },
    'me7bj399': {
      'pt': '2. Finalidade\n',
      'en': '2. Purpose',
    },
    '3yu8dgm8': {
      'pt':
          'O cadastramento a que se refere o presente termo compreende o acesso ao Aplicativo da BAM Assessoria, que possibilita aos seus Usuários acompanhar os resultados de comunicação de sua páginas do Facebook e Instagram, reunindo dados descritivos, mensais, métricas de posts, análises de comentários e direcionamento estratégico e todas as informações disponíveis para o acompanhamento da rede.\n\n',
      'en':
          'The registration referred to in this term includes access to the BAM Assessoria Application, which allows its Users to monitor the communication results of their Facebook and Instagram pages, gathering descriptive, monthly data, post metrics, comment analysis and strategic direction and all information available for monitoring the network.',
    },
    'dhknac5k': {
      'pt': '3. Cadastro\n',
      'en': '3. Registration',
    },
    '376w8mn5': {
      'pt':
          'Os dados cadastrais contemplarão dados pessoais, tais como nome completo e endereço de email, os quais serão necessários para a identificação do Usuário. Compromete-se o Usuário à veracidade dos dados informados, estando ciente a imprecisão deles impedir o acesso ou utilização do Aplicativo, sem prejuízo de responsabilização civil, penal e administrativa.\n\nA BAM Assessoria, sempre que entender necessário ou em decorrência de exigência legal, regulatória ou para cumprimento de ordem judicial, poderá solicitar a atualização ou confirmação de determinados dados e informações, bem como o envio de documentos. Em caso de divergências ou omissões nos dados, a BAM Assessoria poderá, a qualquer momento e sem aviso prévio, negar ou suspender a análise da solicitação de cadastro ou, ainda, suspender ou bloquear o acesso ao aplicativo.\n\nO Usuário se compromete a não fornecer, emprestar ou permitir que suas informações de login permaneçam com terceiros, mantendo-os sob guarda segura e garantindo que sua senha não seja revelada ou exposta a outras pessoas, isentando a BAM Assessoria de qualquer responsabilidade dessa ordem.\n\nAlém das demais obrigações previstas, o Usuário se compromete a assegurar a veracidade e atualização de seus dados pessoais, informações financeiras, endereço para correspondência e demais informações incluídas na plataforma, comprometendo-se a comunicar a BAM Assessoria quaisquer alterações, de forma imediata.\n\n',
      'en':
          'Registration data will include personal information, such as full name and email address, which will be necessary for User identification. The User undertakes to ensure the accuracy of the information provided, and is aware that any inaccuracy may prevent access to or use of the Application, without prejudice to civil, criminal, and administrative liability.\n\nBAM Assessoria, whenever it deems necessary or due to legal or regulatory requirements or in compliance with a court order, may request the update or confirmation of certain data and information, as well as the submission of documents. In the event of discrepancies or omissions in the data, BAM Assessoria may, at any time and without prior notice, deny or suspend the analysis of the registration request or, even, suspend or block access to the application.\n\nThe User undertakes not to provide, lend or allow their login information to remain with third parties, keeping it under secure storage and ensuring that their password is not revealed or exposed to other people, exempting BAM Assessoria from any liability of this order.\n\nIn addition to the other obligations provided for, the User undertakes to ensure the accuracy and updating of their personal data, financial information, mailing address and other information included in the platform, committing to immediately communicate any changes to BAM Assessoria.',
    },
    '7ev2twhk': {
      'pt': '4. Acesso\n',
      'en': '4. Access',
    },
    'hugaunfv': {
      'pt':
          'No Aplicativo, para o acesso às informações pelo Usuário, será necessário que esse efetue o seu cadastramento junto à plataforma, com login e senha e em seguida integre sua conta do Facebook para coleta dos dados do perfil. Inclusive, todas as informações fornecidas ao cadastramento estarão de acordo com a Política de Privacidade da BAM Assessoria. Para saber mais sobre esses dispositivos, acesse nossa Política de Privacidade.\n\nEfetuando o cadastramento, o Usuário será titular de uma conta de utilização que somente poderá ser acessada por ele. Mesmo assim, caso seja detectado pelo App algum indício ou cadastramento de informações falsas, por usuários que, por exemplo, ainda não tenham atingido a idade mínima permitida, essa conta poderá ser automaticamente excluída.\n\nPoderão ser alterados, a qualquer tempo, os termos e condições relativas à utilização do Aplicativo, hipótese em que serão atualizados junto à própria ferramenta. Verificada a continuidade do uso, mesmo após a efetiva postagem da atualização, restará configurada a ciência do Usuário, fato que justifica o necessário monitoramento do Portal e correio eletrônico.\n\n',
      'en':
          'In order to access information on the Application, the User must register with the platform using a username and password and then integrate their Facebook account to collect profile data. Furthermore, all information provided during registration will be in accordance with BAM Assessoria\'s Privacy Policy. To learn more about these provisions, please visit our Privacy Policy. By registering, the User will be the holder of an account that can only be accessed by them. Even so, if the App detects any indication or registration of false information, for example, by users who have not yet reached the minimum permitted age, this account may be automatically deleted. The terms and conditions relating to the use of the Application may be changed at any time, in which case they will be updated within the tool itself. If continued use is verified, even after the update has been effectively posted, the User will remain aware, which justifies the necessary monitoring of the Portal and email.',
    },
    'xpzx34r2': {
      'pt': '5. Violações e Responsabilidades\n',
      'en': '5. Violations and Responsibilities',
    },
    '1bsjt9b2': {
      'pt':
          'Pelo presente, o Usuário assume a responsabilidade pela observância às seguintes obrigações:\nNão autorizar terceiros(as) a utilizarem ou acessarem a Conta do Usuário, mesmo se eles estiverem em sua companhia;\nNão ceder ou transferir a sua Conta, em nenhuma hipótese, a outra pessoa ou entidade;\nObservar e cumprir todas as leis aplicáveis enquanto utilizar ao Aplicativo, manipulando-o apenas para finalidades legítimas\nDispõe-se como expressamente proibidas ao Usuário, durante a utilização do Aplicativo, as seguintes ações:\nO envio, carregamento ou transmissão de conteúdo obsceno, de cunho pornográfico, difamatório ou calunioso, que transfigurem a apologia ao uso de drogas, crime, consumo de entorpecentes ou à violência, ou que, de alguma forma, incite o preconceito ou qualquer forma de discriminação;\nDentre outras condutas, fica expressamente vedada a violação de direitos de terceiros, inclusive dos direitos de sigilo e privacidade\nRealizar a prática de quaisquer atos que propiciem a transmissão ou propagação de vírus, trojans, malware, worm, bot, backdoor, spyware, rootkit, ou quaisquer outros dispositivos que venham a ser criados, que prejudiquem os equipamentos da BAM Assessoria ou de terceiros;\nUtilizar de qualquer sinal distintivo ou bem de propriedade intelectual de titularidade da BAM Assessoria, como nome empresarial, marca ou nome de domínio.\nEm nenhuma hipótese, a BAM Assessoria será responsável:\nPelo uso indevido, danos e eventuais práticas ilegais realizadas pelo Usuário, mesmo que relacionadas com o acesso ao Aplicativo;\nPor eventuais falhas ou impossibilidades técnicas decorrentes da má instalação, uso indevido ou insuficiência técnica do aparelho do Usuário em que esteja instalado o App;\nPela instalação no equipamento do Usuário ou de terceiros, em decorrência de sua navegação na Internet, de vírus, trojans, malware, worm, bot, backdoor, entre outros.\n\n',
      'en':
          'The User hereby assumes responsibility for observing the following obligations: \n Not authorizing third parties to use or access the User\'s Account, even if they are in his/her company; \n Not assigning or transferring his/her Account, under any circumstances, to another person or entity; \n Observing and complying with all applicable laws while using the Application, using it only for legitimate purposes. \n The following actions are expressly prohibited to the User while using the Application: \n Sending, uploading or transmitting obscene, pornographic, defamatory or slanderous content, which promotes drug use, crime, drug use or violence, or which in any way incites prejudice or any form of discrimination; \n Among other conduct, the violation of third party rights, including the rights to confidentiality and privacy\nPerform any acts that facilitate the transmission or propagation of viruses, trojans, malware, worms, bots, backdoors, spyware, rootkits, or any other devices that may be created, which harm the equipment of BAM Assessoria or third parties;\nUse any distinctive sign or intellectual property owned by BAM Assessoria, such as a company name, trademark or domain name.\nUnder no circumstances will BAM Assessoria be responsible:\nFor the misuse, damages and possible illegal practices carried out by the User, even if related to access to the Application;\nFor possible failures or technical impossibilities resulting from poor installation, misuse or technical insufficiency of the User\'s device on which the App is installed;\nFor the installation on the User\'s or third party\'s equipment, as a result of their Internet browsing, of viruses, trojans, malware, worms, bots, backdoor, among others.',
    },
    '7pk7hg1s': {
      'pt': '6. Licensa\n',
      'en': '6. License',
    },
    '8a44yfy0': {
      'pt':
          'De acordo com os termos postos, a BAM Assessoria transfere ao Usuário uma licença limitada, não exclusiva, não passível de sublicenciamento, revogável e não transferível para o:\nUso da plataforma eletrônica em seu dispositivo pessoal, exclusivamente para o acompanhamento dos dados de perfil do facebook e instagram;\nAcesso ao conteúdo, dado ou material disponibilizado a partir da utilização dos serviços especificado, cabendo, em cada caso, o acesso restrito ao uso pessoal, estabelecendo-se o necessário dever de sigilo.\nÉ de exclusiva propriedade da BAM Assessoria todos os direitos inerentes ao App, inclusive no que diz respeito aos seus textos, imagens, layouts, software, códigos, bases de dados, gráficos, artigos, fotografias e demais conteúdos nele produzidos direta ou indiretamente. Inclusive, todos os conteúdos do App são protegidos pela lei de propriedade intelectual, sendo proibido aos Usuários usar, copiar, reproduzir, modificar, publicar, transmitir, distribuir, executar, exibir, licenciar, vender ou explorar qualquer conteúdo do App, seja por qualquer finalidade, sem que obtenha o consentimento prévio e expresso da BAM Assessoria.\n\nTodos os conteúdos reproduzidos ou fornecidos pelo Usuário permanecerão sob a sua propriedade, mesmo após a sua exposição. Contudo, ao compartilhá-lo, o Usuário outorgará uma autorização por prazo indeterminado, gratuita e transferivel, e que permita o sublicenciamento, uso, cópia, modificação, distribuição, publicação ou exibição desse conteúdo nos mais variados formatos e canais de compartilhamento possíveis. Para esse compartilhamento não será exigido novo aviso ou qualquer pagamento, desde que ele esteja relacionado ao funcionamento da plataforma.\n\nSendo assim, a BAM Assessoria possibilitará que sejam apresentados, por qualquer pessoa, conteúdos, informações de texto, áudio ou vídeo, inclusive comentários e feedbacks relacionados aos Cartões BAM Assessoria. Nestas hipóteses, ao fornecê-los, será outorgada à BAM Assessoria uma licença dos direitos autorais sobre o Conteúdo, de forma irrevogável, transferível e com direito a sublicenciar, usar, copiar, modificar, criar obras derivadas, distribuir, publicar, exibir e executar em público sem ulterior aviso ou consentimento.\n\nInclusive, a BAM Assessoria poderá analisar, monitorar ou remover o conteúdo a seu exclusivo critério, a qualquer momento e por qualquer motivo, independentemente de prévio aviso.\n\n',
      'en':
          'In accordance with the terms set forth, BAM Assessoria transfers to the User a limited, non-exclusive, non-sublicensable, revocable and non-transferable license for: \n Use of the electronic platform on your personal device, exclusively for monitoring Facebook and Instagram profile data; \n Access to the content, data or material made available through the use of the specified services, with access, in each case, restricted to personal use, establishing the necessary duty of confidentiality. \n All rights inherent to the App are the exclusive property of BAM Assessoria, including with regard to its texts, images, layouts, software, codes, databases, graphics, articles, photographs and other content produced directly or indirectly. Furthermore, all content on the App is protected by intellectual property law, and Users are prohibited from using, copying, reproducing, modifying, publishing, transmitting, distributing, performing, displaying, licensing, selling, or exploiting any content on the App, for any purpose, without obtaining the prior express consent of BAM Assessoria.\n\nAll content reproduced or provided by the User will remain their property, even after its disclosure. However, by sharing it, the User grants an indefinite, free, and transferable authorization that allows the sublicensing, use, copying, modification, distribution, publication, or display of such content in a wide variety of formats and sharing channels. No new notice or payment will be required for this sharing, as long as it is related to the operation of the platform.\n\nTherefore, BAM Assessoria will allow anyone to submit content, text, audio, or video information, including comments and feedback related to BAM Assessoria Cards. In these cases, by providing them, BAM Assessoria will be granted an irrevocable, transferable copyright license over the Content, with the right to sublicense, use, copy, modify, create derivative works, distribute, publish, display, and perform in public without further notice or consent.\n\nIn addition, BAM Assessoria may review, monitor, or remove the Content at its sole discretion, at any time and for any reason, without prior notice.',
    },
    '0o9ija3y': {
      'pt': '7. Disposições Gerais\n',
      'en': '7. General Provisions',
    },
    'n4kzhes9': {
      'pt':
          'A BAM Assessoria, identificando o caso ou suspeita de fraude, obtenção de benefício ou vantagem ilícita, ou descumprimento de quaisquer condições previstas, reserva-se ao direito de suspender ou cancelar, independentemente de aviso prévio e a qualquer momento, o acesso do Usuário.\n\nEm outra linha, na hipótese de invalidação ou inexequibilidade de qualquer disposição presente nestes termos, sendo ela total ou parcial, não serão afetadas todas as demais, permanecendo assegurada a sua legalidade, na íntegra. Inclusive, neste caso, a disposição inválida, ou parte dela, será substituída por outra válida e exequível.\n\nA inércia da parte lesada ao momento de exercer qualquer dos direitos previstos não importa na sua renúncia, não impedindo o exercício de tal direito posteriormente.\n\n',
      'en':
          'BAM Assessoria, upon identifying a case or suspicion of fraud, obtaining an illicit benefit or advantage, or failure to comply with any of the conditions set forth, reserves the right to suspend or cancel the User\'s access, without prior notice and at any time.\n\nFurthermore, in the event of invalidity or unenforceability of any provision of these terms, whether in whole or in part, all other provisions will not be affected, and their full legality will remain assured. In this case, the invalid provision, or part thereof, will be replaced by a valid and enforceable one.\n\nThe inaction of the injured party when exercising any of the rights provided for does not constitute a waiver thereof, nor will it prevent the exercise of such right later.',
    },
  },
  // post
  {
    'qgh3iq9m': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'qraqfdwz': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'oekqfpl6': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    '62h99554': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    'n8nr3du8': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '90t8e3dq': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'qnkymtiz': {
      'pt': '',
      'en': '',
    },
    'y49yriw1': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'ehv39omr': {
      'pt': 'Média',
      'en': 'Average',
    },
    'moie0ww3': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'jfzb31ee': {
      'pt': 'Imagem',
      'en': 'Image',
    },
    'q14hwewa': {
      'pt': 'Carrossel',
      'en': 'Carousel',
    },
    '6zw0ggqc': {
      'pt': 'Vídeo',
      'en': 'Video',
    },
    '7bbmak6b': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'v9l0h0i6': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'wccyq61r': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'hz1tpab5': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'kzn0erxg': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'ewe4x6zs': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'n7suq2l6': {
      'pt': 'Melhores Posts',
      'en': 'Best Posts',
    },
    'rumwe3kd': {
      'pt': '',
      'en': '',
    },
    'dcjq1es9': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '58d8cki9': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'izjpy7n5': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'gfqnxyon': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'apbhxe8n': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'wddq6o11': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'zdtjqbte': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'g6oqbmu5': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'qmzl3e2a': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'hptto8j0': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'g4tnul94': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'bmiifgi0': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    '4xarm6yb': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'wuueeung': {
      'pt': 'Ver todos os comentários',
      'en': 'See all comments',
    },
    'yykd36qs': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'gs1l91b5': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '34ij2y25': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'dgccixoi': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'a22woi55': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'd74lmiy4': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'eazazznq': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'kmeliytx': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'ib24j5v4': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'frulphds': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'mby1op6o': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'ayi4dztp': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'vvttgm3i': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    't9bas4ol': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '2a99p3pp': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    '8fd892na': {
      'pt': '',
      'en': '',
    },
    '6emqlwpl': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'am8lrfco': {
      'pt': 'Média',
      'en': 'Average',
    },
    'mfjj3xdb': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'f444gc8u': {
      'pt': 'Imagem',
      'en': 'Image',
    },
    '51ou79t4': {
      'pt': 'Carrossel',
      'en': 'Carousel',
    },
    '6z0ea66u': {
      'pt': 'Vídeo',
      'en': 'Video',
    },
    '0n44e8t8': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'f5qunn4p': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'm4hfj36f': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'k3iqhpcn': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '5ztwlib5': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'o6otsi6t': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'f6ou5vew': {
      'pt': 'Melhores Posts',
      'en': 'Best Posts',
    },
    '3wy7zrb2': {
      'pt': '',
      'en': '',
    },
    '9296d4ke': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '3rj7ozwd': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'jhjyr8b3': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'fyw7w3th': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '46ye12ux': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'hgbx0x14': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'ns2p6pr7': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '3e12jxt3': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    's4yk1kdd': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'hk5mcbfu': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'adanzi6m': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'ps6mu173': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'klcwnuq0': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'rngx7shw': {
      'pt': 'Ver todos os comentários',
      'en': 'See all comments',
    },
    '7tump65j': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'e0i4yhuc': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '57wlc9si': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'qqw6e3ew': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '3dh8sfoa': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '0u6nbqzj': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'sa6nfdvb': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'hte8yp4y': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'agkbksdc': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // estrategia
  {
    't0t0c5zl': {
      'pt': 'Questão',
      'en': 'Question',
    },
    'ypgyrsly': {
      'pt': '',
      'en': '',
    },
    'f0d0vzee': {
      'pt': 'Explique de maneira curta o que sua empresa faz',
      'en': 'Briefly explain what your company does',
    },
    'mumwynfz': {
      'pt':
          'Qual é a característica que as pessoas mais elogiam do seu produto/empresa?',
      'en': 'What feature do people most praise about your product/company?',
    },
    '0uhcwdjv': {
      'pt':
          'Selecione até 3 adjetivos que melhor descrevem a imagem que sua empresa deseja transmitir',
      'en':
          'Select up to 3 adjectives that best describe the image your company wants to convey.',
    },
    '5s8v7qf7': {
      'pt': 'Confiável',
      'en': 'Reliable',
    },
    '2wanjicm': {
      'pt': 'Inovadora',
      'en': 'Innovative',
    },
    '4kchyj1j': {
      'pt': 'Premium',
      'en': 'Premium',
    },
    '7td7xl0r': {
      'pt': 'Sustentável',
      'en': 'Sustainable',
    },
    'y1l6a4sv': {
      'pt': 'Acessível',
      'en': 'Accessible',
    },
    'w7cvnxj8': {
      'pt': 'Exclusiva',
      'en': 'Exclusive',
    },
    'eykae888': {
      'pt': 'Moderna',
      'en': 'Modern',
    },
    'qzct7hfo': {
      'pt': 'Tradicional',
      'en': 'Traditional',
    },
    '651nlshc': {
      'pt': 'Rápida',
      'en': 'Quick',
    },
    'mu5em9j8': {
      'pt': 'Criativa',
      'en': 'Creative',
    },
    'nzacyidm': {
      'pt': 'Jovem',
      'en': 'Young',
    },
    'lvkqdlu0': {
      'pt': 'Experiente',
      'en': 'Experienced',
    },
    'xoco0ceu': {
      'pt': 'Luxuosa',
      'en': 'Luxurious',
    },
    'gasps9h4': {
      'pt': 'Responsável',
      'en': 'Responsible',
    },
    'f0bdqut1': {
      'pt': 'Divertida',
      'en': 'Fun',
    },
    'xxryssi8': {
      'pt': 'Aventureira',
      'en': 'Adventurer',
    },
    'uuqymxaa': {
      'pt': 'Dinâmica',
      'en': 'Dynamics',
    },
    '80xgy77k': {
      'pt': 'Autêntica',
      'en': 'Authentic',
    },
    '448ko93a': {
      'pt': 'Empática',
      'en': 'Empathetic',
    },
    'hps6z671': {
      'pt': 'Inspiradora',
      'en': 'Inspiring',
    },
    'y8h51x3u': {
      'pt': 'Eficiente',
      'en': 'Efficient',
    },
    'ydwfyhcu': {
      'pt': 'Tecnológica',
      'en': 'Technological',
    },
    '3vpqphpn': {
      'pt': 'Visionária',
      'en': 'Visionary',
    },
    'dqkfelr9': {
      'pt': 'Séria',
      'en': 'He would be',
    },
    'x5a9aumf': {
      'pt': 'Simples',
      'en': 'Simple',
    },
    'c91ayaxb': {
      'pt': 'Flexível',
      'en': 'Flexible',
    },
    'l5w45p4d': {
      'pt': 'Comprometida',
      'en': 'Committed',
    },
    '3ddwp39t': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    '29fjjrwz': {
      'pt':
          'Selecione até 3 adjetivos que NÃO correspondem à imagem que sua empresa quer transmitir:',
      'en':
          'Select up to 3 adjectives that DO NOT correspond to the image your company wants to convey:',
    },
    'naaujkh5': {
      'pt': 'Dasatualizada',
      'en': 'Outdated',
    },
    '0k7dchyt': {
      'pt': 'Barata',
      'en': 'Cheap',
    },
    '7ivbzri3': {
      'pt': 'Comum',
      'en': 'Common',
    },
    'etfk780r': {
      'pt': 'Tradicional',
      'en': 'Traditional',
    },
    'jhzvhbop': {
      'pt': 'Lenta',
      'en': 'Slow',
    },
    '3vri73av': {
      'pt': 'Antiquada',
      'en': 'Old-fashioned',
    },
    '85du85ft': {
      'pt': 'Inacessível',
      'en': 'Inaccessible',
    },
    'xa32zfkg': {
      'pt': 'Impessoal',
      'en': 'Impersonal',
    },
    'v9yy91sb': {
      'pt': 'Instável',
      'en': 'Unstable',
    },
    '1jkjf3iw': {
      'pt': 'Arrogante',
      'en': 'Arrogant',
    },
    'h26guozs': {
      'pt': 'Conservadora',
      'en': 'Conservative',
    },
    'n8esloiy': {
      'pt': 'Cara',
      'en': 'Face',
    },
    '3k5kb0hu': {
      'pt': 'Monótona',
      'en': 'Monotonous',
    },
    '9viukx8h': {
      'pt': 'Burocrática',
      'en': 'Bureaucratic',
    },
    'x78x1t8x': {
      'pt': 'Rígida',
      'en': 'Rigid',
    },
    '5dur5yml': {
      'pt': 'Superficial',
      'en': 'Superficial',
    },
    '8q9vs2wu': {
      'pt': 'Oportunista',
      'en': 'Opportunist',
    },
    'duadudo8': {
      'pt': 'Agitada',
      'en': 'Agitated',
    },
    'po6sxv7i': {
      'pt': 'Confusa',
      'en': 'Confused',
    },
    'rjbkgxf4': {
      'pt': 'Inexperiente',
      'en': 'Inexperienced',
    },
    '52hd00sl': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'te22uc0c': {
      'pt': 'Quais são as faixas etárias predominantes do seu público médio?',
      'en': 'What are the predominant age groups of your average audience?',
    },
    'qhspbrlk': {
      'pt': '13-17 anos',
      'en': '13-17 years old',
    },
    '5215drnn': {
      'pt': '18-24 anos',
      'en': '18-24 years old',
    },
    't3tr61fx': {
      'pt': '25-34 anos',
      'en': '25-34 years old',
    },
    'zzvqizx0': {
      'pt': '35-44 anos',
      'en': '35-44 years old',
    },
    'pqqwt1wh': {
      'pt': '45-54 anos',
      'en': '45-54 years old',
    },
    'dd9hunx7': {
      'pt': '55-64 anos',
      'en': '55-64 years old',
    },
    'xnygtg06': {
      'pt': 'Acima de 65 anos',
      'en': 'Over 65 years old',
    },
    '8x6nb742': {
      'pt': 'Qual é o gênero predominante do seu público?',
      'en': 'What is the predominant gender of your audience?',
    },
    '6p1kt6zo': {
      'pt': 'Feminino',
      'en': 'Feminine',
    },
    'o6lx93w2': {
      'pt': 'Masculino',
      'en': 'Masculine',
    },
    '4nta9ck2': {
      'pt': 'Ambos igualmente',
      'en': 'Both equally',
    },
    '41dgqk9j': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    't4jxyrj7': {
      'pt':
          'Como é caracterizada a interação do seu cliente com a sua empresa? (Selecione até três opções)',
      'en':
          'How is your customer\'s interaction with your company characterized? (Select up to three options)',
    },
    'j7sjatgv': {
      'pt': 'Compra planejada',
      'en': 'Planned purchase',
    },
    '3vkztmsy': {
      'pt': 'Compra por impulso',
      'en': 'Impulse buying',
    },
    'rvgfaah3': {
      'pt': 'Compra recorrente',
      'en': 'Recurring purchase',
    },
    '2xb2ab5j': {
      'pt': 'Compra ocasional',
      'en': 'Occasional purchase',
    },
    '7w0onfwg': {
      'pt': 'Compra por indicação',
      'en': 'Purchase by referral',
    },
    'svoysqhz': {
      'pt': 'Compra por necessidade imediata',
      'en': 'Purchase due to immediate need',
    },
    'xm6gzme6': {
      'pt': 'Compra baseada em promoções',
      'en': 'Promotion-based purchasing',
    },
    '0x6lssqa': {
      'pt': 'Compra baseada em experiencia anterior',
      'en': 'Purchase based on previous experience',
    },
    'evfogq8f': {
      'pt': 'Compra baseada em relacionamento',
      'en': 'Relationship-based purchasing',
    },
    '130y2mul': {
      'pt': 'Compra agendada',
      'en': 'Scheduled purchase',
    },
    'nlyifvf5': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'j7ctaohl': {
      'pt':
          'Quem é o principal segmento consumidor dos seus produtos/serviços? (Selecione até duas opções)',
      'en':
          'Who is the main consumer segment of your products/services? (Select up to two options)',
    },
    '9avyym8x': {
      'pt': 'Consumidor final (B2C)',
      'en': 'End consumer (B2C)',
    },
    'm50pzqk7': {
      'pt': 'Varejistas',
      'en': 'Retailers',
    },
    'qmj6oheb': {
      'pt': 'Distribuidores',
      'en': 'Distributors',
    },
    '047gceaz': {
      'pt': 'Empresas (B2B)',
      'en': 'Companies (B2B)',
    },
    'y5zat48n': {
      'pt': 'Setor Público (governo, orgãos públicos)',
      'en': 'Public Sector (government, public agencies)',
    },
    'ips6oz6a': {
      'pt': 'Prestadores de serviços',
      'en': 'Service providers',
    },
    'hww8crgj': {
      'pt': 'Indústrias',
      'en': 'Industries',
    },
    'a0pwrrvp': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'uslt4lku': {
      'pt':
          'Quais os objetivos principais da comunicação nas suas redes sociais? (Selecione até duas opções)',
      'en':
          'What are the main objectives of communication on your social networks? (Select up to two options)',
    },
    'n4q3parw': {
      'pt': 'Aumentar reconhecimento',
      'en': 'Increase recognition',
    },
    'abc4iuce': {
      'pt': 'Geração de leads',
      'en': 'Lead generation',
    },
    'xq3ytilg': {
      'pt': 'Venda direta',
      'en': 'Direct sales',
    },
    'f3kk5jpw': {
      'pt': 'Fidelização de clientes',
      'en': 'Customer loyalty',
    },
    'lgowm49k': {
      'pt': 'Informar e educar o público',
      'en': 'Inform and educate the public',
    },
    'lrizj9ef': {
      'pt': 'Interagir com o público',
      'en': 'Interact with the public',
    },
    'omfjumoi': {
      'pt': 'Posicionar como referência',
      'en': 'Position as a reference',
    },
    '4u7utchg': {
      'pt': 'Divulgar ofertas e promoções',
      'en': 'Promote offers and promotions',
    },
    'amahx634': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'g9067whk': {
      'pt':
          'Qual é a frequência ideal planejada inicialmente para publicações nas suas redes sociais?',
      'en':
          'What is the ideal frequency initially planned for publications on your social networks?',
    },
    'bqzcvy08': {
      'pt': 'Diária',
      'en': 'Daily',
    },
    'hk4z83w8': {
      'pt': 'A cada 3 dias',
      'en': 'Every 3 days',
    },
    'omnpnr7b': {
      'pt': 'Semanal',
      'en': 'Weekly',
    },
    '5bs9bv80': {
      'pt': 'Mensal',
      'en': 'Monthly',
    },
    '0zhrpeuz': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'cl68hfl0': {
      'pt':
          'Tem alguma informação adicional que você considera relevante para a análise dos resultados da conta?',
      'en':
          'Do you have any additional information that you consider relevant to analyzing the account results?',
    },
    'wjqthibn': {
      'pt': 'Página anterior',
      'en': 'Previous page',
    },
  },
  // Relatorioestrategico
  {
    'x9aqth27': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'l62utmzj': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'tjsk0kjz': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'e0lmijdb': {
      'pt': 'Relatório estratégico',
      'en': 'Strategic report',
    },
    'ilsvyfjk': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'l1c028br': {
      'pt': 'Resumo de Informações',
      'en': 'Information Summary',
    },
    'azhkasb2': {
      'pt': 'Objetivos',
      'en': 'Objectives',
    },
    '0hs6z4gd': {
      'pt': 'Faixa etária',
      'en': 'Age range',
    },
    'fry7a4r8': {
      'pt': 'Gênero',
      'en': 'Gender',
    },
    '6rzzoihi': {
      'pt': 'Interação',
      'en': 'Interaction',
    },
    'd9pvivrp': {
      'pt': 'Clientes',
      'en': 'Clients',
    },
    'kqs3bff5': {
      'pt': 'Frequência de conteúdo',
      'en': 'Content frequency',
    },
    'mf6xlljf': {
      'pt': 'Relatório do período',
      'en': 'Period report',
    },
    'aujgxgrk': {
      'pt': 'Metas anteriores',
      'en': 'Previous goals',
    },
    'izw1i55r': {
      'pt': 'Metas futuras',
      'en': 'Future goals',
    },
    '6e4ol9ky': {
      'pt': 'Sugestões de conteúdo',
      'en': 'Content suggestions',
    },
    '1p26v074': {
      'pt': 'Avaliação da saída',
      'en': 'Output evaluation',
    },
    'rswrde4v': {
      'pt': 'Escreva suas opiniões em relação a saída original',
      'en': 'Write your opinions regarding the original output',
    },
    'lrre0b88': {
      'pt': 'Publicar Avaliação',
      'en': 'Post Review',
    },
    'd4amri3e': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '0sad9hkf': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '97mq5xrg': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'yjs0p6zc': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'fz9jggcv': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'bp5srs6a': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '4xd1l1mx': {
      'pt': 'Sem Estratégia definida',
      'en': 'No defined strategy',
    },
    'ycu1rqbr': {
      'pt':
          'Responda o formulário de estratégia para direcionar as análises dos resultados da sua marca e garantir um relatório mensal dos resultados com orientações dos proximos passos',
      'en':
          'Complete the strategy form to guide your brand\'s results analysis and ensure a monthly results report with guidance on next steps.',
    },
    '8yq85ebp': {
      'pt': 'Responder Formulário',
      'en': 'Reply Form',
    },
    'ruhf2g42': {
      'pt': 'Publicar mudanças',
      'en': 'Publish changes',
    },
    'rumeiatf': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'q4me1aqm': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'dkhymj66': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'uirj5mf0': {
      'pt': 'Relatório estratégico',
      'en': 'Strategic report',
    },
    'gcwwxcdn': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'p2wa7mer': {
      'pt': 'Resumo de Informações',
      'en': 'Information Summary',
    },
    'wa2hvdi5': {
      'pt': 'Objetivos',
      'en': 'Objectives',
    },
    'b4oxsuvr': {
      'pt': 'Faixa etária',
      'en': 'Age range',
    },
    '632mwxc3': {
      'pt': 'Gênero',
      'en': 'Gender',
    },
    'q0iaun48': {
      'pt': 'Interação',
      'en': 'Interaction',
    },
    '4c0uwhpx': {
      'pt': 'Clientes',
      'en': 'Clients',
    },
    'lk0axtlb': {
      'pt': 'Frequência de conteúdo',
      'en': 'Content frequency',
    },
    'p0tfsjo0': {
      'pt': 'Relatório do período',
      'en': 'Period report',
    },
    '3w5a2ntg': {
      'pt': 'Metas anteriores',
      'en': 'Previous goals',
    },
    'r3jrvuyj': {
      'pt': 'Metas futuras',
      'en': 'Future goals',
    },
    'xv4hlxgx': {
      'pt': 'Sugestões de conteúdo',
      'en': 'Content suggestions',
    },
    'q8xchtow': {
      'pt': 'Avaliação da saída',
      'en': 'Output evaluation',
    },
    'wgud74fj': {
      'pt': 'Escreva suas opiniões em relação a saída original',
      'en': 'Write your opinions regarding the original output',
    },
    '84qglcyt': {
      'pt': 'Publicar Avaliação',
      'en': 'Post Review',
    },
    'y32uea9v': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'ze069x2d': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'syp7wamd': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'rvxtvafp': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'v6bdf5hr': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'rni8p02a': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'guoufdzy': {
      'pt': 'Sem Estratégia definida',
      'en': 'No defined strategy',
    },
    'afhnbwu6': {
      'pt':
          'Responda o formulário de estratégia para direcionar as análises dos resultados da sua marca e garantir um relatório mensal dos resultados com orientações dos proximos passos',
      'en':
          'Complete the strategy form to guide your brand\'s results analysis and ensure a monthly results report with guidance on next steps.',
    },
    'biplbwn6': {
      'pt': 'Responder Formulário',
      'en': 'Reply Form',
    },
    '7p28c1og': {
      'pt': 'Publicar mudanças',
      'en': 'Publish changes',
    },
  },
  // comentario
  {
    'k8l8lzze': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'cpgrryg1': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'mn4s7asw': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'e3dvs0mn': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    'y9a7sjj0': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'q46kcfsx': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'yu1l9zx5': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'ct1kjteb': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'yxpwsbsh': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '60cppos5': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '95jv0ggx': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'ti62vqw1': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'uxigsl73': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'oucpj8x8': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'dk7pnzw4': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    'fezwpueh': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '5qfimb0g': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '79nma5nt': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '4uekqvb3': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'lyuwdfag': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'ubcwguu8': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '94pq9spm': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
  },
  // convidado
  {
    'p0jl95zm': {
      'pt': 'Adicionar convidado',
      'en': 'Add guest',
    },
    '8csvft2f': {
      'pt':
          'Selecione o usuário que deseja adicionar as contas no dropdown abaixo',
      'en':
          'Select the user you want to add accounts to from the dropdown below.',
    },
    '1ryq559x': {
      'pt': '',
      'en': '',
    },
    'xrzv4i58': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'bt4w0n6w': {
      'pt': 'Option 1',
      'en': 'Option 1',
    },
    '493xo0ti': {
      'pt': 'Option 2',
      'en': 'Option 2',
    },
    'x217dz0q': {
      'pt': 'Option 3',
      'en': 'Option 3',
    },
    'fziexj6p': {
      'pt':
          'Selecione as contas abaixo que deseja conectar ao usuário selecionado e em seguida clique no botão de confirmar',
      'en':
          'Select the accounts below that you want to connect to the selected user and then click the confirm button.',
    },
    'uyyeufm3': {
      'pt': 'Adicionar contas selecionadas',
      'en': 'Add selected accounts',
    },
  },
  // home
  {
    'piqkghwj': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    '78ty43mv': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    '5w93c94j': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'sovha1xi': {
      'pt': 'Visão Geral',
      'en': 'Overview',
    },
    'e7voczr1': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'eexh5csm': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'gluksnym': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'y22dkxqc': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'kf1u040x': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'fp2crzqf': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'ocalrea2': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'f55ziqwz': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'pj65zl47': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    '87skulko': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '8yfswiyl': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'cjf46iv3': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'fbg6sfis': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'ua9vnw64': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'n800u7md': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'qdu7rdp5': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'u694sr8m': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'v2r0gw8y': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'lcf2goy0': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'zebgnl3d': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    '0lmxc6p6': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    'mf8fvn60': {
      'pt': '13-17',
      'en': '13-17',
    },
    'znb64vje': {
      'pt': '18-24',
      'en': '18-24',
    },
    '1m740nlh': {
      'pt': '25-34',
      'en': '25-34',
    },
    'nb67ml36': {
      'pt': '35-44',
      'en': '35-44',
    },
    'v0mndjv4': {
      'pt': '45-54',
      'en': '45-54',
    },
    'ukebzyt5': {
      'pt': '55-64',
      'en': '55-64',
    },
    'e1nk2uwz': {
      'pt': '65+',
      'en': '65+',
    },
    'ton23xmd': {
      'pt': 'Homens',
      'en': 'Men',
    },
    '7oizyka3': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'xjca02nk': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    't6xjuq8t': {
      'pt': 'Melhores Posts',
      'en': 'Best Posts',
    },
    'xy4zcxgx': {
      'pt': 'Mais Impressões',
      'en': 'More Impressions',
    },
    'i2sm6qls': {
      'pt': 'Mais Likes',
      'en': 'More Likes',
    },
    'enc9eor9': {
      'pt': 'Mais Engajamento',
      'en': 'More Engagement',
    },
    'ki6tevt9': {
      'pt': 'Não foram encontradas publicações dentro do período analisado',
      'en': 'No publications were found within the analyzed period',
    },
    'rrx9smm4': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'hp3q4rtu': {
      'pt': 'Não foram encontrados comentários para o período analisado',
      'en': 'No comments were found for the period analyzed',
    },
    'fge6i28y': {
      'pt': 'Estratégia',
      'en': 'Strategy',
    },
    'ehortzai': {
      'pt':
          'É necessário responder o formulário inicial para obter o relatório estratégico',
      'en':
          'You must complete the initial form to obtain the strategic report.',
    },
    'a2a95qoj': {
      'pt': 'Responder Formulário',
      'en': 'Reply Form',
    },
    'z49lm4u3': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'tmsmsy05': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    't9aw1647': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'wc3boi1a': {
      'pt': 'Visão Geral',
      'en': 'Overview',
    },
    'z9xl2s0v': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '8cm376ir': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    '7m4fuxlu': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'rhkm6im1': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '1r50vten': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '6gusxwzx': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    '1may7bem': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'dn7i09rd': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'gjowqe8n': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    '43p2zs9d': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'vhye13uw': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'sqdtw9be': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'uny6ga1r': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '9dxw2ll1': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'd9xx9z6y': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'kj79k8gn': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    '1ezok83x': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '1qqukh14': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'yadnv2ev': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    'pw10qt66': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'etyrqroh': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'cxuvmvgo': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'ph0buexy': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'zgrd3m5e': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    '7l25tl7g': {
      'pt': '13-17',
      'en': '13-17',
    },
    'yuytcku1': {
      'pt': '18-24',
      'en': '18-24',
    },
    't1faadbu': {
      'pt': '25-34',
      'en': '25-34',
    },
    'oqk2h84x': {
      'pt': '35-44',
      'en': '35-44',
    },
    'vgy0i866': {
      'pt': '45-54',
      'en': '45-54',
    },
    'wfsqlhs9': {
      'pt': '55-64',
      'en': '55-64',
    },
    'yr0dpifa': {
      'pt': '65+',
      'en': '65+',
    },
    'tovey1jt': {
      'pt': 'Melhores Posts',
      'en': 'Best Posts',
    },
    '6mqthfyj': {
      'pt': 'Mais Impressões',
      'en': 'More Impressions',
    },
    'rtgv4gab': {
      'pt': 'Mais Likes',
      'en': 'More Likes',
    },
    'y6b3u078': {
      'pt': 'Mais Engajamento',
      'en': 'More Engagement',
    },
    'l9ycgisf': {
      'pt': 'Não foram encontradas publicações dentro do período analisado',
      'en': 'No publications were found within the analyzed period',
    },
    'fsfhpk64': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'a26hug07': {
      'pt': 'Não foram encontrados comentários para o período analisado',
      'en': 'No comments were found for the period analyzed',
    },
    'og3caxcw': {
      'pt': 'Estratégia',
      'en': 'Strategy',
    },
    '0uxdm4so': {
      'pt':
          'É necessário responder o formulário inicial para obter o relatório estratégico',
      'en':
          'You must complete the initial form to obtain the strategic report.',
    },
    'fhltne3x': {
      'pt': 'Responder Formulário',
      'en': 'Reply Form',
    },
    '6alw832e': {
      'pt': 'Visão Geral',
      'en': '',
    },
    '23fh4i9g': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    '4ay6p578': {
      'pt': 'Impressões',
      'en': '',
    },
    'ma82p3b0': {
      'pt': 'Cliques',
      'en': '',
    },
    '8qsqgydc': {
      'pt': 'Conversões',
      'en': '',
    },
    'pluxm75s': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'r32k636i': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'cv3wfexi': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'z1ctno89': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    'nrpnjxec': {
      'pt': 'Taxa de jornada',
      'en': 'Journey rate',
    },
    'pt8jvxhs': {
      'pt': 'Custo total',
      'en': 'Total cost',
    },
    '51zpphoz': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    '15fukb9r': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '8d5djnkj': {
      'pt': 'Custo por conversão',
      'en': 'Cost per conversion',
    },
    '6240sna5': {
      'pt': 'Taxa de cliques',
      'en': 'Click-through rate',
    },
    '5vzluwe5': {
      'pt': 'Taxa de conversão',
      'en': 'Conversion rate',
    },
    'f4zffbl7': {
      'pt': 'Dados por dispositivo',
      'en': 'Comparative analysis by device',
    },
    'e92jnswc': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'bsk3ugp5': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    't5tysk5c': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    'i6gc3thw': {
      'pt': 'Custo',
      'en': 'Cost',
    },
    'lv04xngt': {
      'pt': 'Celular',
      'en': 'Cell phone',
    },
    'mj8puagg': {
      'pt': 'PC',
      'en': 'PRAÇA',
    },
    '3p4d3hxn': {
      'pt': 'Tablet',
      'en': 'Tablet',
    },
    '4e5m1wqz': {
      'pt': 'TV',
      'en': 'Cell phone',
    },
    'epakrf8b': {
      'pt': 'Outros',
      'en': 'Cell phone',
    },
    'ncbjnvmc': {
      'pt': 'Dados por público e tempo',
      'en': '',
    },
    'hzpeieqm': {
      'pt': 'Faixa etária',
      'en': '',
    },
    'kbk04323': {
      'pt': 'Impressions',
      'en': 'Women',
    },
    'bumgkzmk': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    '4ny5n6p4': {
      'pt': 'Conversões',
      'en': '',
    },
    'xnqh0jiu': {
      'pt': 'Cliques',
      'en': '',
    },
    '6231ulq7': {
      'pt': '13-17',
      'en': '13-17',
    },
    'd0ypbxfc': {
      'pt': '18-24',
      'en': '18-24',
    },
    'r6d10188': {
      'pt': '25-34',
      'en': '25-34',
    },
    '7tmqs0by': {
      'pt': '35-44',
      'en': '35-44',
    },
    'x2dn16en': {
      'pt': '45-54',
      'en': '45-54',
    },
    '0urari0r': {
      'pt': '55-64',
      'en': '55-64',
    },
    'p42baspw': {
      'pt': '65+',
      'en': '65+',
    },
    '1kmjysgb': {
      'pt': 'Dias da semana',
      'en': '',
    },
    'fya3boke': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    'i44aplfm': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'nprl8gux': {
      'pt': 'Conversões',
      'en': '',
    },
    'lefyztm4': {
      'pt': 'Cliques',
      'en': '',
    },
    '63jvteqb': {
      'pt': 'Seg',
      'en': '13-17',
    },
    '6l75mere': {
      'pt': 'Ter',
      'en': '18-24',
    },
    '2i79j298': {
      'pt': 'Qua',
      'en': '25-34',
    },
    'gp52llcd': {
      'pt': 'Qui',
      'en': '35-44',
    },
    'y8kj0eum': {
      'pt': 'Sex',
      'en': '45-54',
    },
    'cir1d5au': {
      'pt': 'Sab',
      'en': '55-64',
    },
    '4zbi1fdg': {
      'pt': 'Dom',
      'en': '65+',
    },
    'eurzdulr': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'zzei26zs': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'd2o61cnk': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    'cm8d5yg8': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    'd284waqm': {
      'pt': 'Palavra-chave',
      'en': '',
    },
    'x7odvsi5': {
      'pt': 'Visão Geral',
      'en': '',
    },
    '8kfps46m': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    'agw4tpd5': {
      'pt': 'Impressões',
      'en': '',
    },
    '0pmaksib': {
      'pt': 'Cliques',
      'en': '',
    },
    '62l0ey2l': {
      'pt': 'Conversões',
      'en': '',
    },
    'za6jxtod': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    '9ffbdawe': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'harao2wf': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    '8m3a9rpc': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    'c7dnld3b': {
      'pt': 'Taxa de jornada',
      'en': 'Journey rate',
    },
    'x9a6zow2': {
      'pt': 'Custo total',
      'en': 'Total cost',
    },
    'o7wbla6r': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'jnn3dgas': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'jita90a0': {
      'pt': 'Custo por conversão',
      'en': 'Cost per conversion',
    },
    'jz7jiq3b': {
      'pt': 'Taxa de cliques',
      'en': 'Click-through rate',
    },
    '55ykrnq3': {
      'pt': 'Taxa de conversão',
      'en': 'Conversion rate',
    },
    '1reo7epj': {
      'pt': 'Dados por dispositivo',
      'en': 'Comparative analysis by device',
    },
    '982kyixu': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'are9b0ar': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'ld6wslg8': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    '0russarr': {
      'pt': 'Custo',
      'en': 'Cost',
    },
    '5q82emp3': {
      'pt': 'Celular',
      'en': 'Cell phone',
    },
    'l90ascl1': {
      'pt': 'PC',
      'en': 'PRAÇA',
    },
    'ssgbxol2': {
      'pt': 'Tablet',
      'en': 'Tablet',
    },
    'zj3pefz6': {
      'pt': 'TV',
      'en': 'Cell phone',
    },
    'n6vmbbgo': {
      'pt': 'Outros',
      'en': 'Cell phone',
    },
    'nxtgl17r': {
      'pt': 'Dados por público e tempo',
      'en': '',
    },
    '7odf37ft': {
      'pt': 'Faixa etária',
      'en': '',
    },
    'ux938k92': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    'ycmcdaa5': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'dywtmk8m': {
      'pt': 'Conversões',
      'en': '',
    },
    'asd8vbx3': {
      'pt': 'Custo',
      'en': '',
    },
    '5r38haan': {
      'pt': '13-17',
      'en': '13-17',
    },
    'rtfxvg1l': {
      'pt': '18-24',
      'en': '18-24',
    },
    'nv0fy3du': {
      'pt': '25-34',
      'en': '25-34',
    },
    'b4unl9vy': {
      'pt': '35-44',
      'en': '35-44',
    },
    'vd85gcqg': {
      'pt': '45-54',
      'en': '45-54',
    },
    'qvhnlg9j': {
      'pt': '55-64',
      'en': '55-64',
    },
    '93dz589e': {
      'pt': '65+',
      'en': '65+',
    },
    'vogd9ues': {
      'pt': 'Dias da semana',
      'en': '',
    },
    'tgsl86n6': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    'z7mluhrl': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'ngrgrmxq': {
      'pt': 'Conversões',
      'en': '',
    },
    'gyxwh5df': {
      'pt': 'Custo',
      'en': '',
    },
    '6ifkhil6': {
      'pt': 'Seg',
      'en': '13-17',
    },
    'vpqciuta': {
      'pt': 'Ter',
      'en': '18-24',
    },
    'khtpfnan': {
      'pt': 'Qua',
      'en': '25-34',
    },
    'qmygomdr': {
      'pt': 'Qui',
      'en': '35-44',
    },
    'vrz2caa0': {
      'pt': 'Sex',
      'en': '45-54',
    },
    'e5jtkks0': {
      'pt': 'Sab',
      'en': '55-64',
    },
    '8mfkli9g': {
      'pt': 'Dom',
      'en': '65+',
    },
    'ao0xibpf': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'hwxifira': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'pwd77iqg': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    'xij5l6vw': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    'hsi2fg5r': {
      'pt': 'Palavra-chave',
      'en': '',
    },
    'hpp4xdyw': {
      'pt': 'Visão Geral',
      'en': '',
    },
    '2e0msf8r': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    'qu0aw8wc': {
      'pt': 'Reconhecimento',
      'en': '',
    },
    'xu8xflbi': {
      'pt': 'Consideração',
      'en': '',
    },
    'v3a4ts9k': {
      'pt': 'Conversões',
      'en': '',
    },
    'dq1sipqr': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'ffnbuhqj': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'dfgkv0np': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'jii6021p': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    '5dti3d37': {
      'pt': 'Taxa de jornada',
      'en': 'Journey rate',
    },
    '16ebybkb': {
      'pt': 'Custo total',
      'en': 'Total cost',
    },
    'r1uihnjw': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'rzympm8z': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'mq71jjy7': {
      'pt': 'Custo por conversão',
      'en': 'Cost per conversion',
    },
    'nokxhj0u': {
      'pt': 'Taxa de cliques',
      'en': 'Click-through rate',
    },
    'b59pe867': {
      'pt': 'Taxa de conversão',
      'en': 'Conversion rate',
    },
    'aufncrb0': {
      'pt': 'Dados por dispositivo',
      'en': 'Comparative analysis by device',
    },
    'k2jh9pyu': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '6mzj31ea': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'i1s7d8cw': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    '8pd3qzzx': {
      'pt': 'Custo',
      'en': 'Cost',
    },
    '6h4dvi58': {
      'pt': 'Celular',
      'en': 'Cell phone',
    },
    'k6d84b19': {
      'pt': 'PC',
      'en': 'PRAÇA',
    },
    's4fk4waa': {
      'pt': 'Tablet',
      'en': 'Tablet',
    },
    'nybtao9v': {
      'pt': 'TV',
      'en': 'Cell phone',
    },
    'pahfp2s6': {
      'pt': 'Outros',
      'en': 'Cell phone',
    },
    'awycpuba': {
      'pt': 'Dados por público e tempo',
      'en': '',
    },
    'e5di7y3h': {
      'pt': 'Faixa etária',
      'en': '',
    },
    'h1d3h7ho': {
      'pt': 'Impressions',
      'en': 'Women',
    },
    'eqvpin3r': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'm517sj1w': {
      'pt': 'Conversões',
      'en': '',
    },
    'klgurhe1': {
      'pt': 'Cliques',
      'en': '',
    },
    'iic1i1qi': {
      'pt': '13-17',
      'en': '13-17',
    },
    'rhdug9kl': {
      'pt': '18-24',
      'en': '18-24',
    },
    'cxyioh0p': {
      'pt': '25-34',
      'en': '25-34',
    },
    '3z7mpy4w': {
      'pt': '35-44',
      'en': '35-44',
    },
    'ua8ilqq2': {
      'pt': '45-54',
      'en': '45-54',
    },
    'aw4my8p8': {
      'pt': '55-64',
      'en': '55-64',
    },
    'hwat5y0q': {
      'pt': '65+',
      'en': '65+',
    },
    'kysw43dn': {
      'pt': 'Dias da semana',
      'en': '',
    },
    'ft5mcr2j': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    'hcqwjlae': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'ajrqu5g3': {
      'pt': 'Conversões',
      'en': '',
    },
    'knz8q10y': {
      'pt': 'Cliques',
      'en': '',
    },
    'pxqday94': {
      'pt': 'Seg',
      'en': '13-17',
    },
    'upif9nub': {
      'pt': 'Ter',
      'en': '18-24',
    },
    'zmenp59u': {
      'pt': 'Qua',
      'en': '25-34',
    },
    'nucly9gv': {
      'pt': 'Qui',
      'en': '35-44',
    },
    'se08m15e': {
      'pt': 'Sex',
      'en': '45-54',
    },
    'kug5ai11': {
      'pt': 'Sab',
      'en': '55-64',
    },
    'aw0383uh': {
      'pt': 'Dom',
      'en': '65+',
    },
    'o3287071': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'whic8vpp': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'nvwck97s': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    '9ev1d8fi': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    '4p34mnid': {
      'pt': 'Palavra-chave',
      'en': '',
    },
    'zdldw7tn': {
      'pt': 'Campanhas Veiculadas',
      'en': 'Best Ads',
    },
    'vooxhh66': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'vone2pmx': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'hknuyo4p': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'doc32bxo': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'tpynp3vf': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '4498v7se': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'hymg73dx': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    '72sugriq': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'jwv5x4t7': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'zs7228zl': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    '2046uthd': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '6g9v8us7': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'nmuqlods': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    '6fch26ol': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'w1o2okk6': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'o6i6nz6a': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    'dp783tma': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'bpv14wuc': {
      'pt': 'Melhores Criativos',
      'en': '',
    },
    '26hn5tht': {
      'pt': 'Mais Impressões',
      'en': 'Best Posts',
    },
    '39q1y145': {
      'pt': 'Impressões',
      'en': 'Followers',
    },
    'mef7cf0u': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'fufb44zo': {
      'pt': 'Mais Likes',
      'en': 'Best Posts',
    },
    'k6l9lcdq': {
      'pt': 'Likes',
      'en': 'Followers',
    },
    '3pmkva1k': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'e8fgwr2u': {
      'pt': 'Mais Cliques',
      'en': 'Best Posts',
    },
    'w1c93m8j': {
      'pt': 'Cliques',
      'en': 'Followers',
    },
    'rzbqf3iu': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'og085tcr': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'tr6tsvo7': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'ppvic6m4': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '3j2hljtn': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'n96gtit6': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'b6xv60yq': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'savkz2cv': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'lzmlxrty': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '6fgpmp75': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    '99ao7nd1': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'qo02xaku': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'z20pipql': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    'h8r7cah4': {
      'pt': '13-17',
      'en': '13-17',
    },
    'zn88qsxv': {
      'pt': '18-24',
      'en': '18-24',
    },
    't985jxgi': {
      'pt': '25-34',
      'en': '25-34',
    },
    'fx25lhr2': {
      'pt': '35-44',
      'en': '35-44',
    },
    '9jcdrwbq': {
      'pt': '45-54',
      'en': '45-54',
    },
    'beh6q6qk': {
      'pt': '55-64',
      'en': '55-64',
    },
    'acnk2h15': {
      'pt': '65+',
      'en': '65+',
    },
    '44hov738': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'kqu57h0e': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'u17wk9xu': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    'vw4co092': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'xb0jn71v': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    '69h86p62': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'tcm4egcc': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'pxby1z8u': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'kmn1pat6': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'sev7a87k': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    '09bsncvj': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'sdy11vuo': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'k7d5kh7r': {
      'pt': 'Melhores Posts',
      'en': 'Best Posts',
    },
    'pzd0nn7o': {
      'pt': 'Mais Impressões',
      'en': 'More Impressions',
    },
    'b0t7so8k': {
      'pt': 'Mais Likes',
      'en': 'More Likes',
    },
    'bmf5vsgx': {
      'pt': 'Mais Engajamento',
      'en': 'More Engagement',
    },
    '98mrp90q': {
      'pt': 'Não foram encontradas publicações dentro do período analisado',
      'en': 'No publications were found within the analyzed period',
    },
    'uq8j62pc': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'a7dqgbdy': {
      'pt': 'Não foram encontrados comentários para o período analisado',
      'en': 'No comments were found for the period analyzed',
    },
    'k23qwbci': {
      'pt': 'Visão Geral',
      'en': '',
    },
    'bpcan9ab': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    'g79ona9z': {
      'pt': 'Reconhecimento',
      'en': '',
    },
    'gcbfeavi': {
      'pt': 'Consideração',
      'en': '',
    },
    'xcy618ni': {
      'pt': 'Conversões',
      'en': '',
    },
    '8quyvfsa': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'ymk4zho6': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ttic8tfa': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'pwgb84vr': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    '7zy0yaji': {
      'pt': 'Taxa de jornada',
      'en': 'Journey rate',
    },
    'm9lcvskz': {
      'pt': 'Custo total',
      'en': 'Total cost',
    },
    'k4ewbo5p': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'e56g2f4w': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '0mx0ykbk': {
      'pt': 'Custo por conversão',
      'en': 'Cost per conversion',
    },
    'ztg35lk6': {
      'pt': 'Taxa de cliques',
      'en': 'Click-through rate',
    },
    '1kz9xqls': {
      'pt': 'Taxa de conversão',
      'en': 'Conversion rate',
    },
    '3r1bhuyu': {
      'pt': 'Dados por dispositivo',
      'en': 'Comparative analysis by device',
    },
    'l3awkwij': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'oxxppnnt': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'qtmedrso': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    'b0zgutsu': {
      'pt': 'Custo',
      'en': 'Cost',
    },
    '4tenakp7': {
      'pt': 'Celular',
      'en': 'Cell phone',
    },
    'u1vzggvy': {
      'pt': 'PC',
      'en': 'PRAÇA',
    },
    'znxl16r4': {
      'pt': 'Tablet',
      'en': 'Tablet',
    },
    'fhckj813': {
      'pt': 'TV',
      'en': 'Cell phone',
    },
    'k6860ht2': {
      'pt': 'Outros',
      'en': 'Cell phone',
    },
    '3o81qneg': {
      'pt': 'Dados por público e tempo',
      'en': '',
    },
    'f71l9c47': {
      'pt': 'Dias da semana',
      'en': '',
    },
    '24pkffkf': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    '1qgzefg6': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'kn5pp13v': {
      'pt': 'Conversões',
      'en': '',
    },
    'gtxh8jf7': {
      'pt': 'Cliques',
      'en': '',
    },
    'gvi5270t': {
      'pt': 'Seg',
      'en': '13-17',
    },
    'rkre2amg': {
      'pt': 'Ter',
      'en': '18-24',
    },
    '2vut7rqp': {
      'pt': 'Qua',
      'en': '25-34',
    },
    '0jht35bt': {
      'pt': 'Qui',
      'en': '35-44',
    },
    'z9cdwk9q': {
      'pt': 'Sex',
      'en': '45-54',
    },
    'd6wn4x3o': {
      'pt': 'Sab',
      'en': '55-64',
    },
    'obqxse47': {
      'pt': 'Dom',
      'en': '65+',
    },
    'uw4ypdok': {
      'pt': 'Faixa etária',
      'en': '',
    },
    'vxpjqsb0': {
      'pt': 'Impressions',
      'en': 'Women',
    },
    'dwydefyq': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'ax4sszr8': {
      'pt': 'Conversões',
      'en': '',
    },
    'kpd70slg': {
      'pt': 'Cliques',
      'en': '',
    },
    'iyazlzss': {
      'pt': '13-17',
      'en': '13-17',
    },
    '1lxet66n': {
      'pt': '18-24',
      'en': '18-24',
    },
    'xy1ifmbf': {
      'pt': '25-34',
      'en': '25-34',
    },
    'jdfjuk6w': {
      'pt': '35-44',
      'en': '35-44',
    },
    'p458sgko': {
      'pt': '45-54',
      'en': '45-54',
    },
    'rk7c0idy': {
      'pt': '55-64',
      'en': '55-64',
    },
    'uew5w4z0': {
      'pt': '65+',
      'en': '65+',
    },
    'bhrrwlhr': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    '34cbi339': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'wjza25tp': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    '7q2ex0hw': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    'xxxxzqi8': {
      'pt': 'Palavra-chave',
      'en': '',
    },
    't8iqtig6': {
      'pt': 'Campanhas Veiculadas',
      'en': 'Best Ads',
    },
    'o1wbxsf2': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    '6cczi05a': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '3bq06r83': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'a2haop39': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'i7cy34ld': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'x8zfk041': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'om7h1foy': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    'cvl7d7op': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'jgscq3e9': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'kn7a05se': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    '33f43uww': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'babzj3gh': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'kntwtdze': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'pbjb2ydf': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    '06fb0juh': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'pbcjx8oi': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    's97fknll': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    '5f8ot8us': {
      'pt': 'Melhores Criativos',
      'en': '',
    },
    '4tgoupga': {
      'pt': 'Mais Impressões',
      'en': 'Best Posts',
    },
    '61mmbww3': {
      'pt': 'Impressões',
      'en': 'Followers',
    },
    '653597n7': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    '2iqo1nvr': {
      'pt': 'Mais Likes',
      'en': 'Best Posts',
    },
    'klndoett': {
      'pt': 'Likes',
      'en': 'Followers',
    },
    'g4b7rgk6': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'tnvtotaf': {
      'pt': 'Mais Cliques',
      'en': 'Best Posts',
    },
    'o9zoj8tk': {
      'pt': 'Cliques',
      'en': 'Followers',
    },
    '1w12162e': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    '2iwpgrv8': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '2sm3napd': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'jufs818c': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'as01de1l': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'bpyuu59k': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'ydkqlpv7': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'ndh8yu0a': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'zkx6oixx': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'mjm66txy': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'z7els289': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'u0gdewvj': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    '9k60f5zl': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    '66abpiyn': {
      'pt': '13-17',
      'en': '13-17',
    },
    '3lwoir6a': {
      'pt': '18-24',
      'en': '18-24',
    },
    'umy8f1fz': {
      'pt': '25-34',
      'en': '25-34',
    },
    'jq96ddvc': {
      'pt': '35-44',
      'en': '35-44',
    },
    'mf93r9sv': {
      'pt': '45-54',
      'en': '45-54',
    },
    'omoo6hlj': {
      'pt': '55-64',
      'en': '55-64',
    },
    'hfcml1wi': {
      'pt': '65+',
      'en': '65+',
    },
    'br6d7p59': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'n275nwq4': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'nxek3rwl': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    '11i5bmb9': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '492mbezh': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'as7pxh8l': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'yw7u4xbx': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'l5imsnjd': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'rp4vg7ge': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'kufq6clz': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'pol1ix48': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'yo4i5eo9': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'ow6amjhw': {
      'pt': 'Melhores Posts',
      'en': 'Best Posts',
    },
    'cbxj859s': {
      'pt': 'Não foram encontradas publicações dentro do período analisado',
      'en': 'No publications were found within the analyzed period',
    },
    '23mt1lkm': {
      'pt': 'Mais Impressões',
      'en': 'More Impressions',
    },
    'r2hbu7mg': {
      'pt': 'Mais Likes',
      'en': 'More Likes',
    },
    '4i3yk307': {
      'pt': 'Mais Engajamento',
      'en': 'More Engagement',
    },
    'mxunb2h7': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'vkv4nn5u': {
      'pt': 'Não foram encontrados comentários para o período analisado',
      'en': 'No comments were found for the period analyzed',
    },
    'idz214kq': {
      'pt': 'Visão Geral',
      'en': '',
    },
    'uu82401n': {
      'pt': 'Campanhas Veiculadas',
      'en': 'Best Ads',
    },
    'ikxjo22w': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'ihmji4kw': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '8t7ctjb7': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    '2xjxmrbi': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    '5vwnsogf': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'zlx8bj48': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'uhk9odef': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    '5v4wqcgi': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '0s2c5igu': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'qqi8bwzq': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'vs2anv85': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'hzvsd20z': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'qz9usope': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'vro5xgeg': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'phtxnpk2': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'xjqilmty': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    '9xkhhbym': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'vb2fq5ca': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    'meyxem8a': {
      'pt': 'Impressões',
      'en': '',
    },
    '2kaa4jks': {
      'pt': 'Cliques',
      'en': '',
    },
    'kq6nh70v': {
      'pt': 'Conversões',
      'en': '',
    },
    'zxw30v8b': {
      'pt': 'Melhores Criativos',
      'en': '',
    },
    'wbyx9422': {
      'pt': 'Mais Impressões',
      'en': 'Best Posts',
    },
    'shvqct1s': {
      'pt': 'Impressões',
      'en': 'Followers',
    },
    'bs77dhel': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    '7cn972mb': {
      'pt': 'Mais Likes',
      'en': 'Best Posts',
    },
    'kp7kf0ht': {
      'pt': 'Likes',
      'en': 'Followers',
    },
    'igvhvsro': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'joi8hg46': {
      'pt': 'Mais Cliques',
      'en': 'Best Posts',
    },
    '222okcb9': {
      'pt': 'Cliques',
      'en': 'Followers',
    },
    'bhuw8kvm': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'vugd5x6h': {
      'pt': 'Visão Geral',
      'en': '',
    },
    'ewxyct8w': {
      'pt': 'Campanhas Veiculadas',
      'en': 'Best Ads',
    },
    'a74iw6k4': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    'd2g7hm08': {
      'pt': 'Impressões',
      'en': '',
    },
    'cork6fav': {
      'pt': 'Cliques',
      'en': '',
    },
    'rguba5di': {
      'pt': 'Conversões',
      'en': '',
    },
    'zvekbe8u': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    '11sqxd9r': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ui159kvd': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'f090n9os': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'nhw060wq': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'ywjrqf4r': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    's68ddz5v': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    'omyxph9n': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '6hvz0z6l': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '8w3aqw22': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    '3gzxmlyi': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '75y1jm0s': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    '5qqxn7br': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'of6cruq2': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    '932gkotu': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'ib9ngbr7': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    '9gp34trp': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'p7z588wf': {
      'pt': 'Melhores Criativos',
      'en': '',
    },
    'f3wgjzy3': {
      'pt': 'Mais Impressões',
      'en': 'Best Posts',
    },
    'gtaqz0pw': {
      'pt': 'Impressões',
      'en': 'Followers',
    },
    'nnmswtup': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'm6hut22o': {
      'pt': 'Mais Likes',
      'en': 'Best Posts',
    },
    'fl4xwx4y': {
      'pt': 'Likes',
      'en': 'Followers',
    },
    '2xmw51x9': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    '0nchl5c5': {
      'pt': 'Mais Cliques',
      'en': 'Best Posts',
    },
    'gul7uab7': {
      'pt': 'Cliques',
      'en': 'Followers',
    },
    'oot2tex9': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    '9o4s9eq9': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'oso8z5ou': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'n6i71uqr': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    '1vx8apf0': {
      'pt': 'Conecte sua conta',
      'en': '',
    },
    'rymtq7w6': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en': '',
    },
    'arboekig': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en': '',
    },
    '8l2srnna': {
      'pt': 'insights da página e posts',
      'en': '',
    },
    '6xlfrk3a': {
      'pt': 'comentários',
      'en': '',
    },
    'vnbic535': {
      'pt': 'Conectar Conta',
      'en': '',
    },
  },
  // cronograma
  {
    't3k1epk4': {
      'pt': ' ',
      'en': '',
    },
    '0pg1jqw0': {
      'pt': 'Ver todos os comentários',
      'en': 'See all comments',
    },
    'enerhffk': {
      'pt': ' ',
      'en': '',
    },
    'xd76ysrc': {
      'pt': 'Insira seu comentário',
      'en': 'Enter your comment',
    },
    'olan7ttt': {
      'pt': ' ',
      'en': '',
    },
    'b3ck3si3': {
      'pt': ' ',
      'en': '',
    },
    'gebk9k0i': {
      'pt': 'Cronograma',
      'en': 'Timeline',
    },
    '7el80ez5': {
      'pt': 'Home',
      'en': 'Home',
    },
  },
  // anuncio
  {
    'zftcwk6n': {
      'pt': 'Resultados dos anúncios',
      'en': 'Ad results',
    },
    'y86ge1v4': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'hyavt701': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    '991bgex2': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'lveqavo6': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    'thgz4gi4': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'tf1spxg0': {
      'pt': 'Média',
      'en': 'Average',
    },
    'spo0xtxv': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'u6lc4bsm': {
      'pt': 'Conjunto de Anúncios',
      'en': 'Ad Set',
    },
    'ld2nr7ky': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'neprbhc5': {
      'pt': 'Média',
      'en': 'Average',
    },
    '4gi7jbr6': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'sub6ymbr': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    '3b2iq9aj': {
      'pt': 'Impressões',
      'en': '',
    },
    'bfqn8flx': {
      'pt': 'Cliques',
      'en': '',
    },
    '5qxj7nqt': {
      'pt': 'Conversões',
      'en': '',
    },
    'cng7f48u': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'sp4o4jrd': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '51srcwiq': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'r89h9n7l': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'fmoduwb7': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'smaio76z': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'fcro6m43': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    'm5ybrz41': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'v8t7kgkf': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'awxgdiv9': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'io6vj6jt': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '11aigdyo': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'm9mv9fh4': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'zuzazdeu': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    '1cs7qi16': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'dbg52qub': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    'yvkzfnyx': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'q4gddfyj': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    'lu39f7ae': {
      'pt': '',
      'en': 'Select...',
    },
    'ved7shn2': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'pvmcy9td': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'y63t0ixi': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    '9gk4ak3a': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'md45bodr': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'uzyfb6rn': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '1xjhgrmt': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    'pa2x855q': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'izoyfx5s': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'u3jvades': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    '1i245qxh': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '393xcg8a': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'evutlfpw': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    '4nvqwjwc': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    '0vkvpdde': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'nuyshehe': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'ktb4u2dj': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    '9wrbbohy': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'vojtnz8l': {
      'pt': 'Melhores Anúncios',
      'en': 'Best Ads',
    },
    '3w7tjqza': {
      'pt': '',
      'en': 'Select...',
    },
    'ilt442o3': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'ha68cmzm': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'pc5n6l90': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    'wihsj25c': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'mmaqefmf': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'wvo8nk2b': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '4zpspdb2': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    '723inla7': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'vqy2m5da': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'vhgzulc8': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'xjdjb5gr': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'xlsl7g2g': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    '9383xby9': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'bz4ovqrg': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'svc0fimb': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'c2oftn9k': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'mt5fgb6w': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'funz4yyf': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'ranfa9f4': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '48fxk0oj': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'g0u6sbwl': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '0nadpdg9': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'f8s0dhdw': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'vmditgij': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'f3yzlg8w': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'akcuwms1': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'gdm071ec': {
      'pt': 'Resultados dos anúncios',
      'en': 'Ad results',
    },
    'csj1ru7i': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'z3of03xj': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'jfk2dmb5': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'wftkga9s': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    '4orqhohf': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'dwykl9wk': {
      'pt': 'Média',
      'en': 'Average',
    },
    'c0v0zcso': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'xicdmh5q': {
      'pt': 'Conjunto de Anúncios',
      'en': 'Ad Set',
    },
    'dxgajq86': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'aht4e5b0': {
      'pt': 'Média',
      'en': 'Average',
    },
    '6oelq4d0': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'p13kf6dh': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    'rynoonjf': {
      'pt': 'Impressões',
      'en': '',
    },
    'u6jrguh8': {
      'pt': 'Cliques',
      'en': '',
    },
    '2xukvdju': {
      'pt': 'Conversões',
      'en': '',
    },
    '5jbhdn8k': {
      'pt': 'Melhores Anúncios',
      'en': 'Best Ads',
    },
    '9npc08hm': {
      'pt': '',
      'en': 'Select...',
    },
    'gzkfhhy5': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '3xifvlt6': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ibbp2xvx': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    'zvsv7obk': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'y0b1nd8k': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'vm6bwlv7': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '8x50i85z': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    '3v09ugxb': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '6u3ovccw': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    's0m60f39': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    '65scvmro': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '32fuu2g9': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'n2nqorpx': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    '22jdsmqv': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'mwrqwx8k': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'mh1dbuyr': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'do8lihhm': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'jna8luji': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'patrhnoy': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'nfwctbio': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'l05xehku': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'ce21zkdq': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'iu78tpvz': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'go1oif9z': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    'di11jtmt': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '8wrwj563': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '6aqxbkoc': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'ilajuvad': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'eb3n87xs': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    '77vz9dov': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'cu5vr4r5': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'lw0vvuwb': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'rtrt74c7': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    'f9wsq7ir': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'o5qh8fa5': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    '7gy2eir5': {
      'pt': '',
      'en': 'Select...',
    },
    'riunagle': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '89ezoepm': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '4ff29ocd': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    '2flq9ndf': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'oqxr8th5': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'it9zv501': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '4zz7rbrd': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    '6zapxypm': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '9fi777e8': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'i5qz85jz': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'euy1wdtu': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '2h6jceai': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    '98rjpd47': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'jurjjca3': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'r2pq6eco': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'jbhkvp50': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'cywwg0r9': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'tfcvj8sf': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'z8d97mtw': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'ndhdhk62': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'thnir9ka': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'mfl4mqz9': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'jfim6ehp': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'ne5gs029': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'qu0xhgvg': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '68d5fc1h': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '4jrtx0u9': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // criativos
  {
    'rxxiqaev': {
      'pt': 'Resultados do Criativo',
      'en': 'Creative Results',
    },
    '03c92k5a': {
      'pt': 'Objetivos',
      'en': 'Objectives',
    },
    'pvb9353t': {
      'pt': 'Meta de Otimização',
      'en': 'Optimization Goal',
    },
    'n3nqp9ez': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'buq9jih8': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    's7lxhp5w': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'wubq639p': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    '5ft3dgbx': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'trrctzoi': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '8ec4jlxc': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'lld5qg1x': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    'l6hi2qtw': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'lh49ndyh': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'dkp9hwmo': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'am4kin05': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'qki29kzu': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'd463ygme': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'ardbo0ek': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'yww0e8pc': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'qfzj5wip': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    '0x89on2u': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    '1quu2nq5': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    'yydkg0eg': {
      'pt': '',
      'en': 'Select...',
    },
    'uug9qt8z': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'epjwn5ju': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '1t6isrja': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    'ibcf53gv': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    '7pkv0cfh': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'zf68qikn': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '0fqnfsgw': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    '93bxyt7r': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'no1scmt9': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '5g9k7u0t': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'c4lmam4p': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'hqz3twow': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'lc33yrtw': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    '3wc4l7mz': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'qpj7t5iz': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'ps623fau': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'e93k76x6': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'vdz0ehqp': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'ivcvvsfc': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '2jgcvefx': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'ywqem131': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '0wp5wrn8': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'j1dhojua': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '9d4ohrag': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '932dmmsh': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'acu27fcp': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'pkgrdqm8': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'c0or606n': {
      'pt': 'Resultados do Criativo',
      'en': 'Creative Results',
    },
    's2ea5lbr': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'i0nxcw0b': {
      'pt': 'Objetivos',
      'en': 'Objectives',
    },
    '4llbjknl': {
      'pt': 'Meta de Otimização',
      'en': 'Optimization Goal',
    },
    '037ohszi': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    '8n41w18u': {
      'pt': '',
      'en': 'Select...',
    },
    'o3iuf2pi': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'k2hq7jk3': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'wcqr25hd': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    'suj0x1kx': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'r0jzsw6u': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '8gmwt3m9': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '4f5n5m0s': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    'mjx5xpn7': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '11gy8nxw': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '8xciqy47': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'gq0p3urp': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'eimdvi7b': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'eqzwaqg4': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'oznyv2b7': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'bopnga2g': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'lc74bjhg': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'jah6l1f7': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'ky8odsrp': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'hzbr62a4': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    '6c29pbn8': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ihfsdn98': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'wsgugd1k': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'v4jpdrxv': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'cxnvmuzj': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'f5l66b1s': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    'ary9lhxi': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '2tv69700': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'lcerhtk1': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'tsiegx9l': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'xn9ciadu': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'v7av460q': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'kinrkkf5': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    '39ecz37l': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'mptk8rex': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    'a6x6fsbi': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'hih76qs5': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'o26irs84': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'uxoliq5g': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '1wecxcjj': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '0xw8w250': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'ado8mw3j': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '643lhfgt': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '8huf402k': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '8l9q4sxa': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // conjuntos
  {
    'gcu63sap': {
      'pt': 'Configurações de Campanhas',
      'en': 'Campaign Settings',
    },
    'vxodezbd': {
      'pt': 'Campanhas Ativas',
      'en': 'Active Campaigns',
    },
    '8ejuuq4m': {
      'pt': 'Campanhas Inativas',
      'en': 'Active Campaigns',
    },
    'avt13fd0': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'jsaosxgb': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'q8u7lmo1': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'mx2wvi0b': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'srzz8ot3': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '780euzj0': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'yvedfd2o': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'h1uh834z': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'et2veyt4': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'l6e8kwaq': {
      'pt': 'Configurações de Campanhas',
      'en': 'Campaign Settings',
    },
    '1x0oow2r': {
      'pt': 'Campanhas Ativas',
      'en': 'Active Campaigns',
    },
    '6wk9i3ft': {
      'pt': 'Campanhas Inativas',
      'en': 'Active Campaigns',
    },
    'lydz11sb': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '2a6g7fd8': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'iwbshr2f': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'm74s9gt8': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '5hnrb9mr': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'op7tc56y': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'zosm1qff': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'xujk6gw1': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '7op6lgk2': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // googleinsights
  {
    'd59x7otz': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    '6aw6fncb': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'x3ds6rft': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    '6aqyk1v2': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    '32tfdo0a': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    'xcm2zco5': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    't8fl3683': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    't1c63tpp': {
      'pt': 'Impressões',
      'en': '',
    },
    'zg0nwfw9': {
      'pt': 'Cliques',
      'en': '',
    },
    'us2by11b': {
      'pt': 'Conversões',
      'en': '',
    },
    'v4510398': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'h9yvqhy3': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '34m0qj5k': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'n1jl6ki6': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    '4v16mh4u': {
      'pt': 'Taxa de jornada',
      'en': 'Journey rate',
    },
    'bkk8phn2': {
      'pt': 'Custo total',
      'en': 'Total cost',
    },
    'eifitne8': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'krmpu1fi': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'hbrgo8dv': {
      'pt': 'Custo por conversão',
      'en': 'Cost per conversion',
    },
    'a52ov4td': {
      'pt': 'Taxa de cliques',
      'en': 'Click-through rate',
    },
    'l26ng43f': {
      'pt': 'Taxa de conversão',
      'en': 'Conversion rate',
    },
    'ygdm536o': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    'e6th8w6w': {
      'pt': '',
      'en': 'Select...',
    },
    'j2ugtmb1': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'dz8piqm2': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'jye0goi4': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    'qg61hl01': {
      'pt': 'Conversões',
      'en': 'Clicks',
    },
    '4m0ger3c': {
      'pt': 'Custo total ',
      'en': 'Cost per Click',
    },
    'bepdig3i': {
      'pt': 'Custo por mil',
      'en': 'Results',
    },
    'su51e066': {
      'pt': 'Custo por clique',
      'en': 'Cost per result',
    },
    'xwvbsf61': {
      'pt': 'Custo por conversão',
      'en': 'Likes',
    },
    'zbg1a142': {
      'pt': 'Taxa de cliques',
      'en': 'Comments',
    },
    'mdx7mwdf': {
      'pt': 'Taxa de conversão',
      'en': 'Reactions',
    },
    'ng3mqqpp': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'xspqe0sy': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'ysmwf03w': {
      'pt': 'Análise por dispositivo',
      'en': 'Comparative analysis by device',
    },
    '297d245s': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ne4rqz0l': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    '34vgb4c0': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    'ub5zo0wj': {
      'pt': 'Custo',
      'en': 'Cost',
    },
    '2tkfxwzh': {
      'pt': 'Celular',
      'en': 'Cell phone',
    },
    '3l2p9su6': {
      'pt': 'PC',
      'en': 'PRAÇA',
    },
    'vke1k1ey': {
      'pt': 'Tablet',
      'en': 'Tablet',
    },
    's9jvi5yb': {
      'pt': 'TV',
      'en': 'Cell phone',
    },
    'cmegirpj': {
      'pt': 'Outros',
      'en': 'Cell phone',
    },
    '6j9kz11n': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'vbwdr54o': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '558ccd2l': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'n3o4aqie': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'ujw128gw': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'n5vhenz6': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'od65kw36': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'tcjgy1bw': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'ieov0c06': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '9n5a902m': {
      'pt': 'Visão Geral',
      'en': 'Overview',
    },
    'xlhfvn5i': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'mht13bpf': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'tbw484qy': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'vm9zm2e2': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    'opyv6qya': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'ejv1b0mu': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'pq3dq0nw': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'tzqhizjy': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'ydcf3ycl': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    'xl8x2ux1': {
      'pt': 'Taxa de jornada',
      'en': 'Journey rate',
    },
    '67n1ppeg': {
      'pt': 'Custo total',
      'en': 'Total cost',
    },
    'igrb3cc4': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'qp5zmhvw': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'hysiokvj': {
      'pt': 'Custo por conversão',
      'en': 'Cost per conversion',
    },
    'fzcnxje1': {
      'pt': 'Taxa de cliques',
      'en': 'Click-through rate',
    },
    'jpfxl4gc': {
      'pt': 'Taxa de conversão',
      'en': 'Conversion rate',
    },
    'ykpklqsp': {
      'pt': 'Funil de marketing',
      'en': 'Daily results',
    },
    't2f72d5a': {
      'pt': 'Impressões',
      'en': '',
    },
    'f7672oxy': {
      'pt': 'Cliques',
      'en': '',
    },
    'v9gxdqzm': {
      'pt': 'Conversões',
      'en': '',
    },
    'h2vg8ic9': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    '5hir7o8w': {
      'pt': '',
      'en': 'Select...',
    },
    '8ufbxhk8': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'oud5fvsb': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '32ssbkvn': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    'nqrvahzm': {
      'pt': 'Conversões',
      'en': 'Clicks',
    },
    'r3kjtqp7': {
      'pt': 'Custo total ',
      'en': 'Cost per Click',
    },
    'ty7cv2xd': {
      'pt': 'Custo por mil',
      'en': 'Results',
    },
    'f0m2looc': {
      'pt': 'Custo por clique',
      'en': 'Cost per result',
    },
    'hyf65p1g': {
      'pt': 'Custo por conversão',
      'en': 'Likes',
    },
    '6v9q91zo': {
      'pt': 'Taxa de cliques',
      'en': 'Comments',
    },
    'y1rgocw5': {
      'pt': 'Taxa de conversão',
      'en': 'Reactions',
    },
    'bsseeoef': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    '4tffyvhr': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'a576h8ia': {
      'pt': 'Análise comparativa por dispositivo',
      'en': 'Comparative analysis by device',
    },
    'nya5g6jk': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'ok2daruu': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    '2979eoxa': {
      'pt': 'Custo',
      'en': 'Cost',
    },
    'xoquu7n6': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '1v1mc5lj': {
      'pt': 'Celular',
      'en': 'Cell phone',
    },
    'u6k846ig': {
      'pt': 'PC',
      'en': 'PRAÇA',
    },
    'fr47akr9': {
      'pt': 'Tablet',
      'en': 'Tablet',
    },
    '5gzmbmyj': {
      'pt': 'TV',
      'en': 'Cell phone',
    },
    'nr5wivvx': {
      'pt': 'Outros',
      'en': 'Cell phone',
    },
    'g5v3ezht': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'vm5252d2': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'bxm6re0y': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'qhrddmx3': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'm7kngwy9': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'ir88llde': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'atbxik3a': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'zjslgyd7': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'f4t2sk0e': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
  },
  // googledemografia
  {
    'v49z5r8n': {
      'pt': '',
      'en': '@brandname',
    },
    'ev3cqqa3': {
      'pt': '',
      'en': 'Digital Marketing Agency',
    },
    'fxbvmf8m': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    'vb81m4vx': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'bvwjagia': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'y04owg2k': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'mhr4aq8g': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    'nk1cvrja': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'ojn3fljl': {
      'pt': 'Análise comparativa por genero',
      'en': 'Daily results',
    },
    'q3htmwc4': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ja098u1q': {
      'pt': 'Conversões',
      'en': 'Clicks',
    },
    'pqvwu2q6': {
      'pt': 'Cliques',
      'en': 'Impressions',
    },
    'bpvnckbp': {
      'pt': 'Custo',
      'en': 'Impressions',
    },
    'v92x850t': {
      'pt': 'Masculino',
      'en': 'Cell phone',
    },
    'sd539win': {
      'pt': 'Feminino',
      'en': 'PRAÇA',
    },
    'kp0cflfq': {
      'pt': 'Indefinido',
      'en': 'Tablet',
    },
    'mqbj2g1c': {
      'pt': 'Faixa etária',
      'en': '',
    },
    'wfg3g2dk': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    '6al18uml': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'dhjmvz5g': {
      'pt': 'Conversões',
      'en': '',
    },
    'dt0x0vbw': {
      'pt': 'Custo',
      'en': '',
    },
    '68g7v25t': {
      'pt': '13-17',
      'en': '13-17',
    },
    'd7grd737': {
      'pt': '18-24',
      'en': '18-24',
    },
    '7kwzl5i1': {
      'pt': '25-34',
      'en': '25-34',
    },
    'p8uei07u': {
      'pt': '35-44',
      'en': '35-44',
    },
    'y34o7pzl': {
      'pt': '45-54',
      'en': '45-54',
    },
    '0srk5myf': {
      'pt': '55-64',
      'en': '55-64',
    },
    '4tmrw9ma': {
      'pt': '65+',
      'en': '65+',
    },
    'um4thbz6': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'mhh27tun': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    '3q28s77v': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    'hvgqxvma': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    'bqcufrue': {
      'pt': 'Dias da semana',
      'en': '',
    },
    'c5c25n3m': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'xgcpu4v6': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    '8dsuzmxp': {
      'pt': 'Seg',
      'en': '13-17',
    },
    'uwfhcp4u': {
      'pt': 'Ter',
      'en': '18-24',
    },
    'pjviy0v6': {
      'pt': 'Qua',
      'en': '25-34',
    },
    '4aez3157': {
      'pt': 'Qui',
      'en': '35-44',
    },
    'ifkt9bfy': {
      'pt': 'Sex',
      'en': '45-54',
    },
    'ost0vpic': {
      'pt': 'Sab',
      'en': '55-64',
    },
    '4uzjean4': {
      'pt': 'Dom',
      'en': '65+',
    },
    'o1lh4t1b': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'lekclc04': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'rs8zu3q9': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    'w7qgjj09': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    'zmkjyays': {
      'pt': 'Palavra-chave',
      'en': 'Best Ads',
    },
    'wya6e4s6': {
      'pt': '',
      'en': 'Select...',
    },
    'tu306289': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'c80omu8e': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'tu5jwpjd': {
      'pt': 'Cliques',
      'en': '',
    },
    'a7p6x69e': {
      'pt': 'Conversões',
      'en': '',
    },
    '1tf9zzl8': {
      'pt': 'Custo',
      'en': '',
    },
    'jt38d4j7': {
      'pt': 'Impressões',
      'en': 'Cost per Thousand',
    },
    'bs8vmxhh': {
      'pt': 'Conversões',
      'en': 'Cost per Thousand',
    },
    'erak5fqq': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    'z3dpjxom': {
      'pt': 'Custo',
      'en': 'Cost per Thousand',
    },
    'etpopss8': {
      'pt': 'Termos de busca',
      'en': 'Best Ads',
    },
    'ms1pvvpr': {
      'pt': '',
      'en': 'Select...',
    },
    'i0pew1lh': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'jhzs41ad': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'fgoq9m60': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    '9a6c6dve': {
      'pt': 'Conversões',
      'en': '',
    },
    'il7f2en3': {
      'pt': 'Custo',
      'en': '',
    },
    '8jz694uz': {
      'pt': 'Impressões',
      'en': 'Cost per Thousand',
    },
    'zbt1hpw4': {
      'pt': 'Conversões',
      'en': 'Cost per Thousand',
    },
    '38ovawd8': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    'gx41swzl': {
      'pt': 'Custo',
      'en': 'Cost per Thousand',
    },
    'jkozfh2n': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '82fs2j5s': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'fmj2bxks': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    's0k5f6w7': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'irhxjx7a': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'sapocjcr': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '6qxt4q8q': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'r8vsho2r': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'ixcooq9h': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '17bjfenx': {
      'pt': 'Visão Geral',
      'en': 'Overview',
    },
    'cyaw65x6': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '3eyvbtg7': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'd1rvch3j': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'aie3ud70': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    '77gduwkr': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'exjoh439': {
      'pt': 'Análise comparativa por genero',
      'en': 'Daily results',
    },
    '4zpuuhc9': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'mrdkuv7n': {
      'pt': 'Conversões',
      'en': 'Clicks',
    },
    '6qfxh95v': {
      'pt': 'Cliques',
      'en': 'Impressions',
    },
    's9c7pluo': {
      'pt': 'Custo',
      'en': 'Impressions',
    },
    '6ymlltb4': {
      'pt': 'Masculino',
      'en': 'Cell phone',
    },
    'o57hyth6': {
      'pt': 'Feminino',
      'en': 'PRAÇA',
    },
    '24t395y5': {
      'pt': 'Indefinido',
      'en': 'Tablet',
    },
    '2twbmlpo': {
      'pt': 'Faixa etária',
      'en': '',
    },
    '4uwbssuv': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    'u86dj9f2': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'f1ov5b0c': {
      'pt': 'Conversões',
      'en': '',
    },
    'ftpcofhc': {
      'pt': 'Custo',
      'en': '',
    },
    '7za652m1': {
      'pt': '13-17',
      'en': '13-17',
    },
    'gagw099f': {
      'pt': '18-24',
      'en': '18-24',
    },
    'g5dnn800': {
      'pt': '25-34',
      'en': '25-34',
    },
    'uu9qe33v': {
      'pt': '35-44',
      'en': '35-44',
    },
    '9ov801xf': {
      'pt': '45-54',
      'en': '45-54',
    },
    'lqhyliax': {
      'pt': '55-64',
      'en': '55-64',
    },
    '2mln8zmi': {
      'pt': '65+',
      'en': '65+',
    },
    '4v9jsq6h': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'fsqhkndn': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'zspn15x5': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    'kmmkfwh7': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    'owbgile2': {
      'pt': 'Dias da semana',
      'en': '',
    },
    '7qcl47ko': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    'vik22lyf': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'avtl5eq4': {
      'pt': 'Conversões',
      'en': '',
    },
    'rq0edmrm': {
      'pt': 'Custo',
      'en': '',
    },
    '5x8383eq': {
      'pt': 'Segunda',
      'en': '13-17',
    },
    'sibo2eze': {
      'pt': 'Terça',
      'en': '18-24',
    },
    '216ikgs8': {
      'pt': 'Quarta',
      'en': '25-34',
    },
    '8v1uag5q': {
      'pt': 'Quinta',
      'en': '35-44',
    },
    'rvbvjkgx': {
      'pt': 'Sexta',
      'en': '45-54',
    },
    '36wgza8w': {
      'pt': 'Sabado',
      'en': '55-64',
    },
    'flv7ekga': {
      'pt': 'Domingo',
      'en': '65+',
    },
    '7hm3luhd': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    '79oexs9k': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'wgt6j9yy': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    'k6uhu137': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    '3d3m431b': {
      'pt': 'Palavra-chave',
      'en': 'Best Ads',
    },
    'hj5oph5q': {
      'pt': '',
      'en': 'Select...',
    },
    'du170jjx': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'qswbd724': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'tq6m1c48': {
      'pt': 'Cliques',
      'en': '',
    },
    '9swjqiu7': {
      'pt': 'Conversões',
      'en': '',
    },
    'cs8j84dl': {
      'pt': 'Custo',
      'en': '',
    },
    '918xt11e': {
      'pt': 'Impressões',
      'en': 'Cost per Thousand',
    },
    '24nhr88q': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    '9kxcanmj': {
      'pt': 'Conversões',
      'en': 'Cost per Thousand',
    },
    '3d5yv9o2': {
      'pt': 'Custo',
      'en': 'Cost per Thousand',
    },
    't9rvm8za': {
      'pt': 'Termos de Busca',
      'en': 'Best Ads',
    },
    'raw8pm1b': {
      'pt': '',
      'en': 'Select...',
    },
    '4lf7868k': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'rymzsref': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ist3xg5z': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'r11buxyj': {
      'pt': 'Conversões',
      'en': 'Amount Spent',
    },
    'kr8j06rp': {
      'pt': 'Custo',
      'en': '',
    },
    '3n4iohwb': {
      'pt': 'Impressões',
      'en': 'Cost per Thousand',
    },
    'jbkfabib': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    'jmyupqbv': {
      'pt': 'Conversões',
      'en': 'Cost per Thousand',
    },
    '9a2r9yay': {
      'pt': 'Custo',
      'en': 'Cost per Thousand',
    },
    's9i5wlp6': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '2tk3dtz4': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'ph8msjzi': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'bf8lwlok': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'hba82ofw': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'gbv6y10p': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '18vta8c5': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'c0w7b41l': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'uoguu0rr': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
  },
  // estrategiagoogle
  {
    '4755b5gw': {
      'pt': 'Questão',
      'en': 'Question',
    },
    '7sdyf27z': {
      'pt': '',
      'en': '',
    },
    '9kgw24i5': {
      'pt': 'Explique de maneira curta o que sua empresa faz',
      'en': 'Briefly explain what your company does',
    },
    'kn9m323b': {
      'pt':
          'Quais são os principais produtos ou serviços que você deseja anunciar no Google?',
      'en': 'Briefly explain what your company does',
    },
    'ku5r9v9o': {
      'pt':
          'Qual é o principal diferencial de sua empresa em relação aos concorrentes?',
      'en': 'What feature do people most praise about your product/company?',
    },
    'e9vo6ppr': {
      'pt': 'Liste pelo menos 3 termos que descrevem o seu negócio.',
      'en': 'What feature do people most praise about your product/company?',
    },
    '99wtio7g': {
      'pt':
          'Liste pelo menos 3 termos que você gostaria de desassociar do seu negócio.',
      'en': 'What feature do people most praise about your product/company?',
    },
    'vbz9hrfx': {
      'pt':
          'Selecione até 3 adjetivos que melhor descrevem a imagem que sua empresa deseja transmitir',
      'en':
          'Select up to 3 adjectives that best describe the image your company wants to convey.',
    },
    'h8tp7w3r': {
      'pt': 'Confiável',
      'en': 'Reliable',
    },
    'dg52i9qp': {
      'pt': 'Inovadora',
      'en': 'Innovative',
    },
    'ielswk22': {
      'pt': 'Premium',
      'en': 'Premium',
    },
    'lvrln01g': {
      'pt': 'Sustentável',
      'en': 'Sustainable',
    },
    'onpjvz2d': {
      'pt': 'Acessível',
      'en': 'Accessible',
    },
    'zp4tl0ez': {
      'pt': 'Exclusiva',
      'en': 'Exclusive',
    },
    'afku8wa2': {
      'pt': 'Moderna',
      'en': 'Modern',
    },
    'ga9158q5': {
      'pt': 'Tradicional',
      'en': 'Traditional',
    },
    '67xf85c3': {
      'pt': 'Rápida',
      'en': 'Quick',
    },
    'rekzy8wa': {
      'pt': 'Criativa',
      'en': 'Creative',
    },
    'jg65ex6y': {
      'pt': 'Jovem',
      'en': 'Young',
    },
    'yoysfydj': {
      'pt': 'Experiente',
      'en': 'Experienced',
    },
    'd2q5un2b': {
      'pt': 'Luxuosa',
      'en': 'Luxurious',
    },
    'pp6g1yh1': {
      'pt': 'Responsável',
      'en': 'Responsible',
    },
    'xzxrnqwu': {
      'pt': 'Divertida',
      'en': 'Fun',
    },
    'gnwejz7c': {
      'pt': 'Aventureira',
      'en': 'Adventurer',
    },
    'f1qrx13w': {
      'pt': 'Dinâmica',
      'en': 'Dynamics',
    },
    'k53nbuws': {
      'pt': 'Autêntica',
      'en': 'Authentic',
    },
    '0md0l0hh': {
      'pt': 'Empática',
      'en': 'Empathetic',
    },
    'g20lb6vb': {
      'pt': 'Inspiradora',
      'en': 'Inspiring',
    },
    'do0cidkd': {
      'pt': 'Eficiente',
      'en': 'Efficient',
    },
    '2820b15k': {
      'pt': 'Tecnológica',
      'en': 'Technological',
    },
    '0ufpd6o9': {
      'pt': 'Visionária',
      'en': 'Visionary',
    },
    'o4yor1b8': {
      'pt': 'Séria',
      'en': 'He would be',
    },
    '7dlntquh': {
      'pt': 'Simples',
      'en': 'Simple',
    },
    'qcvrod66': {
      'pt': 'Flexível',
      'en': 'Flexible',
    },
    '3bbtf2y8': {
      'pt': 'Comprometida',
      'en': 'Committed',
    },
    'c7pz8dor': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'q69s8tcx': {
      'pt':
          'Selecione até 3 adjetivos que NÃO correspondem à imagem que sua empresa quer transmitir:',
      'en':
          'Select up to 3 adjectives that DO NOT correspond to the image your company wants to convey:',
    },
    'pwj0wnmh': {
      'pt': 'Dasatualizada',
      'en': 'Outdated',
    },
    '7pc7via8': {
      'pt': 'Barata',
      'en': 'Cheap',
    },
    'kfz0n9is': {
      'pt': 'Comum',
      'en': 'Common',
    },
    '08crf5z1': {
      'pt': 'Tradicional',
      'en': 'Traditional',
    },
    'smo7ffsp': {
      'pt': 'Lenta',
      'en': 'Slow',
    },
    'kb2dqjvd': {
      'pt': 'Antiquada',
      'en': 'Old-fashioned',
    },
    'joud5s11': {
      'pt': 'Inacessível',
      'en': 'Inaccessible',
    },
    'ygtxa2vq': {
      'pt': 'Impessoal',
      'en': 'Impersonal',
    },
    'rd2ipc0n': {
      'pt': 'Instável',
      'en': 'Unstable',
    },
    'cg4rzf77': {
      'pt': 'Arrogante',
      'en': 'Arrogant',
    },
    'j72ygntb': {
      'pt': 'Conservadora',
      'en': 'Conservative',
    },
    'j1rag4sq': {
      'pt': 'Cara',
      'en': 'Face',
    },
    '6elm41fp': {
      'pt': 'Monótona',
      'en': 'Monotonous',
    },
    'ojitvtcd': {
      'pt': 'Burocrática',
      'en': 'Bureaucratic',
    },
    'oic2sh30': {
      'pt': 'Rígida',
      'en': 'Rigid',
    },
    'i6tq592j': {
      'pt': 'Superficial',
      'en': 'Superficial',
    },
    'vfj0l634': {
      'pt': 'Oportunista',
      'en': 'Opportunist',
    },
    'j6dvei4m': {
      'pt': 'Agitada',
      'en': 'Agitated',
    },
    'qfp4ns5j': {
      'pt': 'Confusa',
      'en': 'Confused',
    },
    '7efhdtys': {
      'pt': 'Inexperiente',
      'en': 'Inexperienced',
    },
    'xip3ocmz': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'r6ur1utr': {
      'pt': 'Qual é o principal objetivo de sua campanha no Google Ads?',
      'en': 'What is the predominant gender of your audience?',
    },
    'wqacdf3g': {
      'pt': 'Gerar mais vendas online (E-commerce)',
      'en': 'Feminine',
    },
    'znaobruu': {
      'pt': 'Gerar leads (contatos de clientes em potencial)',
      'en': 'Masculine',
    },
    '17f38tix': {
      'pt': 'Aumentar o tráfego do site',
      'en': 'Both equally',
    },
    'tzzkagck': {
      'pt': 'Aumentar o reconhecimento da marca (Branding)',
      'en': '',
    },
    'ge5sba50': {
      'pt': 'Gerar ligações para a empresa',
      'en': '',
    },
    '6pce16uh': {
      'pt': 'Levar clientes para a loja física',
      'en': '',
    },
    'gb72j4nm': {
      'pt': 'Downloads de apps',
      'en': '',
    },
    '8vxqy9vm': {
      'pt': 'Inscritos/Visualizações/Engajamento Youtube',
      'en': '',
    },
    'x70e25fi': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'vcbyk99w': {
      'pt': 'Qual é o gênero predominante do seu público?',
      'en': 'What is the predominant gender of your audience?',
    },
    '2g0xbzks': {
      'pt': 'Feminino',
      'en': 'Feminine',
    },
    '4j44k72v': {
      'pt': 'Masculino',
      'en': 'Masculine',
    },
    'leebtbsx': {
      'pt': 'Ambos igualmente',
      'en': 'Both equally',
    },
    'cctilkxc': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'nnwv3lgg': {
      'pt': 'Quais são as faixas etárias predominantes do seu público médio?',
      'en': 'What are the predominant age groups of your average audience?',
    },
    'pg971x55': {
      'pt': '13-17 anos',
      'en': '13-17 years old',
    },
    '79tvjg2a': {
      'pt': '18-24 anos',
      'en': '18-24 years old',
    },
    'ycz7lccn': {
      'pt': '25-34 anos',
      'en': '25-34 years old',
    },
    'okg4oa2n': {
      'pt': '35-44 anos',
      'en': '35-44 years old',
    },
    'fh36gy7a': {
      'pt': '45-54 anos',
      'en': '45-54 years old',
    },
    'jhuct76d': {
      'pt': '55-64 anos',
      'en': '55-64 years old',
    },
    'ce7uka8b': {
      'pt': 'Acima de 65 anos',
      'en': 'Over 65 years old',
    },
    'tpkgt74n': {
      'pt': 'Qual a localização geográfica do seu público-alvo?',
      'en': 'What feature do people most praise about your product/company?',
    },
    'l1jjztk4': {
      'pt':
          'Como é caracterizada a interação do seu cliente com a sua empresa? (Selecione até três opções)',
      'en':
          'How is your customer\'s interaction with your company characterized? (Select up to three options)',
    },
    'ycp6slcw': {
      'pt': 'Compra planejada',
      'en': 'Planned purchase',
    },
    'zsxr66dc': {
      'pt': 'Compra por impulso',
      'en': 'Impulse buying',
    },
    'ogoyjbu6': {
      'pt': 'Compra recorrente',
      'en': 'Recurring purchase',
    },
    '2ukxwsqe': {
      'pt': 'Compra ocasional',
      'en': 'Occasional purchase',
    },
    'pam0bumf': {
      'pt': 'Compra por indicação',
      'en': 'Purchase by referral',
    },
    'dyxx3skg': {
      'pt': 'Compra por necessidade imediata',
      'en': 'Purchase due to immediate need',
    },
    'rfvbgjdl': {
      'pt': 'Compra baseada em promoções',
      'en': 'Promotion-based purchasing',
    },
    'qbdy40ce': {
      'pt': 'Compra baseada em experiencia anterior',
      'en': 'Purchase based on previous experience',
    },
    'c1khqbkm': {
      'pt': 'Compra baseada em relacionamento',
      'en': 'Relationship-based purchasing',
    },
    '8h3ff8fe': {
      'pt': 'Compra agendada',
      'en': 'Scheduled purchase',
    },
    '39h0dbcb': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'gto9wsu2': {
      'pt':
          'Quem é o principal segmento consumidor dos seus produtos/serviços? (Selecione até duas opções)',
      'en':
          'Who is the main consumer segment of your products/services? (Select up to two options)',
    },
    'zdtqo3f7': {
      'pt': 'Consumidor final (B2C)',
      'en': 'End consumer (B2C)',
    },
    'n31esflu': {
      'pt': 'Varejistas',
      'en': 'Retailers',
    },
    '6jsyzprv': {
      'pt': 'Distribuidores',
      'en': 'Distributors',
    },
    'jmxcumps': {
      'pt': 'Empresas (B2B)',
      'en': 'Companies (B2B)',
    },
    'b54uyc1o': {
      'pt': 'Setor Público (governo, orgãos públicos)',
      'en': 'Public Sector (government, public agencies)',
    },
    'unav14vm': {
      'pt': 'Prestadores de serviços',
      'en': 'Service providers',
    },
    '9e0gzmq4': {
      'pt': 'Indústrias',
      'en': 'Industries',
    },
    '4vjpqkar': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'jtmc3jsz': {
      'pt':
          'Qual é o investimento mensal que você planeja para os anúncios no Google Ads?',
      'en':
          'How is your customer\'s interaction with your company characterized? (Select up to three options)',
    },
    'sfxam1sy': {
      'pt': 'Até R\$1.000',
      'en': 'Planned purchase',
    },
    'dtlpny8x': {
      'pt': 'Entre R\$1.001 e R\$2.500',
      'en': 'Impulse buying',
    },
    '24wr31pa': {
      'pt': 'Entre R\$2.501 e R\$5.000',
      'en': 'Recurring purchase',
    },
    'rwnbin4i': {
      'pt': 'Acima de R\$ 5.000',
      'en': 'Occasional purchase',
    },
    '0cyp9fzn': {
      'pt': 'Ainda não sei/Gostaria de uma sugestão',
      'en': 'Purchase by referral',
    },
    '5h97d1pr': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'bu59fsdd': {
      'pt':
          'Tem alguma informação adicional que você considera relevante para a análise dos resultados da conta?',
      'en':
          'Do you have any additional information that you consider relevant to analyzing the account results?',
    },
    'qu71cfdg': {
      'pt': 'Página anterior',
      'en': 'Previous page',
    },
  },
  // estrategiameta
  {
    'tfanf0w7': {
      'pt': 'Questão',
      'en': 'Question',
    },
    '4qyk10ym': {
      'pt': '',
      'en': '',
    },
    'pm27kfjd': {
      'pt': 'Explique de maneira curta o que sua empresa faz',
      'en': 'Briefly explain what your company does',
    },
    'ys1e58o6': {
      'pt':
          'Quais são os principais produtos ou serviços que você deseja anunciar no Google?',
      'en': 'Briefly explain what your company does',
    },
    'eh0jguiu': {
      'pt':
          'Qual é o principal diferencial de sua empresa em relação aos concorrentes?',
      'en': 'What feature do people most praise about your product/company?',
    },
    '5pfhswuq': {
      'pt':
          'Liste o site/perfil de pelo menos 3 concorrentes ou empresas que você considera exemplar no seu setor. ',
      'en': 'What feature do people most praise about your product/company?',
    },
    'erznve42': {
      'pt':
          'Selecione até 3 adjetivos que melhor descrevem a imagem que sua empresa deseja transmitir',
      'en':
          'Select up to 3 adjectives that best describe the image your company wants to convey.',
    },
    'klng7c7l': {
      'pt': 'Confiável',
      'en': 'Reliable',
    },
    'gr1pbnef': {
      'pt': 'Inovadora',
      'en': 'Innovative',
    },
    'nsg8eu5y': {
      'pt': 'Premium',
      'en': 'Premium',
    },
    '30o8d2h2': {
      'pt': 'Sustentável',
      'en': 'Sustainable',
    },
    'zgz42hfl': {
      'pt': 'Acessível',
      'en': 'Accessible',
    },
    'j9ak3tg8': {
      'pt': 'Exclusiva',
      'en': 'Exclusive',
    },
    'gg8xeomd': {
      'pt': 'Moderna',
      'en': 'Modern',
    },
    'iucdiup7': {
      'pt': 'Tradicional',
      'en': 'Traditional',
    },
    'wscqywjr': {
      'pt': 'Rápida',
      'en': 'Quick',
    },
    'y5c4xlqp': {
      'pt': 'Criativa',
      'en': 'Creative',
    },
    'n5sg85sy': {
      'pt': 'Jovem',
      'en': 'Young',
    },
    'zw10m016': {
      'pt': 'Experiente',
      'en': 'Experienced',
    },
    'pomm8ro0': {
      'pt': 'Luxuosa',
      'en': 'Luxurious',
    },
    '4j8qoyhi': {
      'pt': 'Responsável',
      'en': 'Responsible',
    },
    'g4srtp5i': {
      'pt': 'Divertida',
      'en': 'Fun',
    },
    'oupvgyzf': {
      'pt': 'Aventureira',
      'en': 'Adventurer',
    },
    '93owrnya': {
      'pt': 'Dinâmica',
      'en': 'Dynamics',
    },
    '2zh0bgop': {
      'pt': 'Autêntica',
      'en': 'Authentic',
    },
    'do1sbupl': {
      'pt': 'Empática',
      'en': 'Empathetic',
    },
    'l5xv7lsc': {
      'pt': 'Inspiradora',
      'en': 'Inspiring',
    },
    '8ozows3n': {
      'pt': 'Eficiente',
      'en': 'Efficient',
    },
    'v0jdjb5a': {
      'pt': 'Tecnológica',
      'en': 'Technological',
    },
    'pd3894a9': {
      'pt': 'Visionária',
      'en': 'Visionary',
    },
    'chn0v4wg': {
      'pt': 'Séria',
      'en': 'He would be',
    },
    'bx1fkvmw': {
      'pt': 'Simples',
      'en': 'Simple',
    },
    '524ggcvx': {
      'pt': 'Flexível',
      'en': 'Flexible',
    },
    'w2hoha6d': {
      'pt': 'Comprometida',
      'en': 'Committed',
    },
    'rj4iyrxc': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    '4a9xhjox': {
      'pt':
          'Selecione até 3 adjetivos que NÃO correspondem à imagem que sua empresa quer transmitir:',
      'en':
          'Select up to 3 adjectives that DO NOT correspond to the image your company wants to convey:',
    },
    'pzmoi3kx': {
      'pt': 'Dasatualizada',
      'en': 'Outdated',
    },
    'o46hl2px': {
      'pt': 'Barata',
      'en': 'Cheap',
    },
    '4g7q2itk': {
      'pt': 'Comum',
      'en': 'Common',
    },
    '25wpeh82': {
      'pt': 'Tradicional',
      'en': 'Traditional',
    },
    '3fs4gvjg': {
      'pt': 'Lenta',
      'en': 'Slow',
    },
    'wyeez84o': {
      'pt': 'Antiquada',
      'en': 'Old-fashioned',
    },
    'f29od1a9': {
      'pt': 'Inacessível',
      'en': 'Inaccessible',
    },
    'zeguc7dv': {
      'pt': 'Impessoal',
      'en': 'Impersonal',
    },
    'q6sq0zz9': {
      'pt': 'Instável',
      'en': 'Unstable',
    },
    '4b055xia': {
      'pt': 'Arrogante',
      'en': 'Arrogant',
    },
    'k8u21jcx': {
      'pt': 'Conservadora',
      'en': 'Conservative',
    },
    'z9f3ods0': {
      'pt': 'Cara',
      'en': 'Face',
    },
    'aa5271fi': {
      'pt': 'Monótona',
      'en': 'Monotonous',
    },
    'elvo34sr': {
      'pt': 'Burocrática',
      'en': 'Bureaucratic',
    },
    '1i2rzoaa': {
      'pt': 'Rígida',
      'en': 'Rigid',
    },
    '5fb1v1dg': {
      'pt': 'Superficial',
      'en': 'Superficial',
    },
    'w7gdwm6k': {
      'pt': 'Oportunista',
      'en': 'Opportunist',
    },
    'wk72aof5': {
      'pt': 'Agitada',
      'en': 'Agitated',
    },
    '062e0k8r': {
      'pt': 'Confusa',
      'en': 'Confused',
    },
    'ctkq6i5j': {
      'pt': 'Inexperiente',
      'en': 'Inexperienced',
    },
    'ku45kkha': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'i69znko3': {
      'pt': 'Qual é o principal objetivo de sua campanha no Meta Ads?',
      'en': 'What is the predominant gender of your audience?',
    },
    'otu39gb5': {
      'pt': 'Gerar mais vendas online (E-commerce)',
      'en': 'Feminine',
    },
    'a10iv9kt': {
      'pt': ' Gerar leads (contatos de clientes em potencial)',
      'en': 'Masculine',
    },
    'egmb3uox': {
      'pt': 'Aumentar o tráfego do site',
      'en': 'Both equally',
    },
    'c89t0z01': {
      'pt':
          ' Aumentar o engajamento da minha página (curtidas, seguidores, comentários, etc) ',
      'en': '',
    },
    'zw3odsgu': {
      'pt': ' Aumentar o reconhecimento da marca (Branding)',
      'en': '',
    },
    'dk0gz2uz': {
      'pt': 'Levar clientes para a loja física',
      'en': '',
    },
    'hyep88b3': {
      'pt': 'Downloads de apps',
      'en': '',
    },
    '20l6y3ww': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'dn7d97e0': {
      'pt': 'Qual é o gênero predominante do seu público?',
      'en': 'What is the predominant gender of your audience?',
    },
    'j9qkbza0': {
      'pt': 'Feminino',
      'en': 'Feminine',
    },
    '59bcak7n': {
      'pt': 'Masculino',
      'en': 'Masculine',
    },
    'ekdaxv2t': {
      'pt': 'Ambos igualmente',
      'en': 'Both equally',
    },
    '0uztmhn2': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'jr2hero7': {
      'pt': 'Quais são as faixas etárias predominantes do seu público médio?',
      'en': 'What are the predominant age groups of your average audience?',
    },
    '6nayo1i9': {
      'pt': '13-17 anos',
      'en': '13-17 years old',
    },
    'gsf5bi72': {
      'pt': '18-24 anos',
      'en': '18-24 years old',
    },
    'zsof93og': {
      'pt': '25-34 anos',
      'en': '25-34 years old',
    },
    'se2et9g1': {
      'pt': '35-44 anos',
      'en': '35-44 years old',
    },
    '05latdoa': {
      'pt': '45-54 anos',
      'en': '45-54 years old',
    },
    '423clet5': {
      'pt': '55-64 anos',
      'en': '55-64 years old',
    },
    'i2dznw8w': {
      'pt': 'Acima de 65 anos',
      'en': 'Over 65 years old',
    },
    '55rala8w': {
      'pt': 'Qual a localização geográfica do seu público-alvo?',
      'en': 'What feature do people most praise about your product/company?',
    },
    'lxyf0fu4': {
      'pt':
          'Você identifica padrões de interesses referente ao seu público-alvo?',
      'en': 'What feature do people most praise about your product/company?',
    },
    'aplltg8d': {
      'pt':
          'Você identifica padrões de comportamento referente ao seu público-alvo?',
      'en': 'What feature do people most praise about your product/company?',
    },
    'p58j4oeg': {
      'pt':
          'Como é caracterizada a interação do seu cliente com a sua empresa? (Selecione até três opções)',
      'en':
          'How is your customer\'s interaction with your company characterized? (Select up to three options)',
    },
    'qzv3197q': {
      'pt': 'Compra planejada',
      'en': 'Planned purchase',
    },
    'k0phfzqq': {
      'pt': 'Compra por impulso',
      'en': 'Impulse buying',
    },
    '1x4s5o93': {
      'pt': 'Compra recorrente',
      'en': 'Recurring purchase',
    },
    't9fctuj0': {
      'pt': 'Compra ocasional',
      'en': 'Occasional purchase',
    },
    '9xgh8ie8': {
      'pt': 'Compra por indicação',
      'en': 'Purchase by referral',
    },
    '1ig4xp20': {
      'pt': 'Compra por necessidade imediata',
      'en': 'Purchase due to immediate need',
    },
    '9fb135l4': {
      'pt': 'Compra baseada em promoções',
      'en': 'Promotion-based purchasing',
    },
    '3ytr57ga': {
      'pt': 'Compra baseada em experiencia anterior',
      'en': 'Purchase based on previous experience',
    },
    'mnsci0hx': {
      'pt': 'Compra baseada em relacionamento',
      'en': 'Relationship-based purchasing',
    },
    'o6z7hgco': {
      'pt': 'Compra agendada',
      'en': 'Scheduled purchase',
    },
    'nfxj4flf': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    '84kohwxx': {
      'pt':
          'Quem é o principal segmento consumidor dos seus produtos/serviços? (Selecione até duas opções)',
      'en':
          'Who is the main consumer segment of your products/services? (Select up to two options)',
    },
    'rble2nc6': {
      'pt': 'Consumidor final (B2C)',
      'en': 'End consumer (B2C)',
    },
    'vqgos1dv': {
      'pt': 'Varejistas',
      'en': 'Retailers',
    },
    'ogemy61f': {
      'pt': 'Distribuidores',
      'en': 'Distributors',
    },
    'mc0etb06': {
      'pt': 'Empresas (B2B)',
      'en': 'Companies (B2B)',
    },
    'nduwmu7e': {
      'pt': 'Setor Público (governo, orgãos públicos)',
      'en': 'Public Sector (government, public agencies)',
    },
    'jd243to3': {
      'pt': 'Prestadores de serviços',
      'en': 'Service providers',
    },
    'rjkl3ozh': {
      'pt': 'Indústrias',
      'en': 'Industries',
    },
    'hhcxdr8u': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'hbq0fh85': {
      'pt':
          'Quais recursos você tem à disposição para criação dos conteúdo? (Selecione quantas opções desejar)',
      'en':
          'Who is the main consumer segment of your products/services? (Select up to two options)',
    },
    '0v4gt2ad': {
      'pt': 'Filmagens com Drone',
      'en': 'End consumer (B2C)',
    },
    'djtdqfl0': {
      'pt': 'Fotos no Drive',
      'en': 'Retailers',
    },
    'vp33mtt2': {
      'pt': 'Banco de Imagens',
      'en': 'Distributors',
    },
    '05tejm36': {
      'pt': 'Disponibilidade para gravações',
      'en': 'Companies (B2B)',
    },
    'u8a1fz5m': {
      'pt': 'Vídeos Prontos',
      'en': 'Public Sector (government, public agencies)',
    },
    '7jolj0eb': {
      'pt': 'Animações/Motions',
      'en': 'Service providers',
    },
    'kvox4b9e': {
      'pt': 'Auidios/Narrações',
      'en': 'Industries',
    },
    'yyk54189': {
      'pt': 'Catálogos/PDFs',
      'en': '',
    },
    'bqldcned': {
      'pt':
          'Qual é o investimento mensal que você planeja para os anúncios no Meta Ads?',
      'en':
          'How is your customer\'s interaction with your company characterized? (Select up to three options)',
    },
    'mcv4tlqe': {
      'pt': 'Até R\$1.000',
      'en': 'Planned purchase',
    },
    '83yv520d': {
      'pt': 'Entre R\$1.001 e R\$2.500',
      'en': 'Impulse buying',
    },
    '2w3f8lok': {
      'pt': 'Entre R\$2.501 e R\$5.000',
      'en': 'Recurring purchase',
    },
    'bqz057nt': {
      'pt': 'Acima de R\$ 5.000',
      'en': 'Occasional purchase',
    },
    't05or6v6': {
      'pt': 'Ainda não sei/Gostaria de uma sugestão',
      'en': 'Purchase by referral',
    },
    'by2tbghw': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'pljs8lzk': {
      'pt':
          'Tem alguma informação adicional que você considera relevante para a análise dos resultados da conta?',
      'en':
          'Do you have any additional information that you consider relevant to analyzing the account results?',
    },
    'ztm9e4x7': {
      'pt': 'Página anterior',
      'en': 'Previous page',
    },
  },
  // contamaster
  {
    '4r9ebukd': {
      'pt': 'Adicionar conta master',
      'en': 'Add guest',
    },
    'r9d1upto': {
      'pt': 'Dê um nome para a conta master',
      'en':
          'Select the user you want to add accounts to from the dropdown below.',
    },
    'fg2skkq6': {
      'pt': 'Admin',
      'en': '',
    },
    'bbpsg0x3': {
      'pt':
          'Selecione as contas abaixo que deseja conectar a conta master e em seguida clique no botão de confirmar',
      'en':
          'Select the accounts below that you want to connect to the selected user and then click the confirm button.',
    },
    'mw6hn3f9': {
      'pt': 'Adicionar contas selecionadas',
      'en': 'Add selected accounts',
    },
  },
  // master-googledemografia
  {
    'u1jdnltn': {
      'pt': 'Visão Geral',
      'en': 'Overview',
    },
    'r5dgad73': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '3xg7gr4e': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'hwr57mwm': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'we9o7vt9': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    'z80zi1wm': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '8ob2j5o2': {
      'pt': 'Análise comparativa por genero',
      'en': 'Daily results',
    },
    'nf3g04f3': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '44cuqeam': {
      'pt': 'Conversões',
      'en': 'Clicks',
    },
    'aki3dhuz': {
      'pt': 'Cliques',
      'en': 'Impressions',
    },
    '92lvc506': {
      'pt': 'Custo',
      'en': 'Impressions',
    },
    'ikx25bdu': {
      'pt': 'Masculino',
      'en': 'Cell phone',
    },
    'nzbh28l6': {
      'pt': 'Feminino',
      'en': 'PRAÇA',
    },
    'u6afadxc': {
      'pt': 'Indefinido',
      'en': 'Tablet',
    },
    '3t80fkuy': {
      'pt': 'Faixa etária',
      'en': '',
    },
    '70uuast5': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    'kn3a0q20': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    'fhzb97yd': {
      'pt': 'Conversões',
      'en': '',
    },
    'whyjkoc9': {
      'pt': 'Custo',
      'en': '',
    },
    'ibste1a8': {
      'pt': '13-17',
      'en': '13-17',
    },
    'ux18us8a': {
      'pt': '18-24',
      'en': '18-24',
    },
    '2ob6dp1g': {
      'pt': '25-34',
      'en': '25-34',
    },
    'smncut76': {
      'pt': '35-44',
      'en': '35-44',
    },
    'fpvrxtvy': {
      'pt': '45-54',
      'en': '45-54',
    },
    'wrmfkboe': {
      'pt': '55-64',
      'en': '55-64',
    },
    'js1mtnqj': {
      'pt': '65+',
      'en': '65+',
    },
    'ixkmadtr': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'fucowfr2': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'tb169mlb': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    'apvpxl70': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    'q8cj4ata': {
      'pt': 'Dias da semana',
      'en': '',
    },
    'mif6pp5y': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    'a6af582b': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    '0r8h75h6': {
      'pt': 'Conversões',
      'en': '',
    },
    'd1ovp2mm': {
      'pt': 'Custo',
      'en': '',
    },
    'r8kiguwz': {
      'pt': 'Segunda',
      'en': '13-17',
    },
    '84d08fl8': {
      'pt': 'Terça',
      'en': '18-24',
    },
    '1ud1merk': {
      'pt': 'Quarta',
      'en': '25-34',
    },
    'mxefp0ru': {
      'pt': 'Quinta',
      'en': '35-44',
    },
    '3dus8ccu': {
      'pt': 'Sexta',
      'en': '45-54',
    },
    'fzit2pcl': {
      'pt': 'Sabado',
      'en': '55-64',
    },
    'eti0jdjg': {
      'pt': 'Domingo',
      'en': '65+',
    },
    'yn8zk3uq': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'edi21g1x': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'aldbh72z': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    'p8vm9ejd': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    'iyz6t7t4': {
      'pt': 'Palavra-chave',
      'en': 'Best Ads',
    },
    '5latxnmy': {
      'pt': '',
      'en': 'Select...',
    },
    'dm56cu5f': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '6v5ypzyh': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '79c2574a': {
      'pt': 'Cliques',
      'en': '',
    },
    'jq9d9e83': {
      'pt': 'Conversões',
      'en': '',
    },
    'vuqrahui': {
      'pt': 'Custo',
      'en': '',
    },
    'aes8lifa': {
      'pt': 'Impressões',
      'en': 'Cost per Thousand',
    },
    '4jtfogx3': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    'hs8gf5cn': {
      'pt': 'Conversões',
      'en': 'Cost per Thousand',
    },
    'swq3m4hs': {
      'pt': 'Custo',
      'en': 'Cost per Thousand',
    },
    '0no5knwl': {
      'pt': 'Termos de Busca',
      'en': 'Best Ads',
    },
    'bs1x2gdf': {
      'pt': '',
      'en': 'Select...',
    },
    '4aril1ax': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'j1lum8xn': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'zolvogo6': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'g5f5kmqs': {
      'pt': 'Conversões',
      'en': 'Amount Spent',
    },
    'uikrotnq': {
      'pt': 'Custo',
      'en': '',
    },
    'xu6kujtu': {
      'pt': 'Impressões',
      'en': 'Cost per Thousand',
    },
    '4bt2cbqd': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    'i7t21ypj': {
      'pt': 'Conversões',
      'en': 'Cost per Thousand',
    },
    'prjfm5ud': {
      'pt': 'Custo',
      'en': 'Cost per Thousand',
    },
    'hf44v2h1': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'oj0d8kzo': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '2d10rs7c': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    '3hi0uvio': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'xqm7gusn': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '9h8opqr8': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '5wf6j9ue': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '7fsxkt4x': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '156c1lkd': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'dbgmb85v': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    'q1yrgejx': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'maawdy32': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'plufuajj': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'f0c9vs8l': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    'ipzd9zpc': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'zj9knzcx': {
      'pt': 'Análise comparativa por genero',
      'en': 'Daily results',
    },
    'vmbh2e9u': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'phwyi0pj': {
      'pt': 'Conversões',
      'en': 'Clicks',
    },
    'joem65ps': {
      'pt': 'Cliques',
      'en': 'Impressions',
    },
    'oek740u6': {
      'pt': 'Custo',
      'en': 'Impressions',
    },
    '8g1e9q6s': {
      'pt': 'Masculino',
      'en': 'Cell phone',
    },
    'wl43rekm': {
      'pt': 'Feminino',
      'en': 'PRAÇA',
    },
    '8apq0tug': {
      'pt': 'Indefinido',
      'en': 'Tablet',
    },
    '951o9c7l': {
      'pt': 'Faixa etária',
      'en': '',
    },
    'adcwvb2l': {
      'pt': 'Impressões',
      'en': 'Women',
    },
    'pah6iypi': {
      'pt': 'Cliques',
      'en': 'Indefinite',
    },
    '3a7x7zaz': {
      'pt': 'Conversões',
      'en': '',
    },
    '7i14avkp': {
      'pt': 'Custo',
      'en': '',
    },
    'dopnkkgn': {
      'pt': '13-17',
      'en': '13-17',
    },
    'd2pi179m': {
      'pt': '18-24',
      'en': '18-24',
    },
    '71ebm4gt': {
      'pt': '25-34',
      'en': '25-34',
    },
    'tk7bobcm': {
      'pt': '35-44',
      'en': '35-44',
    },
    'n7p2x3ao': {
      'pt': '45-54',
      'en': '45-54',
    },
    'dg931m2v': {
      'pt': '55-64',
      'en': '55-64',
    },
    'wcq09iwe': {
      'pt': '65+',
      'en': '65+',
    },
    'dwvtn8wi': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'h8a86g66': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    '5vwjlis9': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    '5o7xcma1': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    'hoxa0vpf': {
      'pt': 'Dias da semana',
      'en': '',
    },
    'daxyqbqp': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'otbvg663': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    'y1d2tk0t': {
      'pt': 'Seg',
      'en': '13-17',
    },
    '9licdvvn': {
      'pt': 'Ter',
      'en': '18-24',
    },
    'rurkrjqk': {
      'pt': 'Qua',
      'en': '25-34',
    },
    's57o2br8': {
      'pt': 'Qui',
      'en': '35-44',
    },
    'i8ob1i18': {
      'pt': 'Sex',
      'en': '45-54',
    },
    'zzy4azkl': {
      'pt': 'Sab',
      'en': '55-64',
    },
    'ld6jwnrd': {
      'pt': 'Dom',
      'en': '65+',
    },
    'bo8n1k6q': {
      'pt': 'Impressões',
      'en': 'Cell phone',
    },
    'ja9d26yo': {
      'pt': 'Cliques',
      'en': 'PRAÇA',
    },
    'xotypbo6': {
      'pt': 'Conversões',
      'en': 'Tablet',
    },
    '7wow0hyo': {
      'pt': 'Custo',
      'en': 'Tablet',
    },
    '67uv0mh6': {
      'pt': 'Palavra-chave',
      'en': 'Best Ads',
    },
    'yz73vhgy': {
      'pt': '',
      'en': 'Select...',
    },
    'shufq432': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '2iz4frmi': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ts8lbtaa': {
      'pt': 'Cliques',
      'en': '',
    },
    'pct43akx': {
      'pt': 'Conversões',
      'en': '',
    },
    '5yhiid3f': {
      'pt': 'Custo',
      'en': '',
    },
    '6cqfvajs': {
      'pt': 'Impressões',
      'en': 'Cost per Thousand',
    },
    '8iid1cr0': {
      'pt': 'Conversões',
      'en': 'Cost per Thousand',
    },
    '66bsjbev': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    '8gaqbjso': {
      'pt': 'Custo',
      'en': 'Cost per Thousand',
    },
    'zle5xw2b': {
      'pt': 'Termos de busca',
      'en': 'Best Ads',
    },
    '85mr9zrw': {
      'pt': '',
      'en': 'Select...',
    },
    '5juyrnp8': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'raz71ubw': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '73ozow89': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'qhayllnz': {
      'pt': 'Conversões',
      'en': '',
    },
    '2aw4rti1': {
      'pt': 'Custo',
      'en': '',
    },
    'sy2we1s0': {
      'pt': 'Impressões',
      'en': 'Cost per Thousand',
    },
    'nq0unsxf': {
      'pt': 'Conversões',
      'en': 'Cost per Thousand',
    },
    '8xnkd08a': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    'cf4iyasx': {
      'pt': 'Custo',
      'en': 'Cost per Thousand',
    },
    'qgg77p78': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'lmyyplyo': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'lsuxur5g': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'ydf6ie4w': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'c4vyc0ld': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '1kfuifwv': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'vdfanzqc': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'mc9cqki2': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'ephuq9dy': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
  },
  // master-googleinsights
  {
    'esp9ymfn': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    'qmg2d5e0': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'nr5je0mq': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'gatw8up4': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'n6iqikl4': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    '4m18pdfp': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'kk67mhgo': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    '542pz656': {
      'pt': 'Impressões',
      'en': '',
    },
    'smbjb996': {
      'pt': 'Cliques',
      'en': '',
    },
    'pe042mbd': {
      'pt': 'Conversões',
      'en': '',
    },
    's3f0bby1': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'puyemyau': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'kgtzhus3': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'ailycjv6': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    '8s7zd60x': {
      'pt': 'Taxa de jornada',
      'en': 'Journey rate',
    },
    'am0nzppw': {
      'pt': 'Custo total',
      'en': 'Total cost',
    },
    'zl20lwwz': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    't73rs6gv': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '76syqnl6': {
      'pt': 'Custo por conversão',
      'en': 'Cost per conversion',
    },
    'pv3hbsm6': {
      'pt': 'Taxa de cliques',
      'en': 'Click-through rate',
    },
    'y5lvk9bh': {
      'pt': 'Taxa de conversão',
      'en': 'Conversion rate',
    },
    'yvzxb99m': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    'cxb1kq42': {
      'pt': '',
      'en': 'Select...',
    },
    '358421mr': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '9r80r21a': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '03facfe9': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    'x47xdfeq': {
      'pt': 'Conversões',
      'en': 'Clicks',
    },
    '1vl6l5w6': {
      'pt': 'Custo total ',
      'en': 'Cost per Click',
    },
    'v2fqupi9': {
      'pt': 'Custo por mil',
      'en': 'Results',
    },
    'hamr7jsb': {
      'pt': 'Custo por clique',
      'en': 'Cost per result',
    },
    'tczcwpkq': {
      'pt': 'Custo por conversão',
      'en': 'Likes',
    },
    'axt7hzsp': {
      'pt': 'Taxa de cliques',
      'en': 'Comments',
    },
    '4hxew904': {
      'pt': 'Taxa de conversão',
      'en': 'Reactions',
    },
    'p6gr7bow': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'c672hhqg': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'e2bc4x6u': {
      'pt': 'Análise por dispositivo',
      'en': 'Comparative analysis by device',
    },
    'c6znmfz5': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'jsb0zhzm': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'pf7j8whz': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    'rxtwkk94': {
      'pt': 'Custo',
      'en': 'Cost',
    },
    '0r24ck4y': {
      'pt': 'Celular',
      'en': 'Cell phone',
    },
    'au8rlkwv': {
      'pt': 'PC',
      'en': 'PRAÇA',
    },
    'vxlqdd2q': {
      'pt': 'Tablet',
      'en': 'Tablet',
    },
    '8ykn2s70': {
      'pt': 'TV',
      'en': 'Cell phone',
    },
    'y6tcbuii': {
      'pt': 'Outros',
      'en': 'Cell phone',
    },
    'csoorcqr': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'ewp1kzpi': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'f8pv60qm': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    '4uhttc6k': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '7o90u35d': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'fw81wuuj': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'lxnnfjag': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'zxzchluu': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'jtd76r4x': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'kbck7iau': {
      'pt': 'Visão Geral',
      'en': 'Overview',
    },
    '4jx5irup': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'i5wbvtoi': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'orkvaqvj': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'xy7o2h4j': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    '7qi0j9l4': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'cd6lazl6': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'rrzzzqr4': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '2x46921d': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'cgmy4aau': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    '3y7t7dzr': {
      'pt': 'Taxa de jornada',
      'en': 'Journey rate',
    },
    'fop0e65u': {
      'pt': 'Custo total',
      'en': 'Total cost',
    },
    't1p3off5': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    '6602omgg': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '1t7mzmqo': {
      'pt': 'Custo por conversão',
      'en': 'Cost per conversion',
    },
    'krnsdwfm': {
      'pt': 'Taxa de cliques',
      'en': 'Click-through rate',
    },
    'u28zjj8r': {
      'pt': 'Taxa de conversão',
      'en': 'Conversion rate',
    },
    '4r2cku27': {
      'pt': 'Funil de marketing',
      'en': 'Daily results',
    },
    'yhchqc9l': {
      'pt': 'Impressões',
      'en': '',
    },
    'vob0ktyp': {
      'pt': 'Cliques',
      'en': '',
    },
    'd6v9fb3m': {
      'pt': 'Conversões',
      'en': '',
    },
    'znrxy3xu': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    'hrmr94oz': {
      'pt': '',
      'en': 'Select...',
    },
    'zdphz6pl': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '4jnwbz4y': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'cotjevop': {
      'pt': 'Cliques',
      'en': 'Cost per Thousand',
    },
    '34395za5': {
      'pt': 'Conversões',
      'en': 'Clicks',
    },
    'sfazugvf': {
      'pt': 'Custo total ',
      'en': 'Cost per Click',
    },
    'u7dmcdai': {
      'pt': 'Custo por mil',
      'en': 'Results',
    },
    'ssnu8gjy': {
      'pt': 'Custo por clique',
      'en': 'Cost per result',
    },
    'k630j0zt': {
      'pt': 'Custo por conversão',
      'en': 'Likes',
    },
    '8n9xtyu9': {
      'pt': 'Taxa de cliques',
      'en': 'Comments',
    },
    'bpoq2g8w': {
      'pt': 'Taxa de conversão',
      'en': 'Reactions',
    },
    'cauhkarq': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'api6xtur': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'm1ia8slu': {
      'pt': 'Análise comparativa por dispositivo',
      'en': 'Comparative analysis by device',
    },
    'd5ypgzg7': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'lc2ymmb0': {
      'pt': 'Conversões',
      'en': 'Conversions',
    },
    'm9x2okbb': {
      'pt': 'Custo',
      'en': 'Cost',
    },
    'v8tuycyg': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ab5iajv1': {
      'pt': 'Celular',
      'en': 'Cell phone',
    },
    'y3gsa302': {
      'pt': 'PC',
      'en': 'PRAÇA',
    },
    'kjiyrj4y': {
      'pt': 'Tablet',
      'en': 'Tablet',
    },
    '6znqfxbt': {
      'pt': 'TV',
      'en': 'Cell phone',
    },
    'julgagrp': {
      'pt': 'Outros',
      'en': 'Cell phone',
    },
    'aveuacbh': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'vxanwex3': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'qg1h9wmv': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'sy2yhz6m': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '5g3ziufp': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'eka9xbvy': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'by1u8aaj': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'b6n7ucji': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'q5b3jtwf': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
  },
  // master-metaads
  {
    'bqbiq4mw': {
      'pt': 'Resultados dos anúncios',
      'en': 'Ad results',
    },
    'qyyaiux3': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '38s02olj': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'tbhec8q6': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    'ced363sg': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    '2ld2b5qm': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'vybqukon': {
      'pt': 'Média',
      'en': 'Average',
    },
    'wpgkt15z': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'zebsczfg': {
      'pt': 'Conjunto de Anúncios',
      'en': 'Ad Set',
    },
    'ysrvm4mj': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '0628asie': {
      'pt': 'Média',
      'en': 'Average',
    },
    'g3opqkf9': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    '925gxet4': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    'u5oh0831': {
      'pt': 'Impressões',
      'en': '',
    },
    'yhrpvsk2': {
      'pt': 'Cliques',
      'en': '',
    },
    '6mgztfjn': {
      'pt': 'Conversões',
      'en': '',
    },
    'dqu6mpb8': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'xsoa0xb0': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '73jb3qyx': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    '2fmva8m7': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'nzesh4ye': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'z09v7p2f': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'occjr4gf': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    'ntl6e0um': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '3dj48y7f': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '0omhbz9n': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'ym6yfcwl': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'i6dioagp': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'dh6pcxx6': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'n0n7nj09': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    '7chlu9mg': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'murnjyv1': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    'uketyqby': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'y456vn2p': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    '2fq89h1y': {
      'pt': '',
      'en': 'Select...',
    },
    'fbsarruv': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'cl3t4z8u': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'vno59wgz': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    'j6uudc42': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'twe2iiuf': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '3o61gmdy': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '9sys1to1': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    'xn0f7rg5': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'bikj4f4d': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '4ixitx6u': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'cvqk8cfv': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '7kaaedgq': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    '6cxqhlgt': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'lotl90qe': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    '1x68zl77': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'k43hik5d': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'yuxgwclq': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'fsp6g4sy': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    '682ta735': {
      'pt': 'Melhores Anúncios',
      'en': 'Best Ads',
    },
    'nuvmfwhp': {
      'pt': '',
      'en': 'Select...',
    },
    'rv8rntz7': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'r2x7wmy1': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'owkl12qg': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    'vqp9axpl': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    '4o318vil': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '8zykav39': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'kuaijoa5': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    'jatj8dg9': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'vuoe12pc': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'ngeredxn': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    '6bbvvh49': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'f2ajw7ku': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'm3jxqift': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'tubskkwn': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'fa09jcxl': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'fxh6dgly': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'w6ibclf2': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    '06ij03j2': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'pyo5npzx': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '4aqi51q2': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'zbwuygz3': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'ez9uerei': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'b7agvl37': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '6yg4eckz': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'sgub731v': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '110w9e5x': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'caoimh3u': {
      'pt': 'Resultados dos anúncios',
      'en': 'Ad results',
    },
    '0vj6fg4m': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'fkjduoox': {
      'pt': 'Filtrar Anúncios',
      'en': 'Filter Ads',
    },
    'ly1eu12f': {
      'pt': 'Remover filtros',
      'en': 'Remove filters',
    },
    '71712w8o': {
      'pt': 'Campanha',
      'en': 'Campaign',
    },
    'vib9t1oz': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'fnfczygw': {
      'pt': 'Média',
      'en': 'Average',
    },
    '0vf49z1g': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'n6f03czn': {
      'pt': 'Conjunto de Anúncios',
      'en': 'Ad Set',
    },
    'a8rvpvso': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'ff4y3o2k': {
      'pt': 'Média',
      'en': 'Average',
    },
    '1pol6pxa': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'hrqm915y': {
      'pt': 'Funil de marketing',
      'en': 'Best Ads',
    },
    '430jnjrs': {
      'pt': 'Impressões',
      'en': '',
    },
    '1z5us2mi': {
      'pt': 'Cliques',
      'en': '',
    },
    'pa8tsgyv': {
      'pt': 'Conversões',
      'en': '',
    },
    'ni8j3jl9': {
      'pt': 'Melhores Anúncios',
      'en': 'Best Ads',
    },
    'ipqmikdo': {
      'pt': '',
      'en': 'Select...',
    },
    'rl8t91r1': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'e6ngyj4x': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'tnm953ne': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    'k9blh4rs': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'xeg4w4x2': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '0sx1pq5o': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'hkd50zqd': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    'ifke46v2': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'rw49d85i': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'ftjginad': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    '4l5r8brq': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'fdv70hv3': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'tl40yijx': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    '2ddng8dk': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'hzo11h36': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    '0bqsu65u': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'yhx5dt5g': {
      'pt': 'Ver Anúncio',
      'en': 'View Ad',
    },
    'qur3ufpl': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'fo7l5z32': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'z5aa3c5g': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'ox6h5gj6': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'zm0k408k': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '3onmkh53': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'xp8gs9p6': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    'p1n0scda': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'wx9n0ktc': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'h61yii3z': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'vts7w8p1': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'f6gopxh2': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'et0tmoqq': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'guakf1mh': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'z61r9zg2': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'mzgdf7jo': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    '2mb2cck0': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    '89jcjxi2': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    '9lfszm8b': {
      'pt': '',
      'en': 'Select...',
    },
    '8o6yvv7j': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'gopr3q1a': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'fkpwv6sp': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    'zm2oikri': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'mx7r90yn': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'c2z7uitu': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'pppcp0ta': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    'zy9ao7qd': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '89ool2b6': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'z39emaxn': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'inmunbgi': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '6v1h91o3': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'akrph7u4': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'g4o3x5kt': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'k7droekp': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'irpj42pi': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'pimai62g': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    '7a5uzw87': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'i60ton3i': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '7bingfry': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '53dyu7io': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'n3bbi1os': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'q95e0oa4': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '64fwt4cp': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'kg75x0ai': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '7to623cy': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'dk71uyhr': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // master-metaadsconjuntos
  {
    'gprh3rbr': {
      'pt': 'Configurações de Campanhas',
      'en': 'Campaign Settings',
    },
    'y1sc6c09': {
      'pt': 'Campanhas Ativas',
      'en': 'Active Campaigns',
    },
    'gn9sp93g': {
      'pt': 'Campanhas Inativas',
      'en': 'Active Campaigns',
    },
    'fol4k904': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'nlomdci2': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'tzvrj8oh': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'u9ai5no5': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'pa2mcwvg': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '1ewie7p1': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'nf00yxh0': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'pye5ofb8': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'h6bmbbf7': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    '9m2zuluj': {
      'pt': 'Configurações de Campanhas',
      'en': 'Campaign Settings',
    },
    'tb6wntmg': {
      'pt': 'Campanhas Ativas',
      'en': 'Active Campaigns',
    },
    '6w3anl6x': {
      'pt': 'Campanhas Inativas',
      'en': 'Active Campaigns',
    },
    '4b91wlvk': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'vr21ik0m': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'yeefx3ls': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '8wpw30ki': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'xe23quea': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '5haritcw': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'vkph78no': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '4blkigvq': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'wosk6zou': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // master-metaadscriativos
  {
    'uzp83yy4': {
      'pt': 'Resultados do Criativo',
      'en': 'Creative Results',
    },
    'sh747820': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'el7e8omy': {
      'pt': 'Objetivos',
      'en': 'Objectives',
    },
    '8vm99c78': {
      'pt': 'Meta de Otimização',
      'en': 'Optimization Goal',
    },
    '9bazan87': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    'r7k8uyyu': {
      'pt': '',
      'en': 'Select...',
    },
    '8b7oh8q6': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'lwq8724f': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'fac2pz4a': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    '3j0c5x5i': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'spk3klbg': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'mkqhr52k': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'aa19l968': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    '4pulapev': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'tnocjvul': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'y35uwcnm': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    '21x118fe': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'ypq3q4am': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    '04fe9a9z': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'ttxov2ci': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'aye8dmx6': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    '5ougbnz9': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'e2trc5ay': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'w9tabcon': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    '2kcxb6zg': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'czrfxcnl': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '5m9gboiu': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    '4zib58se': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'np42a95k': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'mxigeuw2': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '84tdb2ju': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    'vvdqosbf': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'o5tef0c9': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'rm41cc0n': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'sk4cci51': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'a8cpggg2': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    'slwsi2bs': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    '4zsrs6uj': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'mj8kas2i': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    '5982vics': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    'blwi3cej': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    '1h7zqxi5': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '440lggc6': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '9t65ytme': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'lpo0jgvd': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'f48rkgv6': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'wu3iyp6a': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'bfrer36e': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '5cbq4pbt': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'q2n7pued': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'fpkggtrl': {
      'pt': 'Resultados do Criativo',
      'en': 'Creative Results',
    },
    'abdxr5kh': {
      'pt': 'Objetivos',
      'en': 'Objectives',
    },
    'i2qvn8m1': {
      'pt': 'Meta de Otimização',
      'en': 'Optimization Goal',
    },
    '1125v9ll': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '3he1kshk': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    '41d9a4jz': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'xfl8be5l': {
      'pt': 'Custo por Mil',
      'en': 'Cost per Thousand',
    },
    'y4h8qoum': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'f9yjy4la': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    '08c4wwbw': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'bdhpzpvv': {
      'pt': 'Custo por Resultado',
      'en': 'Cost per Result',
    },
    '0vasm1kq': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'v232mas7': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '1wcqaxfs': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    'vpa94aed': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '2ryd9y4p': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    '7icioi4f': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'oi9xu4hw': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'nqkpzfqs': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'q5x5jiqo': {
      'pt': 'Visualização Média',
      'en': 'Medium View',
    },
    'fl0i8urh': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'ja9v30p2': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    'zdw2bms3': {
      'pt': '',
      'en': 'Select...',
    },
    'z5k3ewmm': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'apma01nm': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    '5x2alljj': {
      'pt': 'Custo po Mil',
      'en': 'Cost per Thousand',
    },
    '9vnhyxtt': {
      'pt': 'Cliques',
      'en': 'Clicks',
    },
    'nwu5eyjo': {
      'pt': 'Custo por Clique',
      'en': 'Cost per Click',
    },
    'gdctsyt0': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'ynj9nme0': {
      'pt': 'Custo por resultado',
      'en': 'Cost per result',
    },
    'pobanzcn': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'xuwry68o': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'kxtlv7lk': {
      'pt': 'Reações',
      'en': 'Reactions',
    },
    's20wao99': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '8mvl4i0m': {
      'pt': 'Engajamento Post',
      'en': 'Post Engagement',
    },
    '8loo8bna': {
      'pt': 'Engajamento Página',
      'en': 'Page Engagement',
    },
    'wdbxkh48': {
      'pt': 'Cliques no Link',
      'en': 'Link Clicks',
    },
    'z3aop4fi': {
      'pt': 'Conversas Iniciadas',
      'en': 'Conversations Started',
    },
    'h50euj67': {
      'pt': 'Valor Gasto',
      'en': 'Amount Spent',
    },
    'ient8g7w': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'fby4bgdv': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'prbsn5lt': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'hljxtgis': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '3j3ij7dk': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'dmdt3gts': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'kpwhsiea': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '9mnbjek6': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '4r5jb9ic': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'ru82zyjv': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '6kowamhx': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // master-instacomentario
  {
    '0u1jfvqy': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'c53eogf4': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'kyzdap65': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    '0taelylq': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    '6lsr7z12': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'oqoe7946': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'chei4wfp': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'kr2hsrkx': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'avzpk3cm': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'dtz6n7sr': {
      'pt': 'comentários',
      'en': 'comments',
    },
    '00als6a4': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'gsum6eme': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'b0db1qtb': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    '3ag1dnez': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'jawzmp2f': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    'qkd1abng': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '89e44iot': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'm4d3ku9t': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'jk0myxv5': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'b9csdi0u': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'rue4y29u': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'uqz1294y': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
  },
  // master-instainsights
  {
    '2kmwz53l': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    '2fho4vf9': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'qi2rb0u0': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    '4xm9z2c6': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    'auw6p5f0': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '69lyyqmi': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'ast9aotd': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'b87y1tv2': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'xh8owi3g': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '6bl959xi': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'xs68hhnu': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'txwqe1la': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'qpqsh7zs': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'c7h4tw8i': {
      'pt': 'Indisponível',
      'en': 'Unavailable',
    },
    '4rvirwca': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    '6u1a2a0x': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    'ma9omddt': {
      'pt': 'Select...',
      'en': 'Select...',
    },
    '49zr3ck4': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'hjnfc22b': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'ufhz3s97': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'wc8ep9d5': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'ojadiy2k': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    '77iry4au': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'y7kaceyx': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '7opc8cc6': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    '9urhbi77': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'ee0i64uw': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'ymfr6xla': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'ro7xivnf': {
      'pt': 'Demografia',
      'en': 'Demography',
    },
    'tzazpkb5': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'jrax9kby': {
      'pt': 'Homens',
      'en': 'Men',
    },
    '07fh2jll': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    '4omudae2': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    'cyk85cjh': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'mlydtek6': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'bhn5ctu0': {
      'pt': '13-17',
      'en': '13-17',
    },
    '15r7rgc3': {
      'pt': '18-24',
      'en': '18-24',
    },
    'giaav4v1': {
      'pt': '25-34',
      'en': '25-34',
    },
    'flfcm8ve': {
      'pt': '35-44',
      'en': '35-44',
    },
    'tqs137ls': {
      'pt': '45-54',
      'en': '45-54',
    },
    '7j91ou9e': {
      'pt': '55-64',
      'en': '55-64',
    },
    'o4fxmhy1': {
      'pt': '65+',
      'en': '65+',
    },
    'sb4bqebg': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'edioa26k': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'urwconmi': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'entdck3h': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'j6yt5vfg': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'svcq7e3k': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'lrbfmbao': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '7ojrt9de': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'wvlrrh1t': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'jue8m26a': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'lydj5frx': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'oxxie4i5': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'wgi909qd': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    '8vtv88qv': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    '5fu8uzsq': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'gnjxs3gm': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'nqct2ebd': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'uczih74e': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'f4uztgve': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'ctzdr11n': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'l7ya0t8s': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'j5j5zmf1': {
      'pt': 'Indisponível',
      'en': 'Unavailable',
    },
    'f1xv4atr': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'jxm9y30w': {
      'pt': 'Resultados diários',
      'en': 'Daily results',
    },
    '6s18q8kj': {
      'pt': 'Select...',
      'en': 'Select...',
    },
    'bkay6wur': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '6lzuh7mf': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'pwvoj843': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '7sr28dlc': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    '2wag5mpn': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    '5w0z6d5z': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '8nom3mg1': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'c1072s9i': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'dj9eivcw': {
      'pt': 'Contas Engajadas',
      'en': 'Engaged Accounts',
    },
    'qsgp204j': {
      'pt': 'Período atual',
      'en': 'Current period',
    },
    'c77998n0': {
      'pt': 'Período anterior',
      'en': 'Previous period',
    },
    'sfvf5kfl': {
      'pt': 'Demografia - Gênero',
      'en': 'Demographics - Gender',
    },
    'l6v802om': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'pq0hdn9u': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'tbxncitd': {
      'pt': 'Indefinido',
      'en': 'Indefinite',
    },
    'qp67ky6w': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'excx31zr': {
      'pt': 'Demografia - Gênero e Idade',
      'en': 'Demographics - Gender and Age',
    },
    'towi5v1x': {
      'pt': 'Homens',
      'en': 'Men',
    },
    'nsb6iywf': {
      'pt': 'Mulheres',
      'en': 'Women',
    },
    'flrfnxrb': {
      'pt': '13-17',
      'en': '13-17',
    },
    'juy5e7zs': {
      'pt': '18-24',
      'en': '18-24',
    },
    '2a95i8gt': {
      'pt': '25-34',
      'en': '25-34',
    },
    'kzck5t4b': {
      'pt': '35-44',
      'en': '35-44',
    },
    'bawaxb1m': {
      'pt': '45-54',
      'en': '45-54',
    },
    '089ed5em': {
      'pt': '55-64',
      'en': '55-64',
    },
    '43jer7ac': {
      'pt': '65+',
      'en': '65+',
    },
    'se9vrj2v': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'yx2z6cma': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'fq8n04wu': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'd8kpkdo5': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'j8as1l8b': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'jizpbzj4': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '8e0m2of4': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'bheo9ttb': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'v4iql68u': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // master-instapost
  {
    'mj1h7gsz': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'xtdm4nw6': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'fp192sho': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'nwbw23iv': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    '4mdvcgwz': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'x1w1l1f9': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    'e0khnlfy': {
      'pt': '',
      'en': '',
    },
    '8k31gkrd': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'oa1tpenv': {
      'pt': 'Média',
      'en': 'Average',
    },
    'cfmgkyhn': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    'ugrllm9i': {
      'pt': 'Imagem',
      'en': 'Image',
    },
    'ycaqugi7': {
      'pt': 'Carrossel',
      'en': 'Carousel',
    },
    '0oluevs9': {
      'pt': 'Vídeo',
      'en': 'Video',
    },
    '7if1g6fm': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    '5ucc9bar': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'w9yvyul7': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '6a2iqcat': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'qh644ymn': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'n4andnor': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'gmitjia9': {
      'pt': 'Melhores Posts',
      'en': 'Best Posts',
    },
    'xipxss6f': {
      'pt': '',
      'en': '',
    },
    'wzei97zc': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '1hcmxp73': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    '36ff4mlr': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'gjlmy2ig': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'ud9hlvsv': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'wuwb3zbw': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'z2hzkmj7': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '4ce5wr7i': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'dguk6cjr': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'rpln9sz9': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '37ku9vxg': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '9gy4lw0m': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    '88nw3uhj': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'gtr84w2f': {
      'pt': 'Ver todos os comentários',
      'en': 'See all comments',
    },
    'in3xz1df': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'cpanorug': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'abfwkq7g': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '351ewjfh': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'zbk9pso1': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'usavjxcc': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '7la3i16q': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '1pdyn1co': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'l10nduyo': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'uttvej0a': {
      'pt': 'Seguidores',
      'en': 'Followers',
    },
    'lj8zol65': {
      'pt': 'Posts',
      'en': 'Posts',
    },
    'qjoeqmij': {
      'pt': 'Seguindo',
      'en': 'Following',
    },
    'dch5jz1b': {
      'pt': 'Resultados da página',
      'en': 'Page results',
    },
    '2lt1jgvf': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'ciq919d7': {
      'pt': 'Dados descritivos',
      'en': 'Descriptive data',
    },
    '3yzglfvp': {
      'pt': '',
      'en': '',
    },
    '2phw7kdf': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    'svauu0pp': {
      'pt': 'Média',
      'en': 'Average',
    },
    '84bpbsl2': {
      'pt': 'Soma',
      'en': 'Sum',
    },
    '71cs9v4f': {
      'pt': 'Imagem',
      'en': 'Image',
    },
    'u3j3gwue': {
      'pt': 'Carrossel',
      'en': 'Carousel',
    },
    'b6d335im': {
      'pt': 'Vídeo',
      'en': 'Video',
    },
    '6wm47bfe': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'rp1j4gvy': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'kht8vyxd': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    '87cheee8': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '5gwlo8zm': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'exxd8paz': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'v0qwdghp': {
      'pt': 'Melhores Posts',
      'en': 'Best Posts',
    },
    'zsnsaofe': {
      'pt': '',
      'en': '',
    },
    'xiui7db5': {
      'pt': 'Search...',
      'en': 'Search...',
    },
    '1mp2smxv': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    'w3pioped': {
      'pt': 'Impressões',
      'en': 'Impressions',
    },
    'ialu6u76': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'cs7xjay1': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'ze8jpdvq': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'chjpsd6r': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    '9ytx93a5': {
      'pt': 'Alcance',
      'en': 'Scope',
    },
    '414eb5oe': {
      'pt': 'Visualizações',
      'en': 'Views',
    },
    'ghxolcn7': {
      'pt': 'Likes',
      'en': 'Likes',
    },
    'c0fc1kp7': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'aghf5k1j': {
      'pt': 'Engajamento',
      'en': 'Engagement',
    },
    'oraa9v83': {
      'pt': 'Compartilhamentos',
      'en': 'Shares',
    },
    'l0rckq06': {
      'pt': 'Ver todos os comentários',
      'en': 'See all comments',
    },
    'qh0bwsnn': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '3a9iwk9o': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'xk5z6w1i': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '0q9ctvdi': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'mtpdqgbh': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'qjbnq8qj': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'hfokqzdt': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'scewnpoe': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '3hqmwjeg': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // master-estrategia
  {
    'v364m082': {
      'pt': 'Questão',
      'en': 'Question',
    },
    'dtt487kl': {
      'pt': '',
      'en': '',
    },
    'yggeb5o8': {
      'pt': 'Explique de maneira curta o que sua empresa faz',
      'en': 'Briefly explain what your company does',
    },
    'brzumwyc': {
      'pt':
          'Liste o site/perfil de pelo menos 3 concorrentes ou empresas que você considera exemplar no seu setor. ',
      'en': 'What feature do people most praise about your product/company?',
    },
    'ammz616r': {
      'pt':
          'Qual é o principal diferencial de sua empresa em relação aos concorrentes?',
      'en': 'What feature do people most praise about your product/company?',
    },
    'ox4gi9e0': {
      'pt':
          'Quais são os principais produtos ou serviços que você deseja anunciar no Google?',
      'en': 'Briefly explain what your company does',
    },
    'gxhxyoem': {
      'pt':
          'Quais são os principais produtos ou serviços que você deseja anunciar no Meta?',
      'en': 'Briefly explain what your company does',
    },
    '8o6m28uj': {
      'pt':
          'Selecione até 3 adjetivos que melhor descrevem a imagem que sua empresa deseja transmitir',
      'en':
          'Select up to 3 adjectives that best describe the image your company wants to convey.',
    },
    'gib46960': {
      'pt': 'Confiável',
      'en': 'Reliable',
    },
    'k5zf566v': {
      'pt': 'Inovadora',
      'en': 'Innovative',
    },
    'qvck0b2j': {
      'pt': 'Premium',
      'en': 'Premium',
    },
    'jn3e4jj8': {
      'pt': 'Sustentável',
      'en': 'Sustainable',
    },
    'kbnfcj1e': {
      'pt': 'Acessível',
      'en': 'Accessible',
    },
    'xyjfvr36': {
      'pt': 'Exclusiva',
      'en': 'Exclusive',
    },
    '20k5zvle': {
      'pt': 'Moderna',
      'en': 'Modern',
    },
    '04p5ho86': {
      'pt': 'Tradicional',
      'en': 'Traditional',
    },
    'zl9uelb4': {
      'pt': 'Rápida',
      'en': 'Quick',
    },
    '2qu9fzzc': {
      'pt': 'Criativa',
      'en': 'Creative',
    },
    '3klhhv6m': {
      'pt': 'Jovem',
      'en': 'Young',
    },
    't5ceio4y': {
      'pt': 'Experiente',
      'en': 'Experienced',
    },
    'h4g78cqb': {
      'pt': 'Luxuosa',
      'en': 'Luxurious',
    },
    'x5dtk8u7': {
      'pt': 'Responsável',
      'en': 'Responsible',
    },
    'i59bgzec': {
      'pt': 'Divertida',
      'en': 'Fun',
    },
    '5jzhn14c': {
      'pt': 'Aventureira',
      'en': 'Adventurer',
    },
    'fwcdu2qt': {
      'pt': 'Dinâmica',
      'en': 'Dynamics',
    },
    'apflm7m3': {
      'pt': 'Autêntica',
      'en': 'Authentic',
    },
    '02782l11': {
      'pt': 'Empática',
      'en': 'Empathetic',
    },
    'wmtihho8': {
      'pt': 'Inspiradora',
      'en': 'Inspiring',
    },
    '3ya4iost': {
      'pt': 'Eficiente',
      'en': 'Efficient',
    },
    'ugr68ums': {
      'pt': 'Tecnológica',
      'en': 'Technological',
    },
    '394ygwh2': {
      'pt': 'Visionária',
      'en': 'Visionary',
    },
    'zlo5fwtd': {
      'pt': 'Séria',
      'en': 'He would be',
    },
    'j1alkj86': {
      'pt': 'Simples',
      'en': 'Simple',
    },
    '5kps892f': {
      'pt': 'Flexível',
      'en': 'Flexible',
    },
    'jl3we8vr': {
      'pt': 'Comprometida',
      'en': 'Committed',
    },
    'i2fpaon4': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'oysitipc': {
      'pt':
          'Selecione até 3 adjetivos que NÃO correspondem à imagem que sua empresa quer transmitir:',
      'en':
          'Select up to 3 adjectives that DO NOT correspond to the image your company wants to convey:',
    },
    'llg3mjg5': {
      'pt': 'Dasatualizada',
      'en': 'Outdated',
    },
    'xn1r5knb': {
      'pt': 'Barata',
      'en': 'Cheap',
    },
    'j2imgj7c': {
      'pt': 'Comum',
      'en': 'Common',
    },
    '5nngopb9': {
      'pt': 'Tradicional',
      'en': 'Traditional',
    },
    'exign378': {
      'pt': 'Lenta',
      'en': 'Slow',
    },
    'j7xzz5iy': {
      'pt': 'Antiquada',
      'en': 'Old-fashioned',
    },
    'wokyy52w': {
      'pt': 'Inacessível',
      'en': 'Inaccessible',
    },
    'qqq7qk2f': {
      'pt': 'Impessoal',
      'en': 'Impersonal',
    },
    '2egqt34a': {
      'pt': 'Instável',
      'en': 'Unstable',
    },
    'zmlbop07': {
      'pt': 'Arrogante',
      'en': 'Arrogant',
    },
    'hk02g76q': {
      'pt': 'Conservadora',
      'en': 'Conservative',
    },
    '8uh0xmiz': {
      'pt': 'Cara',
      'en': 'Face',
    },
    '9ur333vg': {
      'pt': 'Monótona',
      'en': 'Monotonous',
    },
    'gh3q4sqy': {
      'pt': 'Burocrática',
      'en': 'Bureaucratic',
    },
    'cvopitpo': {
      'pt': 'Rígida',
      'en': 'Rigid',
    },
    'tbg8jyus': {
      'pt': 'Superficial',
      'en': 'Superficial',
    },
    'zr2def51': {
      'pt': 'Oportunista',
      'en': 'Opportunist',
    },
    'gy1g0cct': {
      'pt': 'Agitada',
      'en': 'Agitated',
    },
    'ij7til1b': {
      'pt': 'Confusa',
      'en': 'Confused',
    },
    'y63svmmu': {
      'pt': 'Inexperiente',
      'en': 'Inexperienced',
    },
    '1u3cmp3g': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'wzd0kqmd': {
      'pt': 'Liste pelo menos 3 termos que descrevem o seu negócio.',
      'en': 'What feature do people most praise about your product/company?',
    },
    'umdltx3b': {
      'pt':
          'Liste pelo menos 3 termos que você gostaria de desassociar do seu negócio.',
      'en': 'What feature do people most praise about your product/company?',
    },
    'l0yltbmq': {
      'pt': 'Qual é o gênero predominante do seu público?',
      'en': 'What is the predominant gender of your audience?',
    },
    'upwstp1o': {
      'pt': 'Feminino',
      'en': 'Feminine',
    },
    'blnhr8fy': {
      'pt': 'Masculino',
      'en': 'Masculine',
    },
    'gvhcy0kt': {
      'pt': 'Ambos igualmente',
      'en': 'Both equally',
    },
    '3051rshs': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'md94u2wz': {
      'pt': 'Quais são as faixas etárias predominantes do seu público médio?',
      'en': 'What are the predominant age groups of your average audience?',
    },
    'xa8wm2l9': {
      'pt': '13-17 anos',
      'en': '13-17 years old',
    },
    'u1tt9o4e': {
      'pt': '18-24 anos',
      'en': '18-24 years old',
    },
    '5pe2ux2e': {
      'pt': '25-34 anos',
      'en': '25-34 years old',
    },
    '00yalz2n': {
      'pt': '35-44 anos',
      'en': '35-44 years old',
    },
    '4wmbee7v': {
      'pt': '45-54 anos',
      'en': '45-54 years old',
    },
    '5jxjii8j': {
      'pt': '55-64 anos',
      'en': '55-64 years old',
    },
    'y0l1s1p1': {
      'pt': 'Acima de 65 anos',
      'en': 'Over 65 years old',
    },
    '9yk7q720': {
      'pt': 'Qual a localização geográfica do seu público-alvo?',
      'en': 'What feature do people most praise about your product/company?',
    },
    '0ksnz6i8': {
      'pt':
          'Você identifica padrões de interesses referente ao seu público-alvo?',
      'en': 'What feature do people most praise about your product/company?',
    },
    'cqqfnc0n': {
      'pt':
          'Você identifica padrões de comportamento referente ao seu público-alvo?',
      'en': 'What feature do people most praise about your product/company?',
    },
    '6btld9oq': {
      'pt':
          'Como é caracterizada a interação do seu cliente com a sua empresa? (Selecione até três opções)',
      'en':
          'How is your customer\'s interaction with your company characterized? (Select up to three options)',
    },
    'otdm1iuk': {
      'pt': 'Compra planejada',
      'en': 'Planned purchase',
    },
    'xojbklph': {
      'pt': 'Compra por impulso',
      'en': 'Impulse buying',
    },
    '7syyajor': {
      'pt': 'Compra recorrente',
      'en': 'Recurring purchase',
    },
    'd8n10f9x': {
      'pt': 'Compra ocasional',
      'en': 'Occasional purchase',
    },
    'qovmdllf': {
      'pt': 'Compra por indicação',
      'en': 'Purchase by referral',
    },
    'zks7dhh1': {
      'pt': 'Compra por necessidade imediata',
      'en': 'Purchase due to immediate need',
    },
    'x7wn8p0v': {
      'pt': 'Compra baseada em promoções',
      'en': 'Promotion-based purchasing',
    },
    'r8rq1019': {
      'pt': 'Compra baseada em experiencia anterior',
      'en': 'Purchase based on previous experience',
    },
    'sq4kh1hu': {
      'pt': 'Compra baseada em relacionamento',
      'en': 'Relationship-based purchasing',
    },
    '5d7wa2nf': {
      'pt': 'Compra agendada',
      'en': 'Scheduled purchase',
    },
    'gvjfvww2': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'xqzwoj8k': {
      'pt':
          'Quem é o principal segmento consumidor dos seus produtos/serviços? (Selecione até duas opções)',
      'en':
          'Who is the main consumer segment of your products/services? (Select up to two options)',
    },
    'utqmvt6h': {
      'pt': 'Consumidor final (B2C)',
      'en': 'End consumer (B2C)',
    },
    'omewo00d': {
      'pt': 'Varejistas',
      'en': 'Retailers',
    },
    '0r38og1k': {
      'pt': 'Distribuidores',
      'en': 'Distributors',
    },
    'xpca8c7i': {
      'pt': 'Empresas (B2B)',
      'en': 'Companies (B2B)',
    },
    '5e6js748': {
      'pt': 'Setor Público (governo, orgãos públicos)',
      'en': 'Public Sector (government, public agencies)',
    },
    'fsdj09d9': {
      'pt': 'Prestadores de serviços',
      'en': 'Service providers',
    },
    'cgdm2oe4': {
      'pt': 'Indústrias',
      'en': 'Industries',
    },
    'ci8fh1d4': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'o2e25xgh': {
      'pt':
          'Quais os objetivos principais da comunicação nas suas redes sociais? (Selecione até duas opções)',
      'en':
          'What are the main objectives of communication on your social networks? (Select up to two options)',
    },
    's6f9hoe1': {
      'pt': 'Aumentar reconhecimento',
      'en': 'Increase recognition',
    },
    'gpcpx18z': {
      'pt': 'Geração de leads',
      'en': 'Lead generation',
    },
    '9lroi4pv': {
      'pt': 'Venda direta',
      'en': 'Direct sales',
    },
    'z5tty3n1': {
      'pt': 'Fidelização de clientes',
      'en': 'Customer loyalty',
    },
    'aimj3jej': {
      'pt': 'Informar e educar o público',
      'en': 'Inform and educate the public',
    },
    '1al5mjvy': {
      'pt': 'Interagir com o público',
      'en': 'Interact with the public',
    },
    '0npm0bqc': {
      'pt': 'Posicionar como referência',
      'en': 'Position as a reference',
    },
    '4b6zvqla': {
      'pt': 'Divulgar ofertas e promoções',
      'en': 'Promote offers and promotions',
    },
    'wwc7j8y3': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'no9m2zi3': {
      'pt': 'Qual é o principal objetivo de sua campanha no Google Ads?',
      'en': 'What is the predominant gender of your audience?',
    },
    'ph3gozqs': {
      'pt': 'Gerar mais vendas online (E-commerce)',
      'en': 'Feminine',
    },
    'rj7jlqyb': {
      'pt': 'Gerar leads (contatos de clientes em potencial)',
      'en': 'Masculine',
    },
    'h3lc6ok6': {
      'pt': 'Aumentar o tráfego do site',
      'en': 'Both equally',
    },
    '54g44s6t': {
      'pt': 'Aumentar o reconhecimento da marca (Branding)',
      'en': '',
    },
    'hokg6ila': {
      'pt': 'Gerar ligações para a empresa',
      'en': '',
    },
    '4jqoxdnv': {
      'pt': 'Levar clientes para a loja física',
      'en': '',
    },
    'gt66hlsi': {
      'pt': 'Downloads de apps',
      'en': '',
    },
    '1zl9pfaz': {
      'pt': 'Inscritos/Visualizações/Engajamento Youtube',
      'en': '',
    },
    'lqe10vac': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'jgi76ovo': {
      'pt':
          'Qual é o investimento mensal que você planeja para os anúncios no Google Ads?',
      'en':
          'How is your customer\'s interaction with your company characterized? (Select up to three options)',
    },
    'jzyq85tt': {
      'pt': 'Até R\$1.000',
      'en': 'Planned purchase',
    },
    '82kxiq1b': {
      'pt': 'Entre R\$1.001 e R\$2.500',
      'en': 'Impulse buying',
    },
    'tv6wpk95': {
      'pt': 'Entre R\$2.501 e R\$5.000',
      'en': 'Recurring purchase',
    },
    't9wawz34': {
      'pt': 'Acima de R\$ 5.000',
      'en': 'Occasional purchase',
    },
    'f494ztpc': {
      'pt': 'Ainda não sei/Gostaria de uma sugestão',
      'en': 'Purchase by referral',
    },
    'osthd8ql': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'k86cqbcj': {
      'pt': 'Qual é o principal objetivo de sua campanha no Meta Ads?',
      'en': 'What is the predominant gender of your audience?',
    },
    's6xm84hk': {
      'pt': 'Gerar mais vendas online (E-commerce)',
      'en': 'Feminine',
    },
    'nr5pbqmi': {
      'pt': ' Gerar leads (contatos de clientes em potencial)',
      'en': 'Masculine',
    },
    '5n25lq92': {
      'pt': 'Aumentar o tráfego do site',
      'en': 'Both equally',
    },
    'p3evenyv': {
      'pt':
          ' Aumentar o engajamento da minha página (curtidas, seguidores, comentários, etc) ',
      'en': '',
    },
    'ke4zm9od': {
      'pt': ' Aumentar o reconhecimento da marca (Branding)',
      'en': '',
    },
    'idkux8mx': {
      'pt': 'Levar clientes para a loja física',
      'en': '',
    },
    'y1cp3ouh': {
      'pt': 'Downloads de apps',
      'en': '',
    },
    'wveizpxh': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    '4ex62yru': {
      'pt':
          'Qual é o investimento mensal que você planeja para os anúncios no Meta Ads?',
      'en':
          'How is your customer\'s interaction with your company characterized? (Select up to three options)',
    },
    '3nh0m9il': {
      'pt': 'Até R\$1.000',
      'en': 'Planned purchase',
    },
    'hycuzcvu': {
      'pt': 'Entre R\$1.001 e R\$2.500',
      'en': 'Impulse buying',
    },
    'cbzg9xb8': {
      'pt': 'Entre R\$2.501 e R\$5.000',
      'en': 'Recurring purchase',
    },
    '97n0c4fx': {
      'pt': 'Acima de R\$ 5.000',
      'en': 'Occasional purchase',
    },
    'kbjbb2sn': {
      'pt': 'Ainda não sei/Gostaria de uma sugestão',
      'en': 'Purchase by referral',
    },
    'bfs93ohq': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    'sbajiqai': {
      'pt':
          'Quais recursos você tem à disposição para criação dos conteúdo? (Selecione quantas opções desejar)',
      'en':
          'Who is the main consumer segment of your products/services? (Select up to two options)',
    },
    'bwlojx41': {
      'pt': 'Filmagens com Drone',
      'en': 'End consumer (B2C)',
    },
    '925pfxhw': {
      'pt': 'Fotos no Drive',
      'en': 'Retailers',
    },
    '11h9vam0': {
      'pt': 'Banco de Imagens',
      'en': 'Distributors',
    },
    '7yt6rayo': {
      'pt': 'Disponibilidade para gravações',
      'en': 'Companies (B2B)',
    },
    'd3sf7vb2': {
      'pt': 'Vídeos Prontos',
      'en': 'Public Sector (government, public agencies)',
    },
    '3du3sl0k': {
      'pt': 'Animações/Motions',
      'en': 'Service providers',
    },
    '0pv1n6q3': {
      'pt': 'Auidios/Narrações',
      'en': 'Industries',
    },
    'mpd7403c': {
      'pt': 'Catálogos/PDFs',
      'en': '',
    },
    'c4sn8l3i': {
      'pt':
          'Qual é a frequência ideal planejada inicialmente para publicações nas suas redes sociais?',
      'en':
          'What is the ideal frequency initially planned for publications on your social networks?',
    },
    'w9mvljjk': {
      'pt': 'Diária',
      'en': 'Daily',
    },
    'g7feflay': {
      'pt': 'A cada 3 dias',
      'en': 'Every 3 days',
    },
    'oh63biaz': {
      'pt': 'Semanal',
      'en': 'Weekly',
    },
    'y78o29gg': {
      'pt': 'Mensal',
      'en': 'Monthly',
    },
    'tnexu5yz': {
      'pt': 'Limpar seleção',
      'en': 'Clear selection',
    },
    '5oxps617': {
      'pt':
          'Tem alguma informação adicional que você considera relevante para a análise dos resultados da conta?',
      'en':
          'Do you have any additional information that you consider relevant to analyzing the account results?',
    },
    '8sdxn1w6': {
      'pt': 'Página anterior',
      'en': 'Previous page',
    },
  },
  // master-relatorio
  {
    'oxlpouxo': {
      'pt': 'Relatório estratégico',
      'en': 'Strategic report',
    },
    'tc80de8r': {
      'pt': 'Seleção de período',
      'en': 'Period selection',
    },
    'tn3zbxt1': {
      'pt': 'Resumo de Informações',
      'en': 'Information Summary',
    },
    'sw0bqj59': {
      'pt': 'Objetivos Google',
      'en': 'Objectives',
    },
    'ovo26uc6': {
      'pt': 'Orçamento Google',
      'en': 'Objectives',
    },
    '15o4n1ok': {
      'pt': 'Objetivos Meta Ads',
      'en': 'Objectives',
    },
    'igfwx1pe': {
      'pt': 'Orçamento Meta Ads',
      'en': 'Objectives',
    },
    'brjuezkn': {
      'pt': 'Objetivos Orgânico',
      'en': 'Objectives',
    },
    '85qmvck0': {
      'pt': 'Faixa etária',
      'en': 'Age range',
    },
    'gtmuqhku': {
      'pt': 'Gênero',
      'en': 'Gender',
    },
    't8fasb30': {
      'pt': 'Interação',
      'en': 'Interaction',
    },
    'j2iapbfy': {
      'pt': 'Clientes',
      'en': 'Clients',
    },
    '7f56swef': {
      'pt': 'Recursos Disponíveis',
      'en': 'Content frequency',
    },
    'pyr7q3du': {
      'pt': 'Frequência de Conteúdo',
      'en': 'Content frequency',
    },
    'o6phf1e2': {
      'pt': 'Relatório Geral',
      'en': 'Period report',
    },
    '06f9hgny': {
      'pt': 'Metas Anteriores',
      'en': 'Previous goals',
    },
    'fl2ks2kz': {
      'pt': 'Metas Futuras',
      'en': 'Future goals',
    },
    'a48pj0xc': {
      'pt': 'Ações Unificadas',
      'en': 'Content suggestions',
    },
    '6wc7jbjo': {
      'pt': 'Prioridade ',
      'en': 'Engagement',
    },
    '8swdwo8n': {
      'pt': 'Foco Estratégico ',
      'en': 'Engagement',
    },
    'abkh0m31': {
      'pt': 'Detalhes da Ação ',
      'en': 'Engagement',
    },
    'nm13z5u8': {
      'pt': 'Sazonalidade e Oportunidades',
      'en': 'Content suggestions',
    },
    'ya2cfjfa': {
      'pt': 'Data do Evento ',
      'en': 'Engagement',
    },
    'tpikbdln': {
      'pt': 'Estratégia Sugerida ',
      'en': 'Engagement',
    },
    '4o6baxlu': {
      'pt': 'Relatório de Palavras-Chave',
      'en': 'Period report',
    },
    '81r8v641': {
      'pt': 'Otimizações de Palavras-Chave',
      'en': 'Content suggestions',
    },
    'koqcx6m0': {
      'pt': 'Palavra-Chave ',
      'en': 'Engagement',
    },
    'el34y7pv': {
      'pt': 'Ação Recomendada ',
      'en': 'Engagement',
    },
    'eis3megt': {
      'pt': 'Justificativa ',
      'en': 'Engagement',
    },
    '7v4ja0a0': {
      'pt': 'Prioridade ',
      'en': 'Engagement',
    },
    'trgwgo7a': {
      'pt': 'Oportunidades de Palavras-Chave',
      'en': 'Content suggestions',
    },
    'j637nlhs': {
      'pt': 'Palavra-Chave ',
      'en': 'Engagement',
    },
    '2kuftrth': {
      'pt': 'Correspondência ',
      'en': 'Engagement',
    },
    'np7lxlzc': {
      'pt': 'Fonte  ',
      'en': 'Engagement',
    },
    'a1o8dcub': {
      'pt': 'Potencial ',
      'en': 'Engagement',
    },
    'v48xe3a4': {
      'pt': 'Palavras-Chave de Negativação',
      'en': 'Content suggestions',
    },
    'f20oizod': {
      'pt': 'Palavra-Chave ',
      'en': 'Engagement',
    },
    'lezarx1w': {
      'pt': 'Correspondência ',
      'en': 'Engagement',
    },
    'uumfl008': {
      'pt': 'Justificativa ',
      'en': 'Engagement',
    },
    'qc8dg6ax': {
      'pt': 'Sugestões de Ajustes de Leilão',
      'en': 'Content suggestions',
    },
    'hlsa1o0h': {
      'pt': 'Tipo de Segmento ',
      'en': 'Engagement',
    },
    '2o0n6asb': {
      'pt': 'Segmento ',
      'en': 'Engagement',
    },
    'g67yx3b2': {
      'pt': 'Ação Recomendada ',
      'en': 'Engagement',
    },
    'wjmi89in': {
      'pt': 'Sugestão de Ajuste ',
      'en': 'Engagement',
    },
    '2tnq0jdn': {
      'pt': 'Justificativa ',
      'en': 'Engagement',
    },
    'mtg181xp': {
      'pt': 'Prioridade ',
      'en': 'Engagement',
    },
    'zvik9odm': {
      'pt': 'Relatório Demográfico',
      'en': 'Period report',
    },
    'zue66jxd': {
      'pt': 'Descobertas Externas',
      'en': 'Content suggestions',
    },
    '26ytqfz5': {
      'pt': 'Análise de competidores ',
      'en': 'Engagement',
    },
    'qm4zb3x5': {
      'pt': 'Tendências de Mercado ',
      'en': 'Engagement',
    },
    'qphg20t9': {
      'pt': 'Oportunidades ',
      'en': 'Engagement',
    },
    'qilf9822': {
      'pt': 'Relatório Criativo',
      'en': 'Period report',
    },
    'fdjwueuy': {
      'pt': 'Sugestões de Otimização de Criativos',
      'en': 'Content suggestions',
    },
    'nbpwfh5x': {
      'pt': 'Tipo de Criativo ',
      'en': 'Engagement',
    },
    'feefbnih': {
      'pt': 'Conteúdo do Criativo ',
      'en': 'Engagement',
    },
    'q7ty6n5g': {
      'pt': 'Performance ',
      'en': 'Engagement',
    },
    '4gpf5foi': {
      'pt': 'Ação Recomendada  ',
      'en': 'Engagement',
    },
    'cdvygeru': {
      'pt': 'Justificativa ',
      'en': 'Engagement',
    },
    '3862a8xj': {
      'pt': 'Prioridade ',
      'en': 'Engagement',
    },
    'kc9lns3h': {
      'pt': 'Sugestões de Novos Criativos',
      'en': 'Content suggestions',
    },
    '4a2mdv6l': {
      'pt': 'Tipo de Criativo ',
      'en': 'Engagement',
    },
    'inr8kd5l': {
      'pt': 'Conteúdo do Criativo ',
      'en': 'Engagement',
    },
    'xievnjki': {
      'pt': 'Justificativa ',
      'en': 'Engagement',
    },
    'k3cip0u4': {
      'pt': 'Prioridade ',
      'en': 'Engagement',
    },
    'th9vm5ik': {
      'pt': 'Relatório Geral Google',
      'en': 'Period report',
    },
    '987xe2da': {
      'pt': 'Metas Anteriores Google',
      'en': 'Previous goals',
    },
    '66k2di6p': {
      'pt': 'Metas Futuras Google',
      'en': 'Future goals',
    },
    'jpwifvkw': {
      'pt': 'Relatório de Conteúdo',
      'en': 'Period report',
    },
    '8lhi4bai': {
      'pt': 'Analise de Melhores Posts',
      'en': 'Content suggestions',
    },
    'grlxumat': {
      'pt': 'Tema ',
      'en': 'Engagement',
    },
    'k7wrjbyk': {
      'pt': 'Justificativa ',
      'en': 'Engagement',
    },
    'z127fsnh': {
      'pt': 'Principais Métricas ',
      'en': 'Engagement',
    },
    'snozcfa2': {
      'pt': 'Relatório de Sentimento',
      'en': 'Content suggestions',
    },
    'lgwvi3w9': {
      'pt': 'Sentimento Principal ',
      'en': 'Engagement',
    },
    'ezy0qdu9': {
      'pt': 'Observações ',
      'en': 'Engagement',
    },
    'umede5ig': {
      'pt': 'Sugestões de Conteúdo',
      'en': 'Content suggestions',
    },
    'pi20u3du': {
      'pt': 'Formato ',
      'en': 'Engagement',
    },
    'ugib2yfi': {
      'pt': 'Tema ',
      'en': 'Engagement',
    },
    'xmtvpfyf': {
      'pt': 'Justificativa ',
      'en': 'Engagement',
    },
    '303e667z': {
      'pt': 'Relatório de Audiência',
      'en': 'Period report',
    },
    'hmuqqcx0': {
      'pt': 'Alinhamento Demográfico',
      'en': 'Period report',
    },
    'z4kdjflc': {
      'pt': 'Status ',
      'en': 'Engagement',
    },
    '28uk2rhh': {
      'pt': 'Análise ',
      'en': 'Engagement',
    },
    'tbvls99p': {
      'pt': 'Melhores Períodos',
      'en': 'Period report',
    },
    'e54t9df5': {
      'pt': 'Melhores Dias ',
      'en': 'Engagement',
    },
    '5uj7ayhc': {
      'pt': 'Observações ',
      'en': 'Engagement',
    },
    '99ofse5n': {
      'pt': 'Auditoria de Frequência',
      'en': 'Period report',
    },
    '320ume9n': {
      'pt': 'Posts por Semana ',
      'en': 'Engagement',
    },
    'dnfz0bzf': {
      'pt': 'Status ',
      'en': 'Engagement',
    },
    'lfdcog7v': {
      'pt': 'Sugestões ',
      'en': 'Engagement',
    },
    '50kxyd3i': {
      'pt': 'Relatório Geral Orgânico',
      'en': 'Period report',
    },
    'ebtgovj4': {
      'pt': 'Metas Anteriores Orgânico',
      'en': 'Previous goals',
    },
    '4bpaatd9': {
      'pt': 'Metas Futuras Orgânico',
      'en': 'Future goals',
    },
    'fy483q2i': {
      'pt': 'Relatório Criativo',
      'en': 'Period report',
    },
    'w1d3nef7': {
      'pt': 'Melhores Criativos',
      'en': 'Content suggestions',
    },
    'qalgh3wk': {
      'pt': 'Anúncio ',
      'en': 'Engagement',
    },
    'rmzdizyt': {
      'pt': 'Principais Métricas ',
      'en': 'Engagement',
    },
    'jsgui3zu': {
      'pt': 'Razão ',
      'en': 'Engagement',
    },
    'iclthjk9': {
      'pt': 'Sugestões de Criativos',
      'en': 'Content suggestions',
    },
    '2z1zj2vq': {
      'pt': 'Relatório de Campanhas',
      'en': 'Period report',
    },
    '6avdpfs8': {
      'pt': 'Melhores Conjuntos',
      'en': 'Content suggestions',
    },
    '2o7p2ku6': {
      'pt': 'Conjunto ',
      'en': 'Engagement',
    },
    '91ppeaus': {
      'pt': 'Principais Metricas ',
      'en': 'Engagement',
    },
    'ua75ti0s': {
      'pt': 'Análise Estratégica ',
      'en': 'Engagement',
    },
    'ar07oclb': {
      'pt': 'Riscos e Oportunidades',
      'en': 'Content suggestions',
    },
    'nuq0oqsx': {
      'pt': 'Sugestões de Ação',
      'en': 'Content suggestions',
    },
    'bmcs8zxu': {
      'pt': 'Relatório Geral Meta Ads',
      'en': 'Period report',
    },
    '61d4e212': {
      'pt': 'Metas Anteriores Meta Ads',
      'en': 'Previous goals',
    },
    'r1lia9jk': {
      'pt': 'Metas Futuras Meta Ads',
      'en': 'Future goals',
    },
    '3cxbsiby': {
      'pt': 'Avaliação da saída',
      'en': 'Output evaluation',
    },
    '232oexrz': {
      'pt': 'Escreva suas opiniões em relação a saída original',
      'en': 'Write your opinions regarding the original output',
    },
    'zxqfb22o': {
      'pt': 'Publicar Avaliação',
      'en': 'Post Review',
    },
    'v3qlskdx': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'u5ichk8l': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '6usvycp2': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'rwqvwegl': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'dm1m38ui': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'h92y8rdt': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '0fdd7447': {
      'pt': 'Sem Estratégia definida',
      'en': 'No defined strategy',
    },
    'gdc3eyut': {
      'pt':
          'Responda o formulário de estratégia para direcionar as análises dos resultados da sua marca e garantir um relatório mensal dos resultados com orientações dos proximos passos',
      'en':
          'Complete the strategy form to guide your brand\'s results analysis and ensure a monthly results report with guidance on next steps.',
    },
    'boe3oqh9': {
      'pt': 'Responder Formulário',
      'en': 'Reply Form',
    },
    'sk633987': {
      'pt': 'Publicar mudanças',
      'en': 'Publish changes',
    },
  },
  // CRM
  {
    'zrormbq3': {
      'pt': 'Lista de lead',
      'en': 'Ad results',
    },
    'kgg2vp8n': {
      'pt': 'Adicionar Lead',
      'en': '',
    },
    'vwajjjb4': {
      'pt': 'Download',
      'en': '',
    },
    'e35te2f5': {
      'pt': 'Novo Lead',
      'en': '',
    },
    'fvbzi2vp': {
      'pt': 'Digite o nome..',
      'en': '',
    },
    'oe9rpggx': {
      'pt': 'Digite o email...',
      'en': '',
    },
    'z2mjfxrx': {
      'pt': 'Adicionar',
      'en': '',
    },
    'q587h3rz': {
      'pt': 'Filtrar',
      'en': 'Ad results',
    },
    'd04n8rrn': {
      'pt': 'Nome da negociação',
      'en': '',
    },
    'suaiywql': {
      'pt': 'Email da negociação',
      'en': '',
    },
    'licthuj2': {
      'pt': 'Status da negociação',
      'en': '',
    },
    't0meng1z': {
      'pt': '',
      'en': '',
    },
    'psr58jbt': {
      'pt': 'Search...',
      'en': '',
    },
    'f5u5d050': {
      'pt': 'Responsável da negociação',
      'en': '',
    },
    'zftu4muh': {
      'pt': '',
      'en': '',
    },
    '09v9b4ln': {
      'pt': 'Search...',
      'en': '',
    },
    'd2ygkqq3': {
      'pt': 'Valor total',
      'en': '',
    },
    'gybbh2pi': {
      'pt': 'R\$ 0,00',
      'en': '',
    },
    '5oz09yvw': {
      'pt': 'até',
      'en': '',
    },
    'oib60jbj': {
      'pt': 'R\$ 0,00',
      'en': '',
    },
    '71edii3b': {
      'pt': 'Data de criação',
      'en': '',
    },
    '8td7u8fd': {
      'pt': 'Selecionar',
      'en': '',
    },
    'a7rmjqix': {
      'pt': 'até',
      'en': '',
    },
    'lrh7z3gn': {
      'pt': 'Selecionar',
      'en': '',
    },
    'ciafn43h': {
      'pt': 'Data fechamento',
      'en': '',
    },
    'qstgshpv': {
      'pt': 'Selecionar',
      'en': '',
    },
    'yhrzzxvy': {
      'pt': 'até',
      'en': '',
    },
    'osqomu4l': {
      'pt': 'Selecionar',
      'en': '',
    },
    'm17ivzz0': {
      'pt': 'Data ultima movimentação',
      'en': '',
    },
    'ktnu8f9j': {
      'pt': 'Selecionar',
      'en': '',
    },
    '7ef6as26': {
      'pt': 'até',
      'en': '',
    },
    'hew2460u': {
      'pt': 'Selecionar',
      'en': '',
    },
    'vqsk23ue': {
      'pt': 'Campo Personalizado',
      'en': '',
    },
    'n42a8463': {
      'pt': '',
      'en': '',
    },
    'pm0vgxfz': {
      'pt': 'Search...',
      'en': '',
    },
    'tv7givg2': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'h1yqpds0': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'lxv5veo0': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '2ma7vqeu': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'nvw1cyn4': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'tqwwi18l': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '5tfcpqpx': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'z523rb8f': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'ysm8bkf6': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'xlwoswey': {
      'pt': 'Lista de lead',
      'en': 'Ad results',
    },
    'shor01sh': {
      'pt': 'Adicionar Lead',
      'en': '',
    },
    'g8zc6ozr': {
      'pt': 'Download',
      'en': '',
    },
    '1lpbtg13': {
      'pt': 'Novo Lead',
      'en': '',
    },
    'ra1sjunw': {
      'pt': 'Digite o nome..',
      'en': '',
    },
    '5n55ydoz': {
      'pt': 'Digite o email...',
      'en': '',
    },
    '52xb2qbh': {
      'pt': 'Adicionar',
      'en': '',
    },
    'zepeqaml': {
      'pt': 'Filtrar',
      'en': 'Ad results',
    },
    'i3yhkdua': {
      'pt': 'Nome da negociação',
      'en': '',
    },
    'nd8e9r3s': {
      'pt': 'Email da negociação',
      'en': '',
    },
    'd1rgstbm': {
      'pt': 'Status da negociação',
      'en': '',
    },
    '3y9z6568': {
      'pt': '',
      'en': '',
    },
    '1eqne20i': {
      'pt': 'Search...',
      'en': '',
    },
    'ksc6tm0j': {
      'pt': 'Responsável da negociação',
      'en': '',
    },
    'sxkwu1oi': {
      'pt': '',
      'en': '',
    },
    'r0fucoix': {
      'pt': 'Search...',
      'en': '',
    },
    'tpcznjkt': {
      'pt': 'Valor total',
      'en': '',
    },
    'ljh549qn': {
      'pt': 'R\$ 0,00',
      'en': '',
    },
    '79ewph06': {
      'pt': 'até',
      'en': '',
    },
    'ub9b6t8i': {
      'pt': 'R\$ 0,00',
      'en': '',
    },
    'ibmgsds2': {
      'pt': 'Data de criação',
      'en': '',
    },
    'pkledqk5': {
      'pt': 'Selecionar',
      'en': '',
    },
    '048s6i3a': {
      'pt': 'até',
      'en': '',
    },
    't1ypgp9b': {
      'pt': 'Selecionar',
      'en': '',
    },
    'xx19sihd': {
      'pt': 'Data fechamento',
      'en': '',
    },
    'wgrt71he': {
      'pt': 'Selecionar',
      'en': '',
    },
    'os27kvht': {
      'pt': 'até',
      'en': '',
    },
    'bzvodcpj': {
      'pt': 'Selecionar',
      'en': '',
    },
    '023zqpp9': {
      'pt': 'Data ultima movimentação',
      'en': '',
    },
    'i5sm1xss': {
      'pt': 'Selecionar',
      'en': '',
    },
    'od9mme2h': {
      'pt': 'até',
      'en': '',
    },
    'ulbzppz6': {
      'pt': 'Selecionar',
      'en': '',
    },
    'ht3bq2nv': {
      'pt': 'Campo Personalizado',
      'en': '',
    },
    '55wv20ss': {
      'pt': '',
      'en': '',
    },
    'i4z7w56l': {
      'pt': 'Search...',
      'en': '',
    },
    'r7ns4ulr': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    '745bzzwv': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '124iz8kj': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'fspjvxl9': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '9841bzmc': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'y4htytv8': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '8b1gj7ud': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'n46h88id': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'whkc3dh7': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
  },
  // Crmperfil
  {
    '7yp2ssuf': {
      'pt': 'Informação do  lead',
      'en': 'Ad results',
    },
    'vw4qv3hh': {
      'pt': 'Nome da negociação',
      'en': '',
    },
    '9cr8clfj': {
      'pt': 'Status da negociação',
      'en': '',
    },
    'md64m2ho': {
      'pt': '',
      'en': '',
    },
    '565tym9o': {
      'pt': 'Search...',
      'en': '',
    },
    'ixk7khb7': {
      'pt': 'Email da negociação',
      'en': '',
    },
    '1x5tzwlv': {
      'pt': 'Telefone',
      'en': '',
    },
    'za92k54d': {
      'pt': 'Valor da negociação',
      'en': '',
    },
    '1n5m5qau': {
      'pt': 'Adicionado em',
      'en': '',
    },
    'sx14yrp9': {
      'pt': 'Ultima movimentação',
      'en': '',
    },
    '3l2ga287': {
      'pt': 'Data de fechamento',
      'en': '',
    },
    'ibfl2sta': {
      'pt': 'Campos adicionais',
      'en': '',
    },
    'jbkx5x2g': {
      'pt': 'Lista de Atualizações',
      'en': 'Ad results',
    },
    'fc4et3bb': {
      'pt': 'Adicionar atividade',
      'en': '',
    },
    'o6308a25': {
      'pt': 'Nova Atividade',
      'en': '',
    },
    'jsosrh31': {
      'pt': 'Select...',
      'en': '',
    },
    '10i60c50': {
      'pt': 'Search...',
      'en': '',
    },
    '2ilgsvim': {
      'pt': 'Option 1',
      'en': '',
    },
    'kpr8e1qn': {
      'pt': 'Option 2',
      'en': '',
    },
    '6ecjzxua': {
      'pt': 'Option 3',
      'en': '',
    },
    '0441uo30': {
      'pt': 'Digite aqui...',
      'en': '',
    },
    '1ribk966': {
      'pt': 'Enviar',
      'en': '',
    },
    'g2nt10fh': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'b390had6': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'lonm4eop': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'klgv73u3': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '4q96pw1s': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'cjnf959w': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'xijnokid': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'm982itce': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'ne8mn1t8': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'c6re5los': {
      'pt': 'Lista de Atualizações',
      'en': 'Ad results',
    },
    '0dhoe27y': {
      'pt': 'Adicionar atividade',
      'en': '',
    },
    'wxi3fzf5': {
      'pt': 'Nova Atividade',
      'en': '',
    },
    'sjus93tr': {
      'pt': 'Select...',
      'en': '',
    },
    '3nr4ujx9': {
      'pt': 'Search...',
      'en': '',
    },
    'iwxqdxlh': {
      'pt': 'Option 1',
      'en': '',
    },
    'ta1pesog': {
      'pt': 'Option 2',
      'en': '',
    },
    'u5fr0t72': {
      'pt': 'Option 3',
      'en': '',
    },
    'q8c7q3e3': {
      'pt': 'Digite aqui...',
      'en': '',
    },
    'lfiuiwn8': {
      'pt': 'Enviar',
      'en': '',
    },
    '7r4watna': {
      'pt': 'Informação do  lead',
      'en': 'Ad results',
    },
    'obgetqud': {
      'pt': 'Nome da negociação',
      'en': '',
    },
    'fmrrku6t': {
      'pt': 'Status da negociação',
      'en': '',
    },
    'uylr33oq': {
      'pt': '',
      'en': '',
    },
    '8v0jjhlg': {
      'pt': 'Search...',
      'en': '',
    },
    's8d9pcky': {
      'pt': 'Email da negociação',
      'en': '',
    },
    'sa9iem03': {
      'pt': 'Telefone',
      'en': '',
    },
    '3suqklkh': {
      'pt': 'Valor da negociação',
      'en': '',
    },
    'bpp4tko2': {
      'pt': 'Adicionado em',
      'en': '',
    },
    'l5kfhr1m': {
      'pt': 'Ultima movimentação',
      'en': '',
    },
    'o57cheac': {
      'pt': 'Data de fechamento',
      'en': '',
    },
    'y18hiqao': {
      'pt': 'Responsável da negociação',
      'en': '',
    },
    'uoozbbe8': {
      'pt': '',
      'en': '',
    },
    'uuzart58': {
      'pt': 'Search...',
      'en': '',
    },
    'bmrhhau5': {
      'pt': 'Campos adicionais',
      'en': '',
    },
    'hn42gksh': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'g3w3z8lb': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    'dsv1t0z9': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    'txmr2anw': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    '0qb3n9ma': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'qm6tvumj': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    'o6zhlo9v': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    'coqtcsbz': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    '32jb8nm9': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'cjomh160': {
      'pt': 'Deletar Lead',
      'en': 'Remove Account',
    },
    'o4wb667h': {
      'pt':
          'Essa ação irá remover esse lead do seu CRM e deletar todos os dados relacionados a ele , não será possível recuperar os dados nem atualizações anteriores. Essa ação é irreversível, deseja prosseguir?',
      'en':
          'This action will remove this account from your user account and delete all related data. You won\'t be able to recover data or analytics from previous months. This action is irreversible. Do you want to continue?',
    },
    'cnl4xyth': {
      'pt': 'Desejo continuar',
      'en': 'I want to continue',
    },
    'ilxo2dgq': {
      'pt': 'Remover conta',
      'en': 'Remove account',
    },
    '55t59vxx': {
      'pt': 'Gerenciar tipos de atividades do cliente',
      'en': '',
    },
    '68e2ab67': {
      'pt':
          'Ao adicionar os tipos de atividade abaixo eles estarão disponíveis para seleção dentro da criação de novas atividades dentro da página do cliente, se a opção não aparece no menu, recarregue a página.',
      'en': '',
    },
    'zfd8juwd': {
      'pt': 'Insira o nome da nova atividade',
      'en': '',
    },
    'dfrebb4o': {
      'pt': 'Gerenciar Perfis do CRM',
      'en': '',
    },
    '5ot6unq3': {
      'pt':
          'Aperte o botão de recarregar paravisualizar as contas recem adicionadas ao crm, abaixo, você poderá editar o nome e permissões de cada perfiil',
      'en': '',
    },
  },
  // pipeline
  {
    'tkb6lw56': {
      'pt': 'Conecte sua conta',
      'en': 'Connect your account',
    },
    'alo6ah9j': {
      'pt':
          'Para adicionar uma conta do Instagram ou facebook ao aplicativo e visualizar os dedos  é necessário fazer login com uma conta do facebook válida integrada ao perfil, ao clicar no botão você será redirecionado para um menu de login do Facebook',
      'en':
          'To add an Instagram or Facebook account to the application and view the fingers, you must log in with a valid Facebook account integrated into the profile. When you click the button, you will be redirected to a Facebook login menu.',
    },
    '0f7fvjck': {
      'pt':
          'Ao conectar sua conta do Facebook você permite á bamhub acesso aos seguintes dados:',
      'en':
          'By connecting your Facebook account, you allow bamhub access to the following data:',
    },
    '0si2p1vi': {
      'pt': 'insights da página e posts',
      'en': 'page and post insights',
    },
    'lhwo5v2w': {
      'pt': 'comentários',
      'en': 'comments',
    },
    'r4pdhs9r': {
      'pt': 'Conectar Conta',
      'en': 'Connect Account',
    },
    '4e6w7iok': {
      'pt': 'Aguarde a conexão da sua conta',
      'en': 'Please wait for your account to be connected.',
    },
    '8bj4ia94': {
      'pt':
          'Entre em contato com a equipe da BAM e autorizaremos os acessos aos dados de suas páginas',
      'en':
          'Contact the BAM team and we will authorize access to your page data.',
    },
    'vpw3enjz': {
      'pt': 'Contatar Equipe',
      'en': 'Contact Team',
    },
    'fex0iujt': {
      'pt': 'Nome da negociação',
      'en': '',
    },
    'ja8o15q2': {
      'pt': 'Email da negociação',
      'en': '',
    },
    '2dk7ntfk': {
      'pt': 'Responsável',
      'en': '',
    },
    '756guouf': {
      'pt': '',
      'en': '',
    },
    '5he0yj0k': {
      'pt': 'Search...',
      'en': '',
    },
    'g2opjrvd': {
      'pt': 'Valor total',
      'en': '',
    },
    'a1baoh1t': {
      'pt': 'R\$ 0,00',
      'en': '',
    },
    'ulhke00m': {
      'pt': 'até',
      'en': '',
    },
    'c43q6wwm': {
      'pt': 'R\$ 0,00',
      'en': '',
    },
    'dvn47yon': {
      'pt': 'Data de criação',
      'en': '',
    },
    'ucpucmst': {
      'pt': 'Selecionar',
      'en': '',
    },
    'sol3lijt': {
      'pt': 'até',
      'en': '',
    },
    't8jd2d2g': {
      'pt': 'Selecionar',
      'en': '',
    },
    'z3gd035r': {
      'pt': 'Data fechamento',
      'en': '',
    },
    'uv3zhj04': {
      'pt': 'Selecionar',
      'en': '',
    },
    '8gzgi6m1': {
      'pt': 'até',
      'en': '',
    },
    'qez3wf7u': {
      'pt': 'Selecionar',
      'en': '',
    },
    'pn8qgn3g': {
      'pt': 'Data ultima movimentação',
      'en': '',
    },
    '8s1h13eb': {
      'pt': 'Selecionar',
      'en': '',
    },
    'htlf7ms3': {
      'pt': 'até',
      'en': '',
    },
    'jij9ewq8': {
      'pt': 'Selecionar',
      'en': '',
    },
    'j9pe3wkt': {
      'pt': 'Campo Personalizado',
      'en': '',
    },
    'wpkz1aje': {
      'pt': '',
      'en': '',
    },
    'vg3f4v5g': {
      'pt': 'Search...',
      'en': '',
    },
    '7hwnfejn': {
      'pt': 'Valor do campo',
      'en': '',
    },
    '8twka4co': {
      'pt': 'Gerenciar',
      'en': '',
    },
    '73ohvfbw': {
      'pt': 'Adicionar Lead',
      'en': '',
    },
    'y8y34gg8': {
      'pt':
          'Para remover uma coluna primeiro é necessário que todos os leads  presentes naquela coluna sejam removidos ou direcionados par a outra etapa da negociação. Se já realizou a transferência e a opção não estiver disponível recarregue a página',
      'en': '',
    },
    'iedy2hos': {
      'pt': 'Insira o nome da nova coluna',
      'en': '',
    },
  },
  // solve
  {
    'mqtypxnw': {
      'pt': 'Button',
      'en': '',
    },
    'gd8fx22s': {
      'pt': 'Page Title',
      'en': '',
    },
    '2ygcghlq': {
      'pt': 'Home',
      'en': '',
    },
  },
  // solveCopy
  {
    '447yl4x3': {
      'pt': 'Button',
      'en': '',
    },
    'yvg386xg': {
      'pt': 'Page Title',
      'en': '',
    },
    'pibewsoi': {
      'pt': 'Home',
      'en': '',
    },
  },
  // menu
  {
    'hzd56qga': {
      'pt': 'Cliente BAM',
      'en': 'BAM Client',
    },
    '3qwneqn9': {
      'pt': 'Adicionar nova conta',
      'en': 'Add new account',
    },
    'tlx39tzq': {
      'pt': 'Menu Principal',
      'en': 'Main Menu',
    },
    'nurthmun': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'h9chn4hy': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'sjy3uhg3': {
      'pt': 'Campanhas',
      'en': 'Results',
    },
    'idgfougu': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    '550cax3j': {
      'pt': 'Dados Agrupados',
      'en': 'Results',
    },
    'kva1ae6g': {
      'pt': 'Dados de Posts',
      'en': 'Post Data',
    },
    'nugkwhyf': {
      'pt': 'Cronograma',
      'en': 'Timeline',
    },
    'wpj0qtda': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    'rwmxd8s2': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'fqueeuef': {
      'pt': 'Dados Agrupados',
      'en': 'Results',
    },
    'rgx1s2b2': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    's63ogoxm': {
      'pt': 'Campanhas',
      'en': 'Results',
    },
    '2cahnghe': {
      'pt': 'Resultados',
      'en': 'Results',
    },
    'n51bppki': {
      'pt': 'Dados de Posts',
      'en': 'Post Data',
    },
    '2ctybsf4': {
      'pt': 'Cronograma',
      'en': 'Timeline',
    },
    'gct0fza0': {
      'pt': 'Comentários',
      'en': 'Comments',
    },
    '10m1y2rh': {
      'pt': 'Estratégia',
      'en': 'Strategy',
    },
    'a22981nx': {
      'pt': 'Estratégia',
      'en': 'Strategy',
    },
    'dauzxo40': {
      'pt': 'CRM',
      'en': 'Strategy',
    },
    '846esnv3': {
      'pt': 'Pipeline',
      'en': 'Strategy',
    },
    'vp3dayje': {
      'pt': 'Administrador',
      'en': 'Administrator',
    },
    'uryx25b7': {
      'pt': 'Configurações',
      'en': 'Settings',
    },
  },
  // botaocomentario
  {
    'ct3kj4rh': {
      'pt': 'Insira seu comentário',
      'en': 'Enter your comment',
    },
  },
  // cardsconjunto
  {
    'bw8lwvff': {
      'pt': 'Destino',
      'en': '',
    },
    'wt2fg7pr': {
      'pt': 'Objetivo de otimização',
      'en': '',
    },
    'grgiyeot': {
      'pt': 'Idade',
      'en': '',
    },
    'o1aabm60': {
      'pt': 'Localização',
      'en': '',
    },
    'biqysl69': {
      'pt': 'Exibição',
      'en': '',
    },
    'lkezqp19': {
      'pt': 'Interesses',
      'en': '',
    },
  },
  // historico
  {
    'edxirlbp': {
      'pt': 'Digite aqui...',
      'en': '',
    },
    'osb6fysh': {
      'pt': 'Salvar',
      'en': '',
    },
  },
  // addleadcrm
  {
    'qzd95s1a': {
      'pt': 'Novo Lead',
      'en': '',
    },
    '01x5a4su': {
      'pt': 'Digite o nome..',
      'en': '',
    },
    'svjam329': {
      'pt': 'Digite o email...',
      'en': '',
    },
    'kold4z6z': {
      'pt': 'Adicionar',
      'en': '',
    },
  },
  // containerresponsavel
  {
    'h1a7l5t4': {
      'pt': 'Nome do Responsável',
      'en': '',
    },
    'p0gogvz6': {
      'pt': 'Admin',
      'en': '',
    },
  },
  // Miscellaneous
  {
    'z19pofob': {
      'pt': '',
      'en': '',
    },
    '75hv470r': {
      'pt': '',
      'en': '',
    },
    'w81vmpjr': {
      'pt': '',
      'en': '',
    },
    'sl61qsjn': {
      'pt': '',
      'en': '',
    },
    'k1g3b0m5': {
      'pt': '',
      'en': '',
    },
    '01seywq1': {
      'pt': '',
      'en': '',
    },
    'p829cbkq': {
      'pt': '',
      'en': '',
    },
    'hq8taex1': {
      'pt': '',
      'en': '',
    },
    '70ckd12y': {
      'pt': '',
      'en': '',
    },
    'rp73iiii': {
      'pt': '',
      'en': '',
    },
    'sx1jfpgv': {
      'pt': '',
      'en': '',
    },
    'dyea9dul': {
      'pt': '',
      'en': '',
    },
    'ai7540xq': {
      'pt': '',
      'en': '',
    },
    '5khc7m3e': {
      'pt': '',
      'en': '',
    },
    '5p36agtm': {
      'pt': '',
      'en': '',
    },
    'wpz784nr': {
      'pt': '',
      'en': '',
    },
    'sfffc0yy': {
      'pt': '',
      'en': '',
    },
    'wa1nvcav': {
      'pt': '',
      'en': '',
    },
    'u7in3n56': {
      'pt': '',
      'en': '',
    },
    'vzmqiqoo': {
      'pt': '',
      'en': '',
    },
    'eacof2sg': {
      'pt': '',
      'en': '',
    },
    'ro1sg4zy': {
      'pt': '',
      'en': '',
    },
    '8od4tsb1': {
      'pt': '',
      'en': '',
    },
    'r04c0e46': {
      'pt': '',
      'en': '',
    },
    'lbg184zm': {
      'pt': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
