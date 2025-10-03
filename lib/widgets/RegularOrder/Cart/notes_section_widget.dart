import 'package:flutter/material.dart';
import 'package:str_customer_app/utils/app_colors.dart';
import '../../../models/RegularOrders/Cart/cart_note_model.dart';
import '../../../utils/app_styles.dart';

class NotesSectionWidget extends StatelessWidget {
  final List<CartNoteModel> notes;
  final Function(String noteId) onDeleteNote;

  const NotesSectionWidget({
    super.key,
    required this.notes,
    required this.onDeleteNote,
  });

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Notes:', style: AppStyles.bodyMedium),
              ...notes.map(
                (note) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(note.text, style: AppStyles.bodySmall)),
                      GestureDetector(
                        onTap: () => onDeleteNote(note.id),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.divider,
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                "assets/images/delete.png",
                                width: 12,
                                height: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
