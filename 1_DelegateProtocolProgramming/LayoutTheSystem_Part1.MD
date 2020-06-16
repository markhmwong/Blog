# Layout the system

### Part 1 The System - Functions, Classes, Separation

### Functions
What does a basic functions stopwatch consist of -

Start, Stop, Pause, Lap, Time (resolution depending on your needs, ms, ns etc) and so on

Since I'm short on time I'll only cover Stop and Start functions and that should be enough to cover a working prototype using the Delegate Protocol Paradigm.

### Classes
If we're unaware of this paradigm and easy approach would be to just integrate the timer within the ViewController and open access to the Timer's inner workings, which isn't that great of an idea, in terms of testing and now the targetted ViewController is now responsible for handling the Timer itself, despite being "easier" to access all the necessary variables.

### Separation
So let's first begin to separate everything.

Let's create a Timer class, a ViewController and view to host the interface between the user and model and a model. So I imagine it would be something like so:

Timer <-> ViewController <-> ViewModel <-> Model
                                 | (bidirectional)
                                View

This is a crude diagram, so for a better idea you'll want to view the [MVVM diagram](./MVVM_Diagram.png) within this directory and if you could picture a time class attached with a bidirectional link to the ViewController

For now we'll avoid delegating any tasks for the moment and set up the core code.

[Would you like to know more? Check out Part 2](Code_Part2.MD)
