pub mod Roman {
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

    pub fn from(num: usize) -> String {
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
}
