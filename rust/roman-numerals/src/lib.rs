use std::fmt;

const DECODER: [(usize, &'static str); 13] = [(1000, "M"),
                                              (900, "CM"),
                                              (500, "D"),
                                              (400, "CD"),
                                              (100, "C"),
                                              (90, "XC"),
                                              (50, "L"),
                                              (40, "XL"),
                                              (10, "X"),
                                              (9, "IX"),
                                              (5, "V"),
                                              (4, "IV"),
                                              (1, "I")];

fn from(num: usize) -> String {
    let mut i = 0;
    let mut result = String::new();
    let mut current_number = num;

    while i < DECODER.len() {
        let (number, symbol) = DECODER[i];

        if current_number >= number {
            result.push_str(symbol);
            current_number -= number;
        } else {
            i += 1;
        }
    }

    result
}

pub struct Roman {
    value: String,
}

impl Roman {
    pub fn new(num: String) -> Self {
        Roman { value: num }
    }
}

impl From<usize> for Roman {
    fn from(num: usize) -> Self {
        Roman::new(from(num))
    }
}

impl fmt::Display for Roman {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}", self.value)
    }
}
