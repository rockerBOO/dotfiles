function! DockSend()
  let filePath = expand("%:p")
  let appleScript = "-e \"on run argv\r
    \set filePath to POSIX path of item 1 of argv\r
    \set fileName to POSIX file filePath\r
    \ignoring application responses\r
      \tell app \\\"Transmit\\\" to open fileName\r
    \end ignoring\r
  \end run\""

  silent exec "!osascript " . appleScript . " \"" . filePath . "\""
  echo "File " . filePath . " sent to Transmit." 
endfunction

command! DockSend call DockSend()
