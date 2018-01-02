# Set user defined locale
export LANG=$(locale -uU)

# Add color to ANT output
export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorlogger'

stty erase '^?'

bind 'TAB:menu-complete'
