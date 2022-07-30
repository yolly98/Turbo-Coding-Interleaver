# Turbo-Coding-Interleaver
Electronic systems' project.

## Introduction
The Turbo Coding Interleaver is a digital circuit widely used in the telecommunications sector.
The turbo coding is the application of algorithms for the correction of errors that may happen during the transmissions. 
It may happen that in a data flow some bits become corrupted, for example due to an interference, so these algorithms are
used to correct corrupted bits and restore the original data flow. 
The error correction algorithms have best results if bits are uniformly distributed and are uncorrelated,
however many consecutive bits in the data flow can be corrupted, for this reason the Interleaver is used.
The Interleaver mixes the flow’s bits before the transmission, so that if a sequence of
bits becomes corrupted the errors will be distributed in all the flow, then there is an
Deinterleaver in the reception side that reorders the flow. Thus the Inteleaver in general
receives as input a data flow and return as output the same data flow but with mixed
bits

## Modules
* Block diagram
* Description in vhdl
* Testbench in vhdl and python
* Vivado synthesis
