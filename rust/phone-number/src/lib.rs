use std::fmt;

struct Number {
    country: Option<String>,
    area_code: String,
    num: String,
}

impl Number {
    pub fn parse(num: &str) -> Option<Number> {
        let num = Self::extract_number(num);
        if Self::is_valid(&num.as_str()) {
            let mut country = None;
            let mut offset = 0;

            if num.len() == 11 {
                country = Some(num.chars().take(1).collect::<String>());
                offset = 1;
            }

            Some(Number {
                country: country,
                area_code: num.chars().skip(offset).take(3).collect::<String>(),
                num: num.chars().skip(offset).skip(3).collect::<String>(),
            })
        } else {
            None
        }
    }

    fn is_valid(num: &str) -> bool {
        let size = num.len();

        size == 10 || (num.chars().nth(0).unwrap_or('0') == '1' && size == 11)
    }

    fn extract_number(num: &str) -> String {
        num.chars().filter(|c| c.is_numeric()).collect::<String>()
    }

    pub fn area_code(&self) -> &String {
        &self.area_code
    }

    pub fn pretty_print(&self) -> String {
        format!("({}) {}-{}",
                self.area_code,
                self.num.chars().take(3).collect::<String>(),
                self.num.chars().skip(3).collect::<String>())
    }
}

impl fmt::Display for Number {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}{}", self.area_code, self.num)
    }
}

pub fn number(num: &str) -> Option<String> {
    if let Some(number) = Number::parse(num) {
        Some(number.to_string())
    } else {
        None
    }
}

pub fn area_code(num: &str) -> Option<String> {
    if let Some(number) = Number::parse(num) {
        Some(number.area_code().clone())
    } else {
        None
    }
}

pub fn pretty_print(num: &str) -> String {
    if let Some(number) = Number::parse(num) {
        number.pretty_print()
    } else {
        "invalid".to_string()
    }
}
