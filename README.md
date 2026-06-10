# {{displayName}}

Tauri v2 + React + TypeScript + Vite 项目模板。

> 本仓库为 **hz-cli 模板源**，内含 `{{变量}}` 占位符，不能直接 `npm install` 运行。  
> 请使用 [hz-cli](https://www.npmjs.com/package/hz-cli) 创建项目：

```bash
npx hz-cli create my-app --template tauri-react
```

## 占位符说明

| 占位符 | 说明 | 示例 |
|--------|------|------|
| `{{kebabName}}` | npm / crate 包名 | `my-app` |
| `{{displayName}}` | 应用显示名称 | `My App` |
| `{{snakeName}}` | Rust 模块名 | `my_app` |
| `{{identifier}}` | Tauri bundle id | `com.user.my-app` |
| `{{author}}` | 作者标识 | `user` |
| `{{name}}` | 用户输入的原始项目名 | `my-app` |

## 创建后的开发

```powershell
cd my-app
npm install
npm run tauri:dev
```

## 构建

```powershell
npm run build
npm run tauri:build
```

## Windows 打包

```powershell
npm run tauri:build:windows
npm run tauri:package:windows
```

便携版 zip 输出路径：`dist/{{kebabName}}-v<version>-windows-x64.zip`
