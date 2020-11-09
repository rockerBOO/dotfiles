-- Colorscheme using colorbuddy
-- with Treesitter, Typescript, LSP supported
-- colors from colorsx cloud (defunct website)
--
local Color, c, Group = require"colorbuddy".setup()
local M = {}

function M:colors()
  local themeColors = {
    "#222827",
    "#d5a8e4",
    "#9c75dd",
    "#9898ae",
    "#654a96",
    "#625566",
    "#a9d1df",
    "#e6ebe5",
    "#5d6f74",
    "#cd749c",
    "#63b0b0",
    "#c0c0dd",
    "#5786bc",
    "#3f3442",
    "#849da2",
    "#d9d6cf",
  }

  for i, color in ipairs(themeColors) do Color.new("cloud" .. i - 1, color) end

  Color.new("fg", "#e4dcec")
  Color.new("bg", "#111113")

  Group.new("Normal", c.fg:dark(.01), c.bg:light(.01))

  -- Conceal
  Group.new("Conceal", c.cloud3:light(), c.none)

  Group.new("VertSplit", c.cloud0, c.none)

  Group.new("Function", c.cloud8, c.none, styles.bold)

  Group.new("Error", c.cloud9, c.none, styles.bold)
  Group.new("ErrorMsg", c.cloud1:light():light(), c.cloud9:dark():saturate(.1), styles.bold)

  Group.new("WarningMsg", c.cloud4:light(.3), c.cloud12:dark(.3))
  Group.new("Exception", c.cloud9, c.none, styles.NONE)

  Group.new("Boolean", c.cloud2:dark(), c.none, styles.NONE)
  Group.new("Character", c.cloud14, c.none, styles.NONE)
  Group.new("Comment", c.cloud3:dark(), c.bg:light(.04), styles.NONE)
  Group.new("Conditional", c.cloud10, c.none, styles.NONE)
  Group.new("Constant", c.cloud4, c.none, styles.NONE)

  Group.new("Underlined", c.none, c.none, styles.italic)

  Group.new("Float", c.cloud4, c.none, styles.NONE)

  -- Search
  Group.new("IncSearch", c.cloud10:light(), c.cloud10:dark(.5), styles.italic)
  Group.new("Search", c.cloud10, c.cloud10:dark(.8))

  -- Numbers
  Group.new("Number", c.cloud15, c.none, styles.NONE)

  Group.new("Define", c.cloud10, c.none, styles.NONE)

  Group.new("Delimiter", c.cloud6, c.none, styles.NONE)

  Group.new("Directory", c.cloud4)

  Group.new("Function", c.cloud8)

  -- Folds
  Group.new("Folded", c.cloud4:dark(.1))
  Group.new("FoldColumn", c.cloud4:light())

  -- Diff
  Group.new("DiffAdd", c.none, c.cloud10)
  Group.new("DiffChange", c.none, c.cloud12)
  Group.new("DiffDelete", c.none, c.cloud9)
  Group.new("DiffText", c.none, c.cloud3)

  Group.new("Identifier", c.cloud2, c.none, styles.NONE)
  Group.new("Include", c.cloud10, c.none, styles.NONE)

  Group.new("Keyword", c.cloud4, c.none, styles.italic)

  Group.new("Label", c.cloud10, c.none, styles.italic)

  Group.new("Operator", c.cloud12:dark(), c.none, styles.NONE)

  Group.new("PreProc", c.cloud10, c.none, styles.NONE)

  Group.new("Repeat", c.cloud12:dark(), c.none, styles.NONE)

  Group.new("Statement", c.cloud10, c.none, styles.NONE)
  Group.new("StorageClass", c.cloud10, c.none, styles.NONE)
  Group.new("String", c.cloud14, c.none, styles.NONE)
  Group.new("Structure", c.cloud10, c.none, styles.NONE)
  Group.new("Tag", c.cloud4, c.none, styles.NONE)

  Group.new("Title", c.cloud4, c.none)

  Group.new("Todo", c.cloud13, c.none, styles.NONE)

  Group.new("Type", c.cloud10:light(), c.none, styles.italic)
  Group.new("Typedef", c.cloud10, c.none, styles.NONE)

  -- Side Column
  Group.new("CursorColumn", c.cloud1, c.none, styles.NONE)
  Group.new("LineNr", c.cloud10, c.none, styles.NONE)
  Group.new("CursorLineNr", c.cloud5, c.none, styles.NONE)
  Group.new("Line", c.cloud12, c.none, styles.bold)
  Group.new("SignColumn", c.none, c.none, styles.NONE)

  Group.new("ColorColumn", c.none, c.cloud1)
  Group.new("Cursor", c.cloud0, c.cloud4)
  Group.new("CursorLine", c.none, c.cloud0)
  Group.new("iCursor", c.cloud0, c.cloud4)

  Group.new("EndOfBuffer", c.cloud3, c.none)

  Group.new("MatchParen", c.none, c.cloud13:dark())
  Group.new("NonText", c.bg:light(), c.none)

  -- Popup Menu
  Group.new("PMenu", c.cloud4, c.cloud0)
  Group.new("PmenuSbar", c.cloud4, c.cloud2)
  Group.new("PMenuSel", c.cloud10, c.cloud0)
  Group.new("PmenuThumb", c.cloud8, c.cloud3)

  -- Special
  Group.new("Special", c.cloud4, c.none, styles.NONE)
  Group.new("SpecialChar", c.cloud13, c.none, styles.NONE)
  Group.new("SpecialKey", c.cloud13)
  Group.new("SpecialComment", c.cloud8, c.none, styles.NONE)

  -- Spell
  Group.new("SpellBad", c.cloud11, c.none)
  Group.new("SpellCap", c.cloud13, c.none)
  Group.new("SpellLocal", c.cloud5, c.none)
  Group.new("SpellRare", c.cloud6, c.none)

  -- Statusline
  Group.new("StatusLine", c.cloud10, c.cloud8:dark(.2))
  Group.new("StatusLineNC", c.cloud4, c.cloud8:dark(.3))

  -- Tabline
  Group.new("TabLine", c.cloud2, c.cloud0:dark())
  Group.new("TabLineSel", c.cloud10:light(), c.cloud13, styles.bold)
  Group.new("TabLineFill", c.cloud2, c.cloud0:dark())

  Group.new("Question", c.cloud10, c.none, styles.bold)

  -- Visual
  Group.new("Visual", c.cloud10, c.cloud13:dark(.2))
  Group.new("VisualNOS", c.cloud2, c.cloud1)

  M:lsp()
  M:ale()
  M:typescript()
  M:markdown()
  M:vim()
end

function M:vim()
  Group.new("vimcommand", c.cloud4)
  Group.new("vimmap", c.cloud4)
  Group.new("vimbracket", c.cloud10)
  Group.new("vimmapmodkey", c.cloud6)
  Group.new("vimnotation", c.cloud6)
  Group.new("vimmaplhs", c.cloud10)
  Group.new("vimiscommand", c.cloud10:light())
  Group.new("vimFilter", c.cloud7)
  Group.new("vimMapRhs", c.cloud15:dark(.1))
  Group.new("vimMapRhsExtend", c.cloud15:dark(.1))

  Group.new("vimlet", c.cloud4:dark())
  Group.new("vimnotfunc", c.cloud4:dark())
  Group.new("vimAutoCmdSfxList", c.cloud6)
  Group.new("vimUserFunc", c.cloud10)
  Group.new("vimSetEqual", c.cloud6)
end

function M:lsp()
  Group.new("LspDiagnosticsDefaultHint", c.cloud13:saturate(.05):light(), c.cloud13:dark(.9))
  Group.new("LspDiagnosticsDefaultError", c.cloud1, c.cloud9:dark():saturate(.1))
  Group.new("LspDiagnosticsDefaultWarning", c.cloud6)
  Group.new("LspDiagnosticsDefaultInformation", c.fg)
end

function M:ale()
  -- Clear ALEWarning
  -- Clear ALEError
  vim.cmd("highlight clear ALEWarning")
  vim.cmd("highlight clear ALEError")
end

function M:typescript()
  -- Group.new("typescriptbraces", c.cloud14:dark())

  -- tsx
  Group.new("tsxJsBlock", c.cloud4)
  Group.new("tsxclosetag", c.cloud8)
  Group.new("tsxelseoperator", c.cloud10:dark(.2))

  Group.new("typescriptAliasDeclaration", c.cloud8)
  Group.new("typescriptObjectLiteral", c.cloud8)
  Group.new("typescriptBinaryOp", c.cloud8)

  Group.new("typescriptParenExp", c.cloud8)
  -- Actually used as this? not sure if case sensitive
  Group.new("typescriptparenexp", c.cloud10)

  Group.new("typescriptEnum", c.cloud10)
  Group.new("typescriptString", c.cloud10:light(.3))
  Group.new("typescriptProp", c.cloud10)
  Group.new("typescriptUnion", c.cloud8:dark())

  Group.new("typescriptInterfaceTypeParameter", c.cloud8:dark())
  Group.new("typescriptInterfaceName", c.cloud10)

  Group.new("typescriptParens", c.cloud8)
  Group.new("typescriptTernaryOp", c.cloud8)
  Group.new("typescriptParenthesizedType", c.cloud10:dark(.2))
  Group.new("typescriptIdentifierName", c.cloud10)

  Group.new("typescriptGenericCall", c.cloud8)
  Group.new("typescript1", c.cloud6:dark():saturate(.1))

  Group.new("typescriptAssign", c.cloud6:dark():saturate(.1))
  Group.new("typescriptbraces", c.cloud10)
  Group.new("typescriptendcolons", c.cloud10:light())

  Group.new("typescriptFuncCallArg", c.cloud6)
  Group.new("typescriptTypeBrackets", c.cloud8:dark())
  Group.new("typescriptTypeAnnotation", c.cloud8)
  Group.new("typescriptTypeArguments", c.cloud8)
  Group.new("typescriptTypeReference", c.cloud10)
  Group.new("typescriptTypeCast", c.cloud8)
  Group.new("typescriptFuncType", c.cloud10)

  Group.new("typescriptUnaryOp", c.cloud4:light(.3), c.none, styles.bold)

  Group.new("typescriptaliasdeclaration", c.cloud10)
end

function M:markdown()
  Group.new("markdownh1", c.cloud6:light():saturate(.7), c.cloud0:dark(), styles.bold)
  Group.new("markdownh2", c.cloud6:saturate(.7), c.cloud0:dark(), styles.bold)
  Group.new("markdownh3", c.cloud6:dark(), c.cloud0:dark(), styles.bold)
  Group.new("markdownh4", c.cloud6:dark(), c.cloud0:dark(), styles.bold)
  Group.new("markdownh5", c.cloud6:dark(), c.cloud0:dark(), styles.bold)

  local delimiters = {
    "markdownH1Delimiter",
    "markdownH2Delimiter",
    "markdownH3Delimiter",
    "markdownH4Delimiter",
    "markdownH5Delimiter",
    "markdownH6Delimiter",
  }

  for _, delimiter in ipairs(delimiters) do Group.new(delimiter, c.cloud6:dark(), c.cloud0:dark()) end

  Group.new("markdownCodeDelimiter", c.cloud8:dark(), c.cloud0:dark(.1))
  Group.new("markdownCode", c.cloud4, c.cloud0:dark(.1))
  Group.new("markdownUrl", c.cloud14)
  Group.new("markdownLinkText", c.cloud10)

  Group.new("markdownLinkTextDelimiter", c.cloud8)
  Group.new("markdownLinkDelimiter", c.cloud8)
end

function M:treesitter()
  local error = {"TSError"}

  local punctuation = {"TSPunctDelimiter", "TSPunctBracket", "TSPunchSpecial"}

  local constants = {"TSConstant", "TsConstBuiltin", "TSConstMacro"}

  local string = {"TSStringRegex", "TSString", "TSStringEscape"}

  local boolean = {"TSBoolean"}

  local functions = {"TSFunction", "TSFuncBuiltin", "TSFuncMacro"}

  local methods = {"TSMethod"}

  local fields = {"TSField", "TSProperty"}

  local number = {"TSNumber", "TSFloat"}

  local parameters = {"TSParameter", "TSParameterReference"}

  local operators = {"TSOperator"}

  local forwords = {"TSConditional", "TSRepeat"}

  local keyword = {"TSKeyword", "TSKeywordOperator"}

  local types = {"TSType", "TSTypeBuiltin"}

  local labels = {"TSLabel"}

  local namespaces = {"TSNamespace"}

  local includes = {"TSInclude"}

  local variables = {"TSVariable", "TSVariableBuiltin"}

  local text = {
    "TSText",
    "TSStrong",
    "TSEmphasis",
    "TSUnderline",
    "TSTitle",
    "TSLiteral",
    "TSURI",
    "TSTag",
    "TSTagDelimiter",
  }

  local groups = {
    {error, c.cloud1:light(), c.cloud9:dark(.5)},
    {punctuation, c.cloud3:dark():dark()},
    {constants, c.cloud5:light()},
    {string, c.cloud10:light():light():saturate(.25)},
    {boolean, c.cloud2:light()},
    {functions, c.cloud8:light(.1)},
    {methods, c.cloud8:light(.2)},
    {fields, c.cloud8},
    {number, c.cloud6:light()},
    {parameters, c.cloud6:dark()},
    {operators, c.cloud3:dark():dark()},
    {forwords, c.cloud8:saturate(.1):light(), c.none},
    {keyword, c.cloud4, c.none, styles.bold + styles.italic},
    {types, c.cloud10},
    {includes, c.cloud10},
    {labels, c.cloud4:light()},
    {namespaces, c.cloud4},
    {variables, c.cloud6},
    {text, c.fg},
  }

  -- Apply grouping to each color group
  for _, group in ipairs(groups) do
    for _, color in ipairs(group[1]) do Group.new(color, group[2], group[3], group[4]) end
  end

  -- Group.new("TSPunctBracket", c.blue)
  Group.new("TSPunctDelimiter", c.cloud3:dark():dark():saturate(.1))
  Group.new("TSVariableBuiltin", c.cloud6:dark(), c.none, styles.bold)

  Group.new("TSTypeBuiltin", c.cloud10, c.none, styles.bold)
  Group.new("TSFuncBuiltin", c.cloud8:light(.1), c.none, styles.bold)

  -- Group.new("TSTitle", c.cloud4)
  -- Group.new("TSStrong", c.cloud4, c.none, styles.bold)
end

return M
