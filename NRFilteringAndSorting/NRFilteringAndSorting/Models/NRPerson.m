//
//  NRPerson.m
//  NRFilteringAndSorting
//
//  Created by NicoRobine on 2020/11/4.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import "NRPerson.h"

@implementation NRPerson

+ (instancetype)entityWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    NRPerson* person = [[NRPerson alloc] init];
    person.firstName = firstName;
    person.lastName = lastName;
    return person;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"firstName: %@, lastName:%@", _firstName, _lastName];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"firstName: %@, lastName:%@", _firstName, _lastName];
}

@end
