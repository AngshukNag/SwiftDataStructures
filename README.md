### -- Swift Algorithms -- ###

------------------------------------------------------------------------------------------------------

## Parenthesis Checker -

This functionality uses the Stack datastructure to check for parenthesis syntax check that takes places during compilation of code

You can use the code like this for example

let successBoolVal = ParenthesisChecker.isCorrectExp("[()()]")

This will return True as the opening and closing brackets are appropriately placed

let failureBoolVal = ParenthesisChecker.isCorrectExp("[()(")

This will return False as the opening and closing brackets are not properly placed

------------------------------------------------------------------------------------------------------

## Infix to postfix expression -

This functionality uses the stack data structure to convert an infix expression to a postfix one.

You can use it like this for example

let postFixExpression = ExpressionConverter.convertInfixToPostFix("A*B-(C+D)")

the result of this example would be AB*CD+-

The Expression converter also checks for parenthesis syntax errors and reports errors on finding them


## Circular Queue - 

The CircularArrayQueue data structure is a generic data structure that can be used for Array type queue implementation
