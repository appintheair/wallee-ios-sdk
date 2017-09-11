//
//  WALViewControllerFactory.h
//  WalleeSDK
//
//  Created by Daniel Schmid on 02.09.17.
//  Copyright © 2017 smoca AG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WALTransaction, WALTokenVersion, WALLoadedTokens, WALLoadedPaymentMethods, WALPaymentMethodConfiguration, WALMobileSdkUrl;
@protocol WALPaymentFormView;

typedef void(^WALTokenVersionSelected)(WALTokenVersion *_Nonnull);
typedef void(^WALOnBackBlock)(void);
typedef void(^WALPaymentMethodSelected)(WALPaymentMethodConfiguration *_Nonnull);
typedef void(^WALPaymentMethodSubmited)(WALPaymentMethodConfiguration *_Nonnull);

@protocol WALViewControllerFactory <NSObject>

- (UIViewController *_Nonnull)buildAwaitingFinalStateViewWith:(WALTransaction * _Nonnull)transaction;
- (UIViewController *_Nonnull)buildSuccessViewWith:(WALTransaction * _Nonnull)transaction;
- (UIViewController *_Nonnull)buildFailureViewWith:(WALTransaction * _Nonnull)transaction;

- (UIViewController *_Nonnull)buildTokenListViewWith:(WALLoadedTokens *_Nonnull)loadedTokens
                                         onSelection:(WALTokenVersionSelected _Nullable )callback
                               onChangePaymentMethod:(WALOnBackBlock _Nullable)changePaymentMethod;

/**
 The payment method selection view allows the user to select from a list of payment methods
 the one which should be used to process the transaction with.

 @param loadedPaymentMethods the payment methods from which the user can choose
 @param callback the callback block to invoke when the user selects a payment method
 @param onBack the block to invoke if the user wants to perform a back action (eg. to get to the TokenList)
 @return the viewcontroller to display the payment methods
 */
- (UIViewController *_Nonnull)buildPaymentMethodListViewWith:(WALLoadedPaymentMethods *_Nonnull)loadedPaymentMethods
                                                 onSelection:(WALPaymentMethodSelected _Nullable)callback
                                                      onBack:(WALOnBackBlock _Nonnull)onBack;

- (UIViewController<WALPaymentFormView> *_Nonnull)buildPaymentMethodFormViewWithURL:(WALMobileSdkUrl * _Nonnull)mobileSdkUrl
                                                                      paymentMethod:(NSUInteger)paymentMethodId
                                                                             onBack:(WALOnBackBlock _Nonnull )onBack;

@end


//*/
//@property (nonatomic, copy, readonly) id<WALPaymentFlowContainerFactory> paymentFlowContainerFactory;
//
///**
// * The payment form view factory creates the view which collects the payment information.
// *
// * @return the factory which is used to create the payment form view.
// */
//@property (nonatomic, copy, readonly) id<WALPaymentFormViewControllerFactory> paymentFormViewControllerFactory;
//
///**
// * The token selection view lets the user select a token from a list of tokens. The selected
// * token will be used to process the transaction.
// *
// * @return the factory which is responsible to create teh token selection view.
// */
//@property (nonatomic, copy, readonly) id<WALTokenListViewControllerFactory> tokenListViewControllerFactory;
//
///**
// * The payment method selection view allows the user to select from a list of payment methods
// * the one which should be used to process the transaction with.
// *
// * @return the factory which is responsible for creating the payment method selection view.
// */
//@property (nonatomic, copy, readonly) id<WALPaymentMethodListViewControllerFactory> paymentMethodListViewControllerFactory;
//
///**
// * The success view is displayed once the transaction has been processed successfully.
// *
// * @return the factory which is used to create the success view.
// */
//@property (nonatomic, copy, readonly) id<WALSuccessViewControllerFactory> successViewControllerFactory;
//
///**
// * When the transaction fails the {@link com.wallee.android.sdk.flow.FlowCoordinator} will show
// * a view which explains to the user why the transaction failed. This factory is responsible for
// * this view.
// *
// * @return the factory which is responsible for creating the view for failed transactions.
// */
//@property (nonatomic, copy, readonly) id<WALFailureViewControllerFactory> failureViewControllerFactory;
//
///**
// * The transaction may not reach a final state immediately. In this case the awaiting final
// * state view will be displayed. The returned factory is used to create this view.
// *
// * @return the factory which creates the view for the awaiting final state view.
// */
//@property (nonatomic, copy, readonly) id<WALAwaitingFinalStateViewControllerFactory> awaitingFinalStateViewControllerFactory;
//
