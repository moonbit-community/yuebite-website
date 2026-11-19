# 月比特科技官网

中文企业官网。页面源码在 `main.mbt`，由 MoonBit 构建时生成静态 HTML；样式在 `site.css`。浏览器不需要运行 JavaScript。

## 本地预览

安装 MoonBit 工具链和 Node.js 后，在仓库根目录运行：

```sh
moon check --target js
sh build-site.sh
```

通过本地静态服务器预览 `_site/`。构建生成首页、关于我们和联系我们的中文、英文和日文版本；页脚可切换同一页面的语言。修改 `main.mbt` 或 `site.css` 后重新执行上述命令。

## 发布

将文件提交并推送至仓库的 `main` 分支。在 GitHub 仓库的 **Settings → Pages → Build and deployment → Source** 选择 **GitHub Actions**。如首次推送的部署未成功，在 **Actions** 中手动运行 **Deploy website to GitHub Pages**。

默认项目站点地址为 `https://moonbit-community.github.io/yuebite-website/`；以 Pages 设置中显示的实际地址为准。上线前请确认公司介绍及导航链接，正式 Logo、联系方式等可在资料确认后补充。
