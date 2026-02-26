import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../application/extensions/hardcoded_string_extension.dart';
import '../../../application/extensions/theme_build_context_extension.dart';
import '../../widgets/buttons/ink_well_no_style_button.dart';
import '../../widgets/cards/card_widget.dart';
import '../../widgets/lara_logo.dart';
import '../../widgets/screen_config_widget.dart';
import '../../../utils/functions/launch_url_function.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenConfigWidget(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: context.decorations.appBarGradient,
          ),
          iconTheme: IconThemeData(color: context.colors.white),
          // leadingWidth: 36,
          centerTitle: false,
          titleSpacing: 0.0,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About'.hardcoded,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'App version and information'.hardcoded,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        CardWidget(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Center(
                                    child: Column(
                                      children: <Widget>[
                                        LaraLogo(size: 64),
                                        const SizedBox(height: 16),
                                        Text(
                                          'LARA'.hardcoded,
                                          style: context.textStyles.text24Bold,
                                        ),
                                        Text(
                                          'AI Companion'.hardcoded,
                                          style: context.textStyles.text14w500
                                              .copyWith(
                                                color:
                                                    context.colors.titaniumEcho,
                                              ),
                                        ),
                                        const SizedBox(height: 16),
                                        Card(
                                          elevation: 0,
                                          color: context.colors.pureMist,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              'Version 1.0.0',
                                              style: context
                                                  .textStyles
                                                  .text12w500
                                                  .copyWith(
                                                    color: context
                                                        .colors
                                                        .titaniumEcho,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .animate(delay: 0.3.ms)
                            .fadeIn(
                              begin: 0,
                              duration: 300.ms,
                              curve: Curves.easeInOut,
                            ),
                        const SizedBox(height: 20),
                        CardWidget(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'About LARA'.hardcoded,
                                    style: context.textStyles.text14Bold,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'LARA is your intelligent AI companion designed to provide helpful, creative, and engaging conversations. Built with modern AI technology, LARA adapts to your communication style and helps you with everything from brainstorming ideas to answering questions.'
                                        .hardcoded,
                                    style: context.textStyles.text12,
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            )
                            .animate(delay: 0.6.ms)
                            .fadeIn(
                              begin: 0,
                              duration: 300.ms,
                              curve: Curves.easeInOut,
                            ),
                        const SizedBox(height: 20),
                        CardWidget(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Developer'.hardcoded,
                                    style: context.textStyles.text14Bold,
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.public,
                                        color: context.colors.titaniumEcho,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Created by'.hardcoded,
                                            style: context.textStyles.text10w500
                                                .copyWith(
                                                  color: context
                                                      .colors
                                                      .titaniumEcho,
                                                ),
                                          ),
                                          Text(
                                            'marcelomfranca'.hardcoded,
                                            style:
                                                context.textStyles.text12w600,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  InkWellNoStyleButton(
                                    color: context.colors.darkGrey.withValues(
                                      alpha: 0.6,
                                    ),
                                    onTap: () => launchUrl(
                                      'https://github.com/marcelomfranca',
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/icons/github_icon.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'View on GitHub'.hardcoded,
                                            style:
                                                context.textStyles.text12w600,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .animate(delay: 0.6.ms)
                            .fadeIn(
                              begin: 0,
                              duration: 300.ms,
                              curve: Curves.easeInOut,
                            ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
