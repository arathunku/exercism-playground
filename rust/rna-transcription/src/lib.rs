#[derive(Debug, PartialEq)]
pub struct RibonucleicAcid {
    acid: String,
}

impl RibonucleicAcid {
    pub fn new<S>(v: S) -> RibonucleicAcid
        where S: Into<String>
    {
        RibonucleicAcid { acid: v.into() }
    }
}

#[derive(Debug, PartialEq)]
pub struct DeoxyribonucleicAcid {
    acid: String,
}

impl DeoxyribonucleicAcid {
    pub fn new(v: &str) -> DeoxyribonucleicAcid {
        DeoxyribonucleicAcid { acid: v.to_string() }
    }

    pub fn to_rna(&self) -> RibonucleicAcid {
        RibonucleicAcid::new(self.acid
                                 .chars()
                                 .map(|c| nucleotide_complement_transform(c))
                                 .collect::<String>())
    }
}

fn nucleotide_complement_transform(nucleotide: char) -> char {
    match nucleotide {
        'G' => 'C',
        'C' => 'G',
        'T' => 'A',
        'A' => 'U',
        _ => nucleotide,
    }
}
