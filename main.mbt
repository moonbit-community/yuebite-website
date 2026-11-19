///|
fn ecosystem_cards() -> String {
  let links = [
    (
      "https://www.moonbitlang.cn/", "MoonBit", "了解编程语言、开发工具与入门文档。",
    ),
    (
      "https://mooncakes.io/", "Mooncakes", "浏览 MoonBit 软件包与开源模块。",
    ),
    (
      "https://github.com/moonbit-community", "开源社区", "查看社区项目，参与开源协作。",
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
fn main {
  let cards = ecosystem_cards()
  let page =
    #|<!doctype html>
    #|<html lang="zh-CN">
    #|<head>
    #|  <meta charset="utf-8">
    #|  <meta name="viewport" content="width=device-width, initial-scale=1">
    #|  <meta name="description" content="月比特科技：了解 MoonBit 编程语言、开发工具与开源生态。">
    #|  <title>月比特科技</title>
    #|  <link rel="stylesheet" href="./site.css">
    #|</head>
    #|<body>
    #|  <header class="shell top">
    #|    <a class="brand" href="#home"><span aria-hidden="true">◐</span> 月比特科技</a>
    #|    <nav aria-label="主导航"><a href="#technology">技术与生态</a><a href="#about">关于我们</a></nav>
    #|    <a class="nav-action" href="https://www.moonbitlang.cn/">MoonBit ↗</a>
    #|  </header>
    #|  <main id="home">
    #|    <section class="hero shell" aria-labelledby="headline">
    #|      <div class="hero-text">
    #|        <p class="eyebrow">编程语言 · 开发工具 · 开源生态</p>
    #|        <h1 id="headline">为开发者打造趁手的工具</h1>
    #|        <p class="intro">从 MoonBit 编程语言出发，探索如何让软件开发更简单。</p>
    #|        <div class="actions"><a class="button" href="https://www.moonbitlang.cn/">了解 MoonBit ↗</a><a class="secondary" href="#technology">探索开源生态 ↓</a></div>
    #|      </div>
    #|    </section>
    #|    <section class="feature shell" aria-labelledby="feature-title">
    #|      <svg class="orbit" viewBox="0 0 1100 430" preserveAspectRatio="xMidYMid slice" aria-hidden="true">
    #|        <defs><radialGradient id="moon" cx="30%" cy="22%" r="80%"><stop stop-color="#f6eaff"/><stop offset=".52" stop-color="#a994ff"/><stop offset="1" stop-color="#322561"/></radialGradient></defs>
    #|        <circle cx="728" cy="215" r="265" fill="none" stroke="#aea0de" stroke-opacity=".3"/>
    #|        <circle cx="728" cy="215" r="178" fill="url(#moon)"/>
    #|        <ellipse cx="728" cy="215" rx="285" ry="80" transform="rotate(-24 728 215)" fill="none" stroke="#e3d5ff"/>
    #|        <circle cx="945" cy="95" r="7" fill="#f6eaff"/>
    #|      </svg>
    #|      <div class="feature-copy"><p class="eyebrow">编程语言</p><h2 id="feature-title">探索 MoonBit</h2><a href="https://www.moonbitlang.cn/">访问 MoonBit 官网 ↗</a></div>
    #|    </section>
    #|    <section class="shell section" id="technology">
    #|      <p class="eyebrow">01 / TECHNOLOGY</p>
    #|      <h2>技术与生态</h2>
    #|      <div class="cards">
    $|        \{cards}
    #|      </div>
    #|    </section>
    #|    <section class="shell section" id="about">
    #|      <p class="eyebrow">02 / ABOUT</p>
    #|      <h2>关于月比特科技</h2>
    #|      <p class="intro">我们关注编程语言、开发工具与开源生态。欢迎从 MoonBit 开始，了解相关技术并参与社区交流。</p>
    #|    </section>
    #|  </main>
    #|  <footer class="shell footer"><span>月比特科技</span><a href="#home">返回顶部 ↑</a></footer>
    #|</body>
    #|</html>
  println(page)
}
