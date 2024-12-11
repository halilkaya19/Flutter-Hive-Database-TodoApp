import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:yuotube_tt_proje_1/data/hive_data_store.dart';

dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: "Opss!! Delete",
      subMsg: "Silmek istediğinizden Emimmisiniz",
      duration: 700,
      corner: 20,
      color: Colors.black);
}

dynamic emptyUpdateTask(BuildContext context) {
  return FToast.toast(context,
      msg: "Opss!! Güncelleme",
      subMsg: "Güncelleme Yapmak istediğinizden eminmisiniz",
      duration: 700,
      corner: 20,
      color: Colors.black);
}

warningDialog(BuildContext context) {
  return PanaraInfoDialog.showAnimatedFade(
    context,
    message: "Uyarı Bildirgesi",
    buttonText: "Uyarı",
    onTapDismiss: () {

    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

deleteInfoDialog(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    message: "Tümünü Silmekten Eminmisin !!",
    onTapCancel: () {

      Navigator.of(context).pop();
    },
    onTapConfirm: () {
      //HiveDataSTore().box.clear();
      Navigator.of(context).pop();
    },
    panaraDialogType: PanaraDialogType.error, confirmButtonText: 'Evet', cancelButtonText: 'İptal',
  );
}