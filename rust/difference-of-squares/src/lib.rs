pub fn square_of_sum(num: i64) -> i64 {
    (1..num + 1).fold(0, |acc, v| acc + v).pow(2)
}

pub fn sum_of_squares(num: i64) -> i64 {
    (1..num + 1).fold(0, |acc, v| acc + v.pow(2))
}

pub fn difference(num: i64) -> i64 {
    (sum_of_squares(num) - square_of_sum(num)).abs()
}
