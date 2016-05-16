use std::collections::BTreeMap;

pub fn transform(input: &BTreeMap<i32, Vec<String>>) -> BTreeMap<String, i32> {
    input.iter().fold(BTreeMap::new(), |mut acc, (score, letters)| {
        for letter in letters.iter() {
            acc.insert(letter.to_lowercase().to_string(), *score);
        }
        acc
    })
}
