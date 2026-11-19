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
        $|<a href="\{url}"><strong>\{title} ↗</strong><span>\{description}</span></a>
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
    #|    <a class="brand" href="#home">◐ 月比特科技</a>
    #|    <nav aria-label="主导航"><a href="#technology">技术与生态</a><a href="#about">关于我们</a></nav>
    #|  </header>
    #|  <main id="home">
    #|    <section class="hero shell" aria-labelledby="headline">
    #|      <div class="hero-text">
    #|        <p class="eyebrow">编程语言 · 开发工具 · 开源生态</p>
    #|        <h1 id="headline">为开发者打造<br>趁手的工具<span>。</span></h1>
    #|        <p class="intro">从 MoonBit 编程语言出发，探索如何让软件开发更简单。</p>
    #|        <a class="button" href="#technology">探索技术与生态 →</a>
    #|      </div>
    #|      <svg class="orbit" viewBox="0 0 480 480" aria-hidden="true">
    #|        <defs><radialGradient id="moon" cx="30%" cy="22%" r="80%"><stop stop-color="#e9e5ff"/><stop offset=".52" stop-color="#8574ff"/><stop offset="1" stop-color="#201354"/></radialGradient></defs>
    #|        <circle cx="240" cy="240" r="205" fill="none" stroke="#393258" stroke-dasharray="2 7"/>
    #|        <circle cx="240" cy="240" r="142" fill="url(#moon)"/>
    #|        <ellipse cx="240" cy="240" rx="224" ry="69" transform="rotate(-32 240 240)" fill="none" stroke="#b8acff"/>
    #|        <circle cx="386" cy="101" r="8" fill="#d9d1ff"/>
    #|      </svg>
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
