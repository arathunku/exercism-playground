pub fn anagrams_for<'a>(word: &str, inputs: &[&'a str]) -> Vec<&'a str> {
    let prepared_word = prepare_str(word);

    inputs.iter()
          .cloned()
          .map(|v| {
              println!("Compare: {}, with: {}", v, word);
              v
          })
          .filter(|v| v.to_string().to_lowercase() != word.to_string().to_lowercase())
          .filter(|v| prepare_str(v) == prepared_word)
          .collect::<Vec<&'a str>>()
}


fn prepare_str(v: &str) -> String {
    let mut word = v.to_string()
                    .to_lowercase()
                    .chars()
                    .collect::<Vec<char>>();

    word.sort();

    word.iter()
        .cloned()
        .collect::<String>()
}


#[cfg(test)]
mod tests {
    use super::prepare_str;

    #[test]
    fn sorts_and_lowercases() {
        assert_eq!("abc".to_string(), prepare_str("acB"))
    }
}
