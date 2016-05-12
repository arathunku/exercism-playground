pub fn anagrams_for<'a>(base_word: &str, inputs: &[&'a str]) -> Vec<&'a str> {
    let word = lowercase_sort_transform(base_word);

    inputs.iter()
          .filter(|v| v.to_lowercase() != base_word.to_lowercase())
          .filter(|v| lowercase_sort_transform(v) == word)
          .cloned()
          .collect::<Vec<&'a str>>()
}


fn lowercase_sort_transform(v: &str) -> String {
    let mut word = v.to_lowercase()
                    .chars()
                    .collect::<Vec<char>>();

    word.sort();

    word.into_iter()
        .collect::<String>()
}


#[cfg(test)]
mod tests {
    use super::lowercase_sort_transform;

    #[test]
    fn sorts_and_lowercases() {
        assert_eq!("abc".to_string(), lowercase_sort_transform("acB"))
    }
}
