pub fn hello(name: Option<&str>) -> String {
    let name = if let Some(v) = name {
        v
    } else {
        "World"
    };

    format!("Hello, {}!", name)
}
