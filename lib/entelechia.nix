# Entelechia Library - Core Philosophy Agent Functions
# This library provides declarative functions for philosophical reasoning

{ pkgs ? import <nixpkgs> {} }:

rec {
  # Agent Modes - Different approaches to philosophical inquiry
  modes = {
    # Socratic mode - Question-driven dialectical reasoning
    socratic = {
      name = "socratic";
      description = "Question-driven dialectical reasoning";
      approach = "interrogative";
      method = "elenchos";
      goal = "examine-assumptions";
    };

    # Phenomenological mode - Direct experience analysis
    phenomenological = {
      name = "phenomenological";
      description = "Direct experience and consciousness analysis";
      approach = "descriptive";
      method = "epoché";
      goal = "bracket-presuppositions";
    };

    # Dialectical mode - Thesis-antithesis-synthesis
    dialectical = {
      name = "dialectical";
      description = "Thesis-antithesis-synthesis reasoning";
      approach = "synthetic";
      method = "aufheben";
      goal = "resolve-contradictions";
    };

    # Analytic mode - Logical and linguistic analysis
    analytic = {
      name = "analytic";
      description = "Logical and linguistic precision";
      approach = "analytical";
      method = "decomposition";
      goal = "clarify-concepts";
    };

    # Systematic mode - Holistic systems thinking
    systematic = {
      name = "systematic";
      description = "Holistic systems and relations thinking";
      approach = "holistic";
      method = "integration";
      goal = "understand-wholeness";
    };
  };

  # Reasoning Types
  reasoningTypes = {
    deductive = {
      name = "deductive";
      description = "From general principles to specific conclusions";
      certainty = "necessary";
    };

    inductive = {
      name = "inductive";
      description = "From specific observations to general principles";
      certainty = "probable";
    };

    abductive = {
      name = "abductive";
      description = "Inference to best explanation";
      certainty = "plausible";
    };

    analogical = {
      name = "analogical";
      description = "Reasoning by analogy and similarity";
      certainty = "suggestive";
    };

    transcendental = {
      name = "transcendental";
      description = "Conditions for possibility of experience";
      certainty = "foundational";
    };
  };

  # Agent Configuration Schema
  mkAgent = { mode, reasoning, context ? {}, metadata ? {} }: {
    inherit mode reasoning context metadata;
    type = "philosopher-agent";
    
    # Declarative agent properties
    properties = {
      reflective = true;
      deliberative = true;
      purpose-driven = true;
    };

    # Configuration validation
    isValid = 
      builtins.hasAttr mode.name modes &&
      builtins.hasAttr reasoning.name reasoningTypes;
  };

  # Create inquiry - A structured philosophical question
  mkInquiry = { question, mode, assumptions ? [], constraints ? [], goal ? null }: {
    inherit question mode assumptions constraints;
    type = "philosophical-inquiry";
    
    goal = if goal != null then goal else mode.goal;
    
    # Inquiry metadata
    metadata = {
      timestamp = builtins.currentTime or null;
      mode-name = mode.name;
    };
  };

  # Reflection function - Process inquiry through agent
  reflect = agent: inquiry: {
    agent = agent;
    inquiry = inquiry;
    type = "reflection";
    
    # Reflection structure
    structure = {
      premise = inquiry.question;
      method = agent.mode.method;
      approach = agent.mode.approach;
      reasoning = agent.reasoning.name;
    };

    # Result characteristics
    result = {
      certainty = agent.reasoning.certainty;
      scope = agent.mode.goal;
    };
  };

  # Compose multiple modes for integrated reasoning
  composeModes = modeList: {
    type = "composed-modes";
    modes = modeList;
    description = "Multi-modal philosophical reasoning";
    
    methods = builtins.map (m: m.method) modeList;
    goals = builtins.map (m: m.goal) modeList;
  };

  # Create a reasoning chain
  mkReasoningChain = steps: {
    type = "reasoning-chain";
    steps = steps;
    length = builtins.length steps;
    
    validate = builtins.all (s: s ? type && s.type == "reflection") steps;
  };

  # Utility: Format agent for display
  formatAgent = agent: ''
    Philosopher Agent
    ================
    Mode: ${agent.mode.name}
    Description: ${agent.mode.description}
    Approach: ${agent.mode.approach}
    Method: ${agent.mode.method}
    Reasoning: ${agent.reasoning.name} (${agent.reasoning.certainty})
    Goal: ${agent.mode.goal}
  '';

  # Utility: Format inquiry for display
  formatInquiry = inquiry: ''
    Philosophical Inquiry
    ====================
    Question: ${inquiry.question}
    Mode: ${inquiry.mode.name}
    Goal: ${inquiry.goal}
    Assumptions: ${builtins.toString (builtins.length inquiry.assumptions)}
    Constraints: ${builtins.toString (builtins.length inquiry.constraints)}
  '';

  # Export all modes as a set
  allModes = modes;

  # Export all reasoning types
  allReasoningTypes = reasoningTypes;
}
