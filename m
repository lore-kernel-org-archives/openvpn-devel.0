From: Gert Doering <gert@...1296...>
Date: Tue, 26 Aug 2025 20:39:33 +0200
Message-ID: <20250826183941.21338-1-gert@...1296...>
In-Reply-To: <gerrit.1753360288000.I1d27cb81d32058e40147e1d6dcd12df7f6cb2b30@...2715...>
References: <gerrit.1753360288000.I1d27cb81d32058e40147e1d6dcd12df7f6cb2b30@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] options: Make sure option types are
 treated as unsigned
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

verify_permissions already expects them to be unsigned,
make sure they are to avoid spurious conversion warnings.

Change-Id: I1d27cb81d32058e40147e1d6dcd12df7f6cb2b30
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1106
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 5ee6e93..7dc2912 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -729,38 +729,38 @@
 /*
  * Option classes.
  */
-#define OPT_P_GENERAL         (1 << 0)
-#define OPT_P_UP              (1 << 1)
-#define OPT_P_ROUTE           (1 << 2)
-#define OPT_P_DHCPDNS         (1 << 3) /* includes ip windows options like */
-#define OPT_P_SCRIPT          (1 << 4)
-#define OPT_P_SETENV          (1 << 5)
-#define OPT_P_SHAPER          (1 << 6)
-#define OPT_P_TIMER           (1 << 7)
-#define OPT_P_PERSIST         (1 << 8)
-#define OPT_P_PERSIST_IP      (1 << 9)
-#define OPT_P_COMP            (1 << 10) /* TODO */
-#define OPT_P_MESSAGES        (1 << 11)
-#define OPT_P_NCP             (1 << 12) /**< Negotiable crypto parameters */
-#define OPT_P_TLS_PARMS       (1 << 13) /* TODO */
-#define OPT_P_MTU             (1 << 14) /* TODO */
-#define OPT_P_NICE            (1 << 15)
-#define OPT_P_PUSH            (1 << 16)
-#define OPT_P_INSTANCE        (1 << 17) /**< allowed in ccd, client-connect etc*/
-#define OPT_P_CONFIG          (1 << 18)
-#define OPT_P_EXPLICIT_NOTIFY (1 << 19)
-#define OPT_P_ECHO            (1 << 20)
-#define OPT_P_INHERIT         (1 << 21)
-#define OPT_P_ROUTE_EXTRAS    (1 << 22)
-#define OPT_P_PULL_MODE       (1 << 23)
-#define OPT_P_PLUGIN          (1 << 24)
-#define OPT_P_SOCKBUF         (1 << 25)
-#define OPT_P_SOCKFLAGS       (1 << 26)
-#define OPT_P_CONNECTION      (1 << 27)
-#define OPT_P_PEER_ID         (1 << 28)
-#define OPT_P_INLINE          (1 << 29)
-#define OPT_P_PUSH_MTU        (1 << 30)
-#define OPT_P_ROUTE_TABLE     (1 << 31)
+#define OPT_P_GENERAL         (1u << 0)
+#define OPT_P_UP              (1u << 1)
+#define OPT_P_ROUTE           (1u << 2)
+#define OPT_P_DHCPDNS         (1u << 3) /* includes ip windows options like */
+#define OPT_P_SCRIPT          (1u << 4)
+#define OPT_P_SETENV          (1u << 5)
+#define OPT_P_SHAPER          (1u << 6)
+#define OPT_P_TIMER           (1u << 7)
+#define OPT_P_PERSIST         (1u << 8)
+#define OPT_P_PERSIST_IP      (1u << 9)
+#define OPT_P_COMP            (1u << 10) /* TODO */
+#define OPT_P_MESSAGES        (1u << 11)
+#define OPT_P_NCP             (1u << 12) /**< Negotiable crypto parameters */
+#define OPT_P_TLS_PARMS       (1u << 13) /* TODO */
+#define OPT_P_MTU             (1u << 14) /* TODO */
+#define OPT_P_NICE            (1u << 15)
+#define OPT_P_PUSH            (1u << 16)
+#define OPT_P_INSTANCE        (1u << 17) /**< allowed in ccd, client-connect etc*/
+#define OPT_P_CONFIG          (1u << 18)
+#define OPT_P_EXPLICIT_NOTIFY (1u << 19)
+#define OPT_P_ECHO            (1u << 20)
+#define OPT_P_INHERIT         (1u << 21)
+#define OPT_P_ROUTE_EXTRAS    (1u << 22)
+#define OPT_P_PULL_MODE       (1u << 23)
+#define OPT_P_PLUGIN          (1u << 24)
+#define OPT_P_SOCKBUF         (1u << 25)
+#define OPT_P_SOCKFLAGS       (1u << 26)
+#define OPT_P_CONNECTION      (1u << 27)
+#define OPT_P_PEER_ID         (1u << 28)
+#define OPT_P_INLINE          (1u << 29)
+#define OPT_P_PUSH_MTU        (1u << 30)
+#define OPT_P_ROUTE_TABLE     (1u << 31)
 
 #define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))
 
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 5e094a2..51f7f92 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -307,7 +307,7 @@
 }
 
 bool
-check_pull_client_ncp(struct context *c, const int found)
+check_pull_client_ncp(struct context *c, const unsigned int found)
 {
     if (found & OPT_P_NCP)
     {
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 2b2ff85..ed5d281 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -49,7 +49,7 @@
  *
  * @return  Wether the client NCP process suceeded or failed
  */
-bool check_pull_client_ncp(struct context *c, int found);
+bool check_pull_client_ncp(struct context *c, unsigned int found);
 
 /**
  * Iterates through the ciphers in server_list and return the first

