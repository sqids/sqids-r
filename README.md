# [Sqids R](https://sqids.org/r)

<!-- badges: start -->
[![R-CMD-check](https://github.com/sqids/sqids-r/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/sqids/sqids-r/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

[Sqids](https://sqids.org/r) (*pronounced "squids"*) is a small library that lets you **generate unique IDs from numbers**. It's good for link shortening, fast & URL-safe ID generation and decoding back into numbers for quicker database lookups.

Features:

-   **Encode multiple numbers** - generate short IDs from one or several non-negative numbers
-   **Quick decoding** - easily decode IDs back into numbers
-   **Unique IDs** - generate unique IDs by shuffling the alphabet once
-   **ID padding** - provide minimum length to make IDs more uniform
-   **URL safe** - auto-generated IDs do not contain common profanity
-   **Randomized output** - Sequential input provides nonconsecutive IDs
-   **Many implementations** - Support for [40+ programming languages](https://sqids.org/)

## 🧰 Use-cases

Good for:

-   Generating IDs for public URLs (eg: link shortening)
-   Generating IDs for internal systems (eg: event tracking)
-   Decoding for quicker database lookups (eg: by primary keys)

Not good for:

-   Sensitive data (this is not an encryption library)
-   User IDs (can be decoded revealing user count)

## 🚀 Getting started

Install Sqids from Github (requires 'devtools'):

``` R
# Install devtools.
install.packages('devtools')

# Install 'sqids' from Github.
devtools::install_github('sqids/sqids-r')
```

## 👩‍💻 Examples

Simple encode & decode:

``` R
settings <- sqids::sqids_options() # Default configuration
id <- sqids::encode(c(1, 2, 3), settings) # "86Rf07"
numbers <- sqids::decode(id, settings) # vector(1, 2, 3)
```

> **Note** 🚧 Because of the algorithm's design, **multiple IDs can decode back into the same sequence of numbers**. If it's important to your design that IDs are canonical, you have to manually re-encode decoded numbers and check that the generated ID matches.

Enforce a *minimum* length for IDs:

``` R
settings <- sqids::sqids_options(min_length=10)
id <- sqids::encode(c(1, 2, 3), settings) # "86Rf07xd4z"
numbers <- sqids::decode(id, settings) # vector(1, 2, 3)
```

Randomize IDs by providing a custom alphabet:

``` R
settings <- sqids::sqids_options(
  alphabet = "FxnXM1kBN6cuhsAvjW3Co7l2RePyY8DwaU04Tzt9fHQrqSVKdpimLGIJOgb5ZE"
)
id <- sqids::encode(c(1, 2, 3), settings) # "B4aajs"
numbers <- sqids::decode(id, settings) # vector(1, 2, 3)
```

Prevent specific words from appearing anywhere in the auto-generated IDs:

``` R
settings <- sqids::sqids_options(
  blocklist = c("86Rf07")
)
id <- sqids::encode(c(1, 2, 3), settings) # "se8ojk"
numbers <- sqids::decode(id, settings) # vector(1, 2, 3)
```

## 📝 License

[MIT](LICENSE)
