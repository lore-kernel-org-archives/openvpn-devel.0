From: Gert Doering <gert@...1296...>
Date: Mon,  6 Oct 2025 19:03:58 +0200
Message-ID: <20251006170403.7128-1-gert@...1296...>
In-Reply-To: <gerrit.1759766819000.Ia93bd8874e1b578d553720eedc274b974a462483@...2715...>
References: <gerrit.1759766819000.Ia93bd8874e1b578d553720eedc274b974a462483@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] crypto: Add more explicit casts for
 OpenBSD
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

The compiler on OpenBSD is a bit more zealous
about these strlen's even though these are
static values that can be determined at
compile time...

This was missed in the previous commit
("crypto: Make some casts to int explicit")
because we don't use -Werror on OpenBSD, yet.

Change-Id: Ia93bd8874e1b578d553720eedc274b974a462483
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1252
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1252
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 13635fb..026e874 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1361,8 +1361,8 @@
     int state = PARSE_INITIAL;
 
     /* constants */
-    const int hlen = strlen(static_key_head);
-    const int flen = strlen(static_key_foot);
+    const int hlen = (int)strlen(static_key_head);
+    const int flen = (int)strlen(static_key_foot);
     const int onekeylen = sizeof(key2->keys[0]);
 
     CLEAR(*key2);

