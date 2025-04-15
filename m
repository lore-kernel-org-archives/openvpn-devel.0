From: Gert Doering <gert@...1296...>
Date: Tue, 15 Apr 2025 17:52:53 +0200
Message-ID: <20250415155259.12601-1-gert@...1296...>
In-Reply-To: <gerrit.1744716809000.I37482a8c322680add00bab52272f9945fbb3bd09@...2715...>
References: <gerrit.1744716809000.I37482a8c322680add00bab52272f9945fbb3bd09@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove UINT8_MAX definition
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

Because this is a part of C99 if uint8_t is available.

Change-Id: I37482a8c322680add00bab52272f9945fbb3bd09
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/940
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index bd7a449..a0c22b1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3036,10 +3036,6 @@
     return BSTR(&buffer);
 }
 
-#ifndef UINT8_MAX
-#define UINT8_MAX 0xff
-#endif
-
 /* add some offset to an ipv6 address
  * (add in steps of 8 bits, taking overflow into next round)
  */

