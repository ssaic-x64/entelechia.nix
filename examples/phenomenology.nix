# Example: Phenomenological Analysis
# Examining consciousness and experience using phenomenological method

let
  lib = import ../lib/entelechia.nix {};

  # Create a phenomenological agent with descriptive reasoning
  agent = lib.mkAgent {
    mode = lib.modes.phenomenological;
    reasoning = lib.reasoningTypes.abductive;
    metadata = {
      domain = "consciousness-studies";
      tradition = "continental";
    };
  };

  # Create an inquiry about consciousness
  inquiry = lib.mkInquiry {
    question = "What is the structure of conscious experience before conceptual interpretation?";
    mode = lib.modes.phenomenological;
    assumptions = [
      "Direct experience is accessible"
      "Bracketing presuppositions is possible"
      "Intentionality structures consciousness"
    ];
    constraints = [
      "Must describe rather than explain"
      "Must suspend metaphysical commitments"
    ];
  };

  # Reflect on the inquiry
  reflection = lib.reflect agent inquiry;

in reflection
