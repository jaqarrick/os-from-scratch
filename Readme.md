# OS From Scratch
Following along [this tutorial](https://www.youtube.com/watch?v=9t-SPC7Tczc), but I've made some annotations.

## x86 CPU Registers
All processors have a number of registers that are for specific purposes

- General purpose, index registers
- Status  registers
- Segment registers
- Protected mode registers
- Several other types

### RAM Memory
Memory segmentation: Each memory segment is a contiguous block of memory, and the segmentation mechanism allows for flexibility in organizing and accessing memory. In x86 architecture there are several types of segments:
1. Code Segment
- Used to store executable instructions
- `CS` register holds the base address of the code segment
2. Data Segment
- Used to store data such as variables and constants
- `DS` register holds the base address of the data segment and when accessing data, the effective address is calculated as the sume of the `DS` register value and the offset address.
3. Stack segment
- Used to manage the program's stack
- `SS` register holds the base address of the stack segment. 
4. Extra (Extended Data) Segment (`ES`)
- General-purpose segment that can be used for various purposes, like additional data storage. 

Segments are further divided into smaller units called "offsets." The combination of a segment and an offset forms a physical memory address. The actual memory address is calculated using the formula: Physical Address = Base Address of Segment + Offset.

It's important to note that x86 architecture supports multiple segment registers (CS, DS, ES, SS, etc.), allowing different segments for different purposes.

How to reference a memory location in assembly:
```
segment:[base + index * scale + displacement] 
```

### Interrupts
A signal which makes the processor stop what it's doing, in order to handle that signal. This can be triggered by:
1. An exception
2. Hardware (keyboard key press)
3. Software (using the `INT` instruction)

#### INT with BIOS
Example:
```
INT 0E
```