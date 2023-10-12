# C64 Assembler Scroller with Self-Modification

This repository contains a unique implementation of a text scroller for the Commodore 64, written entirely in 
KickAss assembler. This scroller distinguishes itself by not being restricted to the typical 256-byte limit. 
Instead, it employs self-modifying code to achieve its functionality, showcasing an advanced programming technique.

## Key Features

- **Extended Scrolling Capability:** Unlike most scrollers limited to 256 bytes, this scroller can handle more extensive data, making it suitable for longer messages.
  
- **Self-Modifying Code:** The program dynamically alters its own instructions during runtime. This technique is used primarily for altering the starting address of the print loop, allowing the scroller to repeat its text continuously.

- **Infinite Loop Scrolling:** The scroller is designed to run in an infinite loop, making it ideal for continuous display scenarios, like kiosks or demo presentations.

- **Memory-Efficient Design:** Through the use of indirect pointers and dynamic code modification, the scroller is highly memory-efficient, a critical consideration for the limited resources of the C64.

## How It Works

The code begins by setting up an indirect pointer to the text, initializing the copy loop, and disabling interrupts. It then enters a loop that checks for key presses, waits for the appropriate raster line, and shifts the screen pixels to create the scrolling effect. The print loop displays the text character by character, and upon reaching the end of the text (indicated by a NULL character), it reinitializes the pointer to start again.

The self-modifying aspect comes into play when altering the start address of the print loop. The program adjusts its instructions to change the memory address from which it reads the text, effectively altering its behavior on the fly.

## Setup

The repository includes the main assembler code (`scroller.asm`) and a text file (`humanrights.txt`) that contains the message to be scrolled. The text is imported into the assembler code using the `.import` directive, allowing for easy message changes.

## Usage

To use assemle this scroller, you'll need the [Kick Assembler](http://theweb.dk/KickAssembler/). It is easy to use. Please check it's
documentation.

