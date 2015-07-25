// Copyright (c) 2011 iOSDeveloperZone.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "WebBrowserViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#define PopupTime 10.0
@interface WebBrowserViewController () <GADInterstitialDelegate>
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (strong, nonatomic) NSTimer *timer;
@end

static const CGFloat kNavBarHeight = 52.0f;
static const CGFloat kLabelHeight = 14.0f;
static const CGFloat kMargin = 10.0f;
static const CGFloat kSpacer = 2.0f;
static const CGFloat kLabelFontSize = 12.0f;
static const CGFloat kAddressHeight = 26.0f;

@implementation WebBrowserViewController
@synthesize webView = mWebView;
@synthesize toolbar = mToolbar;
@synthesize back = mBack;
@synthesize forward = mForward;
@synthesize refresh = mRefresh;
@synthesize stop = mStop;

- (void)dealloc
{
    [mWebView release];
    [mToolbar release];
    [mBack release];
    [mForward release];
    [mRefresh release];
    [mStop release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark Display-Time Lifecycle Notifications

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    self.interstitial = nil;
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:PopupTime
                                                      target:self
                                                    selector:@selector(showAdv)
                                                    userInfo:nil
                                                     repeats:YES];
    }

    
}

#pragma mark - show GAD adv

-(void) showAdv
{
    self.interstitial = [[GADInterstitial alloc]
                         initWithAdUnitID:@"ca-app-pub-2974739507750700/3580968677"];
    self.interstitial.delegate = self;
    [self.interstitial loadRequest:[GADRequest request]];
    [self.timer invalidate];
    self.timer = nil;
    
    
}
#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:PopupTime
                                     target:self
                                   selector:@selector(showAdv)
                                   userInfo:nil
                                    repeats:YES];
    
    

    
//    [self.interstitial loadRequest:[GADRequest request]];
    
    
    

    
    NSAssert(self.back, @"Unconnected IBOutlet 'back'");
    NSAssert(self.forward, @"Unconnected IBOutlet 'forward'");
    NSAssert(self.refresh, @"Unconnected IBOutlet 'refresh'");
    NSAssert(self.stop, @"Unconnected IBOutlet 'stop'");
    NSAssert(self.webView, @"Unconnected IBOutlet 'webView'");

    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    NSURL* url = [NSURL URLWithString:@"http://autohungthinh.com/"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self updateButtons];
}


- (void)viewDidUnload
{
    self.webView = nil;
    self.toolbar = nil;
    self.back = nil;
    self.forward = nil;
    self.refresh = nil;
    self.stop = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// MARK: -
// MARK: UI methods

/**
 * \brief Updates the forward, back and stop buttons.
 */
- (void)updateButtons
{
    self.forward.enabled = self.webView.canGoForward;
    self.back.enabled = self.webView.canGoBack;
    self.stop.enabled = self.webView.loading;
}


// MARK: -
// MARK: UIWebViewDelegate protocol
/**
 * \brief 
 *
 * This is called for more than just the toplevel page so is not ideal for 
 * updating the loading URL.
 *
 * \param navigationType is one of:
 * <ol>
 * <li>UIWebViewNavigationTypeFormSubmitted,</li>
 * <li>UIWebViewNavigationTypeBackForward,</li>
 * <li>UIWebViewNavigationTypeReload,</li>
 * <li>UIWebViewNavigationTypeFormResubmitted,</li>
 * <li>UIWebViewNavigationTypeOther.</li>
 * </ol>
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateButtons];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [self.interstitial presentFromRootViewController:self];
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    // [self.imageView removeFromSuperview];
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)interstitial {
    // [self.imageView removeFromSuperview];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateButtons];
}

// MARK: -
// MARK: Debugging methods
- (NSString*)navigationTypeToString:(UIWebViewNavigationType)navigationType
{
    switch(navigationType)
    {
        case UIWebViewNavigationTypeFormSubmitted:
            return @"UIWebViewNavigationTypeFormSubmitted";
        case UIWebViewNavigationTypeBackForward:
            return @"UIWebViewNavigationTypeBackForward";
        case UIWebViewNavigationTypeReload:
            return @"UIWebViewNavigationTypeReload";
        case UIWebViewNavigationTypeFormResubmitted:
            return @"UIWebViewNavigationTypeReload";
        case UIWebViewNavigationTypeOther:
            return @"UIWebViewNavigationTypeOther";
            
    }
    return @"Unexpected/unknown";
}

@end
