# Apple 2 Yahtzee

First version of the first project in this repo.  yay me.

Using **Apple Commander** (https://applecommander.github.io) for accessing the goodies off of the committed disk image.

Extract the Applesoft program with something like:

```
% ~/bin/ac-mac-aarch64-13.0 -e Yahtzee.DO PROGRAM_NAME > blah.bas.txt
```

To see the latest (extracted) code, [check it out](yahtzee.bas)

Program development on an actual Apple 2 with a BMOW [Floopy Emu](https://shop.bigmessowires.com/products/floppy-emu-model-c) instead of physical disks.

Program playback screenshots and animations via [Virtual //](https://www.virtualii.com)

## Notes

I'm trying to keep To The Era, using tools that were available back then. So no lappy for taking notes in markdown and using pandoc to blah blah blah.  The computer had the BASIC program, and if you had any additional stuff to keep track of, you used pen, pencil, and paper.

So here's design notes (I **am** a fountain pen nerd).  I may transcribe some of them for easier consumption.  

| page 1 | page 2 |
| ----- | ----- |
| ![](assets/y1-pg1.jpg) | ![](assets/y1-pg2.jpg) |



## It works!

### Y1 - Getting the basics (heh) going

The first version "Y1" has the data structures defined and initialized, ready for further logic and gameplay.  Also a debug output screen to show all the moving pieces:

![](assets/y1.png)


