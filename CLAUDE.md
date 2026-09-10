# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

"Autómatas" is a Flutter app (Spanish UI) implementing automata-theory algorithms:

- Convert a regular expression (using operators `+` union, `.` concatenation, `*` Kleene star) into a Thompson NFA, then an ε-NFA, then a DFA, then a minimized DFA.
- Convert a user-defined finite automaton (states/alphabet/transitions entered by hand, optionally with ε-transitions) through the same NFA → DFA → minimized-DFA pipeline.
- Validate whether an input string is accepted by the resulting automaton.

The app targets old Dart (pre-null-safety): `pubspec.yaml` pins `sdk: ">=2.1.0 <3.0.0"`. Match this style (no `?`/`!` null-safety operators, nullable-by-default types) when editing existing files.

## Commands

Run from the repo root (`flutter` must be on `PATH`):

- `flutter pub get` — install dependencies after touching `pubspec.yaml`.
- `flutter run` — run on a connected device/simulator.
- `flutter test` — run the widget test suite (`test/widget_test.dart`).
- `flutter test test/widget_test.dart` — run a single test file.
- `flutter analyze` — static analysis.
- `flutter build apk` / `flutter build ios` — platform builds.

Note: `test/widget_test.dart` is the unmodified Flutter template (asserts a counter demo `MyApp` doesn't have) and currently fails against this app's actual `MyApp`. Treat any test failures there as pre-existing until the test itself is rewritten to match the real UI.

## Architecture

- `lib/main.dart` — app entry point; `MyApp` just sets up `MaterialApp` and pushes to `HomePage`.
- `lib/screens/home_screen.dart` — landing page (`HomePage`) with two entry points, navigated via `Hero`-animated routes:
  - "Expresiones regulares" → `ERInputPage` (`er_input_screen.dart`) → `ResultsER` (`er_results.dart`)
  - "Conversiones" → `AutomataInput` (`automata_input.dart`) → `AutomataResults` (`automata_results.dart`)
- `lib/calculadora/` — all non-UI algorithm logic, independent of Flutter widgets:
  - `conversionAutomatas.dart` defines `Automata` (states, alphabet, transitions, initial/final states) and `Transicion`. Key static/instance methods implement the automata pipeline: `thompsonToNFA` (ε-closure based subset construction from a Thompson automaton), `convertirDFA` (subset construction NFA→DFA), `minimizar`/`renombrar`/`eliminarEstadosRepetidos` (state minimization by merging equivalent states), `eliminarEstadoVacio` (removes the dead/trap state), `renombrarChidoLosEstados` (relabels states as `q0, q1, ...`), and `validarCadena` (runs a string through an automaton to test acceptance).
  - `rexpresion.dart` defines `Expresion`, which takes an infix regex, converts it to postfix via a shunting-yard style algorithm (`getPostfix`, with operator precedence in the `precedencia` map), then builds a Thompson automaton by evaluating the postfix expression on a stack of `Automata` fragments combined with `Automata.or`/`and`/`kleen`. The constructor eagerly runs the whole pipeline (Thompson → NFA → DFA → minimized DFA → dead-state-free DFA) so consumers just read `expresion.dfaMinSinVacio`, etc.
- `lib/screens/automata_input.dart` / `er_input_screen.dart` — input forms that build an `Automata` (from a manually entered transition table) or an infix expression string, then navigate to the corresponding results screen, passing the raw input as constructor arguments (the results widgets themselves run the conversion pipeline in their constructor, not in `build()`).
- `lib/screens/automata_results.dart` / `er_results.dart` — near-duplicate results screens (one for hand-built automata, one for regex-derived automata) that render the transition table (`DataTable`) and expose a "validar cadena" dialog to test string acceptance against the final minimized automaton.
- `lib/components/fondo_component.dart` — shared decorative background widgets (`FondoComponent`, `FondoComponent2/3/4`) used across screens; purely presentational, no state.

Data flow is push-based through widget constructors: screens compute their automaton/regex pipeline once (in a `StatefulWidget`'s constructor), not reactively, so results are fixed for the lifetime of that route instance.
