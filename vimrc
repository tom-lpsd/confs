"ファイルエンコーディングの設定
set encoding=utf8
set fileencodings=utf8,euc-jp,iso-2022-jp,sjis
set fileencoding=utf8
"makeのエラーとかがutfで表示されるように環境変数をいじる
let $LANG = 'ja_JP.UTF-8'

"カラースキームの設定
colorscheme DarkDefault

"ファイルの検索パスを動的に変える設定
autocmd BufEnter * execute "set path=/usr/include,/usr/include/c++/*/
    \,/usr/local/include,.," . expand("%:h") . "/../include," . expand("%:h") . "/include"
"ファイルのあるディレクトリに自動でcdする
autocmd BufEnter * execute "cd " . expand("%:p:h")

syntax on
filetype on
filetype indent on
filetype plugin on
au FileType ruby set ts=2 sw=2 expandtab

"インデントはスペース4つ
set shiftwidth=4
"行番号表示
set number
"インクリメンタルサーチオン
set incsearch
"端で折り返さない
set nowrap
"横スクロール時の幅
set sidescroll=1
"編集中にファイルの属性が変わると自動でリロード
set autoread
"バッファのhideを有効に
set hidden
"TABや改行文字が見えるようにする
"set list
"検索結果をハイライト
"set hlsearch

"emacs風のキーバインドの設定
nmap <C-X><C-F> :call EmacsFindFile()<CR> 
nmap <C-X>k :bd 
nmap <C-X>b :IncBufSwitch<CR>
nmap <C-X><C-B> :BufExplorer<CR>
nmap <C-X>2 :sp<ENTER>
nmap <C-X>3 :vs<ENTER>
nmap <C-X>0 c
nmap <C-X>o 

"taglist用の設定
"let Tlist_Auto_Open=1
let Tlist_Exit_OnlyWindow=1
nnoremap <silent> <C-A> :TlistToggle<CR>

"便利な変数のセット
let s:os = system("uname")
let s:domain = system("domainname")

if s:os =~ "Darwin"
    highlight String ctermfg=green
    highlight Comment ctermfg=LightCyan
    highlight vimOption ctermfg=white
    if (system("if [ -e /sw/bin/ctags ]; then \"OK\"; fi") =~ "OK")
	let Tlist_Ctags_Cmd="/sw/bin/ctags"
    else
	let TList_Ctags_Cmd="/opt/local/bin/ctags"
    endif
endif

":makeの挙動をカスタマイズ
if s:os =~ "FreeBSD"
    autocmd BufEnter * let &makeprg = ";gmake " . expand("%:t:r")
else
    autocmd BufEnter * let &makeprg = ";make " . expand("%:t:r")
endif

function ShellBangCheck()
    let first_line = getline(1)
    if (first_line =~ '^#!.*')
        let fname = expand("%")
	if (system("if [ -x " . fname . " ];then \"OK\";fi") !~ "OK")
            call system("chmod 755 " . fname)
	endif
    endif
endfunction

function ExecuteWithArgs ()
    if !exists('b:args')
        let b:args = input('args: ')
    endif
    if (&filetype =~ "^cp*$")
        let cmd = "!rehash; %:t:r "
    else
	let cmd = "!%:p "
    endif
    execute cmd . b:args
endfunction

function MyGtagsCursor ()
    let gtagscmd = "Gtags " . expand("<cword>")
    execute gtagscmd
endfunction

function EmacsFindFile()
    call inputsave()
    let file = input("Find file: ", getcwd() . "/", "file")
    call inputrestore()
    execute "e " . file
endfunction

"daおよびdsp以下はeuc-jpでエンコード
autocmd BufWritePre $HOME/da/**,$HOME/dsp/** set fileencoding=euc-jp
"da以下のc,cppのソースはインデント幅を2に
autocmd BufEnter $HOME/da/**.cpp,$HOME/da/**.c set shiftwidth=2
autocmd FileType c,cpp,perl,vim set cindent

"C-nで即コマンド実行
autocmd FileType c,cpp,perl,ruby,python,sh 
    \map <buffer>  :up :call ExecuteWithArgs()
command -nargs=+ ExecWithThisArgs :let b:args = '<args>'
    \| write | call ExecuteWithArgs()
nnoremap <C-X><C-X> :ExecWithThisArgs 
"c,cppの時は、C-]でgtagsを使う
autocmd FileType c,cpp map <buffer> <silent> <C-]> :call MyGtagsCursor()<CR>

"スクリプトは保存後にchmodする
autocmd BufWritePost *.pl,*.plx,*.sh,*.rb,*.py,*shrc call ShellBangCheck()

set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']
    \['.&ff.']'}%=%l,%c%V%8P

"CとC++のソースの雛型の省略系
ab cinit #include<stdio.h>int main(void)
    \{return 0;}kkA
ab cppinit #include<iostream>using namespace std;
    \int main(){return 0;}kkA
"autocmd FileType c,cpp,perl ab { {}kA

"perlモードでのKコマンドはperldocを参照するように
autocmd FileType perl let &keywordprg="__perldoc(){
    \if perldoc -l $1 2&>1 > /dev/null ;
    \then perldoc $1; else perldoc -f $1; fi };__perldoc"

"バックアップの設定
set backup
set backupdir=~/.vim/backup/
set backupext=~

