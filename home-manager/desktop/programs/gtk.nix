{ pkgs, ... }:

{
  gtk = {
   enable = true;

   cursorTheme = {
     package = pkgs.capitaine-cursors-themed;
     name = "Capitaine Cursors (Gruvbox)";
     size = 12;
   };

   font = {
     package = pkgs.noto-fonts;
     name = "Noto Sans";
     size = 11;
   };

   theme = {
     package = pkgs.gruvbox-gtk-theme;
     name = "Gruvbox-Dark";
   };

   iconTheme = {
     package = pkgs.gruvbox-gtk-theme;
     name = "Gruvbox-Dark";
   };
 }; 
}
