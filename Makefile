# WARNING: This makefile wasn't created to be used on Windows, use the Make.bat instead

PROJ_NAME = SampleProject
CXXFLAGS  = -Wextra -Ofast -std=c++11
LIB       = -lsfml-audio -lsfml-graphics -lsfml-network -lsfml-window -lsfml-system
IDIR      = -I./include/ -L./usr/local/include
LDIR      = -L./usr/local/lib

# Automatic variables
GAME = ./bin/$(shell echo $(PROJ_NAME) | tr A-Z a-z)
OBJ  = $(patsubst src/%, obj/%, $(patsubst %.cpp, %.o, $(wildcard src/**.cpp)))

# System Detection
UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
	OS=LinuxOS
else
	ifeq ($(UNAME), Darwin)
		OS=MacOS
	else
		OS=OtherOS
	endif
endif

$(shell mkdir obj &> /dev/null || true)
$(shell mkdir bin &> /dev/null || true)

default: link

link: $(OBJ)
	$(CXX) $(CXXFLAGS) -D$(OS) $(LDIR) $(OBJ) $(LIB) -o $(GAME)
	@chmod +x $(GAME)

./obj/%.o:
	$(CXX) $(CXXFLAGS) -D$(OS) $(IDIR) -c $(patsubst obj/%, ./src/%, $(patsubst %.o, %.cpp, $@)) -o ./$@

test:
	$(GAME)

clean:
	rm -rf ./obj/
	rm -rf ./bin
	rm -rf ./include
	rm -rf ./lib/32
	rm -rf ./lib/64
	rm -rf ./tmp
	
clobber:
	rm -f ./obj/*.o
	rm -f $(GAME)
