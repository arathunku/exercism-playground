mod response {
    pub static SILENCE: &'static str = "Fine. Be that way!";
    pub static SHOUT: &'static str = "Whoa, chill out!";
    pub static QUESTION: &'static str = "Sure.";
    pub static WHATEVER: &'static str = "Whatever.";
}

pub fn reply(v: &str) -> &'static str {
    let input = v.trim();

    if input.to_uppercase() == input && input.to_lowercase() != input {
        response::SHOUT
    } else if input == "" {
        response::SILENCE
    } else if input.chars().last().unwrap() == '?' {
        response::QUESTION
    } else {
        response::WHATEVER
    }
}
