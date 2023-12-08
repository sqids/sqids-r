library(sqids)
context("Encoding Unit Tests")

test_that("simple", {
  settings <- sqids_options()

  numbers <- c(1, 2, 3)
  id <- "86Rf07"

  expect_equal(encode(numbers, settings), id)
  expect_equal(decode(id, settings), numbers)
})

test_that("different inputs", {
  settings <- sqids_options()

  numbers <- c(0, 0, 0, 1, 2, 3, 100, 1000, 100000, 1000000, max_value())

  expect_equal(decode(encode(numbers, settings), settings), numbers)
})

test_that("incremental numbers", {
  settings <- sqids_options()

  pairs <- list(
    list(id="bM", numbers=c(0)),
    list(id="Uk", numbers=c(1)),
    list(id="gb", numbers=c(2)),
    list(id="Ef", numbers=c(3)),
    list(id="Vq", numbers=c(4)),
    list(id="uw", numbers=c(5)),
    list(id="OI", numbers=c(6)),
    list(id="AX", numbers=c(7)),
    list(id="p6", numbers=c(8)),
    list(id="nJ", numbers=c(9))
  )

  for (pair in pairs) {
    expect_equal(encode(pair$numbers, settings), pair$id)
    expect_equal(decode(pair$id, settings), pair$numbers)
  }
})

test_that("incremental numbers, same index 0", {
  settings <- sqids_options()

  pairs <- list(
    list(id="SvIz", numbers=c(0, 0)),
    list(id="n3qa", numbers=c(0, 1)),
    list(id="tryF", numbers=c(0, 2)),
    list(id="eg6q", numbers=c(0, 3)),
    list(id="rSCF", numbers=c(0, 4)),
    list(id="sR8x", numbers=c(0, 5)),
    list(id="uY2M", numbers=c(0, 6)),
    list(id="74dI", numbers=c(0, 7)),
    list(id="30WX", numbers=c(0, 8)),
    list(id="moxr", numbers=c(0, 9))
  )

  for (pair in pairs) {
    expect_equal(encode(pair$numbers, settings), pair$id)
    expect_equal(decode(pair$id, settings), pair$numbers)
  }
})

test_that("incremental numbers, same index 1", {
  settings <- sqids_options()

  pairs <- list(
    list(id="SvIz", numbers=c(0, 0)),
    list(id="nWqP", numbers=c(1, 0)),
    list(id="tSyw", numbers=c(2, 0)),
    list(id="eX68", numbers=c(3, 0)),
    list(id="rxCY", numbers=c(4, 0)),
    list(id="sV8a", numbers=c(5, 0)),
    list(id="uf2K", numbers=c(6, 0)),
    list(id="7Cdk", numbers=c(7, 0)),
    list(id="3aWP", numbers=c(8, 0)),
    list(id="m2xn", numbers=c(9, 0))
  )

  for (pair in pairs) {
    expect_equal(encode(pair$numbers, settings), pair$id)
    expect_equal(decode(pair$id, settings), pair$numbers)
  }
})

test_that("multi input", {
  settings <- sqids_options()

  numbers <- c(
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
    26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
    50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73,
    74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
    98, 99
  )

  expect_equal(decode(encode(numbers, settings), settings), numbers)
})

test_that("encoding no numbers", {
  settings <- sqids_options()

  expect_equal(encode(c(), settings), "")
})

test_that("decoding empty string", {
  settings <- sqids_options()

  expect_equal(decode("", settings), NULL)
})

test_that("encoding no numbers", {
  settings <- sqids_options()

  expect_equal(decode(encode(c(), settings), settings), NULL)
})

test_that("encode out-of-range numbers", {
  settings <- sqids_options()
  error_msg <- paste0("Encoding supports numbers between 0 and ", max_value(), ".")

  expect_error(encode(-1, settings), error_msg)
  expect_error(encode(max_value() + 1, settings), error_msg)
})
