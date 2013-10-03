#
# Makefile for parallel merge sorting
# Author: Justin Walrath <walrathjaw@gmail.com>
# Since: 10/2/2013
#

#These are script-wide variables used to easily name the necessary ingredients.
#External applications
CC = gcc
DBG = gdb

#IO
BIN = pMergeSort
OUT_DIR = bin/
OUT_OBJ = obj/
SRC_DIR = src/
INCLUDES = -I include/
DATA_DIR = data/
SOURCE = \
$(SRC_DIR)pMergeSort.c \
$(SRC_DIR)fileIO.c
OBJ = $(OUT_OBJ)*.o

#options for externally linked libraries
DFLAGS = -g
CFLAGS = -lpthread

#This will compile the source code.
build: clean mkd
	@echo "+----------------------------------------------+"
	@echo "| Compiling $(BIN) objects......."
	@echo "+----------------------------------------------+"
	$(CC) $(SOURCE) -c $(INCLUDES)
	@mv *.o $(OUT_OBJ)
	@echo "+----------------------------------------------+"
	@echo "| Linking $(BIN) objects......."
	@echo "+----------------------------------------------+"
	$(CC) -o $(OUT_DIR)$(BIN) $(OBJ) $(CFLAGS)
	@echo "+----------------------------------------------+"
	@echo "| Copying over the test data from the data dir |"
	@echo "+----------------------------------------------+"
	@cp $(DATA_DIR)*.txt $(OUT_DIR)

#This will compile the source code in debug mode. To run: "make test-debug"
#This also doubles as a shortened compile as well
debug:
	@echo "+----------------------------------------------+"	
	@echo "| Compiling $(BIN)......."
	@echo "+----------------------------------------------+"
	$(CC) $(DFLAGS) $(CFLAGS) -o $(BIN).debug $(SOURCE) $(INCLUDES)
	@echo "+----------------------------------------------+"	
	@echo "|   Starting debugger - type quit to exit      |"
	@echo "+----------------------------------------------+"
	$(DBG) $(BIN).debug
	@echo "+----------------------------------------------+"	
	@echo "|          Cleaning debug instance             |"
	@echo "+----------------------------------------------+"
	@rm $(BIN).debug

#This will clean out all the executables and objects. To run: "make clean"
clean:
	@echo "+----------------------------------------------+"
	@echo "| Removing $(BIN) executable"
	@echo "+----------------------------------------------+"
	@rm -rf $(OUT_DIR)
	@make clean-objects

#This will clean out just the objects. To run: "make clean-objects"
clean-objects:
	@echo "+----------------------------------------------+"
	@echo "|              Removing objects                |"
	@echo "+----------------------------------------------+"
	@rm -rf ./obj/

#This verifies that the directories needed are made
mkd:
	@mkdir -p $(OUT_DIR)
	@mkdir -p $(OUT_OBJ)
