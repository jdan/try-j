NB. An introduction to the J programming language
NB. https://www.jsoftware.com

NB. `NB.` denotes a comment

NB. Today we're going to compute the Fibonacci numbers.

NB. ===== GETTING SET UP WITH VISUAL STUDIO CODE =====
NB. This repository is meant to be run in a VSCode Dev Container
NB.   https://code.visualstudio.com/docs/remote/containers
NB.
NB. 1. Install the Remote - Containers extension
NB.    https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
NB. 2. Open the command palette (Ctrl/Cmd + Shift + P)
NB. 3. Select "Remote-Containers: Reopen in Container..."
NB. 4. You're now coding in a full Ubuntu environment with the J console

NB. ===== PLAYING WITH THE J EXTENSION =====
NB. This dev container includes the J language VSCode extension (tikkanz.language-j)
NB. Opening this file should also open a J console
NB.     You can also open one with Ctrl/Cmd + Shift + J
NB.     Or by opening the command palette (Ctrl/Cmd + Shift + P)
NB.     and searching "J: Create console"

NB. ===== HELLO, REPL! =====
NB. Evaluate the line below by placing your cursor there and pressing
NB. Ctrl/Cmd + R
1 + 1

NB. You should see the input (1 + 1) indented
NB. And the output (2) on the following line

NB. Evaluate the line (and move your cursor down) with one Ctrl/Cmd + Enter
5 * 3
'hello, world!'

NB. ===== Lists lists and more lists =====
NB. J really shines when it comes to lists - and we'll use 'em to build our
NB. sequence. You can build lists just by writing the elements separated with
NB. whitespace.
1 2 3

NB. The {. verb (or function) is used to get the first element of a list. We
NB. can use it by just plopping it in the front.
{. 1 2 3
{. 10 17 100

NB. The {: verb is used to get the last element of the list.
{: 1 2 3
{: 10 17 100
{: 1

NB. The , verb is used to join lists. You'll notice that this one is different
NB. in that it has stuff on both sides! Kinda like +.
1 , 2
1 2 3 , 4 5 6

NB. We can use the verb +/ to sum the elements of a list.
+/ 1 2 3
+/ _1 5   NB. _ is for negative!

NB. ===== Stacking verbs =====
NB. We can use multiple verbs in an expression. Parentheses () help us control
NB. the order of things.
{. 1 2 3
{: 1 2 3
({. 1 2 3) , ({: 1 2 3)
+/ ({. 1 2 3) , ({: 1 2 3)

NB. Let's kick things up by introducing "forks." J will automagically form a
NB. fork when we combine certain functions.
({. 1 2 3) , ({: 1 2 3)
({. , {:) 1 2 3

NB. See that? We were able to extract the 1 2 3 out as a single argument! J
NB. interprets the series of verbs `{.`, `,`, and `{:` as a "fork" - it sends
NB. our argument to the left and right sides, then takes the results and joins
NB. them with `,`. We can do this with all kinds of verbs.
({: , {.) 1 2 3
({: , {:) 1 2 3
(+/ , {:) 1 2 3
(+/ * {:) 1 2 3

NB. Cool, right? This helps us read out our expressions like sentences. For
NB. instance, "the sum times the last" can be written as +/ * {:, and our
NB. argument is automatically passed to both sides as it needs to be.

NB. ===== Defining verbs =====
NB. We can use the "is" verb =: to define our own verbs.
(+/ , {:) 1 2 3
sumlast =: +/ , {:
sumlast 1 2 3
staticthing =: 55   NB. "nouns" too!
staticthing + 3

NB. We can also get a little more explicit with our verb definitions. The syntax
NB. of which is a little funky, but bear with me.
sumlast =: +/ , {:
sumlast 1 2 3
sumlast =: verb : '(+/ , {:) y'   NB. 'y' is our argument!
sumlast 1 2 3

NB. ===== All together now, Fibonacci =====
NB. Let's take what we've learned so far and start exploring.

NB. We can make a list.
1 2

NB. We can pick items from our list.
{. 1 2
{: 1 2

NB.  The next Fibonacci number is the sum of the previous two.
+/ 1 2
+/ 2 3

NB. We need the sum, but we also need to keep the second number around for next time.
({: 1 2) , (+/ 1 2)
({: 2 3) , (+/ 2 3)

NB. We can extract our argument using a fork to simplify our expression.
({: , +/) 1 2
({: , +/) 2 3

NB. We can stack our verbs multiple times.
({: , +/) 1 2
({: , +/) ({: , +/) 1 2
({: , +/) ({: , +/) ({: , +/) 1 2

NB. We can use the power verb ^: to do this for us.
(({: , +/)^:0) 1 2
(({: , +/)^:1) 1 2
(({: , +/)^:2) 1 2
(({: , +/)^:5) 1 2

NB. We can start at 1 1.
(({: , +/)^:0) 1 1
(({: , +/)^:1) 1 1
(({: , +/)^:2) 1 1
(({: , +/)^:5) 1 1

NB. We can take just the last number.
{: (({: , +/)^:6) 1 1
{: (({: , +/)^:20) 1 1

NB. We can define a Fibonacci function.
fib =: verb : '{: (({: , +/)^:y) 1 1'
fib 6
fib 20
fib 50

NB. ===== CLOSING NOTES =====

NB. I hope this gentle introduction alleviates some of the pain that comes with
NB. looking at an expression like {: (({: , +/)^:20) 1 1 for the first time.
NB. Once you break it down, it's really not so special.

NB. J challenges what it means for code to be "readable." Terse by nature, it
NB. uses compact symbols and clever composition tools to let us write code that
NB. flows like a conversation.

NB. There's still so much to learn. J has a ton of great tools for representing
NB. matrices, polynomials, tables, and much more.

NB. Feel free to poke around the complete J vocabulary to see what else this
NB. great language has to offer. The documentation is just as condensed as the
NB. language itself, so proceed with caution (and lots of patience).
NB. http://www.jsoftware.com/help/dictionary/vocabul.htm
