#import "LeancodeChatClientPlugin.h"
#if __has_include(<leancode_chat_client/leancode_chat_client-Swift.h>)
#import <leancode_chat_client/leancode_chat_client-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "leancode_chat_client-Swift.h"
#endif

@implementation LeancodeChatClientPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLeancodeChatClientPlugin registerWithRegistrar:registrar];
}
@end
