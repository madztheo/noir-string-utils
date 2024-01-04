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

If you want to use the String struct to wrap your str, you can import it like this:

```rust
use dep::string_utils::String;
```

And if you want to use the methods directly on the native str type, you can import the String Trait like so:

```rust
use dep::string_utils::StringTrait;
```

## Usage for String struct

You can use the String struct to wrap your str and use the methods on it.

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

### Similarly for hex numbers

```rust
let my_str = "0x123";
let my_string = String::new(my_str);
let my_int = my_string.from_hex_to_uint();
assert(my_int == 291);
```

### Convert a specific slice of a string into a number

```rust
let my_str = "2023/12/19";
let my_string = String::new(my_str);
let my_int = my_string.to_uint_slice(5, 7);
assert(my_int == 12);
```

### Similarly for hex numbers

```rust
let my_str = "0xa1b2c3d4e5f6";
let my_string = String::new(my_str);
let my_int = my_string.from_hex_to_uint_slice(2, 4);
assert(my_int == 161);
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

### Get the index of a substring

```rust
let my_str = "Hello World!";
let my_string = String::new(my_str);
let my_index = my_string.index_of("World");
assert(my_index == 6);
```

### Get the last index of a character

```rust
let my_str = "Hello World!";
let my_string = String::new(my_str);
let my_index = my_string.last_index_of('l');
assert(my_index == 9);
```

### Get the last index of a substring

```rust
let my_str = "Hello World!";
let my_string = String::new(my_str);
let my_index = my_string.last_index_of('rld');
assert(my_index == 8);
```

### Check if a string contains a character

```rust
let my_str = "Hello World!";
let my_string = String::new(my_str);
assert(my_string.contains('W'));
assert(!my_string.contains('a'));
```

### Check if a string is contained in another string

```rust
let my_str = "Hello World!";
let my_string = String::new(my_str);
assert(my_string.contains('Hello'));
assert(!my_string.contains('everybody'));
```

## Usage for StringTrait

By importing StringTrait, you can use the methods directly on a str. No need to wrap it in a String struct.

### Convert a str containing a number to an integer

```rust
let my_str = "123";
let my_int = my_str.to_uint();
assert(my_int == 123);
```

### Similarly for hexadecimal numbers

```rust
let my_str = "0x123";
let my_int = my_str.from_hex_to_uint();
assert(my_int == 291);
```

### Convert a specific slice of a string into a number

```rust
let my_str = "2023/12/19";
let my_int = my_str.to_uint_slice(5, 7);
assert(my_int == 12);
```

### Similarly for hexadecimal numbers

```rust
let my_str = "0xa1b2c3d4e5f6";
let my_int = my_str.from_hex_to_uint_slice(2, 4);
assert(my_int == 161);
```

### Get the character at a specific index

```rust
let my_str = "Hello World!";
let my_char = my_str.char_at(2);
assert(my_char == 'l');
```

### Get the index of a character

```rust
let my_str = "Hello World!";
let my_index = my_str.index_of('W');
assert(my_index == 6);
```

### Get the index of a substring

```rust
let my_str = "Hello World!";
let my_index = my_str.index_of("World");
assert(my_index == 6);
```

### Get the last index of a character

```rust
let my_str = "Hello World!";
let my_index = my_str.last_index_of('l');
assert(my_index == 9);
```

### Get the last index of a substring

```rust
let my_str = "Hello World!";
let my_index = my_str.last_index_of('rld');
assert(my_index == 8);
```

### Check if a string contains a character

```rust
let my_str = "Hello World!";
assert(my_str.contains('W'));
assert(!my_str.contains('a'));
```

### Check if a string is contained in another string

```rust
let my_str = "Hello World!";
assert(my_str.contains('Hello'));
assert(!my_str.contains('everybody'));
```
