library(mirai)
library(nanonext)
daemons(
  n = 1L,
  url = "ws://127.0.0.1:0",
  dispatcher = "process",
  seed = NULL,
  token = TRUE,
  retry = TRUE
)
cv <- cv()
nextget("cv") %~>% cv
n <- 3L
for (index in seq_len(n)) {
  launch_local(url = rownames(status()$daemons), maxtasks = 1)
  task <- mirai(TRUE)
  call_mirai_(task)
  stopifnot(isFALSE(unresolved(task)))
  stopifnot(isTRUE(task$data))
  saisei(i = 1L, force = FALSE)
}
daemons(n = 0L)
msleep(2000)
stopifnot(cv_value(cv) == 3L)
mclock()
cv_value(cv())
