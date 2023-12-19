# Noir String Utils

## Description

A wrapper for String in Noir that adds some useful methods for common string operations.

## Installation

In your Nargo.toml file, add the following dependency:

```
[dependencies]
string_utils = { tag = "main", git = "https://github.com/madztheo/noir-string-utils.git" }
```

### Import the library

Add this line to the top of your Noir file:

```rust
use dep::string_utils::String;
```

## Usage

### Initialize a String

```rust
let my_string = String::new("Hello World!");
assert(my_string.value == "Hello World!");
assert(my_string.len == 12);
```

### Convert a number in form of a string to an integer

```rust
let my_str = "123";
let my_string = String::new(my_str);
let my_int = my_string.to_uint();
assert(my_int == 123);
```

### Convert a specific slice of a string into a number

```rust
let my_str = "2023/12/19";
let my_string = String::new(my_str);
let my_int = my_string.to_uint_slice(5, 7);
assert(my_int == 12);
```

### Get the character at a specific index

```rust
let my_str = "Hello World!";
let my_string = String::new(my_str);
let my_char = my_string.char_at(2);
assert(my_char == 'l');
```

### Get the index of a character

```rust
let my_str = "Hello World!";
let my_string = String::new(my_str);
let my_index = my_string.index_of('W');
assert(my_index == 6);
```

### Get the last index of a character

```rust
let my_str = "Hello World!";
let my_string = String::new(my_str);
let my_index = my_string.last_index_of('l');
assert(my_index == 9);
```

### Check if a string contains a character

```rust
let my_str = "Hello World!";
let my_string = String::new(my_str);
assert(my_string.contains('W'));
assert(!my_string.contains('a'));
```
