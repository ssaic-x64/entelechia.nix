# Example: Multi-Modal Philosophical Inquiry
# Demonstrates composing multiple reasoning modes for a complex question

let
  lib = import ../lib/entelechia.nix {};
in

let
  # Compose multiple modes for comprehensive analysis
  multiModal = lib.composeModes [
    lib.modes.socratic
    lib.modes.phenomenological
    lib.modes.systematic
  ];

  # Create agents with different reasoning approaches
  socraticAgent = lib.mkAgent {
    mode = lib.modes.socratic;
    reasoning = lib.reasoningTypes.deductive;
    metadata = { perspective = "critical-examination"; };
  };

  phenomenologicalAgent = lib.mkAgent {
    mode = lib.modes.phenomenological;
    reasoning = lib.reasoningTypes.abductive;
    metadata = { perspective = "lived-experience"; };
  };

  systematicAgent = lib.mkAgent {
    mode = lib.modes.systematic;
    reasoning = lib.reasoningTypes.transcendental;
    metadata = { perspective = "holistic-integration"; };
  };

  # Complex inquiry about consciousness
  inquiry = lib.mkInquiry {
    question = "What is the relationship between consciousness, intentionality, and reality?";
    mode = lib.modes.systematic;
    assumptions = [
      "Consciousness is always directed toward something"
      "Reality exists independent of consciousness"
      "Experience mediates our access to reality"
    ];
    constraints = [
      "Must integrate subjective and objective perspectives"
      "Must account for both first-person and third-person views"
    ];
  };

  # Create reflections from each perspective
  socraticReflection = lib.reflect socraticAgent inquiry;
  phenomenologicalReflection = lib.reflect phenomenologicalAgent inquiry;
  systematicReflection = lib.reflect systematicAgent inquiry;

  # Create a reasoning chain
  reasoningChain = lib.mkReasoningChain [
    socraticReflection
    phenomenologicalReflection
    systematicReflection
  ];

in {
  inherit multiModal inquiry reasoningChain;
  
  # Summary of the multi-modal approach
  summary = {
    question = inquiry.question;
    modes-used = builtins.length reasoningChain.steps;
    perspectives = [
      socraticAgent.metadata.perspective
      phenomenologicalAgent.metadata.perspective
      systematicAgent.metadata.perspective
    ];
    chain-valid = reasoningChain.validate;
  };

  # Individual reflections
  reflections = {
    socratic = socraticReflection;
    phenomenological = phenomenologicalReflection;
    systematic = systematicReflection;
  };
}
