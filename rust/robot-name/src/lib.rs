extern crate rand;

use rand::distributions::{Range, IndependentSample};
use rand::Rng;

pub struct Robot {
    name: String,
}

impl Robot {
    pub fn new() -> Robot {
        Robot { name: random_name() }
    }

    pub fn name<'a>(&'a self) -> &'a str {
        &self.name
    }

    pub fn reset_name(&mut self) {
        self.name = random_name();
    }
}

fn random_letter<R: Rng>(rng: &mut R) -> char {
    let range = Range::<u8>::new('A' as u8, 'Z' as u8 + 1);

    range.ind_sample(rng) as char
}

fn random_number<R: Rng>(rng: &mut R) -> i8 {
    let range = Range::<i8>::new(1, 10);

    range.ind_sample(rng)
}

fn random_name() -> String {
    let mut rng = rand::thread_rng();

    format!("{}{}{}{}{}",
            random_letter(&mut rng),
            random_letter(&mut rng),
            random_number(&mut rng),
            random_number(&mut rng),
            random_number(&mut rng))
}
