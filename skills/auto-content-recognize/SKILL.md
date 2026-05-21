---
name: auto-content-recognize
description: "把 image-recognize 公网接口封装成可安装的 skill，并提供统一的 CLI 调用入口。"
---

# Auto Content Recognize

## 作用

当用户希望调用 `image-recognize` 这个公网 HTTP 接口，但不想自己拼接 `curl`、Bearer Token、JSON 或 multipart 请求时，使用这个 skill。

## 安装

```bash
bash <(curl -fsSL 'https://skill.vyibc.com/install-auto-content-recognize.sh?ts=...')
```

## 核心执行入口

```text
skills/auto-content-recognize/scripts/run.sh
```

安装后的 skill 和对外发布的 CLI 都来自这一个脚本。

## 直接执行

```bash
bash <(curl -fsSL https://skill.vyibc.com/auto-content-recognize.sh) \
  --mode=url \
  --url='https://www.youtube.com/watch?v=Ahfe-BW1cFc' \
  --token='YOUR_TOKEN'
```

## 支持的模式

- `url`
- `screenshot-url`
- `file`
