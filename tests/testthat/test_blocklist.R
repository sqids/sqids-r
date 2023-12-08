library(sqids)
context("Blocklist Unit Tests")

test_that("if no custom blocklist param, use the default blocklist", {
  settings <- sqids_options()

  expect_equal(decode("aho1e", settings), c(4572721))
})

test_that("if an empty blocklist param passed, don't use any blocklist", {
  settings <- sqids_options(
    blocklist = c()
  )

  expect_equal(decode("aho1e", settings), c(4572721))
  expect_equal(encode(c(4572721), settings), "aho1e")
})

test_that("if a non-empty blocklist param passed, use only that", {
  settings <- sqids_options(
    blocklist = c(
      "ArUO"  # Originally encoded [100000]
    )
  )

  # Make sure we don't use the default blocklist.
  expect_equal(decode("aho1e", settings), c(4572721))
  expect_equal(encode(c(4572721), settings), "aho1e")

  # Make sure we are using the passed blocklist.
  expect_equal(decode("ArUO", settings), c(100000))
  expect_equal(encode(c(100000), settings), "QyG4")
  expect_equal(decode("QyG4", settings), c(100000))
})

test_that("blocklist", {
  settings <- sqids_options(
    blocklist = c("86Rf07", "se8ojk", "ARsz1p", "Q8AI49", "5sQRZO")
  )

  expect_equal(decode("86Rf07", settings), c(1, 2, 3))
  expect_equal(decode("se8ojk", settings), c(1, 2, 3))
  expect_equal(decode("ARsz1p", settings), c(1, 2, 3))
  expect_equal(decode("Q8AI49", settings), c(1, 2, 3))
  expect_equal(decode("5sQRZO", settings), c(1, 2, 3))
})

test_that("match against a short blocklist word", {
  settings <- sqids_options(
    blocklist = c("pnd")
  )

  expect_equal(decode(encode(c(1000), settings), settings), c(1000))
})

test_that("blocklist filtering in constructor", {
  settings <- sqids_options(
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
    blocklist = c("sxnzkl")    # lowercase blocklist in uppercase alphabet.
  )

  id <- encode(c(1, 2, 3), settings)
  numbers <- decode(id, settings)

  expect_equal(id, "IBSHOZ")
  expect_equal(numbers, c(1, 2, 3))
})

test_that("max encoding attempts", {
  settings <- sqids_options(
    alphabet = "abc",
    min_length = 3,
    blocklist = c("cab", "abc", "bca")
  )

  expect_equal(nchar(settings$alphabet), settings$min_length)
  expect_equal(length(settings$blocklist), settings$min_length)

  expect_error(encode(c(0), settings), "Reached max attempts to re-generate the ID.")
})
