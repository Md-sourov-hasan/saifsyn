import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class StripeWebView extends StatefulWidget {
  final String url;
  const StripeWebView({super.key, required this.url});

  @override
  State<StripeWebView> createState() => _StripeWebViewState();
}

class _StripeWebViewState extends State<StripeWebView> {
  late final WebViewController _controller;
  late final PlatformWebViewWidgetCreationParams _webViewWidgetParams;
  late final Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers;
  bool _isLoading = true;
  bool _isHandlingResult = false;

  @override
  void initState() {
    super.initState();

    _gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>{
      Factory<OneSequenceGestureRecognizer>(EagerGestureRecognizer.new),
    };

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (_) => setState(() => _isLoading = true),
        onPageFinished: (_) => setState(() => _isLoading = false),
        onNavigationRequest: (request) {
          final lowerUrl = request.url.toLowerCase();

          if (lowerUrl.contains('success')) {
            _handlePaymentSuccess();
            return NavigationDecision.prevent;
          }

          if (lowerUrl.contains('cancel') || lowerUrl.contains('failed')) {
            _handlePaymentFailure();
            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.url));

    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      _webViewWidgetParams = AndroidWebViewWidgetCreationParams(
        controller: _controller.platform,
        gestureRecognizers: _gestureRecognizers,
        displayWithHybridComposition: true,
      );
    } else {
      _webViewWidgetParams = PlatformWebViewWidgetCreationParams(
        controller: _controller.platform,
        gestureRecognizers: _gestureRecognizers,
      );
    }
  }

  Future<void> _handlePaymentSuccess() async {
    if (_isHandlingResult || !mounted) return;
    _isHandlingResult = true;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 64,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Payment Received!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your subscription is now active. Enjoy your premium features.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide.none,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue to Dashboard',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  void _handlePaymentFailure() {
    if (_isHandlingResult || !mounted) return;
    _isHandlingResult = true;
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget.fromPlatformCreationParams(
            params: _webViewWidgetParams,
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
