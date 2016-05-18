use std::collections::HashMap;

struct StudentsList {
    names: Vec<String>,
}

impl StudentsList {
    fn new() -> StudentsList {
        StudentsList { names: vec![] }
    }

    fn push(&mut self, name: &str) {
        self.names.push(name.to_string());
        self.names.sort()
    }

    fn names(&self) -> &Vec<String> {
        &self.names
    }
}

pub struct School {
    grades: HashMap<u32, StudentsList>,
}

impl School {
    pub fn new() -> School {
        School { grades: HashMap::new() }
    }

    pub fn add(&mut self, grade: u32, name: &str) {
        &(self.grades.entry(grade).or_insert(StudentsList::new())).push(name);
    }

    pub fn grades(&self) -> Vec<u32> {
        let mut grades = self.grades.keys().map(|&k| k).collect::<Vec<u32>>();
        grades.sort();
        grades
    }

    pub fn grade(&self, grade: u32) -> Option<&Vec<String>> {
        match self.grades.get(&grade) {
            Some(v) => Some(v.names()),
            None => None,
        }
    }
}
