let
  userName = "Karol";
  email = "dobrekkarol@gmail.com";
in
{
    programs.git = {
        enable = true;
        userName = userName;
        userEmail = email;
         extraConfig.init.defaultBranch = "main";
    };
}
