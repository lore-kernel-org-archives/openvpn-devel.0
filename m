From: Gert Doering <gert@...1296...>
Date: Sun,  5 Apr 2026 12:22:04 +0200
Message-ID: <20260405102209.31528-1-gert@...1296...>
In-Reply-To: <gerrit.1775320419000.Iff5be978817bfc0cd4d78818e7be7b90bad71f3c@...2715...>
References: <gerrit.1775320419000.Iff5be978817bfc0cd4d78818e7be7b90bad71f3c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] win: Fix nrpt_dnssec flag handling
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

By default the first enum value is 0.
But we check whether we set the flag by doing
BOOL dnssec = (msg->flags & nrpt_dnssec) != 0;
This can't ever be true.

Found by cppcheck.

Change-Id: Iff5be978817bfc0cd4d78818e7be7b90bad71f3c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1606
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1606
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index bef20cf..ca3267e 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -110,7 +110,7 @@
 
 typedef enum
 {
-    nrpt_dnssec
+    nrpt_dnssec = 1 << 0,
 } nrpt_flags_t;
 
 #define NRPT_ADDR_NUM  8  /* Max. number of addresses */

