///|
fn localized(locale : String, chinese : String, english : String, japanese : String) -> String {
  match locale {
    "en" => english
    "ja" => japanese
    _ => chinese
  }
}

///|
fn moonbit_site(locale : String) -> String {
  localized(locale, "https://www.moonbitlang.cn/", "https://www.moonbitlang.com/", "https://www.moonbitlang.com/")
}

///|
fn language_name(locale : String) -> String {
  localized(locale, "中文", "English", "日本語")
}

///|
fn language_options(locale : String, page_name : String) -> String {
  let links = StringBuilder::new()
  for choice in ["zh-CN", "en", "ja"] {
    let suffix = if choice == "zh-CN" { "" } else { "-" + choice }
    let current = if choice == locale { " aria-current=\"page\"" } else { "" }
    links.write_string(
      (
        $|<a href="./\{page_name}\{suffix}.html" lang="\{choice}" hreflang="\{choice}"\{current}>\{language_name(choice)}</a>
      ),
    )
  }
  links.to_string()
}

///|
fn ecosystem_cards(locale : String) -> String {
  let developer_url = moonbit_site(locale)
  let links = [
    (
      developer_url, "MoonBit", localized(locale, "了解编程语言、开发工具与入门文档。", "Explore the language, developer tools, and getting-started guides.", "言語、開発ツール、入門ガイドを見る。"),
    ),
    (
      "https://mooncakes.io/", "Mooncakes", localized(locale, "浏览 MoonBit 软件包与开源模块。", "Browse MoonBit packages and open-source modules.", "MoonBit のパッケージとオープンソースモジュールを見る。"),
    ),
    (
      "https://github.com/moonbit-community", localized(locale, "开源社区", "Open-source community", "オープンソースコミュニティ"), localized(locale, "查看社区项目，参与开源协作。", "Explore community projects and contribute.", "コミュニティのプロジェクトを探し、開発に参加する。"),
    ),
  ]
  let cards = StringBuilder::new()
  for link in links {
    let (url, title, description) = link
    cards.write_string(
      (
        $|<a href="\{url}"><strong>\{title}</strong><span>\{description}</span><span class="arrow" aria-hidden="true">↗</span></a>
      ),
    )
  }
  cards.to_string()
}

///|
fn ecosystem_label(locale : String) -> String {
  localized(locale, "MoonBit 生态", "MoonBit ecosystem", "MoonBit エコシステム")
}

///|
fn main {
  let args = @env.args()
  let company = args.contains("--company")
  let contact = args.contains("--contact")
  let locale = if args.contains("--en") { "en" } else if args.contains("--ja") { "ja" } else { "zh-CN" }
  let suffix = if locale == "zh-CN" { "" } else { "-" + locale }
  let page_name = if contact { "contact" } else if company { "company" } else { "index" }
  let home_url = if suffix == "" { "./" } else { "./index" + suffix + ".html" }
  let brand = localized(locale, "月比特科技", "Yuebite Technology", "月比特科技")
  let about_label = localized(locale, "关于我们", "About us", "私たちについて")
  let contact_label = localized(locale, "联系我们", "Contact us", "お問い合わせ")
  let title = if contact { contact_label + " | " + brand } else if company { about_label + " | " + brand } else { brand }
  let company_current = if company { " aria-current=\"page\"" } else { "" }
  let language_links = language_options(locale, page_name)
  let developer_url = moonbit_site(locale)
  let cards = ecosystem_cards(locale)
  let header =
    #|<!doctype html>
    $|<html lang="\{locale}">
    #|<head>
    #|  <meta charset="utf-8">
    #|  <meta name="viewport" content="width=device-width, initial-scale=1">
    $|  <meta name="description" content="\{localized(locale, "月比特科技：了解 MoonBit 编程语言、开发工具与开源生态。", "Explore the MoonBit language, developer tools, and open-source ecosystem.", "MoonBit のプログラミング言語、開発ツール、オープンソースを紹介します。")}">
    $|  <title>\{title}</title>
    #|  <link rel="stylesheet" href="./site.css">
    #|</head>
    #|<body>
    #|  <header class="chrome-shell top">
    $|    <a class="brand" href="\{home_url}"><img src="./moonbit-wordmark.png" alt="MoonBit" width="677" height="173"></a>
    $|    <nav aria-label="\{localized(locale, "主导航", "Main navigation", "メインナビゲーション")}">
    $|      <a href="https://seekmoon.moonbitlang.com/cloud">SeekMoon</a>
    $|      <a href="\{developer_url}">\{localized(locale, "MoonBit 编程语言", "MoonBit Programming Language", "MoonBit プログラミング言語")}</a>
    $|      <details class="ecosystem-nav"><summary>\{localized(locale, "生态", "Ecosystem", "エコシステム")}</summary><div class="ecosystem-menu"><a href="\{developer_url}">MoonBit ↗</a><a href="https://mooncakes.io/">Mooncakes ↗</a><a href="\{home_url}#education">\{localized(locale, "教育", "Education", "教育")}</a><a href="\{home_url}#competitions">\{localized(locale, "赛事", "Competitions", "コンテスト")}</a></div></details>
    $|      <a href="./company\{suffix}.html"\{company_current}>\{about_label}</a>
    #|    </nav>
    $|    <div class="nav-actions"><a href="./contact\{suffix}.html">\{localized(locale, "联系我们", "Contact us", "お問い合わせ")}</a><a class="nav-action" href="https://seekmoon.moonbitlang.com/cloud">\{localized(locale, "试用 SeekMoon", "Try SeekMoon", "SeekMoon を試す")} ↗</a></div>
    #|  </header>
  let home =
    #|  <main id="home">
    #|    <section class="hero shell" aria-labelledby="headline">
    #|      <div class="hero-text">
    $|        <h1 id="headline">\{localized(locale, "今天想用 SeekMoon 做什么？", "What will you build with SeekMoon today?", "今日は SeekMoon で何を作りますか？")}</h1>
    $|        <a class="prompt" href="https://seekmoon.moonbitlang.com/cloud"><span>\{localized(locale, "用 SeekMoon，把想法变成项目", "Turn your ideas into projects with SeekMoon", "SeekMoon でアイデアをプロジェクトに")}</span><span class="prompt-action">\{localized(locale, "打开云端工作台", "Open the cloud workspace", "クラウドワークスペースを開く")} <span aria-hidden="true">↗</span></span></a>
    $|        <div class="actions"><a class="secondary" href="\{developer_url}">MoonBit</a><a class="secondary" href="https://mooncakes.io/">Mooncakes</a><a class="secondary" href="#technology">\{localized(locale, "开源生态", "Open source", "オープンソース")}</a><a class="secondary" href="./company\{suffix}.html">\{localized(locale, "关于我们", "About us", "私たちについて")}</a></div>
    #|      </div>
    #|    </section>
    #|    <section class="updates shell" id="feature-title" aria-labelledby="updates-title">
    $|      <div class="updates-controls"><h2 id="updates-title">\{localized(locale, "最近动态", "Latest updates", "最新情報")}</h2>
    $|        <fieldset><legend>\{localized(locale, "切换文章", "Select an article", "記事を切り替える")}</legend><label><input type="radio" name="updates-slide" value="1" checked> 1</label><label><input type="radio" name="updates-slide" value="2"> 2</label></fieldset>
    #|      </div>
    #|      <article class="feature" data-slide="1">
    $|      <img class="feature-logo" src="./moonbit-logo.png" alt="\{localized(locale, "MoonBit 官方标志", "Official MoonBit logo", "MoonBit 公式ロゴ")}" width="508" height="652">
    $|      <div class="feature-copy"><p class="eyebrow">\{localized(locale, "微信公众号", "WeChat Official Account", "WeChat 公式アカウント")}</p><h3>\{localized(locale, "公众号动态 01", "WeChat update 01", "WeChat のお知らせ 01")}</h3><a href="https://mp.weixin.qq.com/s/Sd7Zv89bSiz7aZOEEi_KMg">\{localized(locale, "阅读公众号文章", "Read the article in Chinese", "中国語の記事を読む")} ↗</a></div>
    #|      </article>
    #|      <article class="feature" data-slide="2">
    #|        <img class="feature-logo" src="./moonbit-logo.png" alt="" width="508" height="652">
    $|        <div class="feature-copy"><p class="eyebrow">\{localized(locale, "微信公众号", "WeChat Official Account", "WeChat 公式アカウント")}</p><h3>\{localized(locale, "公众号动态 02", "WeChat update 02", "WeChat のお知らせ 02")}</h3><a href="https://mp.weixin.qq.com/s/cnsj6Z1V9PCEKnb3wbSv0g">\{localized(locale, "阅读公众号文章", "Read the article in Chinese", "中国語の記事を読む")} ↗</a></div>
    #|      </article>
    #|    </section>
    #|    <section class="shell section" id="technology">
    #|      <p class="eyebrow">01 / TECHNOLOGY</p>
    $|      <h2>\{ecosystem_label(locale)}</h2>
    $|      <h3>\{localized(locale, "使用案例", "Use cases", "活用事例")}</h3>
    #|      <div class="cards">
    $|        <a href="https://www.moonbitlang.com/updates/2026/09/21/index"><strong>Mooncakes</strong><span>\{localized(locale, "Mooncakes 软件包网站的后端使用 MoonBit 的 Moonback 框架。", "The Mooncakes package registry runs its web backend on Moonback, a MoonBit framework.", "パッケージレジストリ Mooncakes のウェブバックエンドには、MoonBit 製の Moonback が使われています。")}</span><span class="arrow" aria-hidden="true">↗</span></a>
    $|        <a href="https://www.moonbitlang.com/2026-scc/showcase/"><strong>\{localized(locale, "社区作品展示", "Community showcase", "コミュニティ作品集")}</strong><span>\{localized(locale, "探索用 MoonBit 构建的社区项目。", "Explore community projects built with MoonBit.", "MoonBit で作られたコミュニティの作品を見る。")}</span><span class="arrow" aria-hidden="true">↗</span></a>
    #|      </div>
    $|      <h3>\{localized(locale, "开源社区", "Open-source community", "オープンソースコミュニティ")}</h3>
    #|      <div class="cards">
    $|        \{cards}
    #|      </div>
    $|      <h3 id="education">\{localized(locale, "教育", "Education", "教育")}</h3>
    #|      <div class="cards">
    $|        <a href="https://www.moonbitlang.cn/blog/llvm-backend"><strong>\{localized(locale, "北京大学合作课程", "Peking University course", "北京大学との連携授業")}</strong><span>\{localized(locale, "北京大学研究生课程《编程语言的设计原理》将 MoonBit 纳入教学实践。", "Peking University’s graduate course on programming language design uses MoonBit for hands-on work.", "北京大学の大学院科目「プログラミング言語の設計原理」では、演習に MoonBit を採用しています。")}</span><span class="arrow" aria-hidden="true">↗</span></a>
    $|        <a href="https://www.moonbitlang.cn/events/"><strong>\{localized(locale, "MoonBit 校园行", "MoonBit campus outreach", "MoonBit キャンパス交流")}</strong><span>\{localized(locale, "了解 MoonBit 校园活动和校园大使计划。", "Explore MoonBit campus events and the campus ambassador program.", "MoonBit の学内イベントやキャンパスアンバサダー制度を紹介します。")}</span><span class="arrow" aria-hidden="true">↗</span></a>
    #|      </div>
    $|      <h3 id="competitions">\{localized(locale, "赛事", "Competitions", "コンテスト")}</h3>
    #|      <div class="cards">
    $|        <a href="https://www.moonbitlang.cn/2025-mgpic"><strong>\{localized(locale, "2025 MoonBit 全球编程创新挑战赛", "2025 MoonBit Global Programming Innovation Challenge", "2025 MoonBit グローバルプログラミングチャレンジ")}</strong><span class="arrow" aria-hidden="true">↗</span></a>
    $|        <a href="https://www.moonbitlang.com/2026-scc"><strong>\{localized(locale, "2026 MoonBit 软件合成挑战赛", "2026 MoonBit Software Synthesis Challenge", "2026 MoonBit ソフトウェア合成チャレンジ")}</strong><span class="arrow" aria-hidden="true">↗</span></a>
    #|      </div>
    #|    </section>
    #|    <section class="shell section" id="about">
    #|      <p class="eyebrow">02 / ABOUT</p>
    $|      <h2>\{localized(locale, "关于月比特科技", "About Yuebite Technology", "月比特科技について")}</h2>
    $|      <p class="intro">\{localized(locale, "我们关注编程语言、开发工具与开源生态。欢迎从 MoonBit 开始，了解相关技术并参与社区交流。", "We focus on programming languages, developer tools, and open source. Explore MoonBit and join the community.", "私たちはプログラミング言語、開発ツール、オープンソースに取り組んでいます。MoonBit を使って、技術を学び、コミュニティに参加しましょう。")}</p>
    #|    </section>
    #|  </main>
  let about =
    #|  <main id="home">
    #|    <section class="shell company-intro" aria-labelledby="about-title">
    $|      <p class="eyebrow">\{localized(locale, "关于我们", "About us", "私たちについて")}</p>
    $|      <h1 id="about-title">\{localized(locale, "月比特科技", "Yuebite Technology", "月比特科技")}</h1>
    $|      <p class="intro">\{localized(locale, "我们关注编程语言、开发工具与开源生态。欢迎从 MoonBit 开始，了解相关技术并参与社区交流。", "We focus on programming languages, developer tools, and open source. Explore MoonBit and join the community.", "私たちはプログラミング言語、開発ツール、オープンソースに取り組んでいます。MoonBit を使って、技術を学び、コミュニティに参加しましょう。")}</p>
    #|    </section>
    #|    <section class="shell section" aria-labelledby="team">
    $|      <h2 id="team">\{localized(locale, "团队介绍", "Our team", "チーム紹介")}</h2>
    $|      <p class="intro">\{localized(locale, "我们的工作涵盖编程语言、开发工具和开源生态，希望让开发者更容易把想法变成可用的软件。", "We work on programming languages, developer tools, and open source to help developers turn ideas into usable software.", "プログラミング言語、開発ツール、オープンソースを通じて、開発者がアイデアをソフトウェアにできるよう支援します。")}</p>
    #|      <article class="founder-profile">
    $|        <p class="eyebrow">\{localized(locale, "月比特科技创始人", "Founder of Yuebite Technology", "月比特科技の創業者")}</p>
    $|        <h3>\{localized(locale, "张宏波", "Hongbo Zhang", "張宏波（Hongbo Zhang）")}</h3>
    $|        <p>\{localized(locale, "张宏波发起 MoonBit 项目，并带领团队研发编程语言和开发工具链。他主导创建了 ReScript（前身为 BuckleScript），曾是 OCaml 的核心开发者之一。", "Hongbo Zhang started the MoonBit project and leads the development of its programming language and toolchain. He led the creation of ReScript, which grew out of BuckleScript, and was formerly a core OCaml developer.", "張宏波は MoonBit プロジェクトを立ち上げ、プログラミング言語とツールチェーンの開発を率いています。BuckleScript を前身とする ReScript の開発を主導し、かつては OCaml のコア開発者の一人でした。")}</p>
    #|      </article>
    #|    </section>
    #|    <section class="shell section" aria-labelledby="roadmap">
    $|      <h2 id="roadmap">\{localized(locale, "公司发展路线图", "Company roadmap", "会社のロードマップ")}</h2>
    $|      <p>\{localized(locale, "MoonBit 与 SeekMoon 的公开里程碑。", "Public milestones for MoonBit and SeekMoon.", "MoonBit と SeekMoon の公開マイルストーン。")}</p>
    #|      <ol class="roadmap-list">
    $|        <li><time datetime="2023">\{localized(locale, "2023 年", "2023", "2023年")}</time><h3><a href="https://www.moonbitlang.com/blog/first-announce">\{localized(locale, "MoonBit 首次公开亮相", "MoonBit introduced", "MoonBit を初公開")}</a></h3></li>
    $|        <li><time datetime="2026-02-09">\{localized(locale, "2026 年 2 月 9 日", "Feb 9, 2026", "2026年2月9日")}</time><h3><a href="https://www.moonbitlang.com/blog/moonbit-0-8-0-release">\{localized(locale, "MoonBit 0.8.0 发布", "MoonBit 0.8.0 released", "MoonBit 0.8.0 をリリース")}</a></h3></li>
    $|        <li><time datetime="2026-09-01">\{localized(locale, "2026 年 9 月 1 日", "Sep 1, 2026", "2026年9月1日")}</time><h3><a href="https://www.moonbitlang.com/blog/seekmoon-from-ide-to-ade">\{localized(locale, "SeekMoon 公开介绍 Agent 开发环境", "SeekMoon introduces its Agent Development Environment", "SeekMoon がエージェント開発環境を紹介")}</a></h3></li>
    #|      </ol>
    #|    </section>
    #|    <section class="shell section" aria-labelledby="careers">
    $|      <h2 id="careers">\{localized(locale, "加入我们", "Careers", "採用情報")}</h2>
    $|      <p class="intro">\{localized(locale, "这里将发布开放岗位、岗位要求和申请方式。目前尚未发布招聘信息。", "Open roles, requirements, and application details will appear here. No vacancies are currently listed on this page.", "募集職種、応募要件、応募方法をこちらに掲載します。現在、このページに掲載中の求人はありません。")}</p>
    #|    </section>
    #|  </main>
  let contact_page =
    #|  <main id="home" class="contact-page">
    #|    <div class="shell contact-layout">
    #|      <section aria-labelledby="contact-title">
    $|        <p class="eyebrow">\{localized(locale, "联系我们", "Contact us", "お問い合わせ")}</p>
    $|        <h1 id="contact-title">\{localized(locale, "和月比特科技<br>聊聊你的项目。", "Tell us about<br>your project.", "あなたのプロジェクトについて<br>お聞かせください。")}</h1>
    $|        <p>\{localized(locale, "想了解如何在团队中使用 MoonBit 或 SeekMoon？欢迎就产品试用、技术交流与合作联系我们。", "Interested in using MoonBit or SeekMoon with your team? Get in touch about trials, technical questions, or partnerships.", "チームで MoonBit や SeekMoon を使ってみませんか。試用、技術相談、協業についてお気軽にお問い合わせください。")}</p>
    #|      </section>
    #|      <section class="contact-card" aria-labelledby="contact-card-title">
    $|        <h2 id="contact-card-title">\{localized(locale, "开始交流", "Get in touch", "ご相談窓口")}</h2>
    $|        <label for="work-email">\{localized(locale, "工作电子邮箱", "Work email", "勤務先メールアドレス")}</label>
    #|        <input id="work-email" type="email" autocomplete="email" aria-describedby="contact-note" disabled>
    $|        <p id="contact-note">\{localized(locale, "在线表单暂未开放。开源项目相关问题可前往 GitHub 社区交流，请勿公开填写个人信息。", "The online form is not available yet. For open-source questions, visit GitHub. Do not share personal information publicly.", "オンラインフォームは準備中です。オープンソースに関する質問は GitHub へ。個人情報は公開しないでください。")}</p>
    $|        <a class="secondary" href="https://github.com/moonbit-community">\{localized(locale, "前往 GitHub 社区", "Visit the GitHub community", "GitHub コミュニティへ")} ↗</a>
    #|      </section>
    #|    </div>
    #|  </main>
  let footer =
    #|  <footer class="chrome-shell">
    $|    <nav class="footer-index" aria-label="\{localized(locale, "网站索引", "Site index", "サイトマップ")}">
    $|      <div><h2>\{localized(locale, "产品", "Products", "製品")}</h2><ul><li><a href="https://seekmoon.moonbitlang.com/cloud">SeekMoon Cloud ↗</a></li><li><a href="\{home_url}#feature-title">\{localized(locale, "最近动态", "Latest updates", "最新情報")}</a></li></ul></div>
    $|      <div><h2>\{localized(locale, "开发者", "Developers", "開発者")}</h2><ul><li><a href="\{developer_url}">\{localized(locale, "MoonBit 官网", "MoonBit website", "MoonBit 公式サイト")} ↗</a></li><li><a href="https://mooncakes.io/">\{localized(locale, "软件包与模块", "Packages and modules", "パッケージとモジュール")} ↗</a></li></ul></div>
    $|      <div><h2>\{localized(locale, "开源生态", "Open source", "オープンソース")}</h2><ul><li><a href="\{home_url}#technology">\{localized(locale, "技术与生态", "Technology and ecosystem", "技術とエコシステム")}</a></li><li><a href="https://github.com/moonbit-community">\{localized(locale, "MoonBit 开源社区", "MoonBit open-source community", "MoonBit オープンソースコミュニティ")} ↗</a></li></ul></div>
    $|      <div><h2>\{localized(locale, "公司", "Company", "会社情報")}</h2><ul><li><a href="./company\{suffix}.html">\{localized(locale, "关于我们", "About us", "私たちについて")}</a></li><li><a href="./contact\{suffix}.html">\{localized(locale, "联系我们", "Contact us", "お問い合わせ")}</a></li></ul></div>
    $|      <div><h2>\{localized(locale, "更多", "More", "その他")}</h2><ul><li><a href="https://github.com/moonbit-community/yuebite-website">\{localized(locale, "官网源代码", "Website source code", "サイトのソースコード")} ↗</a></li></ul></div>
    #|    </nav>
    #|    <div class="footer">
    $|    <nav class="footer-links" aria-label="\{localized(locale, "社区链接", "Community links", "コミュニティリンク")}">
    $|      <a href="https://github.com/moonbit-community" aria-label="\{localized(locale, "MoonBit 开源社区", "MoonBit open-source community", "MoonBit オープンソースコミュニティ")} GitHub"><svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12 .75a11.25 11.25 0 0 0-3.56 21.92c.56.1.77-.24.77-.54v-2.1c-3.13.68-3.79-1.33-3.79-1.33-.51-1.3-1.25-1.65-1.25-1.65-1.02-.7.08-.68.08-.68 1.14.08 1.73 1.16 1.73 1.16 1 .73 1.79.84 3.26.53.1-.73.39-1.23.71-1.51-2.5-.29-5.13-1.25-5.13-5.56 0-1.23.44-2.23 1.16-3.02-.12-.29-.5-1.43.11-2.98 0 0 .95-.3 3.09 1.15a10.78 10.78 0 0 1 5.63 0c2.14-1.45 3.08-1.15 3.08-1.15.61 1.55.23 2.69.12 2.98.72.79 1.15 1.79 1.15 3.02 0 4.32-2.63 5.27-5.14 5.55.4.35.76 1.03.76 2.08v3.51c0 .3.2.65.77.54A11.25 11.25 0 0 0 12 .75Z"/></svg></a>
    $|      <button type="button" popovertarget="social-wechat" aria-label="\{localized(locale, "微信公众号", "WeChat Official Account", "WeChat 公式アカウント")}" title="\{localized(locale, "微信公众号", "WeChat Official Account", "WeChat 公式アカウント")}"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M12 5C7 1 1 5 2 10c0 2 1 3 2 4l-1 3 4-2h2m7-7c-4 0-7 3-7 6s3 6 7 6l2-.3 3 1.3-.5-3c1-1 1.5-2 1.5-4 0-3-2.7-6-6-6Z"/><path d="M6 8h1m3 0h1m2 5h1m3 0h1"/></svg></button>
    $|      <button type="button" popovertarget="social-rednote" aria-label="\{localized(locale, "小红书", "RedNote", "小紅書")}" title="\{localized(locale, "小红书", "RedNote", "小紅書")}"><svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true"><rect width="24" height="24" rx="5" fill="currentColor"/><text x="12" y="15" text-anchor="middle" font-size="7" font-weight="700" fill="white">\{localized(locale, "小红书", "RedNote", "小紅書")}</text></svg></button>
    $|      <a href="https://x.com/Moonbitlang" aria-label="\{localized(locale, "MoonBit 的 X 账号", "MoonBit on X", "MoonBit の X アカウント")}" title="X"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M3 3h4l14 18h-4L3 3Zm17 0-7 8m-2 2-7 8"/></svg></a>
    $|      <div class="social-panel" id="social-wechat" popover><strong>\{localized(locale, "微信公众号", "WeChat Official Account", "WeChat 公式アカウント")}</strong><p>\{localized(locale, "在微信的公众号搜索中输入 ", "Search WeChat Official Accounts for ", "WeChat の公式アカウント検索で入力：")}<b>moonbit</b>。</p><button type="button" popovertarget="social-wechat" popovertargetaction="hide">\{localized(locale, "关闭", "Close", "閉じる")}</button></div>
    $|      <div class="social-panel" id="social-rednote" popover><strong>\{localized(locale, "小红书", "RedNote", "小紅書")}</strong><p>\{localized(locale, "在小红书搜索 ", "Search RedNote for ", "小紅書で検索：")}<b>MoonBit 月兔</b>。</p><button type="button" popovertarget="social-rednote" popovertargetaction="hide">\{localized(locale, "关闭", "Close", "閉じる")}</button></div>
    #|    </nav>
    $|    <div class="footer-meta"><span>© \{localized(locale, "月比特科技", "Yuebite Technology", "月比特科技")}</span><a href="#home">\{localized(locale, "返回顶部", "Back to top", "ページ上部へ")} ↑</a></div>
    $|    <details class="locale-picker"><summary class="footer-locale"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><circle cx="12" cy="12" r="9"/><ellipse cx="12" cy="12" rx="4" ry="9"/><path d="M3 12h18"/></svg>\{language_name(locale)}</summary><div class="locale-options">\{language_links}</div></details>
    #|    </div>
    #|  </footer>
    #|</body>
    #|</html>
  let page = if contact { contact_page } else if company { about } else { home }
  println(header + "\n" + page + "\n" + footer)
}
