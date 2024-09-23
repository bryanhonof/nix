summary_rl_next = custom_target(
  command : [
    bash,
    '-euo', 'pipefail',
    '-c',
    '''
      if [ -s @INPUT0@ ]; then
        echo '  - [Upcoming release](release-notes/rl-next.md)' > @OUTPUT@
      else
        true > @OUTPUT@
      fi
    ''',
  ],
  input : [
    rl_next_generated,
  ],
  output : 'SUMMARY-rl-next.md',
)
