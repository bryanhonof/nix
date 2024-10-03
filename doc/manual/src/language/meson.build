builtins_md = custom_target(
  command : nix_eval_for_docs + [
    '--write-to', '@OUTPUT@',
    '--expr',
    '(builtins.readFile @INPUT2@) + import @INPUT0@ (builtins.fromJSON (builtins.readFile ./@INPUT1@)) + (builtins.readFile @INPUT3@)',
  ],
  input : [
    '../../generate-builtins.nix',
    language_json,
    'builtins-prefix.md',
    'builtins-suffix.md'
  ],
  output : 'builtins.md',
  env : nix_env_for_docs,
)
