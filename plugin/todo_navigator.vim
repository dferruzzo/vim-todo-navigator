" ============================================================================
" File:        todo_navigator.vim
" Description: VIM plugin para navegar TODO/FIXME em arquivos Python
" Maintainer:  Auto-generated
" License:     MIT
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

" Diretórios a excluir (pode ser customizado pelo usuário)
if !exists('g:todo_navigator_exclude_dirs')
    let g:todo_navigator_exclude_dirs = ['.venv', 'venv', '__pycache__', '.git', 'node_modules']
endif

" Extensões de arquivo a pesquisar (pode ser customizado pelo usuário)
if !exists('g:todo_navigator_file_extensions')
    let g:todo_navigator_file_extensions = ['*.py']
endif

" ============================================================================
" Main Functions
" ============================================================================


function! todo_navigator#ShowTodos()
    " Usar o diretório inicial salvo
    let base_dir = get(g:, 'todo_navigator_initial_cwd', getcwd())

    " Construir comando find
    let exclude_pattern = ''
    for dir in g:todo_navigator_exclude_dirs
        let exclude_pattern .= ' -name "' . dir . '" -prune -o'
    endfor

    " Construir padrão de extensões
    let ext_pattern = "*.py"
    
    for ext in g:todo_navigator_file_extensions
    endfor

    " Comando completo para encontrar TODOs/FIXMEs
    let find_cmd = 'find ' . shellescape(base_dir) . ' -type d' . exclude_pattern . ' -type f -name "*.py" -exec grep -HnE "TODO|FIXME" {} +'

    " Executar comando e capturar saída
    let todo_list = system(find_cmd)

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
    call append(0, '=== TODO/FIXME Navigator ===')
    call append(1, 'Base directory: ' . base_dir)
    call append(2, 'Press <Enter> to open file, <q> to close')
    call append(3, '')

    " Dividir a saída em linhas e adicionar ao buffer
    let lines = split(rel_todo_list, '\n')
    call append(4, lines)

    " Ir para o início
    normal! gg

    " Configurar syntax highlighting
    syntax clear
    syntax match TodoHeader /^=== TODO.*$/
    syntax match TodoSubHeader /^Press.*$/
    syntax match TodoLineNum /:\d\+:/
    command! TodoNavigator call todo_navigator#ShowTodos()
    command! ShowTodos call todo_navigator#ShowTodos()
    command! TODOToggle call todo_navigator#TODOToggle()
    " Configurar cores
    highlight TodoHeader ctermfg=yellow cterm=bold guifg=yellow gui=bold
    highlight TodoSubHeader ctermfg=gray guifg=gray
    highlight TodoFile ctermfg=blue cterm=bold guifg=blue gui=bold
    highlight TodoLineNum ctermfg=magenta guifg=magenta
    highlight TodoTag ctermfg=green cterm=bold guifg=green gui=bold
    highlight FixmeTag ctermfg=red cterm=bold guifg=red gui=bold

    " Tornar buffer somente leitura
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
        call cursor(5, 1)
    else
        call cursor(4, 1)
    endif

    "echo "TODO Navigator carregado. Use Enter para abrir, q para sair."
endfunction

function! todo_navigator#OpenTodoItem()
    let current_line = getline('.')
    
    " Pular linhas de cabeçalho (primeiras 3 linhas)
    if line('.') <= 3
        echo "Posicione o cursor em uma linha de TODO/FIXME"
        return
    endif
    
    " Extrair arquivo e número da linha usando regex
    " Formato esperado: ./arquivo.py:123:    # TODO/FIXME comentário
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

" Comando principal
command! TodoNavigator call todo_navigator#ShowTodos()
command! ShowTodos call todo_navigator#ShowTodos()
command! TODOToggle call todo_navigator#TODOToggle()

" ============================================================================
" Restore user settings
" ============================================================================

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sw=4 ts=4 sts=4:
