{
  description = "Sean's collection of flake templates";

  outputs = { self }: {

    templates = {

      trivial = {
        path = ./trivial;
        description = "A very basic flake";
      };

      go-home = {
        path = ./go-home;
        description = "A Home Home Manager template with Go Enabled and in the path";
      };

    };

    defaultTemplate = self.templates.trivial;

  };
}
