import 'package:blockin/app/onboarding/ui/components/molecules/selectable.dart';
import 'package:blockin/theme/constants/spacing.dart';
import 'package:blockin/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

/// A group of selectable items that can be used for single or multiple selection.
///
/// This component manages a collection of [BlockinSelectable] widgets and
/// handles the selection state for the group.
class BlockinSelectableGroup extends StatefulWidget {
  /// List of items to display as selectables
  final List<String> items;

  /// Whether multiple items can be selected at once
  /// If false, only one item can be selected at a time (single selection mode)
  final bool allowMultipleSelection;

  /// Initially selected items (by index)
  final List<int>? initialSelectedIndices;

  /// Callback when selection changes
  /// Provides the list of selected item indices
  final Function(List<int> selectedIndices)? onSelectionChanged;

  /// Spacing between selectable items
  final double spacing;

  const BlockinSelectableGroup({
    super.key,
    required this.items,
    this.allowMultipleSelection = true,
    this.initialSelectedIndices,
    this.onSelectionChanged,
    this.spacing = Spacing.medium,
  });

  @override
  State<BlockinSelectableGroup> createState() => _BlockinSelectableGroupState();
}

class _BlockinSelectableGroupState extends State<BlockinSelectableGroup> {
  late Set<int> _selectedIndices;

  @override
  void initState() {
    super.initState();
    _selectedIndices = widget.initialSelectedIndices != null
        ? Set<int>.from(widget.initialSelectedIndices!)
        : <int>{};
  }

  void _handleSelectionChanged(int index, bool newSelectionState) {
    setState(() {
      final isCurrentlySelected = _selectedIndices.contains(index);

      if (widget.allowMultipleSelection) {
        // Multiple selection mode: toggle selection
        if (newSelectionState) {
          _selectedIndices.add(index);
        } else {
          _selectedIndices.remove(index);
        }
      } else {
        // Single selection mode
        if (newSelectionState) {
          // Item is being selected - clear all and select only this one
          _selectedIndices.clear();
          _selectedIndices.add(index);
        } else if (isCurrentlySelected) {
          // User clicked on already selected item - keep it selected
          // (don't allow deselection in single selection mode)
          // Do nothing, item remains selected
        }
      }
    });

    widget.onSelectionChanged?.call(_selectedIndices.toList()..sort());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    final selectables = List<Widget>.generate(widget.items.length, (index) {
      final isSelected = _selectedIndices.contains(index);
      return Padding(
        padding: EdgeInsets.only(bottom: widget.spacing),
        child: BlockinSelectable(
          text: widget.items[index],
          isSelected: isSelected,
          onChanged: (selected) => _handleSelectionChanged(index, selected),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: selectables,
    );
  }
}

@Preview(name: 'BlockinSelectableGroup - Multiple Selection')
Widget blockinSelectableGroupMultiplePreview() {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Theme(
      data: BlockinTheme.darkTheme(),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.extraLarge),
        child: BlockinSelectableGroup(
          items: const [
            'Option 1',
            'Option 2',
            'Option 3',
            'Option 4',
            'Longer Option Name',
          ],
          allowMultipleSelection: true,
          onSelectionChanged: (indices) {
            print('Selected indices: $indices');
          },
        ),
      ),
    ),
  );
}

@Preview(name: 'BlockinSelectableGroup - Single Selection')
Widget blockinSelectableGroupSinglePreview() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Theme(
      data: BlockinTheme.lightTheme(),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.extraLarge),
        child: BlockinSelectableGroup(
          items: const ['Option 1', 'Option 2', 'Option 3'],
          allowMultipleSelection: false,
          initialSelectedIndices: [0],
          onSelectionChanged: (indices) {
            print('Selected indices: $indices');
          },
        ),
      ),
    ),
  );
}
