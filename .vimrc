" # Installation:
"
" * Install vim-plug
" * Install packages by typing :PlugInstall to install all packages


function BasicSetup()
  " ## Base setup
  set number " display line number
  set clipboard=unnamed " if not working, try this: set clipboard=unnamedplus
  syntax on " enable syntax

  set t_Co=256
  set tabstop=2       " The width of a TAB is set to 4.
  set shiftwidth=2    " Indents will have a width of 4.
  set softtabstop=2   " Sets the number of columns for a TAB.
  set expandtab       " Expand TABs to spaces.
  set ai

  " code foldering
  set foldmethod=indent   
  set foldnestmax=10
  set nofoldenable
  set foldlevel=2

  " no backup files
  set nobackup "(required) make vim no backup auto creating
  set noswapfile "(required) make vim no swap file auto creating
  set noundofile "(required) make undo file disable

  "set file format
  set fileformat=unix

  " Rendering setup
  set ttyfast

  " search setup
  set hlsearch
  set incsearch

  " backspace
  set backspace=indent,eol,start
endfunction

" Flutter format command
function FlutterFormat_CurrentFile()
  if &filetype ==# 'dart'
    !flutter format %:p
  endif
endfunction

function MappingSetup()
  function TabsNumberSetup()
    " Go to tab by number
    noremap <leader>1 1gt
    noremap <leader>2 2gt
    noremap <leader>3 3gt
    noremap <leader>4 4gt
    noremap <leader>5 5gt
    noremap <leader>6 6gt
    noremap <leader>7 7gt
    noremap <leader>8 8gt
    noremap <leader>9 9gt
    noremap <leader>0 :tablast<cr>

    map <leader>t<leader> :tabnext
  endfunction

  function SearchMappingSetup()
    " hit enter to turn off highlight
    nnoremap <CR> :nohlsearch<CR><CR>

    "  mark with 's' while search...
    nnoremap / ms/
  endfunction

  function PluginsMapping()
    " Shortcut setting (remapping)
    map <C-c> :NERDTreeToggle<CR>
  endfunction

  function BasicFeaturesMapping()
    nmap vs :vsplit<cr>
    nmap sp :split<cr>
    nmap pc :q!<cr>
    nmap nt :tabnew<cr>
    nmap fq :wq<cr>
    nmap nw :w<cr>

    " N key: go to the start of the l.pyne
    noremap <C-n> 0
    " I key: go to the end of the line
    noremap <C-i> $

    noremap <C-j> <C-f>
    noremap <C-k> <C-b>
  endfunction

  function CustomFeatureMapping()
    function FormatCurrentFile()
      call FlutterFormat_CurrentFile()
    endfunction

    noremap ZF :call FormatCurrentFile()<cr><cr>

  endfunction

  call SearchMappingSetup()
  call TabsNumberSetup()
  call PluginsMapping()
  call BasicFeaturesMapping()
  call CustomFeatureMapping()
endfunction

function LinenumberSetup()
  "show norelative number when enter insert mode
  :augroup numbertoggle
  :  autocmd!
  :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  :augroup END

  " turn relative line numbers on
  " set relativenumber
  " set rnu
  "
  " " turn relative line numbers off
  " :set norelativenumber
  " :set nornu
  "
  " " toggle relative line numbers
  " :set relativenumber!
  " :set rnu!
endfunction

function VimplugSetups()

  function SnippetsSetup()
    " Track the engine.
    Plug 'SirVer/ultisnips'

    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'

    " Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
    " - https://github.com/Valloric/YouCompleteMe
    " - https://github.com/nvim-lua/completion-nvim
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  endfunction


  " Vim-Plugs
  call plug#begin('~/.vim/plugged')
  " ##  html, css, js
  Plug 'mattn/emmet-vim'

  call SnippetsSetup()

  " ## General
  Plug 'scrooloose/nerdtree'                " file tree plugin
  Plug 'posva/vim-vue'                      " vue.js plugin 
  Plug 'morhetz/gruvbox'                    " gruvbox colorscheme
  Plug 'vim-airline/vim-airline'            " arline in vim
  Plug 'vim-airline/vim-airline-themes'     " arline theme
  Plug 'ervandew/supertab'                  " TAB auto complete
  Plug 'kien/ctrlp.vim'                     " Ctrl+P to search files
  " Plug 'scrooloose/syntastic'             " Syntax auto correcting
  Plug 'mtscout6/syntastic-local-eslint.vim' " eslint tools for js
  Plug 'lervag/vimtex'                      " vimtex 4 latex

  " ## react.js, typescript, javascript
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'maxmellon/vim-jsx-pretty'

  Plug 'dart-lang/dart-vim-plugin'

  " ## comment tool:
  Plug 'tomtom/tcomment_vim'
  Plug 'jonsmithers/vim-html-template-literals'

  Plug 'cdata/vim-tagged-template'

  call plug#end()
endfunction

function PluginsConfigs()
  " vim-vue config
  autocmd FileType vue syntax sync fromstart
  autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
  autocmd BufRead,BufNewFile,BufEnter *.dart UltiSnipsAddFiletypes dart-flutter

  " gruvbox theme settings
  let g:gruvbox_italic=1
  let g:gruvbox_termcolors=16
  colorscheme gruvbox

  let g:airline_theme='base16color'

  " vim airline plugins and theme config
  set noshowmode
  set laststatus=0
  let g:airline_powerline_fonts = 1

  set background=dark
  let g:gruvbox_italic=0
  let g:gruvbox_contrast_dark='hard'
  colorscheme gruvbox

  hi Normal guibg=NONE ctermbg=NONE

  " powerline settings
  set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim
  set laststatus=2
  set t_Co=256

  " Syntaisic configs
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_javascript_checkers = ['eslint']
endfunction

function MacosSetup()
  if has("termguicolors")     " set true colors
    set t_8f=\[[38;2;%lu;%lu;%lum
    set t_8b=\[[48;2;%lu;%lu;%lum
    set termguicolors
  endif
endfunction

" Basic vim feature setup
call BasicSetup()
" Keybind mapping setup
call MappingSetup()
" Linenumber config
call LinenumberSetup()
" Initial vim-plug
call VimplugSetups()
" Config plugins
call PluginsConfigs()
" Setups for macos
" call MacosSetup()
