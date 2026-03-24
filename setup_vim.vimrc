  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif


  "Plug modules
  "silent! call plug#begin('~/.vim/plugged')
  call plug#begin('~/.vim/plugged')

  Plug 'andymass/vim-matchup',{'for': ['verilog', 'verilog_systemverilog' ] }
  Plug 'vim-scripts/Align',{'on':'Align'} 
  Plug 'hiberabyss/visincr' ,{'on':'I'} 
  Plug 'vhda/verilog_systemverilog.vim'  , {'for': ['verilog', 'verilog_systemverilog' ] }
  Plug 'jmcneal/verilog-support' , {'for': ['verilog', 'verilog_systemverilog' ] }
  "Plug 'preservim/nerdtree',{'on':'NERDTree'}
  Plug 'ichirou2910/vim-buftabline'
  if exists ("$RHVER") && str2nr($RHVER) >7 
  	Plug 'Yggdroot/indentLine'
  else 
  	Plug 'Yggdroot/indentLine' ,{ 'tag' : 'v2.0'}
  endif 
  "Plug 'wsdjeg/vim-fetch'
  Plug 'mhinz/vim-hugefile'
  Plug 'mtdl9/vim-log-highlighting' ,{'for': ['log', '' ] }
  Plug 'vim-scripts/genutils'
  "Plug 'idbrii/vim-perforce' ,  { 'on': [] } 
  Plug 'gauravjuvekar/vim-perforce' , { 'on': [] }

  call plug#end()


  set nocompatible
  filetype plugin indent on
  syntax on
  set shiftwidth=2
  set tabstop=2
  set expandtab
  set laststatus=2
  set cmdheight=1
  set wildmenu
  set showcmd
  set showmatch
  set magic
  set incsearch
  set wrapscan
  set uc=50
  set updatetime=24000
  set autowrite
  set number 
  set shortmess=at
  set ignorecase
  set nospell
  set splitbelow
  set splitright
  set mouse=a
  "set lazyredraw
  set hls
  set isfname-=,

  let g:netrw_liststyle= 4 "Default listing style for Explorer is Tree
  "cd to directory when opening a file in it
  autocmd BufEnter * silent! lcd %:p:h

 " keys remapping
  noremap <F7> :set hls!<CR>
  noremap <F11> :set wrap!<CR>
  noremap <F9> :set relativenumber! <CR>
  noremap <F12> :set ic!<CR>
  noremap <MouseMiddle> <esc>"*p

  "Jump buffers using Tab/Shift+Tab
  nnoremap <Tab> :bnext<CR>
  nnoremap <S-Tab> :bprevious<CR>

  "Shift Insert must paste
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>


 "indentLine settings
  let g:indentLine_char_list = ['|', '�', '.' , '!']

  "Perforce Loading. Load on demand and only if env is setup
  augroup load_perforce
    autocmd!
    
      autocmd InsertEnter * call Perforce_load()
            \| autocmd! load_perforce
  augroup END

  function Perforce_load()
    if !empty($JP4_HOME)
      let g:p4CmdPath = '$JP4_HOME/p4'
      let &runtimepath .= ",/usr/hw-tools/icmanage/contrib/vimrc"
      let g:p4EnableMenu = 1
      let g:p4UseExpandedMenu = 0
      "runtime perforce/perforceutils.vim
      runtime perforce/perforcemenu.vim
      call plug#load('vim-perforce')
    endif
  endfunction 

  "huge files trigger size 
  let g:hugefile_trigger_size=500
  "use ] and [ instead of ]c and [c to navigate between diff segments
  if &diff
    set cursorline
    map ] ]c
    map [ [c
    hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
    hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
    hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
  endif


  au BufNewFile,BufRead *.v,*.vh,*.vt,*.gv,*.jv,*.jvh,*.bvrl,*.vlib set ft=verilog_systemverilog syntax=verilog_systemverilog 
  au BufNewFile,BufRead *.svh,*.sv,*.svt,*.v,*.vh,*.vt,*.gv,*.jsvh,*.jsv,*.vlib set ft=verilog_systemverilog syntax=verilog_systemverilog 

  au BufNewFile,BufRead *.log,*.log.gz set ft=log syntax=log 

  " Search for selected text, forwards or backwards.
  vnoremap <silent> * :<C-U>
        \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
        \gvy/<C-R><C-R>=substitute(
        \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
        \gV:call setreg('"', old_reg, old_regtype)<CR>
  vnoremap <silent> # :<C-U>
        \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
        \gvy?<C-R><C-R>=substitute(
        \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
        \gV:call setreg('"', old_reg, old_regtype)<CR>



if !exists("*FoldStackBelow")
    function FoldStackBelow()
        silent! execute "normal! zf/^\\S\<CR>zzO\ejo\ek"
    endfunction
endif
command! FoldStackBelow call FoldStackBelow()
"if filereadable(/usr/hw-tools/icmanage/contrib/vimrc/icm.vimrc)
"  source /usr/hw-tools/icmanage/contrib/vimrc/icm.vimrc
"endif

