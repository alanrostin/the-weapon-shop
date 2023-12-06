# Compiler and linker flags
CC 			:= g++
SRC_DIR 	:= src
BIN_DIR 	:= bin
BIN_EXE 	:= $(BIN_DIR)/weaponshop
OUTPUT 		:= $(if $(findstring Windows_NT, $(OS)), $(BIN_EXE).exe, $(BIN_EXE))
OBJ_DIR 	:= $(BIN_DIR)/obj
INC_DIRS 	:= -I$(SRC_DIR)
SRC_FILES 	:= $(wildcard $(SRC_DIR)/*.cpp)
H_FILES 	:= $(wildcard $(SRC_DIR)/*.h)
OBJ_FILES 	:= $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC_FILES))
CPP_FLAGS 	:= -O3 -std=c++20
MAKEFLAGS 	+= -j8

# Compile the object files and place them in their own directory
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(H_FILES)
	$(CC) $(CPP_FLAGS) $(INC_DIRS) -c -o $@ $<

# Link the object files together to create the final executable
$(OUTPUT): $(OBJ_FILES) Makefile
	$(CC) $(OBJ_FILES) -o $(OUTPUT)

# Compile and link the executable
all: $(OUTPUT)

# Build and run the executable
run: $(OUTPUT)
	$(if $(findstring Windows_NT, $(OS)), cd bin && weaponshop.exe && cd .., cd bin && ./weaponshop && cd ..)

# Clean up all the object files and the executable
clean:
	$(if $(findstring Windows_NT, $(OS)), del bin\obj\*.o && del bin\weaponshop.exe, rm $(OBJ_DIR)/*.o && rm $(OUTPUT))
