{ lib
, mkMesonDerivation

, meson
, ninja
, lowdown
, mdbook
, mdbook-linkcheck
, jq
, python3
, rsync
, nix-cli

# Configuration Options

, version
}:

let
  inherit (lib) fileset;
in

mkMesonDerivation (finalAttrs: {
  pname = "nix-manual";
  inherit version;

  workDir = ./.;
  fileset = fileset.difference
    (fileset.unions [
      ../../.version
      # Too many different types of files to filter for now
      ../../doc/manual
      ./.
    ])
    # Do a blacklist instead
    ../../doc/manual/package.nix;

  # TODO the man pages should probably be separate
  outputs = [ "out" "man" ];

  # Hack for sake of the dev shell
  passthru.baseNativeBuildInputs = [
    meson
    ninja
    (lib.getBin lowdown)
    mdbook
    mdbook-linkcheck
    jq
    python3
    rsync
  ];

  nativeBuildInputs = finalAttrs.passthru.baseNativeBuildInputs ++ [
    nix-cli
  ];

  preConfigure =
    ''
      chmod u+w ./.version
      echo ${finalAttrs.version} > ./.version
    '';

  postInstall = ''
    mkdir -p ''${!outputDoc}/nix-support
    echo "doc manual ''${!outputDoc}/share/doc/nix/manual" >> ''${!outputDoc}/nix-support/hydra-build-products
  '';

  meta = {
    platforms = lib.platforms.all;
  };
})
