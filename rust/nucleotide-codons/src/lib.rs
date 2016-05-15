use std::collections::HashMap;

#[derive(Debug)]
pub struct Codon {
    codons: HashMap<String, String>,
}

fn decode_char(c: char) -> char {
    match c {
        'A' | 'W' | 'M' | 'R' | 'D' | 'H' | 'V' | 'N' => 'A',
        'C' | 'S' | 'Y' | 'B' => 'C',
        'G' | 'K' => 'G',
        'T' => 'T',
        _ => ' ',
    }
}

impl Codon {
    pub fn name_for(&self, codon: &str) -> Result<&str, &'static str> {
        if codon.len() != 3 {
            return Err("Invalid length");
        }

        let code = codon.chars()
            .map(decode_char)
            .collect::<String>();

        if code.chars().any(|c| c == ' ') {
            return Err("Some invalid chars.");
        }

        match self.codons.get(&code) {
            Some(ref v) => Ok(v),
            None => Err("ok"),
        }
    }
}

pub fn parse(pairs: Vec<(&'static str, &'static str)>) -> Codon {
    let mut codons: HashMap<String, String> = HashMap::with_capacity(pairs.len());

    for (codon, name) in pairs.into_iter() {
        codons.insert(codon.to_string(), name.to_string());
    }

    Codon { codons: codons }
}
