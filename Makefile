ALL   = plu
FLAGS = -framework Foundation

.PHONY: all clean

all: $(ALL)

plu: src/main.m
	$(CC) -o $@ $^ $(FLAGS)

clean:
	$(RM) $(ALL)
