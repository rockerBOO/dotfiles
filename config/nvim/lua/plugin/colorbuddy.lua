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

  for i, color in ipairs(themeColors) do Color.new("cloud" .. i-1, color) end

  Color.new("fg", "#e4dcec")
  Color.new("bg", "#111113")

  Group.new("Normal", c.fg, c.bg)

  Group.new("Conceal", c.cloud3:light(), c.none)
  Group.new("VertSplit", c.cloud3, c.none)

  Group.new("Function", c.cloud8, c.none, styles.bold)
  Group.new("Error", c.cloud9, c.none, styles.bold)
  Group.new("ErrorMsg", c.cloud1, c.cloud9, styles.bold)
  Group.new("WarningMsg", c.cloud5, c.cloud12, styles.bold)
  Group.new("Boolean", c.cloud9, c.none, styles.NONE)
  Group.new("Character", c.cloud14, c.none, styles.NONE)
  Group.new("Comment", c.cloud3:light(), c.none, styles.NONE)
  Group.new("Conditional", c.cloud9, c.none, styles.NONE)
  Group.new("Constant", c.cloud4, c.none, styles.NONE)
  Group.new("Define", c.cloud9, c.none, styles.NONE)
  Group.new("Delimiter", c.cloud6, c.none, styles.NONE)
  Group.new("Exception", c.cloud9, c.none, styles.NONE)
  Group.new("Float", c.cloud15, c.none, styles.NONE)
  Group.new("Function", c.cloud8, c.none, styles.NONE)
  Group.new("Identifier", c.cloud4, c.none, styles.NONE)
  Group.new("Include", c.cloud9, c.none, styles.NONE)
  Group.new("Keyword", c.cloud9, c.none, styles.italic)
  Group.new("Label", c.cloud9, c.none, styles.italic)
  Group.new("Number", c.cloud15, c.none, styles.NONE)
  Group.new("Operator", c.cloud9, c.none, styles.NONE)
  Group.new("PreProc", c.cloud9, c.none, styles.NONE)
  Group.new("Repeat", c.cloud9, c.none, styles.NONE)
  Group.new("Special", c.cloud4, c.none, styles.NONE)
  Group.new("SpecialChar", c.cloud13, c.none, styles.NONE)
  Group.new("SpecialComment", c.cloud8, c.none, styles.NONE)
  Group.new("Statement", c.cloud9, c.none, styles.NONE)
  Group.new("StorageClass", c.cloud9, c.none, styles.NONE)
  Group.new("String", c.cloud14, c.none, styles.NONE)
  Group.new("Structure", c.cloud9, c.none, styles.NONE)
  Group.new("Tag", c.cloud4, c.none, styles.NONE)
  Group.new("Title", c.cloud4, c.none)
  Group.new("Todo", c.cloud13, c.none, styles.NONE)
  Group.new("Type", c.cloud9, c.none, styles.italic)
  Group.new("Typedef", c.cloud9, c.none, styles.NONE)
  Group.new("CursorColumn", c.cloud1, c.none, styles.NONE)
  Group.new("LineNr", c.cloud9, c.none, styles.NONE)
  Group.new("CursorLineNr", c.cloud5, c.none, styles.NONE)
  Group.new("Line", c.cloud12, c.none, styles.bold)
  Group.new("SignColumn", c.none, c.none, styles.NONE)

  Group.new("ColorColumn", c.none, c.cloud1)
  Group.new("Cursor", c.cloud0, c.cloud4)
  Group.new("CursorLine", c.none, c.cloud0)
  Group.new("iCursor", c.cloud0, c.cloud4)
  Group.new("EndOfBuffer", c.none, c.none)
  Group.new("MatchParen", c.cloud8, c.cloud3)
  Group.new("NonText", c.none, c.none)
  Group.new("PMenu", c.cloud4, c.cloud2)
  Group.new("PmenuSbar", c.cloud4, c.cloud2)
  Group.new("PMenuSel", c.cloud6, c.cloud9)
  Group.new("PmenuThumb", c.cloud8, c.cloud3)
  Group.new("SpecialKey", c.cloud3, c.cloud3)
  Group.new("SpellBad", c.cloud11, c.cloud0)
  Group.new("SpellCap", c.cloud13, c.cloud0)
  Group.new("SpellLocal", c.cloud5, c.cloud0)
  Group.new("SpellRare", c.cloud6, c.cloud0)
  Group.new("Visual", c.cloud4, c.cloud9)
  Group.new("VisualNOS", c.cloud2, c.cloud1)

end

function M:treesitter()
  local error = {"TSError"}

  local punctuation = {"TSPunctDelimiter", "TSPunctBracket", "TSPunchSpecial"}

  local constants = {"TSConstant", "TsConstBuiltin", "TSConstMacro"}

  local string = {"TSStringRegex", "TSString", "TSStringEscape"}

  local boolean = {"TSBoolean"}

  local number = {"TSNumber", "TSFloat"}

  local parameters = {"TSParameter", "TSParameterReference"}

  local operators = {"TSOperator"}

  local keywords = {"TSConditional", "TSRepeat"}

  local keyword = {"TSKeyword", "TSKeywordOperator"}

  local labels = {"TSLabel"}

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
    {error, c.cloud9, c.cloud1},
    {punctuation, c.cloud4:light():light()},
    {constants, c.cloud5:light()},
    {string, c.cloud10:light()},
    {boolean, c.cloud2:light()},
    {number, c.cloud6:light()},
    {parameters, c.cloud6, c.cloud12},
    {operators, c.cloud3:dark()},
    {keywords, c.cloud4:light()},
    {keyword, c.cloud4:light()},
    {labels, c.cloud4:light()},
    {variables, c.cloud12:light():light()},
    {text, c.fg},
  }

  -- Apply grouping to each color group
  for _, group in ipairs(groups) do
    for _, color in ipairs(group[1]) do Group.new(color, group[2], group[3], group[4]) end
  end
end

return M
