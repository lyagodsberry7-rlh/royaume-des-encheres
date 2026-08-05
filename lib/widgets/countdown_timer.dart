import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/colors/royal_colors.dart';
import '../theme/decorations/royal_radius.dart';
import '../theme/typography/royal_text_styles.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;

  final bool compact;

  final Color? backgroundColor;

  final Color? textColor;

  final VoidCallback? onFinished;

  const CountdownTimer({
    super.key,
    required this.endTime,
    this.compact = false,
    this.backgroundColor,
    this.textColor,
    this.onFinished,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _remaining;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _remaining = widget.endTime.difference(DateTime.now());

    _start();
  }

  void _start() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final remaining = widget.endTime.difference(DateTime.now());

        if (remaining.isNegative || remaining.inSeconds <= 0) {
          _timer?.cancel();

          widget.onFinished?.call();

          if (mounted) {
            setState(() {
              _remaining = Duration.zero;
            });
          }

          return;
        }

        if (mounted) {
          setState(() {
            _remaining = remaining;
          });
        }
      },
    );
  }

  String _two(int value) => value.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    if (_remaining == Duration.zero) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: RoyalColors.live,
          borderRadius: RoyalRadius.pill,
        ),
        child: const Text(
          "TERMINÉE",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    final days = _remaining.inDays;

    final hours = _remaining.inHours.remainder(24);

    final minutes = _remaining.inMinutes.remainder(60);

    final seconds = _remaining.inSeconds.remainder(60);

    String value;

    if (days > 0) {
      value =
          "${_two(days)}j ${_two(hours)}h ${_two(minutes)}m";
    } else {
      value =
          "${_two(hours)}:${_two(minutes)}:${_two(seconds)}";
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: widget.compact ? 10 : 14,
        vertical: widget.compact ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            RoyalColors.secondary.withValues(alpha: .18),
        borderRadius: RoyalRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timer_outlined,
            size: widget.compact ? 16 : 18,
            color: widget.textColor ?? RoyalColors.primary,
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: RoyalTextStyles.timer.copyWith(
              color: widget.textColor ?? RoyalColors.primary,
              fontSize: widget.compact ? 15 : 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}