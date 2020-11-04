//
//  NRFilteringAndSortingTests.m
//  NRFilteringAndSortingTests
//
//  Created by NicoRobine on 2020/11/2.
//  Copyright © 2020 Nicorobine. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NRProductModel.h"

@interface NSNumber (Factorial)
- (NSNumber *)factorial;
@end

@implementation NSNumber (Factorial)
- (NSNumber *)factorial {
    return @(tgamma([self doubleValue] + 1));
}
@end

@interface NRFilteringAndSortingTests : XCTestCase

@end

@implementation NRFilteringAndSortingTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

// 字符串比较
- (void)testPredicateWithStringFormat {
    NSString* testStr_1 = @"张三李四王五";
    NSString* utiStr_1 = @"public.data";
    NSString* utiStr_2 = @"public.image";
    
    // 相等的谓词
    NSPredicate* predicateEqual_1 = [NSPredicate predicateWithFormat:@"SELF = %@", testStr_1];
    XCTAssertTrue([predicateEqual_1 evaluateWithObject:testStr_1]);
    
    NSPredicate* predicateEqual_2 = [NSPredicate predicateWithFormat:@"SELF = %@", @"张三"];
    XCTAssertFalse([predicateEqual_2 evaluateWithObject:testStr_1]);
    
    // 字符串包含什么字串
    NSPredicate* predicateContains_3 = [NSPredicate predicateWithFormat:@"SELF contains %@", @"张三"];
    XCTAssertTrue([predicateContains_3 evaluateWithObject:testStr_1]);
    
    // 字符串以什么开始
    NSPredicate* predicatBeginwith_4 = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", @"张三"];
    XCTAssertTrue([predicatBeginwith_4 evaluateWithObject:testStr_1]);
    
    // 字符串以什么结尾
    NSPredicate* predicatEndwith_5 = [NSPredicate predicateWithFormat:@"SELF ENDSWITH %@", @"王五"];
    XCTAssertTrue([predicatEndwith_5 evaluateWithObject:testStr_1]);
    
    // 使用like的谓词，?匹配一个字符，*匹配任意多个字符
    NSPredicate* predicatLike_6 = [NSPredicate predicateWithFormat:@"SELF like %@", @"*王五"];
    XCTAssertTrue([predicatLike_6 evaluateWithObject:testStr_1]);
    
    // 使用like的谓词，?匹配一个字符，*匹配任意多个字符
    NSPredicate* predicatLike_7 = [NSPredicate predicateWithFormat:@"SELF like %@", @"????王五"];
    XCTAssertTrue([predicatLike_7 evaluateWithObject:testStr_1]);
    
    // 使用正则的谓词
    NSPredicate* predicatMatches_7 = [NSPredicate predicateWithFormat:@"SELF matches %@", @".*王五"];
    XCTAssertTrue([predicatMatches_7 evaluateWithObject:testStr_1]);
    
    // 是否在UTI的层级
    NSPredicate* predicatUTIConformsTo_8 = [NSPredicate predicateWithFormat:@"SELF UTI-CONFORMS-TO %@", utiStr_1];
    XCTAssertTrue([predicatUTIConformsTo_8 evaluateWithObject:utiStr_2]);
    
    // UTI是否一致
    NSPredicate* predicatUTIEauals_9 = [NSPredicate predicateWithFormat:@"SELF UTI-EQUALS %@", utiStr_1];
    XCTAssertTrue([predicatUTIEauals_9 evaluateWithObject:utiStr_1]);
}

// 基础的比较
- (void)testPredicateWithBaseCompare {
    NSUInteger defaultValue = 5;
    NSUInteger lowValue = 3;
    NSUInteger highValue = 9;
    
    // 相等
    NSPredicate* predicatEqual_1 = [NSPredicate predicateWithFormat:@"SELF = %@", @(defaultValue)];
    XCTAssertTrue([predicatEqual_1 evaluateWithObject:@(defaultValue)]);
    NSPredicate* predicatEqual_2 = [NSPredicate predicateWithFormat:@"SELF == %@", @(defaultValue)];
    XCTAssertTrue([predicatEqual_2 evaluateWithObject:@(defaultValue)]);
    
    // 大于等于
    NSPredicate* predicatBiggerThanOrEqual_2 = [NSPredicate predicateWithFormat:@"SELF >= %@", @(defaultValue)];
    XCTAssertTrue([predicatBiggerThanOrEqual_2 evaluateWithObject:@(highValue)]);
    XCTAssertFalse([predicatBiggerThanOrEqual_2 evaluateWithObject:@(lowValue)]);
    XCTAssertTrue([predicatBiggerThanOrEqual_2 evaluateWithObject:@(defaultValue)]);
    
    // 小于等于
    NSPredicate* predicatlessThanOrEqual_2 = [NSPredicate predicateWithFormat:@"SELF <= %@", @(defaultValue)];
    XCTAssertFalse([predicatlessThanOrEqual_2 evaluateWithObject:@(highValue)]);
    XCTAssertTrue([predicatlessThanOrEqual_2 evaluateWithObject:@(lowValue)]);
    XCTAssertTrue([predicatlessThanOrEqual_2 evaluateWithObject:@(defaultValue)]);
    
    // 大于
    NSPredicate* predicatBiggerThan_3 = [NSPredicate predicateWithFormat:@"SELF > %@", @(defaultValue)];
    XCTAssertTrue([predicatBiggerThan_3 evaluateWithObject:@(highValue)]);
    XCTAssertFalse([predicatBiggerThan_3 evaluateWithObject:@(lowValue)]);
    XCTAssertFalse([predicatBiggerThan_3 evaluateWithObject:@(defaultValue)]);
    
    // 小于
    NSPredicate* predicatlessThan_3 = [NSPredicate predicateWithFormat:@"SELF < %@", @(defaultValue)];
    XCTAssertFalse([predicatlessThan_3 evaluateWithObject:@(highValue)]);
    XCTAssertTrue([predicatlessThan_3 evaluateWithObject:@(lowValue)]);
    XCTAssertFalse([predicatlessThan_3 evaluateWithObject:@(defaultValue)]);
    
    // 不等于
    NSPredicate* predicatUnequal_3 = [NSPredicate predicateWithFormat:@"SELF != %@", @(defaultValue)];
    XCTAssertFalse([predicatUnequal_3 evaluateWithObject:@(defaultValue)]);
    XCTAssertTrue([predicatUnequal_3 evaluateWithObject:@(lowValue)]);
    
    // 之间，包含边界
    NSPredicate* predicatBetween_1 = [NSPredicate predicateWithFormat:@"SELF BETWEEN %@", @[@(lowValue), @(highValue)]];
    XCTAssertTrue([predicatBetween_1 evaluateWithObject:@(defaultValue)]);
    XCTAssertTrue([predicatBetween_1 evaluateWithObject:@(lowValue)]);
    XCTAssertFalse([predicatBetween_1 evaluateWithObject:@(0)]);
    
    NSPredicate* predicatBetween_2 = [NSPredicate predicateWithFormat:@"attributeName BETWEEN %@", @[@(lowValue), @(highValue)]];
    // 使用%K来动态的设置属性，如果使用%@会额外增加字符串，造成错误
    NSPredicate* predicatBetween_3 = [NSPredicate predicateWithFormat:@"%K BETWEEN %@", @"attributeName", @[@(lowValue), @(highValue)]];
//    NSPredicate* predicatBetween_4 = [NSPredicate predicateWithFormat:@"%@ BETWEEN %@", @"attributeName", @[@(lowValue), @(highValue)]];
    NSDictionary *dictionary = @{ @"attributeName" : @5 };
    XCTAssertTrue([predicatBetween_2 evaluateWithObject:dictionary]);
    XCTAssertTrue([predicatBetween_3 evaluateWithObject:dictionary]);
//    XCTAssertFalse([predicatBetween_4 evaluateWithObject:dictionary]);
}

// 布尔谓词
- (void)testPredicateBool {
    // 永远是True的谓词
    NSPredicate* predicatTrue = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    XCTAssertTrue([predicatTrue evaluateWithObject:@(YES)]);
    XCTAssertTrue([predicatTrue evaluateWithObject:@(NO)]);
    XCTAssertTrue([predicatTrue evaluateWithObject:nil]);
    
    // 永远是false的谓词
    NSPredicate* predicatFalse = [NSPredicate predicateWithFormat:@"FALSEPREDICATE"];
    XCTAssertFalse([predicatFalse evaluateWithObject:@(YES)]);
    XCTAssertFalse([predicatFalse evaluateWithObject:@(NO)]);
    XCTAssertFalse([predicatFalse evaluateWithObject:nil]);
}

// 基本组合谓词
- (void)testPredicateBasicCompound {
    NSUInteger defaultValue = 5;
    NSUInteger lowValue = 3;
    NSUInteger highValue = 9;
    
    // && 或者 AND都可以
    NSPredicate* predicatAND = [NSPredicate predicateWithFormat:@"SELF > 2 && SELF < 7"];
    XCTAssertTrue([predicatAND evaluateWithObject:@(defaultValue)]);
    XCTAssertTrue([predicatAND evaluateWithObject:@(lowValue)]);
    XCTAssertFalse([predicatAND evaluateWithObject:@(10)]);
    
    // || 或者 OR都可以
    NSPredicate* predicatOR = [NSPredicate predicateWithFormat:@"SELF < 5 ||  SELF > 9"];
    XCTAssertFalse([predicatOR evaluateWithObject:@(defaultValue)]);
    XCTAssertTrue([predicatOR evaluateWithObject:@(lowValue)]);
    XCTAssertFalse([predicatOR evaluateWithObject:@(highValue)]);
    
    // !或者NOT都可以
    NSPredicate* predicatNOT = [NSPredicate predicateWithFormat:@"NOT SELF = %@", @(5)];
    XCTAssertFalse([predicatNOT evaluateWithObject:@(defaultValue)]);
    XCTAssertTrue([predicatNOT evaluateWithObject:@(lowValue)]);
    XCTAssertTrue([predicatNOT evaluateWithObject:@(highValue)]);
}

// 测试聚合操作
- (void)testPredicateAggegateOperation {
    NSArray* ages = @[@(3), @(5), @(6), @(7), @(9), @(12), @(15), @(18)];
    NSArray* names = @[@"lisi", @"张三", @"王五", @"Jemmy", @"Jodan", @"Tom"];
    NSArray* names_1 = @[@"Mal", @"Json", @"Lucas"];
    NSArray* subNames = @[@"lisi", @"张三", @"王五"];
    
    // ANY，任何一个含有
    NSPredicate* predicateAny_1 = [NSPredicate predicateWithFormat:@"ANY SELF < 3"];
    NSPredicate* predicateAny_2 = [NSPredicate predicateWithFormat:@"ANY SELF < 7"];
    XCTAssertFalse([predicateAny_1 evaluateWithObject:ages]);
    XCTAssertTrue([predicateAny_2 evaluateWithObject:ages]);
    
    // ALL,所有的
    NSPredicate* predicateALL_1 = [NSPredicate predicateWithFormat:@"ALL SELF < 7"];
    NSPredicate* predicateALL_2 = [NSPredicate predicateWithFormat:@"ALL SELF < 20"];
    XCTAssertFalse([predicateALL_1 evaluateWithObject:ages]);
    XCTAssertTrue([predicateALL_2 evaluateWithObject:ages]);
    
    // NONE,没有
    NSPredicate* predicateNONE_1 = [NSPredicate predicateWithFormat:@"NONE SELF = %@", @"张三"];
    NSPredicate* predicateNONE_2 = [NSPredicate predicateWithFormat:@"NONE SELF = %@", @"Susan"];
    XCTAssertFalse([predicateNONE_1 evaluateWithObject:names]);
    XCTAssertTrue([predicateNONE_2 evaluateWithObject:names]);
    
    // IN，左侧的元素必须出现在右侧元素中
    NSPredicate* predicateIN_1 = [NSPredicate predicateWithFormat:@"SELF IN %@", @[@"张三", @"Jack"]];
    NSPredicate* predicateIN_2 = [NSPredicate predicateWithFormat:@"SELF IN %@", names];
    XCTAssertFalse([predicateIN_1 evaluateWithObject:names]);
    XCTAssertFalse([predicateIN_1 evaluateWithObject:names_1]);
    XCTAssertTrue([predicateIN_2 evaluateWithObject:@"张三"]);
    
    // array[index] 指定索引的值 越界触发异常
    NSPredicate* predicateArrayIndex_1 = [NSPredicate predicateWithFormat:@"SELF[1] = %@", @(5)];
    NSPredicate* predicateArrayIndex_2 = [NSPredicate predicateWithFormat:@"%@[1] = SELF", @[@(1), @(3)]];
    // 越界不会返回false会触发异常
//    NSPredicate* predicateArrayIndex_3 = [NSPredicate predicateWithFormat:@"SELF[20] > %@", @(0)];
    XCTAssertTrue([predicateArrayIndex_1 evaluateWithObject:ages]);
    XCTAssertFalse([predicateArrayIndex_1 evaluateWithObject:names]);
    XCTAssertTrue([predicateArrayIndex_2 evaluateWithObject:@(3)]);
//    XCTAssertFalse([predicateArrayIndex_3 evaluateWithObject:ages]);
    
    // array[FIRST] 第一个索引 越界不会出发异常 nil会出发异常
    NSPredicate* predicateArrayFirst_1 = [NSPredicate predicateWithFormat:@"SELF[FIRST] = %@", @(3)];
    XCTAssertTrue([predicateArrayFirst_1 evaluateWithObject:ages]);
    XCTAssertFalse([predicateArrayFirst_1 evaluateWithObject:@[]]);
//    XCTAssertFalse([predicateArrayFirst_1 evaluateWithObject:nil]);
    
    // array[LAST] 最后一个索引 越界不会出发异常 nil会出发异常
        NSPredicate* predicateArrayLAST_1 = [NSPredicate predicateWithFormat:@"SELF[LAST] = %@", @(18)];
        XCTAssertTrue([predicateArrayLAST_1 evaluateWithObject:ages]);
        XCTAssertFalse([predicateArrayLAST_1 evaluateWithObject:@[]]);
    //    XCTAssertFalse([predicateArrayFirst_1 evaluateWithObject:nil]);
    
    // array[SIZE] 数组大小 nil出发异常
    NSPredicate* predicateArraySIZE_1 = [NSPredicate predicateWithFormat:@"SELF[SIZE] = %@", @(8)];
        XCTAssertTrue([predicateArraySIZE_1 evaluateWithObject:ages]);
        XCTAssertFalse([predicateArraySIZE_1 evaluateWithObject:subNames]);
//        XCTAssertFalse([predicateArrayFirst_1 evaluateWithObject:nil]);
}

- (void)testPredicateWithExpress {
    NSArray* ages = @[@(3), @(5), @(6), @(7), @(9), @(12), @(15), @(18)];
    
    NSExpression* selfExpression = [NSExpression expressionForEvaluatedObject];
    NSExpression* mediamNumExpression = [NSExpression expressionForConstantValue:@(12)];
    NSExpression* bigNumExpression = [NSExpression expressionForConstantValue:@(100)];
    NSPredicate* greaterThanPredicate_1 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:mediamNumExpression modifier:NSDirectPredicateModifier type:NSGreaterThanPredicateOperatorType options:NSNormalizedPredicateOption];
    XCTAssertTrue([greaterThanPredicate_1 evaluateWithObject:@(16)]);
    XCTAssertFalse([greaterThanPredicate_1 evaluateWithObject:@(12)]);
    
    NSPredicate* anyPredicate_1 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:mediamNumExpression modifier:NSAnyPredicateModifier type:NSEqualToPredicateOperatorType options:NSNormalizedPredicateOption];
    NSPredicate* anyPredicate_2 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:bigNumExpression modifier:NSAnyPredicateModifier type:NSEqualToPredicateOperatorType options:NSNormalizedPredicateOption];
    XCTAssertTrue([anyPredicate_1 evaluateWithObject:ages]);
    XCTAssertFalse([anyPredicate_2 evaluateWithObject:ages]);
    
    NSPredicate* allPredicate_1 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:mediamNumExpression modifier:NSAllPredicateModifier type:NSLessThanPredicateOperatorType options:NSNormalizedPredicateOption];
    NSPredicate* allPredicate_2 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:bigNumExpression modifier:NSAllPredicateModifier type:NSLessThanPredicateOperatorType options:NSNormalizedPredicateOption];
    XCTAssertFalse([allPredicate_1 evaluateWithObject:ages]);
    XCTAssertTrue([allPredicate_2 evaluateWithObject:ages]);
    
    NSExpression *left1 = [NSExpression expressionForVariable:@"key1"];
    NSExpression *right1 = [NSExpression expressionWithFormat:@"%@", @[@"aaa", @"bbb", @"ccc"]];
    NSComparisonPredicate* predicate1 = [NSComparisonPredicate predicateWithLeftExpression:left1 rightExpression:right1 modifier:NSDirectPredicateModifier type:NSInPredicateOperatorType options:NSCaseInsensitivePredicateOption];
    NSLog(@"predicate1: %@", [predicate1 predicateFormat]);
    XCTAssertTrue([predicate1 evaluateWithObject:nil substitutionVariables:@{@"key1":@"aaa"}]);
    
    NSExpression *left2 = [NSExpression expressionForKeyPath:@"key1.key2"];
    NSExpression *right2 = [NSExpression expressionWithFormat:@"%@", @[@"aaa", @"bbb", @"ccc"]];
    NSComparisonPredicate* predicate2 = [NSComparisonPredicate predicateWithLeftExpression:left2 rightExpression:right2 modifier:NSDirectPredicateModifier type:NSInPredicateOperatorType options:NSCaseInsensitivePredicateOption];
    NSLog(@"predicate2: %@", [predicate2 predicateFormat]);
    XCTAssertTrue([predicate2 evaluateWithObject:@{@"key1": @{@"key2": @"bbb"}}]);
    
    // 创建一个常数表达式
    NSExpression *sun = [NSExpression expressionForConstantValue:ages];
    NSExpression *right3 = [NSExpression expressionForFunction:@"sum:" arguments:@[sun]];
    NSComparisonPredicate* predicate3 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:right3 modifier:NSDirectPredicateModifier type:NSLessThanPredicateOperatorType options:NSNormalizedPredicateOption];
    NSLog(@"predicate3: %@", [predicate3 predicateFormat]);
    XCTAssertTrue([predicate3 evaluateWithObject:@10]);
    XCTAssertFalse([predicate3 evaluateWithObject:@77]);
}

- (void)testValueExpression {
    NSExpression* constantExpression = [NSExpression expressionForConstantValue:@20];
    NSExpression* selfExpression = [NSExpression expressionForEvaluatedObject];
    NSExpression* keyPathExpression = [NSExpression expressionForKeyPath:@"key1.key2"];
    NSExpression* varExpression = [NSExpression expressionForVariable:@"variable"];
    NSExpression* anyKeyExpression = [NSExpression expressionForAnyKey];
    
    NSLog(@"constantExpression: %@", constantExpression);
    NSLog(@"selfExpression: %@", selfExpression);
    NSLog(@"keyPathExpression: %@", keyPathExpression);
    NSLog(@"varExpression: %@", varExpression);
    NSLog(@"anyKeyExpression: %@", anyKeyExpression);
    
    NSComparisonPredicate* predicate_1 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:constantExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSNormalizedPredicateOption];
    XCTAssertTrue([predicate_1 evaluateWithObject:@20]);
    
    NSComparisonPredicate* predicate_2 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:varExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSNormalizedPredicateOption];
    XCTAssertTrue([predicate_2 evaluateWithObject:@30 substitutionVariables:@{@"variable": @30}]);
    
    NSExpression *right2 = [NSExpression expressionWithFormat:@"%@", @[@"aaa", @"bbb", @"ccc"]];
    NSComparisonPredicate* predicate_3 = [NSComparisonPredicate predicateWithLeftExpression:keyPathExpression rightExpression:right2 modifier:NSDirectPredicateModifier type:NSInPredicateOperatorType options:NSCaseInsensitivePredicateOption];
    XCTAssertTrue([predicate_3 evaluateWithObject:@{@"key1": @{@"key2": @"bbb"}}]);
}

// 创建聚合查询
- (void)testAggregateExpression {
    NSExpression* constantExpression_1 = [NSExpression expressionForConstantValue:@20];
    NSExpression* constantExpression_2 = [NSExpression expressionForConstantValue:@30];
    NSExpression* selfExpression = [NSExpression expressionForEvaluatedObject];
    NSSet* testSet = [NSSet setWithObjects:@10, @20, @30, nil];
    NSSet* testSet_1 = [NSSet setWithObjects:@20, @30, @40, @50, nil];
    NSExpression* setExpression = [NSExpression expressionForConstantValue:testSet];
    NSExpression* setExpression_1 = [NSExpression expressionForConstantValue:testSet_1];
    NSArray* testArray = @[@10, @20];
    
    NSExpression* aggregate_1 = [NSExpression expressionForAggregate:@[constantExpression_1, constantExpression_2]];
    NSComparisonPredicate* predicate_1 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:aggregate_1 modifier:NSAnyPredicateModifier type:NSInPredicateOperatorType options:NSNormalizedPredicateOption];
    NSLog(@"predicate_1: %@", predicate_1);
    XCTAssertTrue([predicate_1 evaluateWithObject:testArray]);
    
    NSComparisonPredicate* predicate_2 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:setExpression modifier:NSAnyPredicateModifier type:NSInPredicateOperatorType options:NSNormalizedPredicateOption];
    NSLog(@"predicate_2: %@", predicate_2);
    XCTAssertTrue([predicate_2 evaluateWithObject:testArray]);
    
    NSExpression* aggregate_2 = [NSExpression expressionForAggregate:@[constantExpression_1, setExpression]];
    NSComparisonPredicate* predicate_3 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:aggregate_2 modifier:NSDirectPredicateModifier type:NSInPredicateOperatorType options:NSNormalizedPredicateOption];
    NSLog(@"predicate_3: %@", predicate_3);
    XCTAssertTrue([predicate_3 evaluateWithObject:testSet]);
    
    NSExpression* unionExpression_1 = [NSExpression expressionForUnionSet:setExpression with:setExpression_1];
    NSComparisonPredicate* predicate_4 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:unionExpression_1 modifier:NSDirectPredicateModifier type:NSInPredicateOperatorType options:NSNormalizedPredicateOption];
    NSLog(@"predicate_4: %@", predicate_4);
    XCTAssertTrue([predicate_4 evaluateWithObject:@10]);
    XCTAssertTrue([predicate_4 evaluateWithObject:@30]);
    XCTAssertTrue([predicate_4 evaluateWithObject:@50]);
    
    NSExpression* intersectExpression_1 = [NSExpression expressionForIntersectSet:setExpression with:setExpression_1];
    NSComparisonPredicate* predicate_5 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:intersectExpression_1 modifier:NSDirectPredicateModifier type:NSInPredicateOperatorType options:NSNormalizedPredicateOption];
    NSLog(@"predicate_5: %@", predicate_5);
    XCTAssertFalse([predicate_5 evaluateWithObject:@10]);
    XCTAssertTrue([predicate_5 evaluateWithObject:@30]);
    XCTAssertFalse([predicate_5 evaluateWithObject:@50]);
    
    NSExpression* minusExpression = [NSExpression expressionForMinusSet:setExpression with:setExpression_1];
    NSComparisonPredicate* predicate_6 = [NSComparisonPredicate predicateWithLeftExpression:selfExpression rightExpression:minusExpression modifier:NSDirectPredicateModifier type:NSInPredicateOperatorType options:NSNormalizedPredicateOption];
    NSLog(@"predicate_6: %@", predicate_6);
    XCTAssertTrue([predicate_6 evaluateWithObject:@10]);
    XCTAssertFalse([predicate_6 evaluateWithObject:@30]);
    XCTAssertFalse([predicate_6 evaluateWithObject:@50]);
}

// 创建子查询
- (void)testSubExpression {
    NSSet* datas = [NSSet setWithObjects:
                    @{@"firstName": @"Jane",@"lastName": @"Doe"},
                    @{@"firstName": @"Jack",@"lastName": @"Doe"},
                    @{@"firstName": @"Jane",@"lastName": @"White"},
                    @{@"firstName": @"Jodan",@"lastName": @"Machale"},
                    @{@"firstName": @"Livse",@"lastName": @"Suton"},
                    nil];
    
    NSExpression* setExpression = [NSExpression expressionForConstantValue:datas];
    
    NSString* variable = @"person";
    
    NSExpression* firstNameVarExpression = [NSExpression expressionWithFormat:@"$person.firstName"];
    NSExpression* firstNameExpression = [NSExpression expressionForConstantValue:@"Jane"];
    NSPredicate* firstPredicate = [NSComparisonPredicate predicateWithLeftExpression:firstNameVarExpression rightExpression:firstNameExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSCaseInsensitivePredicateOption | NSDiacriticInsensitivePredicateOption];
    
    NSExpression* lastNameVarExpression = [NSExpression expressionWithFormat:@"$person.lastName"];
    NSExpression* lastNameExpression = [NSExpression expressionForConstantValue:@"Doe"];
    NSPredicate* lastPredicate = [NSComparisonPredicate predicateWithLeftExpression:lastNameVarExpression rightExpression:lastNameExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSCaseInsensitivePredicateOption | NSDiacriticInsensitivePredicateOption];
    NSCompoundPredicate* compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[firstPredicate, lastPredicate]];
    NSLog(@"compoundPredicate: %@", [compoundPredicate predicateFormat]);
    NSExpression* expression = [NSExpression expressionForSubquery:setExpression usingIteratorVariable:variable predicate:compoundPredicate];
    NSExpression* sizeExpression = [NSExpression expressionForFunction:@"count:" arguments:@[expression]];
    NSLog(@"sizeExpression: %@", sizeExpression);
    NSExpression* zeroExpression = [NSExpression expressionForConstantValue:@0];
    NSPredicate* predicate = [NSComparisonPredicate predicateWithLeftExpression:sizeExpression rightExpression:zeroExpression modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:NSNormalizedPredicateOption];
    NSLog(@"predicate format: %@", [predicate predicateFormat]);
    XCTAssertFalse([predicate evaluateWithObject:setExpression]);
}

// 使用Block创建表达式
- (void)testBlockExpression {
    
    NSExpression* constantExpression_1 = [NSExpression expressionForConstantValue:@"ccc"];
    NSExpression* constantExpression_2 = [NSExpression expressionForConstantValue:@"ddd"];
    
    NSExpression* expression = [NSExpression expressionForBlock:^id _Nonnull(id  _Nullable evaluatedObject, NSArray<NSExpression *> * _Nonnull expressions, NSMutableDictionary * _Nullable context) {
        NSLog(@"evaluatedObject: %@, context: %@",evaluatedObject, context);
        for (NSExpression* expression in expressions) {
            NSLog(@"expression: %@", expression);
        }
        return @"bbb";
    } arguments:@[constantExpression_1, constantExpression_2]];
    
    NSMutableDictionary* context = @{@"key1": @"aaa"}.mutableCopy;
    
    NSString* result = [expression expressionValueWithObject:@"aaa" context:context];
    NSString* result_1 = [constantExpression_1 expressionValueWithObject:@"ppp" context:context];
    
    XCTAssertTrue([result isEqualToString:@"bbb"]);
    XCTAssertTrue([result_1 isEqualToString:@"ccc"]);
}

// 测试系统定义的函数表达式
- (void)testSystemFuncExpression {
    NSArray* array_1 = @[@10, @20, @30, @40, @50];
    NSArray* array_2 = @[@40, @50, @60, @70, @80, @90];
    NSArray* array_3 = @[@30, @40, @30, @70, @70, @70, @40, @40];
    
    NSExpression* numberExpression_1 = [NSExpression expressionForConstantValue:array_1];
    NSExpression* numberExpression_2 = [NSExpression expressionForConstantValue:array_2];
    NSExpression* numberExpression_3 = [NSExpression expressionForConstantValue:array_3];
    NSExpression* constantExpression = [NSExpression expressionForConstantValue:@100];
    NSExpression* constantExpression_1 = [NSExpression expressionForConstantValue:@200];
    NSExpression* constantExpression_2 = [NSExpression expressionForConstantValue:@300];
    NSExpression* constantExpression_3 = [NSExpression expressionForConstantValue:@325];
    
    
    // 平均值
    NSExpression* averageExpression = [NSExpression expressionForFunction:@"average:" arguments:@[numberExpression_1]];
    NSNumber* value = [averageExpression expressionValueWithObject:nil context:nil];
    NSLog(@"averageExpression: %@", averageExpression);
    XCTAssertEqual(value.intValue, 30);
    
    // 和
    NSExpression* sumExpression = [NSExpression expressionForFunction:@"sum:" arguments:@[numberExpression_1]];
    NSExpression* sumExpression_1 = [NSExpression expressionForFunction:@"sum:" arguments:@[numberExpression_1, numberExpression_2]];
    NSNumber* sumValue = [sumExpression expressionValueWithObject:nil context:nil];
    NSNumber* sumValue_1 = [sumExpression_1 expressionValueWithObject:nil context:nil];
    NSLog(@"sumExpression: %@", sumExpression);
    NSLog(@"sumExpression_1: %@", sumExpression_1);
    XCTAssertEqual(sumValue.intValue, 150);
    XCTAssertEqual(sumValue_1.intValue, 150);
    
    // 数量
    NSExpression* countExpression = [NSExpression expressionForFunction:@"count:" arguments:@[numberExpression_1]];
    NSNumber* countValue = [countExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(countValue.intValue, 5);
    
    // 最小值
    NSExpression* minExpression = [NSExpression expressionForFunction:@"min:" arguments:@[numberExpression_2]];
    NSNumber* minValue = [minExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(minValue.intValue, 40);
    
    // 最大值
    NSExpression* maxExpression = [NSExpression expressionForFunction:@"max:" arguments:@[numberExpression_2]];
    NSNumber* maxValue = [maxExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(maxValue.intValue, 90);
    
    // 中间值
    NSExpression* medianExpression = [NSExpression expressionForFunction:@"median:" arguments:@[numberExpression_1]];
    NSExpression* medianExpression_1 = [NSExpression expressionForFunction:@"median:" arguments:@[numberExpression_2]];
    NSNumber* medianValue = [medianExpression expressionValueWithObject:nil context:nil];
    NSNumber* medianValue_1 = [medianExpression_1 expressionValueWithObject:nil context:nil];
    XCTAssertEqual(medianValue.intValue, 30);
    XCTAssertEqual(medianValue_1.intValue, 65);
    
    // 众数，一组中出现最多的数的数组，可能是一个或者多个
    NSExpression* modeExpression = [NSExpression expressionForFunction:@"mode:" arguments:@[numberExpression_3]];
    NSArray* modes = [modeExpression expressionValueWithObject:nil context:nil];
    XCTAssertTrue([modes containsObject:@40]);
    XCTAssertTrue([modes containsObject:@70]);
    
    // 标准差
    NSExpression* stddevExpression = [NSExpression expressionForFunction:@"stddev:" arguments:@[numberExpression_1]];
    NSNumber* stddevValue = [stddevExpression expressionValueWithObject:nil context:nil];
    XCTAssertTrue(fabs(stddevValue.doubleValue - 14.142135623730951) < DBL_EPSILON);
    
    // 加法
    NSExpression* addToExpression = [NSExpression expressionForFunction:@"add:to:" arguments:@[constantExpression, constantExpression_1]];
    NSNumber* addToValue = [addToExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(addToValue.intValue, 300);
    
    // 减法
    NSExpression* substractExpression = [NSExpression expressionForFunction:@"from:subtract:" arguments:@[constantExpression_2, constantExpression]];
    NSNumber* substractValue = [substractExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(substractValue.intValue, 200);
    
    // 乘法
    NSExpression* multiplyExpression = [NSExpression expressionForFunction:@"multiply:by:" arguments:@[constantExpression_2, constantExpression]];
    NSNumber* multiplyValue = [multiplyExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(multiplyValue.intValue, 30000);
    
    // 除法
    NSExpression* divideExpression = [NSExpression expressionForFunction:@"divide:by:" arguments:@[constantExpression_2, constantExpression]];
    NSNumber* divideValue = [divideExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(divideValue.intValue, 3);
    
    // 取模
    NSExpression* modulusExpression = [NSExpression expressionForFunction:@"modulus:by:" arguments:@[constantExpression_3, constantExpression]];
    NSNumber* modulusValue = [modulusExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(modulusValue.intValue, 25);
    
    // 平方根
    NSExpression* sqrtExpression = [NSExpression expressionForFunction:@"sqrt:" arguments:@[constantExpression]];
    NSNumber* sqrtValue = [sqrtExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(sqrtValue.intValue, 10);
    
    // 对数
    NSExpression* logExpression = [NSExpression expressionForFunction:@"log:" arguments:@[constantExpression]];
    NSNumber* logValue = [logExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(logValue.intValue, 2);
    
    // 自然对数
    NSExpression* lnExpression = [NSExpression expressionForFunction:@"ln:" arguments:@[constantExpression]];
    NSNumber* lnValue = [lnExpression expressionValueWithObject:nil context:nil];
    NSLog(@"lnValue: %@", lnValue);
    XCTAssertNotNil(lnValue);
    
    // 幂
    NSExpression* raiseToPowerExpression = [NSExpression expressionForFunction:@"raise:toPower:" arguments:@[constantExpression, [NSExpression expressionForConstantValue:@2]]];
    NSNumber* raiseToPowerValue = [raiseToPowerExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(raiseToPowerValue.intValue, 10000);
    
    // 高等数学里以自然常数e为底的指数函数
    NSExpression* expExpression = [NSExpression expressionForFunction:@"exp:" arguments:@[[NSExpression expressionForConstantValue:@2.0]]];
    NSNumber* expValue = [expExpression expressionValueWithObject:nil context:nil];
    NSLog(@"expValue: %@", expValue);
    XCTAssertEqual(expValue.doubleValue, exp(2.0));
    
    // 将数字转换为不小于其值的最小整数
    NSExpression* ceilingExpression = [NSExpression expressionForFunction:@"ceiling:" arguments:@[[NSExpression expressionForConstantValue:@22.3]]];
    NSNumber* ceilingValue = [ceilingExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(ceilingValue.intValue, 23);
    
    // 绝对值
    NSExpression* absExpression = [NSExpression expressionForFunction:@"abs:" arguments:@[[NSExpression expressionForConstantValue:@-22]]];
    NSNumber* absValue = [absExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(absValue.intValue, 22);
    
    // 最接近但是不大于数组中值的整数
    NSExpression* truncExpression = [NSExpression expressionForFunction:@"trunc:" arguments:@[[NSExpression expressionForConstantValue:@22.3]]];
    NSNumber* truncValue = [truncExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(truncValue.intValue, 22);
    
    // 随机数，0到1之间
    NSExpression* randomExpression = [NSExpression expressionForFunction:@"random" arguments:@[]];
    NSNumber* randomValue = [randomExpression expressionValueWithObject:nil context:nil];
    NSMutableArray<NSNumber *> *randoms = @[].mutableCopy;
    for (int i = 0; i < 10; ++i) {
        [randoms addObject:[randomExpression expressionValueWithObject:nil context:nil]];
    }
    NSLog(@"randomValue: %@", randomValue);
    NSLog(@"randoms: %@", randoms);
    XCTAssertNotNil(randomValue);
    
    // 随机数, 0和指定值之间，不支持random:函数了
//    NSExpression* randomExpression_1 = [NSExpression expressionForFunction:@"random:" arguments:@[constantExpression_4]];
//    NSNumber* randomValue_1 = [randomExpression_1 expressionValueWithObject:nil context:nil];
//    NSMutableArray<NSNumber *> *randoms_1 = @[].mutableCopy;
//    for (int i = 0; i < 10; ++i) {
//        [randoms_1 addObject:[randomExpression_1 expressionValueWithObject:nil context:nil]];
//    }
//    NSLog(@"randomValue_1: %@", randomValue_1);
//    NSLog(@"randoms_1: %@", randoms_1);
//    XCTAssertNotNil(randomValue_1);
    
    // 当前日期的函数
    NSExpression* dateExpression = [NSExpression expressionForFunction:@"now" arguments:@[]];
    NSDate* dateValue = [dateExpression expressionValueWithObject:nil context:nil];
    NSLog(@"dateValue: %@", dateValue);
    XCTAssertNotNil(dateValue);
    
    // 返回不大于指定数值的最大整数
    NSExpression* floorExpression = [NSExpression expressionForFunction:@"floor:" arguments:@[[NSExpression expressionForConstantValue:@22.3]]];
    NSNumber* floorValue = [floorExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(floorValue.intValue, 22);
    XCTAssertNotEqual(floorValue.intValue, 21);;
    
    // 字符串变大写
    NSExpression* uppercaseExpression = [NSExpression expressionForFunction:@"uppercase:" arguments:@[[NSExpression expressionForConstantValue:@"AAaaBBbbCCcc"]]];
    NSString* uppercaseValue = [uppercaseExpression expressionValueWithObject:nil context:nil];
    XCTAssertTrue([@"AAAABBBBCCCC" isEqualToString:uppercaseValue]);
    
    // 字符串变小写
    NSExpression* lowercaseExpression = [NSExpression expressionForFunction:@"lowercase:" arguments:@[[NSExpression expressionForConstantValue:@"AAaaBBbbCCcc"]]];
    NSString* lowercaseValue = [lowercaseExpression expressionValueWithObject:nil context:nil];
    XCTAssertTrue([@"aaaabbbbcccc" isEqualToString:lowercaseValue]);
    
    // 位AND运算
    NSExpression* bitwiseAndExpression = [NSExpression expressionForFunction:@"bitwiseAnd:with:" arguments:@[[NSExpression expressionForConstantValue:@0x00F6], [NSExpression expressionForConstantValue:@0x0037]]];
    NSNumber* bitwiseAndValue = [bitwiseAndExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(bitwiseAndValue.intValue, 0x0036);
    
    // 为OR运算
    NSExpression* bitwiseOrExpression = [NSExpression expressionForFunction:@"bitwiseOr:with:" arguments:@[[NSExpression expressionForConstantValue:@0x00F6], [NSExpression expressionForConstantValue:@0x0037]]];
    NSNumber* bitwiseOrValue = [bitwiseOrExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(bitwiseOrValue.intValue, 0x00F7);
    
    // 位异或运算
    NSExpression* bitwiseXorExpression = [NSExpression expressionForFunction:@"bitwiseXor:with:" arguments:@[[NSExpression expressionForConstantValue:@0x00F6], [NSExpression expressionForConstantValue:@0x0037]]];
    NSNumber* bitwiseXorValue = [bitwiseXorExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(bitwiseXorValue.intValue, 0x00C1);
    
    // 左移
    NSExpression* leftshiftExpression = [NSExpression expressionForFunction:@"leftshift:by:" arguments:@[[NSExpression expressionForConstantValue:@0x00F6], [NSExpression expressionForConstantValue:@4]]];
    NSNumber* leftshiftValue = [leftshiftExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(leftshiftValue.intValue, 0x0F60);
    
    // 右移
    NSExpression* rightshiftExpression = [NSExpression expressionForFunction:@"rightshift:by:" arguments:@[[NSExpression expressionForConstantValue:@0x00F6], [NSExpression expressionForConstantValue:@4]]];
    NSNumber* rightshiftValue = [rightshiftExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(rightshiftValue.intValue, 0x000F);
    
    // 补码
    NSExpression* onesComplementExpression = [NSExpression expressionForFunction:@"onesComplement:" arguments:@[[NSExpression expressionForConstantValue:@0x00F6]]];
    NSNumber* onesComplementValue = [onesComplementExpression expressionValueWithObject:nil context:nil];
    XCTAssertEqual(onesComplementValue.intValue, 0xFFFFFF09);
    
    // 没有操作 不支持了
//    NSExpression* onindexExpression = [NSExpression expressionForFunction:@"onindex:" arguments:@[[NSExpression expressionForConstantValue:@100]]];
//    NSNumber* onindexValue = [onindexExpression expressionValueWithObject:nil context:nil];
//    XCTAssertEqual(onindexValue.intValue, 100);
    
}

- (void)testFuncExpression {
    NSArray* array_1 = @[@10, @20, @30, @40, @50];
    
    NSExpression *constantExpression = [NSExpression expressionForConstantValue:[NSNumber numberWithDouble:4.2]];
    NSExpression *functionalExpression_1 = [NSExpression expressionForFunction:constantExpression selectorName:@"stringValue" arguments:nil];
    NSLog(@"%@",[functionalExpression_1 expressionValueWithObject:nil context:nil]);
    
    NSExpression *expression = [NSExpression expressionWithFormat:@"FUNCTION(4.2, 'factorial')"];
    id value = [expression expressionValueWithObject:nil context:nil];
    NSLog(@"%@", value);
    
    NSExpression* arrayExpression = [NSExpression expressionForConstantValue:array_1];
    NSExpression* funcExpression_1 = [NSExpression expressionForFunction:arrayExpression selectorName:@"reverseObjectEnumerator" arguments:nil];
    value = [funcExpression_1 expressionValueWithObject:nil context:nil];
    NSLog(@"funcExpression_1 %@", value);
    
//    NSExpression* funcExpression_2 = [NSExpression expressionForFunction:arrayExpression selectorName:@"objectAtIndex:" arguments:@[@0]];
//    value = [funcExpression_2 expressionValueWithObject:nil context:nil];
//    NSLog(@"funcExpression_1 %@", value);
}

@end
