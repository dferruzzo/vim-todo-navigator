" ============================================================================
" File:        todo_navigator.vim
" Description: VIM plugin to navigate TODO/FIXME/NOTE comments in codebase
" Maintainer:  dferruzzo <https://github.com/dferruzzo>
" License:     MIT
" Version:     1.0.0
" ============================================================================
"
" USAGE:
"   :TodoNavigator  - Open TODO navigation window
"   :TODOToggle     - Toggle TODO window on/off
"
" CONFIGURATION:
"   let g:todo_navigator_keywords = ['TODO', 'FIXME', 'NOTE', 'HACK', 'BUG']
"   let g:todo_navigator_file_extensions = ['*.py', '*.js', '*.vim']
"   let g:todo_navigator_exclude_dirs = ['.git', '.venv', 'node_modules']
"
" MAPPINGS:
"   In TODO buffer: <Enter> to jump to item, q to close
"   Recommended: nmap <F5> :TODOToggle<CR>
"
" ============================================================================

" Prevent loading twice
if exists('g:loaded_todo_navigator') || &cp
    finish
endif

let g:loaded_todo_navigator = 1

" Salvar o diretório inicial onde o Vim foi aberto
if !exists('g:todo_navigator_initial_cwd')
    let g:todo_navigator_initial_cwd = getcwd()
endif

" Save user settings
let s:save_cpo = &cpo
set cpo&vim

" ============================================================================
" Global Variables
" ============================================================================

" Diretórios a excluir da busca (pode ser customizado pelo usuário)
" Default: ['.venv', 'venv', '__pycache__', '.git', 'node_modules']
if !exists('g:todo_navigator_exclude_dirs')
    let g:todo_navigator_exclude_dirs = ['.venv', 'venv', '__pycache__', '.git', 'node_modules']
endif

" Extensões de arquivo a pesquisar (pode ser customizado pelo usuário)  
" Default: ['*.py', '*.js', '*.ts', '*.java', '*.c', '*.cpp', '*.h', '*.html', '*.css', '*.md']
if !exists('g:todo_navigator_file_extensions')
    let g:todo_navigator_file_extensions = ['*.py', '*.js', '*.ts', '*.java', '*.c', '*.cpp', '*.h', '*.html', '*.css', '*.md']
endif

" Tags/palavras-chave a pesquisar (pode ser customizado pelo usuário)
" Default: ['TODO', 'FIXME', 'NOTE', 'HACK', 'BUG', 'CANCELLED', 'XXX']
if !exists('g:todo_navigator_keywords')
    let g:todo_navigator_keywords = ['TODO', 'FIXME', 'NOTE', 'HACK', 'BUG', 'CANCELLED', 'XXX']
endif

" ============================================================================
" Main Functions
" ============================================================================

" Function: todo_navigator#ShowTodos()
" Description: Searches for TODO-style comments and displays them in a navigation buffer
" 
" This function:
" 1. Uses grep to recursively search for keywords in specified file types
" 2. Excludes configured directories (like .git, node_modules, etc.)
" 3. Creates a split window with results
" 4. Applies syntax highlighting for different keyword types
" 5. Sets up key mappings for navigation
"
" Returns: Nothing (void function)
" Side effects: Opens a new split window with TODO results
function! todo_navigator#ShowTodos()
    " Usar o diretório inicial salvo
    let base_dir = get(g:, 'todo_navigator_initial_cwd', getcwd())

    " Construir comando find
    let exclude_pattern = ''
    for dir in g:todo_navigator_exclude_dirs
        let exclude_pattern .= ' \\( -name "' . dir . '" -prune \\) -o'
    endfor

    " Construir padrão de extensões para grep
    let include_pattern = ''
    for ext in g:todo_navigator_file_extensions
        let include_pattern .= '--include="' . ext . '" '
    endfor

    " Construir padrão de exclusões para grep
    let exclude_grep_pattern = ''
    for dir in g:todo_navigator_exclude_dirs
        let exclude_grep_pattern .= '--exclude-dir="' . dir . '" '
    endfor

    " Construir padrão de palavras-chave para buscar
    let keywords_pattern = join(g:todo_navigator_keywords, '\|')

    " Comando completo para encontrar TODOs/FIXMEs/etc
    let find_cmd = 'grep -r ' . exclude_grep_pattern . include_pattern . '-n "' . keywords_pattern . '" ' . shellescape(base_dir) . ' 2>/dev/null'

    " Executar comando e capturar saída
    let todo_list = system(find_cmd)

    " Verificar se houve erro no comando find/grep
    if v:shell_error != 0 && v:shell_error != 1
        echo "Erro ao executar comando find: " . v:shell_error
        return
    endif

    " Remover o caminho base do início das linhas para exibir relativo
    let rel_todo_list = substitute(todo_list, '\V' . base_dir . '/', '', 'g')

    " Verificar se encontrou algo
    if v:shell_error != 0 || empty(trim(rel_todo_list))
        echo "Nenhum TODO/FIXME encontrado." 
        return
    endif

    " Criar split horizontal e novo buffer
    split
    enew

    " Configurar buffer como temporal
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal nobuflisted
    setlocal noswapfile

    " Definir nome do buffer
    file TODO


    " Adicionar cabeçalho e mostrar diretório base
    call append(0, '=== TODO Navigator ===')
    call append(1, 'Base directory: ' . base_dir)
    call append(2, 'Keywords: ' . join(g:todo_navigator_keywords, ', '))
    call append(3, 'Press <Enter> to open file, <q> to close')
    call append(4, '')

    " Dividir a saída em linhas e adicionar ao buffer
    let lines = split(rel_todo_list, '\n')
    call append(5, lines)

    " Ir para o início
    normal! gg

    " Configurar syntax highlighting
    syntax clear
    syntax match TodoHeader /^=== TODO Navigator ===$/
    syntax match TodoSubHeader /^Base directory:.*$/
    syntax match TodoSubHeader /^Keywords:.*$/
    syntax match TodoSubHeader /^Press.*$/
    syntax match TodoFile /^[^:]*:/
    syntax match TodoLineNum /:\d\+:/
    
    " Criar syntax highlighting dinâmico para todas as palavras-chave
    for keyword in g:todo_navigator_keywords
        execute 'syntax match TodoKeyword_' . keyword . ' /' . keyword . '/'
    endfor

    " Configurar cores
    highlight TodoHeader ctermfg=yellow cterm=bold guifg=yellow gui=bold
    highlight TodoSubHeader ctermfg=gray guifg=gray
    highlight TodoFile ctermfg=blue cterm=bold guifg=blue gui=bold
    highlight TodoLineNum ctermfg=magenta guifg=magenta
    
    " Cores específicas para diferentes tipos de tags
    highlight TodoKeyword_TODO ctermfg=green cterm=bold guifg=green gui=bold
    highlight TodoKeyword_FIXME ctermfg=red cterm=bold guifg=red gui=bold
    highlight TodoKeyword_NOTE ctermfg=cyan cterm=bold guifg=cyan gui=bold
    highlight TodoKeyword_HACK ctermfg=yellow cterm=bold guifg=orange gui=bold
    highlight TodoKeyword_BUG ctermfg=red cterm=bold guifg=red gui=bold
    highlight TodoKeyword_CANCELLED ctermfg=gray cterm=strikethrough guifg=gray gui=strikethrough
    highlight TodoKeyword_XXX ctermfg=red cterm=bold guifg=red gui=bold

    " Tornar buffer somente leitura DEPOIS de adicionar conteúdo
    setlocal readonly
    setlocal nomodifiable

    " Configurar status line para mostrar linha atual
    setlocal statusline=%f\ [%l/%L]\ %p%%
    setlocal laststatus=2

    " Mapear teclas
    nnoremap <buffer> <CR> :call todo_navigator#OpenTodoItem()<CR>
    nnoremap <buffer> q :quit<CR>
    nnoremap <buffer> <Esc> :quit<CR>


    " Posicionar cursor na primeira entrada real (após o cabeçalho)
    if len(lines) > 0
        call cursor(6, 1)
    else
        call cursor(5, 1)
    endif

    "echo "TODO Navigator carregado. Use Enter para abrir, q para sair."
endfunction

" Function: todo_navigator#OpenTodoItem()
" Description: Opens the file and jumps to the line of the selected TODO item
"
" This function:
" 1. Parses the current line to extract filename and line number
" 2. Validates the file exists and line format is correct
" 3. Closes the TODO navigation window
" 4. Opens the target file and jumps to the specific line
" 5. Highlights the line temporarily for visual feedback
"
" Expected line format: "filename:line_number:    # KEYWORD comment"
" Returns: Nothing (void function)
" Side effects: Opens file, changes cursor position, closes TODO window
function! todo_navigator#OpenTodoItem()
    let current_line = getline('.')
    
    " Pular linhas de cabeçalho (primeiras 4 linhas)
    if line('.') <= 4
        echo "Posicione o cursor em uma linha de TODO/FIXME/etc"
        return
    endif
    
    " Extrair arquivo e número da linha usando regex
    " Formato esperado: ./arquivo.py:123:    # TODO/FIXME/etc comentário
    let matches = matchlist(current_line, '\v^([^:]+):(\d+):')
    
    if len(matches) < 3
        echo "Linha inválida. Formato esperado: arquivo:linha:conteúdo"
        return
    endif
    
    let filename = matches[1]
    let line_number = matches[2]
    
    " Verificar se o arquivo existe
    if !filereadable(filename)
        echo "Arquivo não encontrado: " . filename
        return
    endif
    
    " Ir para a janela anterior (original)
    wincmd p
    
    " Fechar o buffer TODO
    wincmd j
    quit
    
    " Abrir o arquivo
    execute 'edit ' . filename
    
    " Ir para a linha específica
    execute line_number
    
    " Centralizar a linha na tela
    normal! zz
    
    " Destacar a linha temporariamente
    let l:match_id = matchadd('Search', '\%' . line('.') . 'l')
    call timer_start(2000, {-> matchdelete(l:match_id)})
    
    "echo "Aberto: " . filename . " linha " . line_number
endfunction

" ============================================================================
" Commands and Mappings
" ============================================================================

" Function: todo_navigator#TODOToggle()
" Description: Toggles the TODO navigation window on/off
"
" This function:
" 1. Searches for existing TODO buffer in all windows
" 2. If found, closes all windows showing the TODO buffer
" 3. If not found, opens a new TODO navigation window
"
" Returns: Nothing (void function)
" Side effects: Opens or closes TODO navigation window
function! todo_navigator#TODOToggle()
    let l:todo_bufnr = -1
    for bufnr in range(1, bufnr('$'))
        if bufexists(bufnr) && bufname(bufnr) ==# 'TODO' && getbufvar(bufnr, '&buftype') ==# 'nofile'
            let l:todo_bufnr = bufnr
            break
        endif
    endfor
    if l:todo_bufnr != -1
        " Find and close all windows showing the TODO buffer (Vim-compatible)
        let winnr = 1
        while winnr <= winnr('$')
            if winbufnr(winnr) == l:todo_bufnr
                execute winnr . 'wincmd c'
                " After closing, don't increment winnr, as windows shift
            else
                let winnr += 1
            endif
        endwhile
        return
    else
    call todo_navigator#ShowTodos()
    endif
endfunction

" ============================================================================
" Command Definitions
" ============================================================================

" Main command to open TODO navigation window
command! TodoNavigator call todo_navigator#ShowTodos()

" Alternative command name for the same functionality
command! ShowTodos call todo_navigator#ShowTodos()

" Toggle command to open/close TODO window
command! TODOToggle call todo_navigator#TODOToggle()

" ============================================================================
" Restore user settings
" ============================================================================

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sw=4 ts=4 sts=4:
