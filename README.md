# 月比特科技官网

中文企业官网。构建时，MoonBit 从 `generator/main.mbt` 生成静态 HTML。样式和图片放在 `assets/`。

## 本地预览

安装 MoonBit 工具链、Node.js、Git 和 C 编译器后，首次构建前运行 `moon update` 初始化包索引。然后在仓库根目录运行以下命令。

```sh
moon check --target js
moon run --target native build-site.mbtx
```

通过本地静态服务器预览 `_site/`。构建会生成各页面的中文、英文和日文版本，页脚可切换同一页面的语言。构建会把 `assets/` 的内容复制到 `_site/`，并保留其中的目录结构。

## 发布

将文件提交并推送至仓库的 `main` 分支。在 GitHub 仓库的 **Settings → Pages → Build and deployment → Source** 选择 **GitHub Actions**。如首次推送的部署未成功，在 **Actions** 中手动运行 **Deploy website to GitHub Pages**。

默认项目站点地址为 `https://moonbit-community.github.io/yuebite-website/`；以 Pages 设置中显示的实际地址为准。上线前请确认公司介绍及导航链接，正式 Logo、联系方式等可在资料确认后补充。
