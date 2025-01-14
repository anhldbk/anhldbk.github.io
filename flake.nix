{
  description = "Jekyll with Ruby 2 using Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Use a recent nixpkgs
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        ruby2 = pkgs.ruby_2_7; # Or ruby_2_6, ruby_2_5 etc. as needed

        bundlerEnv = ruby2.bundlerEnv {
          name = "jekyll-env";
          gemdir = ./.; # The directory containing your Gemfile
          lockFile = ./Gemfile.lock; # Optional, but recommended
        };

        jekyll = bundlerEnv.override {
          inherit ruby2;
        };

        bundleExec = jekyll + "/bin/bundle exec";

      in {
        devShell = pkgs.mkShell {
          buildInputs = [ jekyll pkgs.git ];
          shellHook = ''
            export BUNDLE_PATH=$(pwd)/.bundle
            export PATH="$bundleExec:$PATH"
          '';
        };

        # Example commands
        jekyllBuild = pkgs.writeShellScriptBin "jekyll-build" ''
          export BUNDLE_PATH=$(pwd)/.bundle
          export PATH="$bundleExec:$PATH"
          bundle exec jekyll build
        '';

        jekyllServe = pkgs.writeShellScriptBin "jekyll-serve" ''
          export BUNDLE_PATH=$(pwd)/.bundle
          export PATH="$bundleExec:$PATH"
          bundle exec jekyll serve --livereload
        '';
      });
}