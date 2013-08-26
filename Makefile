all: srv.exe cli.exe

srv.exe: srv.hs
	ghc -Wall -O9 srv.hs

cli.exe: cli.hs
	ghc -Wall -O9 cli.hs

clean:
	rm -f cli.o cli.hi cli.exe cli srv.o srv.hi srv.exe srv
