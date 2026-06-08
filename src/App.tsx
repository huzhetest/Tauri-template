import { useState } from "react";
import { invoke } from "@tauri-apps/api/core";
import { openUrl } from "@tauri-apps/plugin-opener";
import { ArrowUpRight, CheckCircle2, Monitor, Package, Terminal } from "lucide-react";

const FEATURES = [
  {
    icon: Monitor,
    title: "Tauri v2 Shell",
    description: "Desktop window, icons, capabilities, and Rust entrypoints are ready.",
  },
  {
    icon: Terminal,
    title: "React + Vite",
    description: "Fast frontend development with TypeScript and strict build checks.",
  },
  {
    icon: Package,
    title: "Windows Packaging",
    description: "Portable zip, MSI, NSIS, and GitHub Actions workflows are included.",
  },
];

function App() {
  const [name, setName] = useState("Tauri");
  const [message, setMessage] = useState("");
  const [isLoading, setIsLoading] = useState(false);

  async function greet() {
    setIsLoading(true);
    try {
      const response = await invoke<string>("greet", { name });
      setMessage(response);
    } catch (error) {
      setMessage(error instanceof Error ? error.message : String(error));
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <main className="app-shell">
      <section className="hero-panel" aria-labelledby="app-title">
        <div className="hero-copy">
          <span className="eyebrow">
            <CheckCircle2 size={16} aria-hidden="true" />
            Ready for desktop development
          </span>
          <h1 id="app-title">Tauri-template</h1>
          <p>
            A clean React, TypeScript, Vite, and Tauri v2 starter extracted from a
            working desktop app.
          </p>
        </div>

        <div className="command-panel" aria-label="Tauri command test">
          <label htmlFor="name">Command input</label>
          <div className="command-row">
            <input
              id="name"
              value={name}
              onChange={(event) => setName(event.target.value)}
              placeholder="Your name"
            />
            <button type="button" onClick={greet} disabled={isLoading}>
              {isLoading ? "Running" : "Run"}
            </button>
          </div>
          <output>{message || "Invoke the Rust greet command to test the bridge."}</output>
        </div>
      </section>

      <section className="feature-grid" aria-label="Template features">
        {FEATURES.map((feature) => (
          <article className="feature-card" key={feature.title}>
            <feature.icon size={22} aria-hidden="true" />
            <h2>{feature.title}</h2>
            <p>{feature.description}</p>
          </article>
        ))}
      </section>

      <footer>
        <button type="button" className="link-button" onClick={() => openUrl("https://tauri.app")}>
          Tauri docs
          <ArrowUpRight size={16} aria-hidden="true" />
        </button>
      </footer>
    </main>
  );
}

export default App;
