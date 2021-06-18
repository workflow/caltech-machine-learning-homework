let
  jupyter = import (builtins.fetchGit {
    url = https://github.com/tweag/jupyterWith;
    rev = "";
  }) {};

  #pkgs = import <nixpkgs> { };

   # Version: 3.8.6
  # python3 = (import (pkgs.fetchzip {
  #   url = "https://github.com/nixos/nixpkgs/archive/7138a338b58713e0dea22ddab6a6785abec7376a.zip";
  #   sha256 = "1asgl1hxj2bgrxdixp3yigp7xn25m37azwkf3ppb248vcfc5kil3";
  # }) { }).python3;

  iPython = jupyter.kernels.iPythonWith {
    name = "python";
    packages = p: with p; [ 
      matplotlib
      numpy
      scikitlearn
      sympy
    ];
    # Errors out with Python 3.8 for now
    #inherit python3;
  };

  jupyterEnvironment =
    jupyter.jupyterlabWith {
      kernels = [ iPython ];
    };
in
  jupyterEnvironment.env
