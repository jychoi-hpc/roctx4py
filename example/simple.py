import roctx4py as rx

for _ in range(10):
    rx.start("count")
    for i in range(1000):
        pass
    rx.stop("count")
