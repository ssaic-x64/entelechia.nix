# Example: Epistemology Inquiry
# An inquiry into the nature of knowledge using Socratic method

let
  lib = import ../lib/entelechia.nix {};

  # Create a Socratic agent with deductive reasoning
  agent = lib.mkAgent {
    mode = lib.modes.socratic;
    reasoning = lib.reasoningTypes.deductive;
    metadata = {
      domain = "epistemology";
      tradition = "ancient-greek";
    };
  };

  # Create an inquiry about knowledge
  inquiry = lib.mkInquiry {
    question = "What is knowledge, and how does it differ from mere belief?";
    mode = lib.modes.socratic;
    assumptions = [
      "Knowledge requires justification"
      "Belief can exist without truth"
      "Truth is independent of belief"
    ];
    constraints = [
      "Must distinguish knowledge from opinion"
      "Must address the problem of justified true belief"
    ];
  };

  # Reflect on the inquiry
  reflection = lib.reflect agent inquiry;

in reflection
