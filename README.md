# Yuebite Technology Website

This repository contains the official Yuebite Technology website. MoonBit generates static HTML from `generator/main.mbt` during the build. Stylesheets and images live in `assets/`.

## Local Preview

Install the MoonBit toolchain, Node.js, Git, and a C compiler. Before your first build, run `moon update` to initialize the package index. Then run the following commands from the repository root.

```sh
moon check --target js
moon run --target native build-site.mbtx
```

Serve `_site/` with a local static file server to preview the site. The build generates Chinese, English, and Japanese versions of each page. Use the footer to switch languages on the current page. The build copies the contents of `assets/` into `_site/` and preserves the directory structure.

## Deployment

Commit your changes and push them to the `main` branch. In the GitHub repository, select **GitHub Actions** under **Settings → Pages → Build and deployment → Source**. If the first push fails to deploy, run **Deploy website to GitHub Pages** manually from the **Actions** tab.

Check the Pages settings for the site's configured URL. The default is the [project's GitHub Pages URL](https://moonbit-community.github.io/yuebite-website/).

Before launch, review the company description and navigation links. You can add the official logo and contact details once they are confirmed.
