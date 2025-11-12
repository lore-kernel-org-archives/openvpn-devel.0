From: Gert Doering <gert@...1296...>
Date: Wed, 12 Nov 2025 14:01:43 +0100
Message-ID: <20251112130149.10890-1-gert@...1296...>
In-Reply-To: <gerrit.1762949155000.I4104d7e34fbc7232b677e937fc598128a8b7b3bc@...2715...>
References: <gerrit.1762949155000.I4104d7e34fbc7232b677e937fc598128a8b7b3bc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tapctl: use better wording for adapters
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

From: Lev Stipakov <lev@...515...>

"TUN/TAP" is a bit confusing, so use more generic "VPN network adapter"
wording.

Change-Id: I4104d7e34fbc7232b677e937fc598128a8b7b3bc
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1371
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1371
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 3caffd8..4d25998 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -50,9 +50,9 @@
     L"\n"
     L"Commands:\n"
     L"\n"
-    L"create     Create a new TUN/TAP adapter\n"
-    L"list       List TUN/TAP adapters\n"
-    L"delete     Delete specified network adapter\n"
+    L"create     Create a new VPN network adapter\n"
+    L"list       List VPN network adapters\n"
+    L"delete     Delete specified VPN network adapter\n"
     L"help       Display this text\n"
     L"\n"
     L"Hint: Use \"tapctl help <command>\" to display help for particular command.\n"
@@ -61,7 +61,7 @@
 static const WCHAR usage_message_create[] =
     L"%ls\n"
     L"\n"
-    L"Creates a new TUN/TAP adapter\n"
+    L"Creates a new VPN network adapter\n"
     L"\n"
     L"Usage:\n"
     L"\n"
@@ -69,8 +69,8 @@
     L"\n"
     L"Options:\n"
     L"\n"
-    L"--name <name>  Set TUN/TAP adapter name. Should the adapter with given name    \n"
-    L"               already exist, an error is returned. If this option is not      \n"
+    L"--name <name>  Set VPN network adapter name. Should the adapter with given     \n"
+    L"               name already exist, an error is returned. If this option is not \n"
     L"               specified, a default adapter name is chosen by Windows.         \n"
     L"               Note: This name can also be specified as OpenVPN's --dev-node   \n"
     L"               option.                                                         \n"
@@ -80,13 +80,13 @@
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints newly created TUN/TAP adapter's GUID to stdout.            \n"
+    L"This command prints newly created VPN network adapter's GUID to stdout.        \n"
 ;
 
 static const WCHAR usage_message_list[] =
     L"%ls\n"
     L"\n"
-    L"Lists TUN/TAP adapters\n"
+    L"Lists VPN network adapters\n"
     L"\n"
     L"Usage:\n"
     L"\n"
@@ -99,13 +99,13 @@
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints all TUN/TAP adapters to stdout.                            \n"
+    L"This command prints all VPN network adapters to stdout.                        \n"
 ;
 
 static const WCHAR usage_message_delete[] =
     L"%ls\n"
     L"\n"
-    L"Deletes the specified network adapter\n"
+    L"Deletes the specified VPN network adapter\n"
     L"\n"
     L"Usage:\n"
     L"\n"

