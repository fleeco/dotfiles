{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      #export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain codeartifact-default --domain-owner 939067023032 --region us-east-1 --query authorizationToken --output text`
    '';
  };
}
