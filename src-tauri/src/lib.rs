#[tauri::command]
fn greet(name: String) -> String {
    let trimmed = name.trim();
    let display_name = if trimmed.is_empty() { "there" } else { trimmed };
    format!("Hello, {display_name}! Your Tauri command is wired up.")
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![greet])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
