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
    #|  <header class="chrome-shell top">
    #|    <a class="brand" href="#home"><span aria-hidden="true">◐</span> 月比特科技</a>
    #|    <nav aria-label="主导航"><a href="#home">产品</a><a href="https://www.moonbitlang.cn/">开发者</a><a href="#technology">开源生态</a><a href="#about">公司</a></nav>
    #|    <div class="nav-actions"><a class="nav-action" href="https://seekmoon.moonbitlang.com/cloud">试用 SeekMoon ↗</a></div>
    #|  </header>
    #|  <main id="home">
    #|    <section class="hero shell" aria-labelledby="headline">
    #|      <div class="hero-text">
    #|        <h1 id="headline">今天想用 SeekMoon 做什么？</h1>
    #|        <a class="prompt" href="https://seekmoon.moonbitlang.com/cloud"><span>用 SeekMoon，把想法变成项目</span><span class="prompt-action">打开云端工作台 <span aria-hidden="true">↗</span></span></a>
    #|        <div class="actions"><a class="secondary" href="https://www.moonbitlang.cn/">MoonBit</a><a class="secondary" href="https://mooncakes.io/">Mooncakes</a><a class="secondary" href="#technology">开源生态</a><a class="secondary" href="#about">关于我们</a></div>
    #|      </div>
    #|    </section>
    #|    <section class="feature shell" aria-labelledby="feature-title">
    #|      <img class="feature-logo" src="./moonbit-logo.png" alt="MoonBit 官方标志" width="508" height="652">
    #|      <div class="feature-copy"><p class="eyebrow">认识 MoonBit</p><h2 id="feature-title">从一门语言开始</h2><p>从写下第一行代码，到构建自己的项目，探索 MoonBit 编程语言与开发工具。</p><a href="https://www.moonbitlang.cn/">访问 MoonBit 官网 ↗</a></div>
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
    #|  <footer class="chrome-shell footer">
    #|    <nav class="footer-links" aria-label="社区链接">
    #|      <a href="https://github.com/moonbit-community" aria-label="MoonBit 开源社区 GitHub"><svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12 .75a11.25 11.25 0 0 0-3.56 21.92c.56.1.77-.24.77-.54v-2.1c-3.13.68-3.79-1.33-3.79-1.33-.51-1.3-1.25-1.65-1.25-1.65-1.02-.7.08-.68.08-.68 1.14.08 1.73 1.16 1.73 1.16 1 .73 1.79.84 3.26.53.1-.73.39-1.23.71-1.51-2.5-.29-5.13-1.25-5.13-5.56 0-1.23.44-2.23 1.16-3.02-.12-.29-.5-1.43.11-2.98 0 0 .95-.3 3.09 1.15a10.78 10.78 0 0 1 5.63 0c2.14-1.45 3.08-1.15 3.08-1.15.61 1.55.23 2.69.12 2.98.72.79 1.15 1.79 1.15 3.02 0 4.32-2.63 5.27-5.14 5.55.4.35.76 1.03.76 2.08v3.51c0 .3.2.65.77.54A11.25 11.25 0 0 0 12 .75Z"/></svg></a>
    #|      <a href="https://mooncakes.io/">Mooncakes ↗</a>
    #|    </nav>
    #|    <div class="footer-meta"><span>© 月比特科技</span><a href="#home">返回顶部 ↑</a></div>
    #|    <span class="footer-locale"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><circle cx="12" cy="12" r="9"/><ellipse cx="12" cy="12" rx="4" ry="9"/><path d="M3 12h18"/></svg>中文 <span>中国</span></span>
    #|  </footer>
    #|</body>
    #|</html>
  println(page)
}
