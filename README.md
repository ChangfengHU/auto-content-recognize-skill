# auto-content-recognize

`auto-content-recognize` 用来封装 `image-recognize` 这个公网 HTTP 接口，对外提供两个主要命令：

## 1. 直接执行 CLI

不需要安装 skill，直接调用接口：

```bash
bash <(curl -fsSL https://skill.vyibc.com/auto-content-recognize.sh) \
  --mode=url \
  --url='https://www.youtube.com/watch?v=Ahfe-BW1cFc' \
  --token='YOUR_TOKEN'
```

这个命令本质上是在执行：

```text
skills/auto-content-recognize/scripts/run.sh
```

它帮你统一处理三类输入：

- `--mode=url`
- `--mode=screenshot-url`
- `--mode=file`

也会统一处理 Bearer Token 和请求格式，不需要自己手写 `curl`。

## 2. 安装 skill

这个命令会把 `auto-content-recognize` 作为一个真正的 skill 安装到 agent 环境：

```bash
bash <(curl -fsSL 'https://skill.vyibc.com/install-auto-content-recognize.sh?ts=...')
```

安装目录通常会是：

- `~/.codex/skills/auto-content-recognize`
- `~/.claude/skills/auto-content-recognize`
- `~/.cursor/skills/auto-content-recognize`

安装完成后，skill 内会包含：

- `SKILL.md`
- `scripts/run.sh`

## 3. 支持的调用模式

- `url`：识别 YouTube 或 GitHub 这类公开链接
- `screenshot-url`：识别公开截图链接
- `file`：直接上传本地图片文件

## 4. 调用示例

YouTube 链接：

```bash
bash <(curl -fsSL https://skill.vyibc.com/auto-content-recognize.sh) \
  --mode=url \
  --url='https://www.youtube.com/watch?v=Ahfe-BW1cFc' \
  --token='YOUR_TOKEN'
```

GitHub 仓库链接：

```bash
bash <(curl -fsSL https://skill.vyibc.com/auto-content-recognize.sh) \
  --mode=url \
  --url='https://github.com/owner/repo' \
  --token='YOUR_TOKEN'
```

上传图片文件：

```bash
bash <(curl -fsSL https://skill.vyibc.com/auto-content-recognize.sh) \
  --mode=file \
  --file='/path/to/screenshot.png' \
  --token='YOUR_TOKEN'
```

## 5. 发布

如果你在仓库目录里，本地发布：

```bash
./scripts/publish-skill.sh
```

如果你已经把改动 push 到 GitHub `main`，远程发布：

```bash
bash <(curl -fsSL https://skill.vyibc.com/publish-auto-content-recognize.sh)
```

## 6. 仓库结构

```text
README.md
scripts/
  auto-content-recognize.sh
  publish-auto-content-recognize.sh
  publish-skill.sh
  upload-file.sh
skills/
  auto-content-recognize/
    SKILL.md
    scripts/run.sh
```

说明：

- `scripts/auto-content-recognize.sh` 是直接给人执行的 CLI 入口
- `skills/auto-content-recognize/scripts/run.sh` 是唯一核心执行逻辑
- 安装后的 skill 和发布后的 CLI 都来自这一个脚本
