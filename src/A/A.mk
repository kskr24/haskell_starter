bin/A: src/A/main.hs
	$(GHC) -o $@ $^ $(LDFLAGS)
