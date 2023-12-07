library(sqids)
context("Min. Length Unit Tests")

test_that("simple", {
  settings <- sqids_options(min_length=nchar(DEFAULT_ALPHABET))

  numbers <- c(1, 2, 3)
  id <- "86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTM"

  expect_equal(encode(numbers, settings), id)
  expect_equal(decode(id, settings), numbers)
})

test_that("incremental", {
  numbers <- c(1, 2, 3)
  pairs <- list(
    list(min_length=6, id="86Rf07"),
    list(min_length=7, id="86Rf07x"),
    list(min_length=8, id="86Rf07xd"),
    list(min_length=9, id="86Rf07xd4"),
    list(min_length=10, id="86Rf07xd4z"),
    list(min_length=11, id="86Rf07xd4zB"),
    list(min_length=12, id="86Rf07xd4zBm"),
    list(min_length=13, id="86Rf07xd4zBmi"),
    list(min_length=nchar(DEFAULT_ALPHABET) + 0, id="86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTM"),
    list(min_length=nchar(DEFAULT_ALPHABET) + 1, id="86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMy"),
    list(min_length=nchar(DEFAULT_ALPHABET) + 2, id="86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMyf"),
    list(min_length=nchar(DEFAULT_ALPHABET) + 3, id="86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMyf1")
  )

  for (pair in pairs) {
    settings <- sqids_options(min_length=pair$min_length)

    expect_equal(encode(numbers, settings), pair$id)
    expect_equal(nchar(encode(numbers, settings)), pair$min_length)
    expect_equal(decode(pair$id, settings), numbers)
  }
})

test_that("incremental numbers", {
  settings <- sqids_options(min_length=nchar(DEFAULT_ALPHABET))

  pairs <- list(
    list(id="SvIzsqYMyQwI3GWgJAe17URxX8V924Co0DaTZLtFjHriEn5bPhcSkfmvOslpBu", numbers=c(0, 0)),
    list(id="n3qafPOLKdfHpuNw3M61r95svbeJGk7aAEgYn4WlSjXURmF8IDqZBy0CT2VxQc", numbers=c(0, 1)),
    list(id="tryFJbWcFMiYPg8sASm51uIV93GXTnvRzyfLleh06CpodJD42B7OraKtkQNxUZ", numbers=c(0, 2)),
    list(id="eg6ql0A3XmvPoCzMlB6DraNGcWSIy5VR8iYup2Qk4tjZFKe1hbwfgHdUTsnLqE", numbers=c(0, 3)),
    list(id="rSCFlp0rB2inEljaRdxKt7FkIbODSf8wYgTsZM1HL9JzN35cyoqueUvVWCm4hX", numbers=c(0, 4)),
    list(id="sR8xjC8WQkOwo74PnglH1YFdTI0eaf56RGVSitzbjuZ3shNUXBrqLxEJyAmKv2", numbers=c(0, 5)),
    list(id="uY2MYFqCLpgx5XQcjdtZK286AwWV7IBGEfuS9yTmbJvkzoUPeYRHr4iDs3naN0", numbers=c(0, 6)),
    list(id="74dID7X28VLQhBlnGmjZrec5wTA1fqpWtK4YkaoEIM9SRNiC3gUJH0OFvsPDdy", numbers=c(0, 7)),
    list(id="30WXpesPhgKiEI5RHTY7xbB1GnytJvXOl2p0AcUjdF6waZDo9Qk8VLzMuWrqCS", numbers=c(0, 8)),
    list(id="moxr3HqLAK0GsTND6jowfZz3SUx7cQ8aC54Pl1RbIvFXmEJuBMYVeW9yrdOtin", numbers=c(0, 9))
  )

  for (pair in pairs) {
    expect_equal(encode(pair$numbers, settings), pair$id)
    expect_equal(decode(pair$id, settings), pair$numbers)
  }
})

test_that("min lengths", {
  numbers <- list(
    c(0),
    c(0, 0, 0, 0, 0),
    c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10),
    c(100, 200, 300),
    c(1000, 2000, 3000),
    c(1000000),
    c(max_value())
  )

  min_lengths <- c(0, 1, 5, 10, DEFAULT_MIN_LENGTH)
  for (min in min_lengths) {
    for (set in numbers) {
      settings <- sqids_options(min_length=min)
      id <- encode(set, settings)

      expect_gte(nchar(id), min)
      expect_equal(decode(id, settings), set)
    }
  }
})

test_that("out-of-range invalid min length", {
  min_length_limit <- 255
  min_length_error <- paste0("Minimum length must be between 0 and ", min_length_limit, ".")

  expect_error(sqids_options(min_length=-1), min_length_error)
  expect_error(sqids_options(min_length=min_length_limit + 1), min_length_error)
})
