import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ShadButton.outline(
        onPressed: () {
          // TODO: Implement date selection
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PhosphorIcon(PhosphorIcons.calendar()),
            const SizedBox(width: 8),
            Text(
              'Select date to reservation',
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            const SizedBox(width: 8),
            PhosphorIcon(
              PhosphorIcons.arrowRight(),
              color: Theme.of(context).hintColor,
            ),
          ],
        ),
      ),
    );
  }
}
