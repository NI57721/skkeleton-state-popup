let s:config = #{labels: {}, opts: {}}

function! skkeleton_state_popup#config(config) abort
  let s:config.labels = a:config ->get('labels', {})
  let s:config.opts   = a:config ->get('opts', {})
endfunction

function! skkeleton_state_popup#enable() abort
  let suffix = has('nvim') ? 'nvim' : 'vim'
  let s:create_or_update_popup = function('s:create_or_update_popup_in_' .. suffix)
  let s:close_popup = function('s:close_popup_in_' .. suffix)

  augroup skkeleton-state-popup
    autocmd!
    if has_key(s:config.labels, 'latin')
      autocmd InsertEnter,CursorMovedI * call s:create_or_update_popup()
    else
      autocmd InsertEnter * call s:create_or_update_popup()
    endif
    autocmd User skkeleton-handled if mode() =~# '^i' | call s:create_or_update_popup() | endif
    autocmd InsertLeave * call s:close_popup()
  augroup END
endfunction

let skkeleton_state_popup#run = function('skkeleton_state_popup#enable')

function! skkeleton_state_popup#disable() abort
  call s:close_popup()
  autocmd! skkeleton-state-popup
endfunction

function! s:create_or_update_popup_in_vim() abort
  let label = s:current_label()
  if empty(label)
    call s:close_popup_in_vim()
    return
  endif

  if has_key(s:, 'popup_id') && index(popup_list(), s:popup_id) != -1
    call popup_move(s:popup_id, s:config.opts)
    call popup_settext(s:popup_id, label)
  else
    let s:popup_id = popup_create(label, s:config.opts)
  endif
endfunction

function! s:close_popup_in_vim() abort
  if !has_key(s:, 'popup_id')
    return
  endif

  let popup_id = remove(s:, 'popup_id')
  if index(popup_list(), popup_id) != -1
      call popup_close(popup_id)
  endif
endfunction

function! s:create_or_update_popup_in_nvim() abort
  let label = s:current_label()
  if empty(label)
    call s:close_popup_in_nvim()
    return
  endif

  let s:config.opts.height = 1
  let s:config.opts.width = strwidth(label)

  if !has_key(s:, 'buf')
    let s:buf = nvim_create_buf(v:false, v:true)
  endif
  call nvim_buf_set_lines(s:buf, 0, 1, v:true, [label])
  if has_key(s:, 'popup_id') && nvim_win_is_valid(s:popup_id)
    call nvim_win_set_config(s:popup_id, s:config.opts)
  else
    let s:popup_id = nvim_open_win(s:buf, 0, s:config.opts)
  endif
endfunction

function! s:close_popup_in_nvim() abort
  if !has_key(s:, 'popup_id')
    return
  endif

  let popup_id = remove(s:, 'popup_id')
  if nvim_win_is_valid(popup_id)
    call nvim_win_close(popup_id, v:true)
  endif

  if has_key(s:, 'buf')
    execute 'bwipeout! ' .. s:buf
    call remove(s:, 'buf')
  endif
endfunction

function! s:current_label() abort
  let mode = empty(g:skkeleton#mode) ? '' : g:skkeleton#mode
  let phase = g:skkeleton#state ->get('phase', '')

  if phase ==# 'escape' && g:skkeleton#get_config() ->get('keepState', v:false)
    if has_key(s:, 'current_bufnr') && s:current_bufnr == bufnr()
      return s:config.labels ->get('input', {}) ->get('hira', '')
    else
      let s:current_bufnr = bufnr()
      return ''
    endif
  endif
  if empty(mode)
    return s:config.labels ->get('latin', '')
  endif
  return s:config ->get('labels', {}) ->get(phase, {}) ->get(mode, '')
endfunction

