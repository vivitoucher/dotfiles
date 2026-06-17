{ pkgs, ... }:

{
  # inject quickshell engine natively
  home.packages = with pkgs; [
    quickshell
  ];

  # direct mapping for layout scripts
  home.file.".config/quickshell/shell.qml".text = ''
    // quickshell interface architecture
    import qt.core
    import quickshell
    
    ShellRoot {
      // setup definition lives here
    }
  '';
}
