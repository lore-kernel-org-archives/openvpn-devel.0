From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 11 Jul 2025 12:04:05 +0200
Message-Id: <20250711100405.240625-1-frank@...2641...>
In-Reply-To: <gerrit.1752140383000.Icad1a52d14311a6f06bda081cab2f4bded8d47ed@...2715...>
References: <gerrit.1752140383000.Icad1a52d14311a6f06bda081cab2f4bded8d47ed@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix compiler warning in reliable.c with
 --disable-debug
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

Use the easy way out. Using pre-compiler to completely
avoid n_active seems like overkill.

Change-Id: Icad1a52d14311a6f06bda081cab2f4bded8d47ed
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1082
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 6aef112..424d194 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -648,6 +648,7 @@
             }
         }
     }
+    (void)n_active; /* dmsg might not generate code */
     dmsg(D_REL_DEBUG, "ACK reliable_can_send active=%d current=%d : %s",
          n_active,
          n_current,

