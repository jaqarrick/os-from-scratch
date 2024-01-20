# Specify the assembler to be used
ASM=nasm

# Directories
SRC_DIR=src
BUILD_DIR=build

# Target: $(BUILD_DIR)/main_floppy.img depends on $(BUILD_DIR)/main.bin
$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
	# Copy the binary to create a floppy image
	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_floppy.img
	# Adjust the size of the image to 1440 KB (standard size for a floppy disk)
	truncate -s 1440k $(BUILD_DIR)/main_floppy.img

# Target: $(BUILD_DIR)/main.bin depends on $(SRC_DIR)/main.asm
$(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
	# Assemble main.asm using nasm, output as a binary file in $(BUILD_DIR)
	$(ASM) $(SRC_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.bin