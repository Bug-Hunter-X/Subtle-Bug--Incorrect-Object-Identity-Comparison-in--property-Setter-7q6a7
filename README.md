# Objective-C @property Setter Bug

This repository demonstrates a subtle bug that can occur in Objective-C when using custom setter methods with `@property` attributes. The bug involves an incorrect comparison of object identity instead of object equality within the setter, which can lead to data corruption and unexpected behavior. The solution provides a corrected version of the setter that ensures proper object handling and prevents data loss.

## Bug Description

The bug arises from the use of `!=` in the setter method to compare the incoming value with the existing property value. This comparison checks for object *identity*, not *equality*. If the incoming string has the same content but is a different object, the copy is not performed.  This may especially affect the scenario where autoreleased strings are used as input to the setter.  The original string may be released before the copy is created, causing potential crashes due to dangling pointers.

## Solution

The solution is to use the `isEqualToString:` method to compare the content of the strings instead of relying on the object identity comparison.  This ensures correct behavior even when the incoming string is a different object instance with the same content as the existing property.

## How to reproduce

1. Clone this repository.
2. Open the project in Xcode.
3. Run the project.  The buggy version will demonstrate the unexpected behavior; the corrected version will showcase the solution and prevent such behavior. 