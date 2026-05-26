local function env_or(name, fallback)
    local value = os.getenv(name)
    if value and value ~= "" then
        return value
    end

    return fallback
end

return {
    terminal = env_or("TERMINAL", "kitty"),
    file_manager = env_or("FILE_MANAGER", "yazi"),
    gui_file_manager = "thunar",
    browser = "google-chrome-stable",
    menu = env_or("MENU", "fuzzel"),
}
