# Entelechia Usage Guide

## Overview

Entelechia is a Nix-based philosophy agent system that provides declarative tools for philosophical reasoning and inquiry. It treats purpose as realization, not search.

## Installation

### With Flakes (Recommended)

```bash
# Run directly without installation
nix run github:ssaic-x64/entelechia.nix

# Enter development environment
nix develop github:ssaic-x64/entelechia.nix

# Build the package
nix build github:ssaic-x64/entelechia.nix
```

### Without Flakes

```bash
# Build using default.nix
nix-build

# Install to profile
nix-env -f . -i entelechia
```

## Usage

### List Available Modes

```bash
entelechia modes
```

Available reasoning modes:
- **socratic**: Question-driven dialectical reasoning
- **phenomenological**: Direct experience analysis
- **dialectical**: Thesis-antithesis-synthesis
- **analytic**: Logical and linguistic precision
- **systematic**: Holistic systems thinking

### List Reasoning Types

```bash
entelechia reasoning
```

Available reasoning types:
- **deductive**: Necessary conclusions from principles
- **inductive**: Probable generalizations from observations
- **abductive**: Plausible best explanations
- **analogical**: Suggestive similarity reasoning
- **transcendental**: Foundational possibility conditions

### Create an Agent

```bash
entelechia agent socratic
```

This creates and displays a philosopher-agent configuration.

### Run Examples

```bash
entelechia example epistemology
entelechia example phenomenology
entelechia example systems
entelechia example dialectical
```

### Evaluate Expressions

```bash
entelechia eval 'mkAgent { mode = modes.analytic; reasoning = reasoningTypes.deductive; }'
```

### Interactive REPL

```bash
entelechia repl
```

Enter an interactive Nix REPL with the Entelechia library loaded.

## Creating Custom Inquiries

Create a `.nix` file with your inquiry:

```nix
# my-inquiry.nix
let
  lib = import <entelechia-lib> {};
in

let
  agent = lib.mkAgent {
    mode = lib.modes.socratic;
    reasoning = lib.reasoningTypes.deductive;
  };

  inquiry = lib.mkInquiry {
    question = "Your philosophical question here";
    mode = lib.modes.socratic;
    assumptions = [ "assumption 1" "assumption 2" ];
    constraints = [ "constraint 1" ];
  };

  reflection = lib.reflect agent inquiry;
in reflection
```

Then process it:

```bash
entelechia inquiry my-inquiry.nix
```

## Library API

### Core Functions

- `mkAgent { mode, reasoning, context?, metadata? }` - Create a philosopher-agent
- `mkInquiry { question, mode, assumptions?, constraints?, goal? }` - Create an inquiry
- `reflect agent inquiry` - Process inquiry through agent
- `composeModes modeList` - Compose multiple modes
- `mkReasoningChain steps` - Create a reasoning chain

### Modes

Access via `lib.modes`:
- `lib.modes.socratic`
- `lib.modes.phenomenological`
- `lib.modes.dialectical`
- `lib.modes.analytic`
- `lib.modes.systematic`

### Reasoning Types

Access via `lib.reasoningTypes`:
- `lib.reasoningTypes.deductive`
- `lib.reasoningTypes.inductive`
- `lib.reasoningTypes.abductive`
- `lib.reasoningTypes.analogical`
- `lib.reasoningTypes.transcendental`

## Philosophy

Entelechia embodies:
- **Declarative reasoning**: Configuration over imperative logic
- **Mode-based inquiry**: Multiple approaches to philosophical questions
- **Systems thinking**: Holistic understanding of relations
- **Purpose as realization**: Actualization rather than search

The name "Entelechia" comes from Aristotle's concept of ἐντελέχεια (entelecheia), meaning the realization or actualization of potential - the state of having one's purpose fulfilled.

## Examples in Detail

### Epistemology Example

Explores the nature of knowledge using Socratic method with deductive reasoning.

### Phenomenology Example

Examines conscious experience using phenomenological bracketing (epoché) with abductive reasoning.

### Systems Example

Investigates part-whole relations using systematic thinking with transcendental reasoning.

### Dialectical Example

Addresses freedom and necessity through Hegelian dialectics with synthesis.

## Development

### Enter Development Shell

```bash
nix develop
```

This provides:
- Nix with flakes enabled
- jq for JSON processing
- nixpkgs-fmt for formatting
- Core utilities

### Format Nix Files

```bash
nixpkgs-fmt *.nix lib/*.nix
```

### Test the Build

```bash
nix build
./result/bin/entelechia modes
```

## License

MIT License - See LICENSE file

## Contributing

Contributions welcome! This is a declarative philosophy system - add new modes, reasoning types, or examples that embody reflective thinking.
