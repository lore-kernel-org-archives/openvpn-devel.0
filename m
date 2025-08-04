From: Gert Doering <gert@...1296...>
Date: Mon,  4 Aug 2025 11:10:21 +0200
Message-ID: <20250804091027.13509-1-gert@...1296...>
In-Reply-To: <gerrit.1733837528000.I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11@...2715...>
References: <gerrit.1733837528000.I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v12] Disable clang-format for some code parts
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

These do not come out better with clang-format,
so leave them be.

Change-Id: I4dd0c44982955f16ec4a3f167d4e6f3e9b4dbc11
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/829
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e9e50da..e9dd5f2 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -75,6 +75,7 @@
  *
  * @{
  */
+/* clang-format off */
 #define S_ERROR         (-2)    /**< Error state.  */
 #define S_ERROR_PRE     (-1)    /**< Error state but try to send out alerts
                                  *  before killing the keystore and moving
@@ -105,7 +106,7 @@
 #define S_GENERATED_KEYS  8     /**< The data channel keys have been generated
                                  *  The TLS session is fully authenticated
                                  *  when reaching this state. */
-
+/* clang-format on */
 /* Note that earlier versions also had a S_OP_NORMAL state that was
  * virtually identical with S_ACTIVE and the code still assumes everything
  * >= S_ACTIVE to be fully operational */
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 58ab8cc..a67540d 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -37,6 +37,7 @@
 #endif
 
 
+/* clang-format off */
 const WCHAR title_string[] =
     _L(PACKAGE_NAME) L" " _L(PACKAGE_VERSION)
 ;
@@ -111,6 +112,7 @@
     L"\n"
     L"tapctl delete <adapter GUID | adapter name>\n"
 ;
+/* clang-format on */
 
 
 /**

