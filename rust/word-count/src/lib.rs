extern crate regex;
use regex::Regex;

use std::collections::HashMap;

pub fn word_count(s: &str) -> HashMap<String, u32> {
    let mut word_counter: HashMap<String, u32> = HashMap::new();
    let re = Regex::new(r"([^\w+]|_)").unwrap();

    for word in re.split(&s.to_lowercase()) {
        if word != "" {
            *word_counter.entry(word.to_string()).or_insert(0) += 1;
        }
    }

    word_counter
}
