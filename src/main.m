#import <Foundation/Foundation.h>

void printUsage() {
    printf("Usage: %s [-p] [path]\n", getprogname());
}

void printObject(NSString *key, id object, int indent) {
    NSMutableString *indentation = [NSMutableString string];
    for (int i = 0; i < indent; i++) {
        [indentation appendString:@"   "];
    }
    
    if (key) {
        printf("%s%s => ", indentation.UTF8String, key.UTF8String);
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = object;
        printf("Dictionary[%lu]\n", (unsigned long)dict.count);
        for (id key in dict) {
            printObject(key, dict[key], indent + 1);
        }
    } else if ([object isKindOfClass:[NSArray class]]) {
        NSArray *array = object;
        printf("Array[%lu]\n", (unsigned long)array.count);
        for (NSUInteger i = 0; i < array.count; i++) {
            printf("%s   [%lu]: ", indentation.UTF8String, (unsigned long)i);
            printObject(nil, array[i], indent + 1);
        }
    } else if ([object isKindOfClass:[NSData class]]) {
        NSData *data = object;
        NSMutableString *hexString = [NSMutableString stringWithCapacity:data.length * 2];
        const unsigned char *bytePtr = data.bytes;
        
        for (NSUInteger i = 0; i < data.length; ++i) {
            [hexString appendFormat:@"%02x", bytePtr[i]];
        }
        
        if (data.length > 32) {
            NSString *truncatedHexString = [NSString stringWithFormat:@"%@ ... %@", [hexString substringToIndex:32], [hexString substringFromIndex:hexString.length - 32]];
            printf("Data[%lu] (%s)\n", (unsigned long)data.length, truncatedHexString.UTF8String);
        } else {
            printf("Data[%lu] (%s)\n", (unsigned long)data.length, hexString.UTF8String);
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if (CFBooleanGetTypeID() == CFGetTypeID((__bridge CFTypeRef)object)) {
            printf("%s\n", ([object boolValue] ? "true" : "false"));
        } else {
            printf("%s\n", [[object description] UTF8String]);
        }
    } else if ([object isKindOfClass:[NSString class]]) {
        printf("\"%s\"\n", [[object description] UTF8String]);
    } else if (object) {
        printf("%s\n", [[object description] UTF8String]);
    } else {
        printf("\n");
    }
}

int main(int argc, char * argv[]) {
    int c;
    BOOL printCF = NO;

    NSString *path;

    while ((c = getopt(argc, argv, "p")) != -1) {
        if (c == 'p') {
            printCF = YES;
        } else {
            printUsage();
            return -1;
        }
    }

    if (optind < argc) {
        path = [NSString stringWithUTF8String:argv[optind]];
    } else {
        printUsage();
        return -1;
    }

    @autoreleasepool {
        NSDictionary *content = [NSDictionary dictionaryWithContentsOfFile:path];

        if (printCF) {
            puts(content.description.UTF8String);
        } else {
            printObject(nil, content, 0);
        }
    }
    return 0;
}
