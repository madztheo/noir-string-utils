use dep::std::println;

global UPPERCASE_A_INDEX: u8 = 65;
global UPPERCASE_Z_INDEX: u8 = 90;
global LOWERCASE_A_INDEX: u8 = 97;
global LOWERCASE_Z_INDEX: u8 = 122;
global ZERO_INDEX: u8 = 48;
global NINE_INDEX: u8 = 57;
global ASCII_TABLE_START_INDEX: u8 = 33;
global SORTED_ASCII_TABLE: [str<1>; 94] = ["!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",",
    "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", "<", "=", ">",
    "?", "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
    "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "\\", "]", "^", "_", "`", "a",
    "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
    "t", "u", "v", "w", "x", "y", "z", "{", "|", "}", "~"
];

struct String<N> {
    value: str<N>,
    len: u64,
}

impl<N> String<N> {
    fn new(value: str<N>) -> Self {
        Self { value, len: N }
    }
    
    fn code_at(self: Self, index: u64) -> u8 {
        assert(index < self.len);
        self.value.as_bytes()[index]
    }

    fn char_at(self: Self, index: u64) -> str<1> {
        let byte = self.code_at(index);
        let ascii_index = byte - ASCII_TABLE_START_INDEX;
        SORTED_ASCII_TABLE[ascii_index]
    }

    fn index_of(self: Self, c: str<1>) -> i127 {
        let byte = c.as_bytes()[0];
        let str_bytes = self.value.as_bytes();
        let mut index = -1 as i127;
        for i in 0..self.len {
            if (index == -1) & (str_bytes[i] == byte) {
                index = i as i127;
            }
        }
        index
    }

    fn last_index_of(self: Self, c: str<1>) -> i127 {
        let byte = c.as_bytes()[0];
        let str_bytes = self.value.as_bytes();
        let mut index = -1 as i127;
        for i in 0..self.len {
            if str_bytes[i] == byte {
                index = i as i127;
            }
        }
        index
    }

    fn indexes_of(self: Self, c: str<1>) -> Vec<u64> {
        let byte = c.as_bytes()[0];
        let str_bytes = self.value.as_bytes();
        let mut indexes: Vec<u64> = Vec::new();
        for i in 0..self.len {
            if str_bytes[i] == byte {
                indexes.push(i);
            }
        }
        indexes
    }

    fn contains(self: Self, c: str<1>) -> bool {
        self.index_of(c) != -1
    }

    fn occurrences_of(self: Self, c: str<1>) -> u64 {
        let byte = c.as_bytes()[0];
        let str_bytes = self.value.as_bytes();
        let mut count = 0;
        for i in 0..self.len {
            if str_bytes[i] == byte {
                count += 1;
            }
        }
        count
    }

    fn digit_at(self: Self, index: u64) -> u8 {
        let byte = self.value.as_bytes()[index];
        assert((byte >= ZERO_INDEX) & (byte <= NINE_INDEX));
        byte - ZERO_INDEX
    }

    fn hex_digit_at(self: Self, index: u64) -> u8 {
        let byte = self.value.as_bytes()[index];
        if (byte >= ZERO_INDEX) & (byte <= NINE_INDEX) {
            byte - ZERO_INDEX
        } else if (byte >= UPPERCASE_A_INDEX) & (byte <= UPPERCASE_Z_INDEX) {
            byte - UPPERCASE_A_INDEX + 10
        } else if (byte >= LOWERCASE_A_INDEX) & (byte <= LOWERCASE_Z_INDEX) {
            byte - LOWERCASE_A_INDEX + 10
        } else{
            assert(false);
            0
        }
    }

    fn to_uint_slice(self: Self, start: u64, end: u64) -> u64 {
        let mut result = 0;
        for i in start..end {
            let digit = self.digit_at(i);
            result = result * 10 + digit as u64;
        }
        result
    }

    fn to_uint(self: Self) -> u64 {
        self.to_uint_slice(0, self.len)
    }

    // Note: this function bugs with i127 for some reason
    fn to_int(self: Self) -> i126 {
        if self.char_at(0) == "-" {
            -1 * self.to_uint_slice(1, self.len) as i126
        } else {
            self.to_uint_slice(0, self.len) as i126
        }
    }

    fn from_hex_to_uint_slice(self: Self, start: u64, end: u64) -> u64 {
        let mut result = 0;
        for i in start..end {
            let digit = self.hex_digit_at(i);
            result = result * 16 + digit as u64;
        }
        result
    }

    fn from_hex_to_uint(self: Self, with_prefix: bool) -> u64 {
        if with_prefix {
            self.from_hex_to_uint_slice(2, self.len)
        } else {
            self.from_hex_to_uint_slice(0, self.len)
        }
    }

    fn to_array_of_chars(self: Self) -> [str<1>; N] {
        let mut result: [str<1>; N] = [" "; N];
        for i in 0..self.len {
            result[i] = self.char_at(i);
        }
        result
    }
}

#[test]
fn test_init() {
    let s = String::new("hello");
    assert(s.len == 5);
    assert(s.value == "hello");
}

#[test]
fn test_char_at() {
    let s = String::new("hello");
    assert(s.char_at(0) == "h");
    assert(s.char_at(1) == "e");
    assert(s.char_at(2) == "l");
    assert(s.char_at(3) == "l");
    assert(s.char_at(4) == "o");
}

#[test]
fn test_code_at() {
    let s = String::new("hello");
    assert(s.code_at(0) == 104);
    assert(s.code_at(1) == 101);
    assert(s.code_at(2) == 108);
    assert(s.code_at(3) == 108);
    assert(s.code_at(4) == 111);
}

#[test]
fn test_index_of() {
    let s = String::new("hello");
    assert(s.index_of("h") == 0);
    assert(s.index_of("e") == 1);
    assert(s.index_of("l") == 2);
    assert(s.index_of("o") == 4);
    assert(s.index_of("a") == -1);
}

#[test]
fn test_last_index_of() {
    let s = String::new("hello");
    assert(s.last_index_of("h") == 0);
    assert(s.last_index_of("e") == 1);
    assert(s.last_index_of("l") == 3);
    assert(s.last_index_of("o") == 4);
    assert(s.last_index_of("a") == -1);
}

#[test]
fn test_indexes_of() {
    let s = String::new("hello");
    assert(s.indexes_of("h").get(0) == 0);
    assert(s.indexes_of("e").get(0) == 1);
    assert(s.indexes_of("l").get(0) == 2);
    assert(s.indexes_of("l").get(1) == 3);
    assert(s.indexes_of("o").get(0) == 4);
    assert(s.indexes_of("a").len() == 0);
}

#[test]
fn test_contains() {
    let s = String::new("hello");
    assert(s.contains("h"));
    assert(s.contains("e"));
    assert(s.contains("l"));
    assert(s.contains("o"));
    assert(!s.contains("a"));
}

#[test]
fn test_occurrences_of() {
    let s = String::new("hello");
    assert(s.occurrences_of("h") == 1);
    assert(s.occurrences_of("e") == 1);
    assert(s.occurrences_of("l") == 2);
    assert(s.occurrences_of("o") == 1);
    assert(s.occurrences_of("a") == 0);
}

#[test]
fn test_digit_at() {
    let s = String::new("20231219");
    assert(s.digit_at(0) == 2);
    assert(s.digit_at(1) == 0);
    assert(s.digit_at(2) == 2);
    assert(s.digit_at(3) == 3);
    assert(s.digit_at(4) == 1);
    assert(s.digit_at(5) == 2);
    assert(s.digit_at(6) == 1);
    assert(s.digit_at(7) == 9);
}

#[test]
fn test_hex_digit_at() {
    let s = String::new("0x1324ABCDEF");
    assert(s.hex_digit_at(2) == 1);
    assert(s.hex_digit_at(3) == 3);
    assert(s.hex_digit_at(4) == 2);
    assert(s.hex_digit_at(5) == 4);
    assert(s.hex_digit_at(6) == 10);
    assert(s.hex_digit_at(7) == 11);
    assert(s.hex_digit_at(8) == 12);
    assert(s.hex_digit_at(9) == 13);
    assert(s.hex_digit_at(10) == 14);
    assert(s.hex_digit_at(11) == 15);
}

#[test]
fn test_to_uint() {
    let s = String::new("20231219");
    assert(s.to_uint() == 20231219);
}

#[test]
fn test_to_int() {
    let s = String::new("-25");
    assert(s.to_int() == -25);

    let s = String::new("25");
    assert(s.to_int() == 25);
}

#[test]
fn test_to_uint_slice() {
    let s = String::new("2023/12/19");
    assert(s.to_uint_slice(0, 4) == 2023);
    assert(s.to_uint_slice(5, 7) == 12);
    assert(s.to_uint_slice(8, 10) == 19);
}

#[test]
fn test_from_hex_to_uint_slice() {
    let s = String::new("0x1324ABCDEF");
    assert(s.from_hex_to_uint_slice(2, 6) == 0x1324);
    assert(s.from_hex_to_uint_slice(6, 9) == 0xABC);
    assert(s.from_hex_to_uint_slice(9, 12) == 0xDEF);
}

#[test]
fn test_from_hex_to_uint() {
    let uppercase_hex = String::new("0x1324ABCDEF");
    assert(uppercase_hex.from_hex_to_uint(true) == 0x1324ABCDEF);

    let lowercase_hex = String::new("0x1234abcdef");
    assert(lowercase_hex.from_hex_to_uint(true) == 0x1234ABCDEF);

    let hex_without_prefix = String::new("1234abcdef");
    assert(hex_without_prefix.from_hex_to_uint(false) == 0x1234ABCDEF);

    let hex_with_leading_zeros = String::new("0x000001");
    assert(hex_with_leading_zeros.from_hex_to_uint(true) == 1);
}

#[test]
fn test_to_array_of_chars() {
    let s = String::new("hello");
    let arr = s.to_array_of_chars();
    assert(arr[0] == "h");
    assert(arr[1] == "e");
    assert(arr[2] == "l");
    assert(arr[3] == "l");
    assert(arr[4] == "o");
}
