{
  description = ''Nim module for parsing SubViewer subtitle files'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-subviewer-master.flake = false;
  inputs.src-subviewer-master.owner = "achesak";
  inputs.src-subviewer-master.ref   = "refs/heads/master";
  inputs.src-subviewer-master.repo  = "nim-subviewer";
  inputs.src-subviewer-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-subviewer-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-subviewer-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}