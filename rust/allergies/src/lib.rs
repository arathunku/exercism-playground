#[derive(Clone, Debug, PartialEq)]
pub enum Allergen {
    Cats,
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
}

const ALLERGENS: [Allergen; 8] = [Allergen::Eggs,
                                  Allergen::Peanuts,
                                  Allergen::Shellfish,
                                  Allergen::Strawberries,
                                  Allergen::Tomatoes,
                                  Allergen::Chocolate,
                                  Allergen::Pollen,
                                  Allergen::Cats];

pub struct Allergies {
    allergies: Vec<Allergen>,
}

impl Allergies {
    pub fn new(flags: u16) -> Allergies {
        let mut flags = flags;
        let mut allergies = vec![];

        for allergy in ALLERGENS.iter() {
            if flags != 0 {
                if 0 != (flags & 1) {
                    allergies.push(allergy.clone());
                }
                flags = flags >> 1;

            }
        }

        Allergies { allergies: allergies }
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        self.allergies.clone()
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        self.allergies().contains(allergen)
    }
}
