# Multiple Secret Hensel Codes (MSH Code)
Ruby code for the **MSH Code library**, a lightweight, probabilistic, general purpose, fully homomorphic data encoding mechanism. By David W. H. A. da Silva.

## Requirements

This code requires Ruby installed on your system. There are [several options for downloading and installing Ruby](https://www.ruby-lang.org/en/downloads/ "Download Ruby").

This project uses only Ruby standard libraries, so once you have Ruby installed (version 2.6.3 and greater), you have everything required to run the code. We tested our implementation on Mac OSX version 10.13.6 with ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-darwin17].

## Contact

If you have any questions, comments of suggestions, feel free to send an email to dhonorio@uccs.edu .

## Usage

### Running tests

Once Ruby is installed on your machine, from the command line and in the root directory of the project, run the tests to check the code with the following command:

`$ rake`

You should get a result similiar to the following:

```console
Run options: --seed 9109

# Running:

...........

Finished in 5.316182s, 2.0692 runs/s, 9.0290 assertions/s.

11 runs, 48 assertions, 0 failures, 0 errors, 0 skips
```

### Ruby Interactive Shell

You can also run code from the Ruby Interactive Shell (IRB). From the project's root directory, execute the following command on the terminal:

`$ irb`

You will see the IRB's prompt. Next, command snippets for specific cases that can be executed on IRB.

#### Key Generation

Require the file the will boot the entire project on IRB:

`> require './x'`

Create the 'x' object with the required secret and public variables by passing a configuration for depth (first argument) and security parameter (second argument):

`> code = X::MSHCode.new 1024`

which return something like

`=> #<X::MSHCode:0x00007f98c6869410 @lambda=1024, @p1=1418335..., @p2=1556630..., @g=2207823...>`

Encode the number 219:

`> beta1 = code.encode(219)`

which returns it encoded value

`=> 6799619...`

Encryt the number 173:

`> beta2 = code.decode(173)`

which return it encoded value

` => 7027868...`

Add beta1 e beta2:

`> beta1_add_beta2 = code.add(beta1,beta2)`

returning

`=> => 750240...`

Multiply beta1 e beta2:

`> beta1_mul_beta2 = code.mul(beta1,beta2)`

returning

`=> 1427542...`

Decode beta1_mul_beta2

`> code.decode(beta1_add_beta2)`

which returns

`=> 392`

and we see that the result equals to 219 + 173 = 392

Decode beta1_mul_beta2:

`> code.decode(beta1_mul_beta2)`

which returns

`=> 37887`

and we see that the result equals to 219 * 173 = 37887
```
