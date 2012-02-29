From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:22:15 +0200
Message-Id: <1330546942-18250-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
References: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [openvpn-gui 1/8] cleanup: resolve unused parameter
	warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 localization.c |    6 ++++++
 main.c         |    2 ++
 openvpn.c      |    5 +++++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/localization.c b/localization.c
index 8e86b50..eb541fc 100644
--- a/localization.c
+++ b/localization.c
@@ -296,6 +296,10 @@ FillLangListProc(HANDLE module, PTSTR type, PTSTR stringId, WORD langId, LONG_PT
 {
     langProcData *data = (langProcData*) lParam;
 
+    (void)module;
+    (void)type;
+    (void)stringId;
+
     int index = ComboBox_AddString(data->languages, LangListEntry(IDS_LANGUAGE_NAME, langId));
     ComboBox_SetItemData(data->languages, index, langId);
 
@@ -318,6 +322,8 @@ LanguageSettingsDlgProc(HWND hwndDlg, UINT msg, WPARAM wParam, LPARAM lParam)
         .language = GetGUILanguage()
     };
 
+    (void)wParam;
+
     switch(msg) {
 
     case WM_INITDIALOG:
diff --git a/main.c b/main.c
index bf24fbc..22c8bef 100644
--- a/main.c
+++ b/main.c
@@ -406,6 +406,8 @@ static INT_PTR CALLBACK
 AboutDialogFunc(HWND hwndDlg, UINT msg, WPARAM wParam, LPARAM lParam)
 {
   LPPSHNOTIFY psn;
+  (void)hwndDlg;
+  (void)wParam;
   if (msg == WM_NOTIFY) {
     psn = (LPPSHNOTIFY) lParam;
     if (psn->hdr.code == (UINT) PSN_APPLY)
diff --git a/openvpn.c b/openvpn.c
index 5662c50..48a6ef6 100644
--- a/openvpn.c
+++ b/openvpn.c
@@ -56,6 +56,7 @@ const TCHAR *cfgProp = _T("conn");
 void
 OnReady(connection_t *c, char *msg)
 {
+    (void)msg;
     ManagementCommand(c, "state on", NULL, regular);
     ManagementCommand(c, "log all on", OnLogLine, combined);
 }
@@ -67,6 +68,7 @@ OnReady(connection_t *c, char *msg)
 void
 OnHold(connection_t *c, char *msg)
 {
+    (void)msg;
     ManagementCommand(c, "hold off", NULL, regular);
     ManagementCommand(c, "hold release", NULL, regular);
 }
@@ -348,6 +350,9 @@ void
 OnStop(connection_t *c, char *msg)
 {
     UINT txt_id, msg_id;
+
+    (void)msg;
+
     SetMenuStatus(c, disconnected);
 
     switch (c->state)
-- 
1.7.3.4


