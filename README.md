# entelechia.nix

A declarative philosopher-agent system built with Nix.

Built for reflective reasoning, mode-based inquiry,
and systems thinking through configuration.

---

## Quick Start

```bash
# Run with Nix flakes
nix run github:ssaic-x64/entelechia.nix -- modes

# List all reasoning modes
nix run github:ssaic-x64/entelechia.nix -- modes

# Create a Socratic agent
nix run github:ssaic-x64/entelechia.nix -- agent socratic

# Run an example inquiry
nix run github:ssaic-x64/entelechia.nix -- example epistemology
```

## Features

- **Multiple Reasoning Modes**: Socratic, phenomenological, dialectical, analytic, and systematic
- **Various Reasoning Types**: Deductive, inductive, abductive, analogical, transcendental
- **Declarative Configuration**: Define agents and inquiries as Nix expressions
- **Compositional**: Combine modes and chain reasoning steps
- **Reproducible**: Nix ensures consistent evaluation across environments

## Philosophy

Purpose is treated as realization, not search.

From Aristotle's ἐντελέχεια (entelecheia): the condition of having one's purpose fulfilled - actuality as opposed to mere potentiality.

## Documentation

See [USAGE.md](USAGE.md) for detailed documentation and examples.

## License

MIT License - See [LICENSE](LICENSE)
