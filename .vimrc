" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
source $VIMRUNTIME/mswin.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"关闭欢迎界面
set shortmess+=I

"开启语法高亮
syntax on

" 开启文件类型检测、插件、自动缩进
filetype plugin indent on

" Tab 宽度 = 4 个空格
set tabstop=4

" 自动缩进时也用 4 格
set shiftwidth=4

" 把 Tab 自动转成空格
set expandtab

" 设置字体和大小
set guifont=Iosevka:h12

" 隐藏菜单栏
set guioptions-=m

" 隐藏工具栏
set guioptions-=T

" 不把特殊功能键当ESC
set noesckeys

" 显示相对行号
set relativenumber

" 同时显示绝对行号
set number

" 搜索时忽略大小写
set ignorecase

" 但有大写时就区分大小写
set smartcase

" 输入时实时搜索
set incsearch

" C 语言缩进风格：switch 里 case 缩进 1 格
set cinoptions=l1

" 允许文件里写 vim 配置
set modeline

" 自动缩进
set autoindent

" 打开文件时自动切换到该文件目录
set autochdir

" 隐藏右侧滚动条
set guioptions-=r

" 底部状态栏隐藏
set guioptions-=b

" 隐藏左侧滚动条
set guioptions-=L

" 编码全部用 UTF-8，兼容中文
set encoding=utf-8
set fileencodings=utf-8,gbk,gb2312
set termencoding=utf-8

" 主题
colorscheme industry

" 显示空格、Tab、换行等空白字符
set nolist
" 定义显示符号：Tab 空格 换行
set listchars=tab:▸\ ,space:·,eol:$
" 按 F3 切换显示/隐藏空白字符
nnoremap <F3> :set list!<CR>
inoremap <F3> <C-o>:set list!<CR>

"Vim 禁止备份/交换/撤销文件
" 禁止 .bak 备份文件
set nobackup
"禁止viminfo
set viminfo=
" 禁止 .swp/.swo 交换文件
set noswapfile
" 禁止 .un~ 撤销文件
set noundofile
" 防止部分插件自动开启备份
set nowritebackup

" windows表情颜色
set renderoptions=type:directx