From: Gert Doering <gert@...1296...>
Date: Wed, 26 Nov 2025 11:49:32 +0100
Message-ID: <20251126104938.5612-1-gert@...1296...>
In-Reply-To: <gerrit.1763880426000.I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca@...2715...>
References: <gerrit.1763880426000.I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] iservice: fix off by one error
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

From: Heiko Hund <heiko@...2662...>

In case there is more than one non-ignored interface domain, the start
of the next domain was off by one glyph. That meant that all but the
first domain was ignored when converting to MULTI_SZ.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: I3ebf30f6d9edc66eb54fb3f1b5634c96d156b1ca
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1395
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1395
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 31a7ffa..23d18aa 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2234,7 +2234,8 @@
                     return NO_ERROR;
                 }
 
-                pos = comma + 1;
+                /* Comma pos is now +1 after adding leading dot */
+                pos = comma + 2;
             }
         }
     }

