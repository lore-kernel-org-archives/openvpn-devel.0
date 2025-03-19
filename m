From: Gert Doering <gert@...1296...>
Date: Wed, 19 Mar 2025 15:22:24 +0100
Message-ID: <20250319142234.25046-1-gert@...1296...>
In-Reply-To: <gerrit.1736341120000.Ib3a166ead912beb2a591105c84d96d342664c05f@...2715...>
References: <gerrit.1736341120000.Ib3a166ead912beb2a591105c84d96d342664c05f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Post tchar.h removal cleanup
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

Remove some unused defines.

Change-Id: Ib3a166ead912beb2a591105c84d96d342664c05f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/854
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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

