- [技巧109 不离开 Vim 调用 grep](#技巧109-不离开-vim-调用-grep)
- [技巧110 定制 grep 程序](#技巧110-定制-grep-程序)


# 技巧109 不离开 Vim 调用 grep

Vim 的 `:grep` 命令封装了外部 grep，然后可以用 quickfix 列表浏览查找结果。

Vim 会自动加入 `-n` 参数，所以 `:grep Waldo *` 也会在输出结果中加入行号信息。这样在 quickfix 列表中可以直接跳转到行。

# 技巧110 定制 grep 程序
