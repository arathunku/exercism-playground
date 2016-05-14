use std::collections::HashMap;

fn default_nucleotide_counts() -> HashMap<char, usize> {
    let mut result: HashMap<char, usize> = HashMap::new();

    for nucleotide in ['A', 'T', 'C', 'G'].iter() {
        result.insert(*nucleotide, 0);
    }

    result
}

pub fn nucleotide_counts(dna: &str) -> HashMap<char, usize> {
    let mut result: HashMap<char, usize> = default_nucleotide_counts();

    for c in dna.chars() {
        *result.entry(c).or_insert(0) += 1;
    }

    result
}

pub fn count(predicate: char, dna: &str) -> usize {
    nucleotide_counts(dna).get(&predicate).unwrap().clone()
}
