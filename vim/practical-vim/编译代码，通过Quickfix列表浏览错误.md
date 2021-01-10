# 编译代码，通过 Quickfix 列表浏览错误

- [编译代码，通过 Quickfix 列表浏览错误](#编译代码通过-quickfix-列表浏览错误)
  - [技巧107 浏览 Quickfix 列表](#技巧107-浏览-quickfix-列表)

Quickfix 列表会维护一组由文件名、行号、列号（可选）与消息组成的注释定位信息。

## 技巧107 浏览 Quickfix 列表

浏览 Quickfix 列表的命令：

- `:cnext` 跳转到下一项
- `:cprev` 跳转到上一项
- `:cfirst` 跳转到第一项
- `:clast` 跳转到最后一项
- `:cnfile` 跳转到下一个文件中的第一项
- `:cpfile` 跳转到上一个文件中的最后一项
- `:cc N` 跳转到第 N 项
- `:copen` 打开 Quickfix 窗口
- `:cclose` 关闭 Quickfix 窗口
- `:cdo {cmd}` 在 Quickfix 列表中的每一行上执行 {cmd}
- `:cfdo {cmd}` 在 Quickfix 列表中的每个文件上执行一次 {cmd}
