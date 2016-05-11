extern crate chrono;
use chrono::*;

pub fn after(date: DateTime<UTC>) -> DateTime<UTC> {
    date + Duration::seconds(10i64.pow(9))
}
