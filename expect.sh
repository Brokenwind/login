#!/usr/bin/expect
# file name :login
# Usages : ip address
# Description : 自动登录

set ip [lindex $argv 0]
spawn ./jump.sh
expect "*user>*" { send "webedit\r" }
expect "*host>*" { send  ${ip}\r }
interact
#EOF
