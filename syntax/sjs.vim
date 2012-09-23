" Vim syntax file
" Language:	Stratified Javascript
" Maintainer:	Tim Cuthbertson <tim@gfxmonk.net>
" Updaters:	Tim Cuthbertson <tim@gfxmonk.net>
" URL:		XXX
" Changes:	(tc) initially forked from javascript.vim in vim 7.3.
"		     Added SJS constructs & multiline quotes
" Last Change:	2011 Sep 08

" tuning parameters:
" unlet sjs_fold

if !exists("main_syntax")
  let main_syntax = 'sjs'
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("sjs_fold")
  unlet sjs_fold
endif

syn keyword sjsCommentTodo      TODO FIXME XXX TBD contained
syn match   sjsLineComment      "\/\/.*" contains=@Spell,sjsCommentTodo
syn match   sjsCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  sjsComment	       start="/\*"  end="\*/" contains=@Spell,sjsCommentTodo
syn match   sjsSpecial	       "\\\d\d\d\|\\."
syn region  sjsStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=sjsSpecial,@htmlPreproc
syn region  sjsStringS	       start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=sjsSpecial,@htmlPreproc

syn match   sjsSpecialCharacter "'\\.'"
syn match   sjsNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  sjsRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gi]\{0,2\}\s*$+ end=+/[gi]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline

syn keyword sjsConditional	if else switch
syn keyword sjsRepeat		while for do in
syn keyword sjsBranch		break continue
syn keyword sjsOperator		new delete instanceof typeof
syn keyword sjsType		Array Boolean Date Function Number Object String RegExp
syn keyword sjsStatement		return with
syn keyword sjsBoolean		true false
syn keyword sjsNull		null undefined
syn keyword sjsIdentifier	arguments this var let
syn keyword sjsLabel		case default
syn keyword sjsException		try catch finally throw
syn keyword sjsMessage		alert confirm prompt status
syn keyword sjsGlobal		self window top parent
syn keyword sjsMember		document event location 
syn keyword sjsDeprecated	escape unescape
syn keyword sjsReserved		abstract boolean byte char class const debugger double enum export extends final float goto implements import int interface long native package private protected public short static super synchronized throws transient volatile 

"NOTE: these are the _only_ SJS specific additions / overrides:
syn keyword sjsException		and or retract
syn keyword sjsGlobal		waitfor spawn require hold
syn keyword sjsStatement		using
syn region  sjsStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"+	contains=sjsSpecial,@htmlPreproc
syn region  sjsInterpolation	matchgroup=sjsInterpolationDelimiter start="#{" end="}" contained contains=ALL containedIn=sjsStringD,sjsStringS

if exists("sjs_fold")
    syn match	sjsFunction	"\<function\>"
    syn region	sjsFunctionFold	start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match sjsSync	grouphere sjsFunctionFold "\<function\>"
    syn sync match sjsSync	grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword sjsFunction	function
    syn match	sjsBraces	   "[{}\[\]]"
    syn match	sjsParens	   "[()]"
endif

syn sync fromstart
syn sync maxlines=100

if main_syntax == "sjs"
  syn sync ccomment sjsComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sjs_syn_inits")
  if version < 508
    let did_sjs_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink sjsComment		Comment
  HiLink sjsLineComment		Comment
  HiLink sjsCommentTodo		Todo
  HiLink sjsSpecial		Special
  HiLink sjsStringS		String
  HiLink sjsStringD		String
  HiLink sjsCharacter		Character
  HiLink sjsSpecialCharacter	sjsSpecial
  HiLink sjsNumber		sjsValue
  HiLink sjsConditional		Conditional
  HiLink sjsRepeat		Repeat
  HiLink sjsBranch		Conditional
  HiLink sjsOperator		Operator
  HiLink sjsType			Type
  HiLink sjsStatement		Statement
  HiLink sjsFunction		Function
  HiLink sjsBraces		Function
  HiLink sjsError		Error
  HiLink sjsParenError		sjsError
  HiLink sjsNull			Keyword
  HiLink sjsBoolean		Boolean
  HiLink sjsRegexpString		String

  HiLink sjsIdentifier		Identifier
  HiLink sjsLabel		Label
  HiLink sjsException		Exception
  HiLink sjsMessage		Keyword
  HiLink sjsGlobal		Keyword
  HiLink sjsMember		Keyword
  HiLink sjsDeprecated		Exception 
  HiLink sjsReserved		Keyword
  HiLink sjsDebug		Debug
  HiLink sjsConstant		Label

  delcommand HiLink
endif

let b:current_syntax = "sjs"
if main_syntax == 'sjs'
  unlet main_syntax
endif

" vim: ts=8
