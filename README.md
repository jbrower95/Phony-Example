Phony

Phony helps you authenticate users by their cell phone numbers. Typical 2-factor authentication setups text the user a code,
and ask them to submit that code into the application. This is a clunky interaction that often leads users to switch apps to copy and paste a code,
which presents a horrible UX.

Phony solves this problem by having users text a code to a specified number. Only two method calls are necessary for this authentication,
and, with the web portal, you can directly integrate with Firebase's custom JWT tokens. 

Phony is available as a singleton for convenience via +sharedPhony. Individual instances for unforseeable cases of multiple-authentication can be created + used without a problem.

Somewhere in your application (preferably your application's didFinishingLaunching: method), initialize Phony with your app + key
```objective-c
[Phony initWithAppKey: secret:]
```
these two values can be found in the [portal](https://push.justinbrower.com)

To kick off authentication, start by calling
```objective-c
[[Phony sharedPhony] confirmPhoneNumber:(NSString *_Nonnull)number completion:(void (^ _Nullable)(NSString * _Nullable replyTo, NSString * _Nullable content, NSError * _Nullable error))handler];
```

This will contact the phony server and get a unique token + secret for your user. You will also get a number to text, assuming
Now, to prove that you own the phone number you previously specified, have the user text this code in.

```objective-c
[[Phony sharedPhony] authenticateWithDefaultTextMessageDialog:(NSString * _Nonnull)replyTo content:(NSString * _Nonnull)content handler:(void (^ _Nullable)(BOOL authenticated, NSString * _Nullable firebase))authHandler];
```

Calling this method will present the user with a text message dialog. All your user must do is tap 'send'.
After calling this method, Phony will immediately begin polling the server to see if your user's text was received. The handler
you provide will be called if the request times out, or if a poll returns successful. 

At that point, if you have your firebase secret entered into your app on the portal, you'll receive a JWT token to authenticate with firebase.
Otherwise, you'll just receive basic proof that the user owns the specified phone number.
