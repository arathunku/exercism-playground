use std::ops::Rem;

pub fn is_leap_year(year: u32) -> bool {
    year.rem(4) == 0 && year.rem(100) != 0 || year.rem(400) == 0
}
