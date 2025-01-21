In Objective-C, a subtle bug can arise from the interaction between `@property` attributes and custom setter/getter methods.  Consider this scenario:

```objectivec
@interface MyClass : NSObject
@property (nonatomic, strong) NSString *myString;
@end

@implementation MyClass
- (void)setMyString:(NSString *)newString {
    if (newString != _myString) { // Check for equality, not identity
        _myString = [newString copy];
    }
}
@end
```

The issue lies in the use of `!=` in the setter. This compares object *identity*, not *equality*. If `newString` is a different object but has the same content as `_myString`, the copy won't be made, potentially leading to unexpected behavior.

This is especially problematic when using string manipulation:  If `newString` is an autoreleased string, the `setMyString` method might accidentally release the original string before the copy is made, resulting in a dangling pointer and possible crashes. 