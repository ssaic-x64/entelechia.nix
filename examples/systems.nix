# Example: Systematic Philosophy
# Holistic systems thinking about reality

let
  lib = import ../lib/entelechia.nix {};
in

let
  # Create a systematic agent with multiple reasoning modes
  agent = lib.mkAgent {
    mode = lib.modes.systematic;
    reasoning = lib.reasoningTypes.transcendental;
    metadata = {
      domain = "metaphysics";
      tradition = "systematic-idealism";
    };
  };

  # Create an inquiry about wholeness
  inquiry = lib.mkInquiry {
    question = "How do parts relate to wholes in complex systems?";
    mode = lib.modes.systematic;
    assumptions = [
      "Wholes are more than the sum of parts"
      "Relations constitute systems"
      "Emergence is real"
    ];
    constraints = [
      "Must account for both composition and emergence"
      "Must integrate multiple perspectives"
    ];
  };

  # Reflect on the inquiry
  reflection = lib.reflect agent inquiry;

in reflection
