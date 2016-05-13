static ERROR_DIFFERENT_LENGTH: &'static str = "inputs of different length";

pub fn hamming_distance(strand1: &str, strand2: &str) -> Result<usize, &'static str> {
    if strand1.len() != strand2.len() {
        return Result::Err(ERROR_DIFFERENT_LENGTH);
    }

    let count = strand1.chars()
                       .zip(strand2.chars())
                       .fold(0, |count, (a, b)| {
                           if a != b {
                               count + 1
                           } else {
                               count
                           }
                       });

    Ok(count)
}
