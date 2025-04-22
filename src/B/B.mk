bin/B: src/B/main.hs
	$(GHC) -o $@ $^ $(LDFLAGS)
