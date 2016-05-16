const PRIME_FACTORS: [i32; 3] = [3, 5, 7];

fn number_to_rainspeak(n: &i32) -> &'static str {
    match *n {
        3 => "Pling",
        5 => "Plang",
        7 => "Plong",
        _ => "",
    }
}

pub fn raindrops(number: i32) -> String {
    let result = PRIME_FACTORS.iter()
        .filter(|&n| number % n == 0)
        .map(number_to_rainspeak)
        .collect::<String>();

    if result.is_empty() {
        format!("{}", number)
    } else {
        result
    }
}
