From: Gert Doering <gert@...1296...>
Date: Sat,  4 Apr 2026 22:35:19 +0200
Message-ID: <20260404203525.30790-1-gert@...1296...>
In-Reply-To: <gerrit.1775324949000.I4d6501ddfb321f57a76841f29ff92c5a412908bb@...2715...>
References: <gerrit.1775324949000.I4d6501ddfb321f57a76841f29ff92c5a412908bb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] openvpnmsica: Fix setting of iTicks in
 schedule_adapter_delete
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

Increase the integer, not the pointer.

Found by cppcheck.

Change-Id: I4d6501ddfb321f57a76841f29ff92c5a412908bb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1608
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1608
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index a145b64..fdb610c 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -613,7 +613,7 @@
                 msica_arg_seq_add_tail(seq, szArgument);
             }
 
-            iTicks += MSICA_ADAPTER_TICK_SIZE;
+            *iTicks += MSICA_ADAPTER_TICK_SIZE;
             break; /* Adapter names are unique. There should be no other adapter with this name. */
         }
     }

