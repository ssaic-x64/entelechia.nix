# Example: Dialectical Reasoning
# Thesis-antithesis-synthesis approach to freedom

let
  lib = import ../lib/entelechia.nix {};

  # Create a dialectical agent
  agent = lib.mkAgent {
    mode = lib.modes.dialectical;
    reasoning = lib.reasoningTypes.deductive;
    metadata = {
      domain = "political-philosophy";
      tradition = "hegelian";
    };
  };

  # Create an inquiry about freedom
  inquiry = lib.mkInquiry {
    question = "How can individual freedom be reconciled with collective necessity?";
    mode = lib.modes.dialectical;
    assumptions = [
      "Freedom and necessity appear contradictory"
      "Contradictions can be resolved synthetically"
      "Higher unity preserves lower moments"
    ];
    constraints = [
      "Must identify the contradiction clearly"
      "Must achieve genuine synthesis, not mere compromise"
    ];
  };

  # Reflect on the inquiry
  reflection = lib.reflect agent inquiry;

in reflection
