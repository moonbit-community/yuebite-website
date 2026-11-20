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
  let page_name = if contact { "contact" } else if company { "company" } else if args.contains("--education") { "education" } else if args.contains("--competitions") { "competitions" } else if args.contains("--events") { "events" } else if args.contains("--ecosystem") { "ecosystem" } else if args.contains("--news") { "news" } else { "index" }
  let home_url = if suffix == "" { "./" } else { "./index" + suffix + ".html" }
  let brand = localized(locale, "月比特科技", "Yuebite Technology", "月比特科技")
  let about_label = localized(locale, "关于我们", "About us", "私たちについて")
  let contact_label = localized(locale, "联系我们", "Contact us", "お問い合わせ")
  let language_label = localized(locale, "MoonBit 编程语言", "MoonBit Programming Language", "MoonBit プログラミング言語")
  let ecosystem_nav_label = localized(locale, "生态", "Ecosystem", "エコシステム")
  let education_label = localized(locale, "教育", "Education", "教育")
  let competitions_label = localized(locale, "赛事", "Competitions", "コンテスト")
  let events_label = localized(locale, "活动", "Events", "イベント")
  let news_label = localized(locale, "最新动态", "Latest updates", "最新情報")
  let news_url = "./news" + suffix + ".html"
  let news_current = if page_name == "news" { " aria-current=\"page\"" } else { "" }
  let title = match page_name {
    "news" => news_label + " | " + brand
    "contact" => contact_label + " | " + brand
    "company" => about_label + " | " + brand
    "education" => education_label + " | " + brand
    "competitions" => competitions_label + " | " + brand
    "events" => events_label + " | " + brand
    "ecosystem" => ecosystem_label(locale) + " | " + brand
    _ => brand
  }
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
    #|  <link rel="stylesheet" href="./site.css?v=20261120-1">
    #|</head>
    #|<body>
    #|  <header class="chrome-shell top">
    $|    <a class="brand" href="\{home_url}"><img src="./moonbit-wordmark.png" alt="MoonBit" width="677" height="173"></a>
    $|    <nav aria-label="\{localized(locale, "主导航", "Main navigation", "メインナビゲーション")}">
    $|      <a href="https://seekmoon.moonbitlang.com/">\{localized(locale, "SeekMoon 智能体", "SeekMoon Agent", "SeekMoon エージェント")}</a>
    $|      <a href="\{developer_url}">\{language_label}</a>
    $|      <details class="ecosystem-nav"><summary>\{ecosystem_nav_label}</summary><div class="ecosystem-menu"><a href="https://mooncakes.io/">Mooncakes ↗</a><a href="./education\{suffix}.html">\{education_label}</a><a href="./competitions\{suffix}.html">\{competitions_label}</a><a href="./events\{suffix}.html">\{events_label}</a></div></details>
    $|      <a href="\{news_url}"\{news_current}>\{news_label}</a>
    $|      <a href="./company\{suffix}.html"\{company_current}>\{about_label}</a>
    #|    </nav>
    $|    <div class="nav-actions"><a href="./contact\{suffix}.html">\{localized(locale, "联系我们", "Contact us", "お問い合わせ")}</a><a class="nav-action" href="https://seekmoon.moonbitlang.com/">\{localized(locale, "试用 SeekMoon", "Try SeekMoon", "SeekMoon を試す")} ↗</a></div>
    #|  </header>
  let home =
    #|  <main id="home">
    #|    <section class="hero shell" aria-labelledby="headline">
    #|      <div class="hero-text">
    $|        <h1 id="headline">\{brand}</h1>
    $|        <p class="hero-intro">\{localized(locale, "我们打造 MoonBit 编程语言和 SeekMoon 智能体，希望让软件创作不再是少数人的专长，让更多人把想象变成改变世界的作品。", "We build the MoonBit programming language and the SeekMoon agent with a vision: a world where more people can create software and turn their ideas into things that change the world.", "私たちはプログラミング言語 MoonBit と AI エージェント SeekMoon を開発し、より多くの人がソフトウェアをつくり、想像を世界を変える作品へと形にできる未来を目指します。")}</p>
    $|        <a class="prompt" href="https://seekmoon.moonbitlang.com/"><span>\{localized(locale, "用 SeekMoon，把想法变成项目", "Turn your ideas into projects with SeekMoon", "SeekMoon でアイデアをプロジェクトに")}</span><span class="prompt-action">\{localized(locale, "试用 SeekMoon", "Try SeekMoon", "SeekMoon を試す")} <span aria-hidden="true">↗</span></span></a>
    $|        <div class="actions"><a class="secondary" href="\{developer_url}">MoonBit</a><a class="secondary" href="https://mooncakes.io/">Mooncakes</a><a class="secondary" href="./ecosystem\{suffix}.html">\{localized(locale, "开源生态", "Open source", "オープンソース")}</a><a class="secondary" href="./company\{suffix}.html">\{localized(locale, "关于我们", "About us", "私たちについて")}</a></div>
    #|      </div>
    #|    </section>
    #|    <section class="updates shell" id="feature-title" aria-labelledby="updates-title">
    $|      <div class="updates-controls"><h2 id="updates-title">\{localized(locale, "最近动态", "Latest updates", "最新情報")}</h2>
    $|        <fieldset><legend class="updates-visually-hidden">\{localized(locale, "切换文章", "Select an article", "記事を切り替える")}</legend><label><input type="radio" name="updates-slide" value="1" checked><span>01</span></label><label><input type="radio" name="updates-slide" value="2"><span>02</span></label></fieldset>
    #|      </div>
    #|      <article class="feature" data-slide="1">
    $|      <img class="feature-logo" src="./news-carousel-downloads.jpg" alt="\{localized(locale, "MoonBit 累计下载突破 1060 万，月比特科技成立", "MoonBit reaches 10.6 million downloads; Yuebite Technology is founded", "MoonBit の累計ダウンロード数が1,060万を突破、月比特科技が設立")}">
    $|      <div class="feature-copy"><p class="eyebrow">\{localized(locale, "微信公众号", "WeChat Official Account", "WeChat 公式アカウント")}</p><h3>\{localized(locale, "MoonBit 累计下载突破 1060 万", "MoonBit passes 10.6 million downloads", "MoonBit の累計ダウンロード数が1,060万を突破")}</h3><a href="https://mp.weixin.qq.com/s/Sd7Zv89bSiz7aZOEEi_KMg">\{localized(locale, "阅读公众号文章", "Read the article in Chinese", "中国語の記事を読む")} ↗</a></div>
    #|      </article>
    #|      <article class="feature" data-slide="2">
    $|        <img class="feature-logo" src="./news-carousel-meetup.jpg" alt="\{localized(locale, "MoonBit 1.0 发布 Meetup 暨黑客松季度决赛", "MoonBit 1.0 launch meetup and hackathon finals", "MoonBit 1.0 発表ミートアップとハッカソン決勝")}">
    $|        <div class="feature-copy"><p class="eyebrow">\{localized(locale, "微信公众号", "WeChat Official Account", "WeChat 公式アカウント")}</p><h3>\{localized(locale, "MoonBit 1.0 发布 Meetup", "MoonBit 1.0 launch meetup", "MoonBit 1.0 発表ミートアップ")}</h3><a href="https://mp.weixin.qq.com/s/cnsj6Z1V9PCEKnb3wbSv0g">\{localized(locale, "阅读公众号文章", "Read the article in Chinese", "中国語の記事を読む")} ↗</a></div>
    #|      </article>
    #|    </section>
    #|    <script>
    #|      {
    #|        const updates = document.getElementById('feature-title');
    #|        const slides = Array.from(updates.querySelectorAll('input[name="updates-slide"]'));
    #|        const motion = matchMedia('(prefers-reduced-motion: reduce)');
    #|        setInterval(() => {
    #|          if (motion.matches || document.hidden || updates.matches(':hover') || updates.contains(document.activeElement)) return;
    #|          const current = slides.findIndex(slide => slide.checked);
    #|          slides[(current + 1) % slides.length].checked = true;
    #|        }, 6000);
    #|      }
    #|    </script>
    #|    <section class="shell seekmoon-cta" aria-labelledby="seekmoon-cta-title">
    $|      <h2 id="seekmoon-cta-title">\{localized(locale, "开始使用 SeekMoon", "Get started with SeekMoon", "SeekMoon を始める")}</h2>
    $|      <a href="https://seekmoon.moonbitlang.com/">\{localized(locale, "打开云端工作台", "Open the cloud workspace", "クラウドワークスペースを開く")} <span aria-hidden="true">↗</span></a>
    #|    </section>
    #|  </main>
  let ecosystem_page =
    #|  <main id="home">
    #|    <section class="shell section" id="technology">
    #|      <p class="eyebrow">01 / TECHNOLOGY</p>
    $|      <h1>\{ecosystem_label(locale)}</h1>
    $|      <h3>\{localized(locale, "使用案例", "Use cases", "活用事例")}</h3>
    #|      <div class="cards">
    $|        <a href="https://www.moonbitlang.com/updates/2026/09/21/index"><strong>Mooncakes</strong><span>\{localized(locale, "Mooncakes 软件包网站的后端使用 MoonBit 的 Moonback 框架。", "The Mooncakes package registry runs its web backend on Moonback, a MoonBit framework.", "パッケージレジストリ Mooncakes のウェブバックエンドには、MoonBit 製の Moonback が使われています。")}</span><span class="arrow" aria-hidden="true">↗</span></a>
    $|        <a href="https://www.moonbitlang.com/2026-scc/showcase/"><strong>\{localized(locale, "社区作品展示", "Community showcase", "コミュニティ作品集")}</strong><span>\{localized(locale, "探索用 MoonBit 构建的社区项目。", "Explore community projects built with MoonBit.", "MoonBit で作られたコミュニティの作品を見る。")}</span><span class="arrow" aria-hidden="true">↗</span></a>
    #|      </div>
    $|      <h3>\{localized(locale, "开源社区", "Open-source community", "オープンソースコミュニティ")}</h3>
    #|      <div class="cards">
    $|        \{cards}
    #|      </div>
    #|    </section>
    #|  </main>
  let education_page =
    #|  <main id="home"><section class="shell section">
    $|      <h1>\{education_label}</h1>
    #|      <div class="cards">
    $|        <a href="https://www.moonbitlang.cn/blog/llvm-backend"><strong>\{localized(locale, "北京大学合作课程", "Peking University course", "北京大学との連携授業")}</strong><span>\{localized(locale, "北京大学研究生课程《编程语言的设计原理》将 MoonBit 纳入教学实践。", "Peking University’s graduate course on programming language design uses MoonBit for hands-on work.", "北京大学の大学院科目「プログラミング言語の設計原理」では、演習に MoonBit を採用しています。")}</span><span class="arrow" aria-hidden="true">↗</span></a>
    $|        <a href="https://www.moonbitlang.cn/events/"><strong>\{localized(locale, "MoonBit 校园行", "MoonBit campus outreach", "MoonBit キャンパス交流")}</strong><span>\{localized(locale, "了解 MoonBit 校园活动和校园大使计划。", "Explore MoonBit campus events and the campus ambassador program.", "MoonBit の学内イベントやキャンパスアンバサダー制度を紹介します。")}</span><span class="arrow" aria-hidden="true">↗</span></a>
    #|      </div>
    #|  </section></main>
  let competitions_page =
    #|  <main id="home"><section class="shell section">
    $|      <h1>\{competitions_label}</h1>
    #|      <div class="cards">
    $|        <a href="https://www.moonbitlang.cn/2025-mgpic"><strong>\{localized(locale, "2025 MoonBit 全球编程创新挑战赛", "2025 MoonBit Global Programming Innovation Challenge", "2025 MoonBit グローバルプログラミングチャレンジ")}</strong><span class="arrow" aria-hidden="true">↗</span></a>
    $|        <a href="https://www.moonbitlang.com/2026-scc"><strong>\{localized(locale, "2026 MoonBit 软件合成挑战赛", "2026 MoonBit Software Synthesis Challenge", "2026 MoonBit ソフトウェア合成チャレンジ")}</strong><span class="arrow" aria-hidden="true">↗</span></a>
    #|      </div>
    #|    </section>
    #|  </main>
  let events_page =
    #|  <main id="home"><section class="shell section news-index events-index" aria-labelledby="events-title">
    $|      <h1 id="events-title">\{events_label}</h1>
    $|      <p>\{localized(locale, "了解 MoonBit 的线下聚会与开发者社区活动。", "Explore MoonBit meetups and developer community events.", "MoonBit のミートアップや開発者コミュニティのイベントをご紹介します。")}</p>
    #|      <div class="news-grid">
    #|        <article><a class="news-story" href="https://mp.weixin.qq.com/s/cnsj6Z1V9PCEKnb3wbSv0g">
    #|          <img src="./news-moonbit-meetup.jpg" alt="">
    $|          <h2>\{localized(locale, "MoonBit 1.0 发布 Meetup 暨黑客松季度决赛", "MoonBit 1.0 launch meetup and hackathon finals", "MoonBit 1.0 発表ミートアップとハッカソン決勝")}</h2>
    #|          <span class="news-arrow" aria-hidden="true">↗</span>
    $|          <p class="event-description">\{localized(locale, "一场围绕 MoonBit 1.0 发布与黑客松季度决赛的社区聚会。", "A community meetup for the MoonBit 1.0 launch and the quarterly hackathon finals.", "MoonBit 1.0 の発表とハッカソンの四半期決勝を行うコミュニティイベントです。")}</p>
    $|          <p class="news-meta">\{localized(locale, "活动详情 · 微信公众号", "Event details · WeChat (Chinese)", "イベント詳細・WeChat（中国語）")}</p>
    #|        </a></article>
    #|      </div>
    #|  </section></main>
  let news_page =
    #|  <main id="home"><section class="shell section news-index news-archive" aria-labelledby="news-title">
    $|      <h1 id="news-title">\{news_label}</h1>
    $|      <p>\{localized(locale, "查看月比特科技的近期报道与活动消息。以下原文为中文。", "Read recent coverage and event announcements from Yuebite Technology. The articles are in Chinese.", "月比特科技の最近の記事やイベント情報をご覧ください。記事は中国語です。")}</p>
    #|      <div class="news-grid">
    #|        <article><a class="news-story" href="https://mp.weixin.qq.com/s/cnsj6Z1V9PCEKnb3wbSv0g">
    #|          <img src="./news-moonbit-meetup.jpg" alt="">
    $|          <p class="news-meta">\{localized(locale, "活动预告 · 微信公众号", "Event announcement · WeChat", "イベント告知・WeChat")}</p>
    $|          <h2>\{localized(locale, "MoonBit 1.0 发布 Meetup 暨黑客松季度决赛", "MoonBit 1.0 launch meetup and hackathon finals", "MoonBit 1.0 発表ミートアップとハッカソン決勝")}</h2>
    #|          <span class="news-arrow" aria-hidden="true">↗</span>
    #|        </a></article>
    #|        <article><a class="news-story" href="https://mp.weixin.qq.com/s/Sd7Zv89bSiz7aZOEEi_KMg">
    #|          <img src="./news-moonbit-downloads.jpg" alt="">
    $|          <p class="news-meta">\{localized(locale, "MoonBit 动态 · 微信公众号", "MoonBit news · WeChat", "MoonBit ニュース・WeChat")}</p>
    $|          <h2>\{localized(locale, "MoonBit 累计下载突破 1060 万", "MoonBit passes 10.6 million downloads", "MoonBit の累計ダウンロード数が1,060万を突破")}</h2>
    #|          <span class="news-arrow" aria-hidden="true">↗</span>
    #|        </a></article>
    #|      </div>
    #|  </section></main>
  let about =
    #|  <main id="home">
    #|    <section class="shell company-intro" aria-labelledby="about-title">
    $|      <p class="eyebrow">\{localized(locale, "关于我们", "About us", "私たちについて")}</p>
    $|      <h1 id="about-title">\{localized(locale, "月比特科技", "Yuebite Technology", "月比特科技")}</h1>
    $|      <p class="intro">\{localized(locale, "我们关注编程语言、开发工具与开源生态。欢迎从 MoonBit 开始，了解相关技术并参与社区交流。", "We focus on programming languages, developer tools, and open source. Explore MoonBit and join the community.", "私たちはプログラミング言語、開発ツール、オープンソースに取り組んでいます。MoonBit を使って、技術を学び、コミュニティに参加しましょう。")}</p>
    #|    </section>
    #|    <section class="shell section" aria-labelledby="team">
    $|      <h2 id="team">\{localized(locale, "团队介绍", "Our team", "チーム紹介")}</h2>
    #|      <article class="founder-profile">
    $|        <img class="founder-photo" src="./founder-hongbo-zhang.png" alt="\{localized(locale, "张宏波", "Hongbo Zhang", "張宏波")}" width="533" height="800" loading="lazy">
    #|        <div class="founder-copy">
    $|        <h3>\{localized(locale, "张宏波", "Hongbo Zhang", "張宏波（Hongbo Zhang）")}</h3>
    $|        <p class="founder-title">\{localized(locale, "月比特科技创始人", "Founder of Yuebite Technology", "月比特科技の創業者")}</p>
    $|        <p>\{localized(locale, "张宏波发起 MoonBit 项目，并带领团队研发编程语言和开发工具链。他主导创建了 ReScript（前身为 BuckleScript），曾是 OCaml 的核心开发者之一。", "Hongbo Zhang started the MoonBit project and leads the development of its programming language and toolchain. He led the creation of ReScript, which grew out of BuckleScript, and was formerly a core OCaml developer.", "張宏波は MoonBit プロジェクトを立ち上げ、プログラミング言語とツールチェーンの開発を率いています。BuckleScript を前身とする ReScript の開発を主導し、かつては OCaml のコア開発者の一人でした。")}</p>
    $|        <p>\{localized(locale, "他本科毕业于清华大学电子工程系，曾在宾夕法尼亚大学从事编程语言方向的博士研究。他的研究涵盖编程语言设计与实现、编译器及多后端工具链、函数式语言和类型系统。", "He earned his undergraduate degree in electronic engineering from Tsinghua University and pursued doctoral research in programming languages at the University of Pennsylvania. His research spans language design and implementation, compilers and multi-backend toolchains, functional programming, and type systems.", "清華大学電子工程系を卒業し、ペンシルベニア大学でプログラミング言語の博士課程の研究に取り組みました。研究分野は言語設計と実装、コンパイラとマルチバックエンドのツールチェーン、関数型言語、型システムです。")}</p>
    $|        <a href="https://mp.weixin.qq.com/s/bXy3MRiLLXd9RKvLBSo3wA">\{localized(locale, "阅读创始人专访", "Read the interview in Chinese", "中国語のインタビューを読む")} ↗</a>
    #|        </div>
    #|      </article>
    #|    </section>
    #|    <section class="shell section" aria-labelledby="roadmap">
    $|      <h2 id="roadmap">\{localized(locale, "公司发展路线图", "Company roadmap", "会社のロードマップ")}</h2>
    $|      <p>\{localized(locale, "MoonBit 与月比特科技的发展里程碑。", "Milestones for MoonBit and Yuebite Technology.", "MoonBit と月比特科技の歩み。")}</p>
    #|      <ol class="roadmap-list" role="list">
    $|        <li><time datetime="2022-09">\{localized(locale, "2022 年 9 月", "Sep 2022", "2022年9月")}</time><h3><a href="https://www.moonbitlang.cn/blog/moonbit-third-anniversary">\{localized(locale, "MoonBit 项目正式立项", "MoonBit project begins", "MoonBit プロジェクトが正式に始動")}</a></h3></li>
    $|        <li><time datetime="2023-08">\{localized(locale, "2023 年 8 月", "Aug 2023", "2023年8月")}</time><h3><a href="https://www.moonbitlang.com/blog/first-announce">\{localized(locale, "MoonBit 首次公开发布", "MoonBit first public release", "MoonBit を初公開")}</a></h3></li>
    $|        <li><time datetime="2025-06">\{localized(locale, "2025 年 6 月", "Jun 2025", "2025年6月")}</time><h3><a href="https://www.moonbitlang.cn/about-us/">\{localized(locale, "MoonBit Beta 发布", "MoonBit Beta released", "MoonBit Beta をリリース")}</a></h3></li>
    $|        <li><time datetime="2026-02">\{localized(locale, "2026 年 2 月", "Feb 2026", "2026年2月")}</time><h3><a href="https://www.moonbitlang.com/blog/moonbit-0-8-0-release">\{localized(locale, "MoonBit 0.8.0 发布", "MoonBit 0.8.0 released", "MoonBit 0.8.0 をリリース")}</a></h3></li>
    $|        <li><h3>\{localized(locale, "深圳月比特科技有限公司成立", "Yuebite Technology is founded in Shenzhen", "深圳月比特科技有限公司を設立")}</h3></li>
    $|        <li><time datetime="2026-11">\{localized(locale, "2026 年 11 月 · 计划", "Nov 2026 · Planned", "2026年11月・予定")}</time><h3>\{localized(locale, "MoonBit 1.0 发布 Meetup", "MoonBit 1.0 launch meetup", "MoonBit 1.0 発表ミートアップ")}</h3></li>
    #|      </ol>
    #|    </section>
    #|    <section class="shell section" aria-labelledby="careers">
    $|      <h2 id="careers">\{localized(locale, "加入我们", "Careers", "採用情報")}</h2>
    #|      <article class="job">
    $|        <h3>\{localized(locale, "开发者社区经营经理", "Developer Community Manager", "開発者コミュニティマネージャー")}</h3>
    $|        <p>\{localized(locale, "一篇清晰的技术内容、一场有收获的活动、一次及时的交流，都可能成为开发者走近 MoonBit 的起点。我们期待你连接开源贡献者、高校与技术社区，帮助更多开发者了解 MoonBit、上手使用，并参与共建。", "Help developers discover, learn, and contribute to MoonBit through clear technical content, useful events, and timely conversations.", "技術コンテンツやイベント、日々の対話を通じて、開発者が MoonBit を知り、使い、開発に参加できるよう支援します。")}</p>
    #|        <details>
    $|          <summary>\{localized(locale, "查看完整岗位说明", "View full job description", "募集要項を見る")}</summary>
    $|          <h4>\{localized(locale, "你将参与", "Responsibilities", "業務内容")}</h4>
    $|          <ul><li>\{localized(locale, "开发者社群运营：连接开源贡献者、高校及技术社区，促进交流与共建。", "Connect open-source contributors, universities, and technical communities.", "オープンソース貢献者、大学、技術コミュニティをつなぐ。")}</li><li>\{localized(locale, "技术内容策划：帮助更多开发者了解、使用 MoonBit。", "Plan technical content that helps developers get started with MoonBit.", "MoonBit の理解と活用を促す技術コンテンツを企画する。")}</li><li>\{localized(locale, "社区活动执行：推进活动落地，为开发者创造交流与参与的机会。", "Run community events that bring developers together.", "開発者の交流や参加の機会となるイベントを運営する。")}</li></ul>
    $|          <h4>\{localized(locale, "我们希望你有", "Qualifications", "応募要件")}</h4>
    $|          <p>\{localized(locale, "有社区、内容或活动运营经验；对编程与开源感兴趣，愿意动手体验开发工具；擅长写作、沟通与项目执行。", "Experience in community, content, or event operations; interest in programming and open source; willingness to try developer tools; strong writing, communication, and execution skills.", "コミュニティ、コンテンツ、イベントのいずれかの運営経験。プログラミングやオープンソースへの関心、開発ツールを試す意欲、文章力・コミュニケーション力・実行力。")}</p>
    $|          <p>\{localized(locale, "加分项：有开源社区、AI 编程工具或海外社区运营经验。", "A plus: experience with open-source communities, AI coding tools, or international community operations.", "歓迎要件：オープンソースコミュニティ、AI コーディングツール、海外コミュニティの運営経験。")}</p>
    #|        </details>
    $|        <a class="secondary" href="https://m.zhipin.com/mpa/html/weijd/weijd-job/1293df3be8a5abb20nx_39m-EFJQ?date8=20261110&amp;sid=tosee_jd_31a7d83e868b63c81Hx-39y_GVo~&amp;openWeapp=1&amp;fromSource=2">\{localized(locale, "去 BOSS 直聘投递", "Apply on BOSS Zhipin", "BOSS直聘で応募する")} →</a>
    #|      </article>
    #|      <article class="job">
    $|        <h3>\{localized(locale, "Agent 产品经理", "Agent Product Manager", "エージェントプロダクトマネージャー")}</h3>
    $|        <p>\{localized(locale, "从应用搭建、工具制作到内容生成，Agent 产品需要理解用户想完成什么，组织合适的工具，并持续打磨从想法到成果交付的体验。我们期待你参与 MoonBit Agent 智能体产品建设。", "Build the MoonBit Agent product around what users want to accomplish, from creating apps and tools to generating content and delivering results.", "アプリ構築、ツール作成、コンテンツ生成など、ユーザーのアイデアを成果につなげる MoonBit Agent の体験をつくります。")}</p>
    #|        <details>
    $|          <summary>\{localized(locale, "查看完整岗位说明", "View full job description", "募集要項を見る")}</summary>
    $|          <h4>\{localized(locale, "你将参与", "Responsibilities", "業務内容")}</h4>
    $|          <ul><li>\{localized(locale, "Agent 产品建设：围绕应用搭建、工具制作与内容生成，打造从想法到成果交付的完整体验。", "Design end-to-end workflows for building apps and tools and generating content.", "アプリ構築、ツール作成、コンテンツ生成の一連の体験を設計する。")}</li><li>\{localized(locale, "工具集成与产品迭代：推动工具能力集成，持续完善产品体验。", "Integrate tools and improve the product through iteration.", "ツールの統合を進め、製品体験を継続的に改善する。")}</li><li>\{localized(locale, "商业化推进：兼顾用户价值与商业价值，推动产品商业化。", "Drive commercialization while balancing user and business value.", "ユーザー価値と事業価値を両立しながら事業化を進める。")}</li></ul>
    $|          <h4>\{localized(locale, "我们希望你有", "Qualifications", "応募要件")}</h4>
    $|          <p>\{localized(locale, "3 年以上产品或研发经验，具备开发者工具研发背景；理解 LLM、Agent、上下文管理与工具调用；深度使用过 Claude Code、Codex、Cursor 等产品；兼具用户洞察、产品判断与商业意识。", "At least three years in product or engineering, with a developer-tool engineering background. Understand LLMs, agents, context management, and tool calling. Have hands-on experience with tools like Claude Code, Codex, and Cursor, plus sound user, product, and business judgment.", "製品企画または開発の経験が3年以上あり、開発者向けツールの開発経験があること。LLM、エージェント、コンテキスト管理、ツール呼び出しを理解し、Claude Code、Codex、Cursor などを使い込んでいること。ユーザー理解、製品判断、事業感覚を備えていること。")}</p>
    $|          <p>\{localized(locale, "加分项：有 Agent 产品从 0 到 1、MCP 生态或商业化经验。", "A plus: experience launching an agent product from scratch, working with the MCP ecosystem, or commercializing a product.", "歓迎要件：エージェント製品の立ち上げ、MCP エコシステム、事業化の経験。")}</p>
    #|        </details>
    $|        <a class="secondary" href="https://m.zhipin.com/mpa/html/weijd/weijd-job/9afa82af0fb42f7e0nx_39m7FVFT?date8=20261110&amp;sid=tosee_jd_31a7d83e868b63c81Hx-39y_GVo~&amp;openWeapp=1&amp;fromSource=2&amp;_security_check=1_1795141545227">\{localized(locale, "去 BOSS 直聘投递", "Apply on BOSS Zhipin", "BOSS直聘で応募する")} →</a>
    #|      </article>
    $|      <h3>\{localized(locale, "工作地点与薪酬福利", "Location, pay, and benefits", "勤務地・給与・福利厚生")}</h3>
    $|      <ul><li>\{localized(locale, "深圳 · 线下办公", "Shenzhen · On-site", "深圳・オフィス勤務")}</li><li>\{localized(locale, "提供有竞争力的薪酬，优秀人才待遇可进一步商议。", "Competitive pay, with room to negotiate for exceptional candidates.", "競争力のある給与。経験や能力に応じて個別に相談できます。")}</li><li>\{localized(locale, "补充医疗、房补等福利。", "Supplemental medical coverage and a housing allowance.", "補足医療保険や住宅手当など。")}</li></ul>
    #|    </section>
    #|  </main>
  let contact_page =
    #|  <main id="home" class="contact-page">
    #|    <div class="shell contact-layout">
    #|      <section aria-labelledby="contact-title">
    $|        <h1 id="contact-title" class="eyebrow">\{contact_label}</h1>
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
    $|      <div><h2>\{localized(locale, "SeekMoon 智能体", "SeekMoon Agent", "SeekMoon エージェント")}</h2><ul><li><a href="https://seekmoon.moonbitlang.com/">SeekMoon Cloud ↗</a></li></ul></div>
    $|      <div><h2>\{language_label}</h2><ul><li><a href="\{developer_url}">\{localized(locale, "MoonBit 官网", "MoonBit website", "MoonBit 公式サイト")} ↗</a></li></ul></div>
    $|      <div><h2>\{ecosystem_nav_label}</h2><ul><li><a href="https://mooncakes.io/">Mooncakes ↗</a></li><li><a href="./education\{suffix}.html">\{education_label}</a></li><li><a href="./competitions\{suffix}.html">\{competitions_label}</a></li><li><a href="./events\{suffix}.html">\{events_label}</a></li><li><a href="./ecosystem\{suffix}.html">\{ecosystem_label(locale)}</a></li></ul></div>
    $|      <div><h2><a href="\{news_url}">\{news_label}</a></h2></div>
    $|      <div><h2><a href="./company\{suffix}.html">\{about_label}</a></h2><ul><li><a href="./contact\{suffix}.html">\{contact_label}</a></li><li><a href="https://github.com/moonbit-community/yuebite-website">\{localized(locale, "官网源代码", "Website source code", "サイトのソースコード")} ↗</a></li></ul></div>
    #|    </nav>
    #|    <div class="footer">
    $|    <nav class="footer-links" aria-label="\{localized(locale, "社区链接", "Community links", "コミュニティリンク")}">
    $|      <a href="https://github.com/moonbit-community" aria-label="\{localized(locale, "MoonBit 开源社区", "MoonBit open-source community", "MoonBit オープンソースコミュニティ")} GitHub"><svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12 .75a11.25 11.25 0 0 0-3.56 21.92c.56.1.77-.24.77-.54v-2.1c-3.13.68-3.79-1.33-3.79-1.33-.51-1.3-1.25-1.65-1.25-1.65-1.02-.7.08-.68.08-.68 1.14.08 1.73 1.16 1.73 1.16 1 .73 1.79.84 3.26.53.1-.73.39-1.23.71-1.51-2.5-.29-5.13-1.25-5.13-5.56 0-1.23.44-2.23 1.16-3.02-.12-.29-.5-1.43.11-2.98 0 0 .95-.3 3.09 1.15a10.78 10.78 0 0 1 5.63 0c2.14-1.45 3.08-1.15 3.08-1.15.61 1.55.23 2.69.12 2.98.72.79 1.15 1.79 1.15 3.02 0 4.32-2.63 5.27-5.14 5.55.4.35.76 1.03.76 2.08v3.51c0 .3.2.65.77.54A11.25 11.25 0 0 0 12 .75Z"/></svg></a>
    #|      <div class="footer-wechat">
    $|        <button type="button" aria-label="\{localized(locale, "微信公众号二维码", "WeChat QR code", "WeChat のQRコード")}" popovertarget="footer-wechat-code"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M12 5C7 1 1 5 2 10c0 2 1 3 2 4l-1 3 4-2h2m7-7c-4 0-7 3-7 6s3 6 7 6l2-.3 3 1.3-.5-3c1-1 1.5-2 1.5-4 0-3-2.7-6-6-6Z"/><path d="M6 8h1m3 0h1m2 5h1m3 0h1"/></svg></button>
    $|        <figure class="footer-wechat-preview" aria-hidden="true"><img src="./wechat-yuebite.png" alt="" width="148" height="148"><figcaption>\{brand}</figcaption></figure>
    $|        <figure class="footer-wechat-popover" id="footer-wechat-code" popover><img src="./wechat-yuebite.png" alt="\{localized(locale, "微信公众号二维码", "WeChat QR code", "WeChat のQRコード")}" width="148" height="148"><figcaption>\{brand}</figcaption></figure>
    #|      </div>
    $|      <a href="https://discord.gg/FyXNY8cpyJ" aria-label="MoonBit Discord" title="Discord"><svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M20.3 4.4a19 19 0 0 0-4.7-1.5l-.6 1.2a17 17 0 0 0-6 0l-.6-1.2a19 19 0 0 0-4.7 1.5A20 20 0 0 0 .2 17.8a19 19 0 0 0 5.8 3l1.2-2a12 12 0 0 1-1.8-.9l.4-.3a15 15 0 0 0 12.4 0l.4.3a12 12 0 0 1-1.8.9l1.2 2a19 19 0 0 0 5.8-3 20 20 0 0 0-3.5-13.4ZM8.1 15.4c-1.2 0-2.1-1.1-2.1-2.4s.9-2.4 2.1-2.4 2.1 1.1 2.1 2.4-.9 2.4-2.1 2.4Zm7.8 0c-1.2 0-2.1-1.1-2.1-2.4s.9-2.4 2.1-2.4 2.1 1.1 2.1 2.4-.9 2.4-2.1 2.4Z"/></svg></a>
    $|      <a href="https://www.xiaohongshu.com/user/profile/636b072f000000001f01c84a" aria-label="\{localized(locale, "小红书", "RedNote", "小紅書")}" title="\{localized(locale, "小红书", "RedNote", "小紅書")}"><svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true"><rect width="24" height="24" rx="5" fill="currentColor"/><text x="12" y="15" text-anchor="middle" font-size="7" font-weight="700" fill="white">\{localized(locale, "小红书", "RedNote", "小紅書")}</text></svg></a>
    $|      <a href="https://www.zhihu.com/people/moonbit" aria-label="\{localized(locale, "MoonBit 知乎主页", "MoonBit on Zhihu", "MoonBit の知乎プロフィール")}" title="\{localized(locale, "知乎", "Zhihu", "知乎")}"><svg width="20" height="20" viewBox="0 0 24 24" aria-hidden="true"><rect width="24" height="24" rx="5" fill="currentColor"/><text x="12" y="17" text-anchor="middle" font-size="15" font-weight="700" fill="white">知</text></svg></a>
    $|      <a href="https://x.com/Moonbitlang" aria-label="\{localized(locale, "MoonBit 的 X 账号", "MoonBit on X", "MoonBit の X アカウント")}" title="X"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" aria-hidden="true"><path d="M3 3h4l14 18h-4L3 3Zm17 0-7 8m-2 2-7 8"/></svg></a>
    #|    </nav>
    $|    <div class="footer-meta"><span>© \{localized(locale, "月比特科技", "Yuebite Technology", "月比特科技")}</span><a href="#home">\{localized(locale, "返回顶部", "Back to top", "ページ上部へ")} ↑</a></div>
    $|    <details class="locale-picker"><summary class="footer-locale"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><circle cx="12" cy="12" r="9"/><ellipse cx="12" cy="12" rx="4" ry="9"/><path d="M3 12h18"/></svg>\{language_name(locale)}</summary><div class="locale-options">\{language_links}</div></details>
    #|    </div>
    #|  </footer>
    #|</body>
    #|</html>
  let page = match page_name {
    "news" => news_page
    "contact" => contact_page
    "company" => about
    "education" => education_page
    "competitions" => competitions_page
    "events" => events_page
    "ecosystem" => ecosystem_page
    _ => home
  }
  println(header + "\n" + page + "\n" + footer)
}
