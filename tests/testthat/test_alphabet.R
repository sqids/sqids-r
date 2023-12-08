library(sqids)
context("Alphabet Unit Tests")

test_that("simple", {
  settings <- sqids_options(
    alphabet = "0123456789abcdef"
  )

  numbers <- c(1, 2, 3)
  id <- "489158"

  expect_equal(encode(numbers, settings), id)
  expect_equal(decode(id, settings), numbers)
})

test_that("short alphabet", {
  settings <- sqids_options(
    alphabet = "abc"
  )

  numbers <- c(1, 2, 3)
  expect_equal(decode(encode(numbers, settings), settings), numbers)
})

test_that("long alphabet", {
  settings <- sqids_options(
    alphabet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_+|{}[];:\'"/?.>,<`~'
  )

  numbers <- c(1, 2, 3)
  expect_equal(decode(encode(numbers, settings), settings), numbers)
})

test_that("multibyte characters", {
  expect_error(sqids_options(alphabet = "ë1092"), "Alphabet cannot contain multibyte characters.")
})

test_that("repeating alphabet characters", {
  expect_error(sqids_options(alphabet = "aabcdefg"), "Alphabet must contain unique characters.")
})

test_that("too short of an alphabet", {
  expect_error(sqids_options(alphabet = "ab"), "Alphabet lenght must be at least 3.")
})
