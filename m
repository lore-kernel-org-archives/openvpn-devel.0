From: Gert Doering <gert@...1296...>
Date: Tue, 18 Mar 2025 18:50:29 +0100
Message-ID: <20250318175036.26655-1-gert@...1296...>
In-Reply-To: <gerrit.1736341120000.Ib3a166ead912beb2a591105c84d96d342664c05f@...2715...>
References: <gerrit.1736341120000.Ib3a166ead912beb2a591105c84d96d342664c05f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Post tchar.h removal cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

Change-Id: Ib3a166ead912beb2a591105c84d96d342664c05f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/854
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/dev-tools/text-removal.sh b/dev-tools/text-removal.sh
deleted file mode 100755
index 7b4e863..0000000
--- a/dev-tools/text-removal.sh
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/bin/bash
-
-# Replace all occurences of TEXT() in our codebase
-# to convert it to simpler Unicode-only code.
-
-set -x
-
-sed -i -E \
-	-e 's/TEXT\(("[^"]*")\)/L\1/g' \
-	-e 's/TEXT\(([^)]*)\)/L\1/g' \
-        -e 's/_T\(/_L(/g' \
-	-e 's/" LPRIsLPTSTR L"/ls/g' \
-	-e 's/" LPRIsLPTSTR/ls"/g' \
-	-e 's/LPRIsLPTSTR L"/L"ls/g' \
-	-e 's/" LPRIsLPOLESTR L"/ls/g' \
-	-e 's/LPRIsLPOLESTR L"/L"ls/g' \
-	-e 's/" LPRIsLPOLESTR/ls"/g' \
-	-e 's/" PRIsLPTSTR "/ls/g' \
-	-e 's/" PRIsLPOLESTR "/ls/g' \
-	-e 's/TCHAR/WCHAR/g' \
-	-e 's/LPTSTR/LPWSTR/g' \
-	-e 's/LPCTSTR/LPCWSTR/g' \
-	-e 's/LPRIXGUID/_L(PRIXGUID)/g' \
-	-e 's/LTAP_WIN_COMPONENT_ID/_L(TAP_WIN_COMPONENT_ID)/g' \
-	-e 's/LPACKAGE_(VERSION|NAME)/_L(PACKAGE_\1)/g' \
-        -e 's/LPACKAGE /_L(PACKAGE) /g' \
-	-e 's/_tcslen/wcslen/g' \
-        -e 's/_tcszlen/wcszlen/g' \
-	-e 's/_tcsrchr/wcsrchr/g' \
-	-e 's/_tcschr/wcschr/g' \
-	-e 's/_tcsstr/wcsstr/g' \
-	-e 's/_tcszistr/wcszistr/g' \
-        -e 's/_tcscpy/wcscpy/g' \
-        -e 's/_tcsicmp/wcsicmp/g' \
-        -e 's/_tcsdup/wcsdup/g' \
-        -e 's/_istspace/iswspace/g' \
-        -e 's/_stprintf/swprintf/g' \
-        -e 's/_ftprintf/fwprintf/g' \
-        -e 's/_tmain/wmain/g' \
-        -e 's/tchar\.h/wchar.h/g' \
-	src/openvpnmsica/*.[ch] \
-        src/openvpnserv/*.[ch] \
-        src/tapctl/*.[ch]
-
-# manual cleanup for complicated cases
-sed -i -E \
-    -e 's/error 0x%x.\\n"\),/error 0x%x).\\n",/g' \
-    src/tapctl/main.c
-sed -i -E \
-    -e 's/" is optional\\n"\),/") is optional\\n",/g' \
-    src/openvpnserv/service.c
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index b2b706b..7112f26 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -24,11 +24,6 @@
 #ifndef _SERVICE_H
 #define _SERVICE_H
 
-/* We do not support non-unicode builds */
-#ifndef UNICODE
-#define UNICODE
-#endif
-
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index ca5c6d4..49a3cf6 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -22,13 +22,11 @@
 #ifndef BASIC_H
 #define BASIC_H
 
-#ifdef _UNICODE
-#define PRIsLPWSTR      "ls"
-#define PRIsLPOLESTR    "ls"
-#else
-#define PRIsLPWSTR      "s"
-#define PRIsLPOLESTR    "ls"
+/* We do not support non-unicode builds */
+#ifndef UNICODE
+#define UNICODE
 #endif
+
 #define PRIXGUID        "{%08lX-%04hX-%04hX-%02hhX%02hhX-%02hhX%02hhX%02hhX%02hhX%02hhX%02hhX}"
 #define PRIGUID_PARAM(g) \
     (g).Data1, (g).Data2, (g).Data3, (g).Data4[0], (g).Data4[1], (g).Data4[2], (g).Data4[3], (g).Data4[4], (g).Data4[5], (g).Data4[6], (g).Data4[7]

