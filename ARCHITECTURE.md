# Architecture Document: Entelechia Philosophy Agent

## Overview

Entelechia is a Nix-based philosophy agent system that embodies declarative reasoning through functional programming principles. The name derives from Aristotle's ἐντελέχεια (entelecheia), meaning the realization or actualization of potential.

## Design Philosophy

### Core Principles

1. **Declarative Configuration**: Philosophical reasoning is expressed as data structures, not imperative procedures
2. **Compositional**: Modes and reasoning types can be composed to create complex inquiries
3. **Reproducible**: Nix ensures consistent evaluation across all environments
4. **Type-Safe**: Nix's type system provides compile-time guarantees
5. **Purpose as Realization**: Treating philosophical inquiry as actualization rather than search

## Architecture

### Component Structure

```
entelechia.nix/
├── lib/
│   └── entelechia.nix       # Core library with agent logic
├── bin/
│   └── entelechia           # CLI interface
├── examples/
│   ├── epistemology.nix     # Knowledge inquiry
│   ├── phenomenology.nix    # Consciousness analysis
│   ├── dialectical.nix      # Freedom/necessity synthesis
│   ├── systems.nix          # Part-whole relations
│   └── multimodal.nix       # Multi-perspective reasoning
├── flake.nix                # Nix flake configuration
├── default.nix              # Legacy Nix support
└── docs/
    ├── README.md            # Quick start guide
    ├── USAGE.md             # Detailed usage
    ├── TESTING.md           # Testing guide
    └── ARCHITECTURE.md      # This document
```

### Library Components

#### 1. Modes (lib/entelechia.nix)

Five philosophical reasoning modes:

- **Socratic**: Question-driven dialectical reasoning (method: elenchos)
- **Phenomenological**: Direct experience analysis (method: epoché)
- **Dialectical**: Thesis-antithesis-synthesis (method: aufheben)
- **Analytic**: Logical and linguistic precision (method: decomposition)
- **Systematic**: Holistic systems thinking (method: integration)

Each mode has:
- `name`: Identifier
- `description`: Purpose
- `approach`: Methodological orientation
- `method`: Specific technique
- `goal`: Intended outcome

#### 2. Reasoning Types

Five types of inference:

- **Deductive**: Necessary conclusions from principles (certainty: necessary)
- **Inductive**: Probable generalizations (certainty: probable)
- **Abductive**: Best explanations (certainty: plausible)
- **Analogical**: Similarity reasoning (certainty: suggestive)
- **Transcendental**: Possibility conditions (certainty: foundational)

#### 3. Core Functions

- `mkAgent { mode, reasoning, context?, metadata? }`: Create a philosopher-agent configuration
- `mkInquiry { question, mode, assumptions?, constraints?, goal? }`: Define a philosophical question
- `reflect agent inquiry`: Process inquiry through agent's reasoning framework
- `composeModes modeList`: Combine multiple modes for integrated reasoning
- `mkReasoningChain steps`: Chain multiple reflections sequentially
- `formatAgent agent`: Display agent configuration
- `formatInquiry inquiry`: Display inquiry structure

### CLI Interface

The `entelechia` command provides:

```
Commands:
  modes               List available reasoning modes
  reasoning           List reasoning types
  agent <mode>        Create and display agent
  inquiry <file>      Process inquiry from Nix file
  example <name>      Run example inquiry
  eval <expr>         Evaluate Nix expression
  repl                Interactive REPL
  help                Show help
```

### Nix Integration

#### Flake Structure

- **Inputs**: nixpkgs, flake-utils
- **Outputs**:
  - `packages.default`: Main entelechia package
  - `devShells.default`: Development environment
  - `apps.default`: Runnable application

#### Build Process

1. Copy library to output
2. Install CLI script
3. Wrap script with PATH and environment variables
4. Install examples and documentation

## Usage Patterns

### Basic Usage

```nix
let
  lib = import <entelechia-lib> {};
  
  agent = lib.mkAgent {
    mode = lib.modes.socratic;
    reasoning = lib.reasoningTypes.deductive;
  };
  
  inquiry = lib.mkInquiry {
    question = "What is knowledge?";
    mode = lib.modes.socratic;
  };
  
in lib.reflect agent inquiry
```

### Multi-Modal Reasoning

```nix
let
  lib = import <entelechia-lib> {};
  
  # Create different agents
  critical = lib.mkAgent {
    mode = lib.modes.socratic;
    reasoning = lib.reasoningTypes.deductive;
  };
  
  experiential = lib.mkAgent {
    mode = lib.modes.phenomenological;
    reasoning = lib.reasoningTypes.abductive;
  };
  
  # Chain their reflections
  chain = lib.mkReasoningChain [
    (lib.reflect critical inquiry)
    (lib.reflect experiential inquiry)
  ];
  
in chain
```

## Technical Decisions

### Why Nix?

1. **Declarative**: Perfect match for declarative philosophy
2. **Reproducible**: Philosophical configurations are reproducible
3. **Compositional**: Natural composition of functions
4. **Lazy Evaluation**: Efficient handling of complex structures
5. **Type System**: Compile-time validation

### Why Bash for CLI?

1. **Portability**: Available on all Unix systems
2. **Simplicity**: Direct integration with Nix commands
3. **Transparency**: Easy to understand and modify
4. **Dependencies**: Minimal (just Nix, jq, coreutils)

### Data Model

Agents and inquiries are pure data structures:

```nix
agent = {
  type = "philosopher-agent";
  mode = { name, description, approach, method, goal };
  reasoning = { name, description, certainty };
  properties = { reflective, deliberative, purpose-driven };
}

inquiry = {
  type = "philosophical-inquiry";
  question = "...";
  mode = { ... };
  assumptions = [ ... ];
  constraints = [ ... ];
  goal = "...";
}

reflection = {
  type = "reflection";
  agent = { ... };
  inquiry = { ... };
  structure = { premise, method, approach, reasoning };
  result = { certainty, scope };
}
```

## Extension Points

### Adding New Modes

Edit `lib/entelechia.nix`:

```nix
modes = {
  # ... existing modes
  
  pragmatic = {
    name = "pragmatic";
    description = "Consequence-based reasoning";
    approach = "practical";
    method = "experimental";
    goal = "test-through-action";
  };
};
```

### Adding New Reasoning Types

```nix
reasoningTypes = {
  # ... existing types
  
  hermeneutic = {
    name = "hermeneutic";
    description = "Interpretive understanding";
    certainty = "contextual";
  };
};
```

### Creating Custom Inquiries

Create a `.nix` file following the example pattern:

```nix
let lib = import <entelechia-lib> {};
in
let
  agent = lib.mkAgent { ... };
  inquiry = lib.mkInquiry { ... };
in lib.reflect agent inquiry
```

## Testing Strategy

1. **Syntax Validation**: `nix-instantiate --parse`
2. **Type Checking**: Nix's built-in evaluation
3. **Structure Testing**: `validate.sh` script
4. **Integration Testing**: Example execution
5. **Manual Testing**: REPL exploration

## Future Enhancements

Potential extensions (not in current scope):

1. **Formal Logic Integration**: SMT solver backend
2. **Argument Visualization**: Graph output
3. **Historical Context**: Philosopher database
4. **Interactive Dialogue**: Multi-turn reasoning
5. **Knowledge Base**: Store and retrieve reflections
6. **Natural Language**: Parse questions from text
7. **Web Interface**: Browser-based REPL

## Dependencies

### Runtime
- Nix (with flakes support recommended)
- jq (JSON processing)
- coreutils (basic utilities)
- bash (CLI interface)

### Development
- nixpkgs-fmt (code formatting)
- git (version control)

## Performance Considerations

- **Lazy Evaluation**: Nix only evaluates what's needed
- **Pure Functions**: No side effects, easy caching
- **Immutable Data**: No mutation overhead
- **Parallel Evaluation**: Nix can parallelize independent computations

## Security Considerations

- **No External Network**: All evaluation is local
- **Sandboxed Builds**: Nix build sandbox isolation
- **Reproducible**: Hash-based integrity
- **No Secrets**: No credentials in configurations

## Philosophical Foundations

The system embodies several philosophical concepts:

1. **Aristotelian Teleology**: Purpose as actualization
2. **Multiple Perspectives**: No single "correct" mode
3. **Systematic Unity**: Composable reasoning
4. **Reflective Practice**: Self-aware inquiry
5. **Declarative Truth**: Configuration as assertion

## Conclusion

Entelechia demonstrates that philosophical reasoning can be formalized through declarative configuration while maintaining richness and flexibility. By leveraging Nix's strengths, it provides a reproducible, composable system for exploring philosophical questions through multiple modes and reasoning types.

The architecture prioritizes simplicity, extensibility, and alignment with philosophical principles. As a declarative system, it treats purpose as realization rather than search, embodying the very concept its name represents.
